# Instalar solamente los paquetes que falten
paquetes <- c("ggplot2", "tidyr", "tibble", "pheatmap")

for (paquete in paquetes) {
  if (!requireNamespace(paquete, quietly = TRUE)) {
    install.packages(
      paquete,
      repos = "https://cloud.r-project.org"
    )
  }
}

library(ggplot2)
library(tidyr)
library(tibble)
library(pheatmap)

# Mismos datos originales del Tema 9
base <- data.frame(
  estacion = c(
    "Centro",
    "San Jerónimo",
    "Wanchaq",
    "San Sebastián",
    "Poroy"
  ),
  pm10_ugm3 = c(45, 28, 62, 35, NA),
  no2_ppb = c(18.2, 12.5, 25.4, 15.0, 9.8),
  ruido_db = c(72, 58, 81, 65, 52),
  tipo_zona = c(
    "Urbana", "Valle", "Urbana", "Urbana", "Altoandina"
  )
)

rownames(base) <- base$estacion
variables <- c("pm10_ugm3", "no2_ppb", "ruido_db")

datos <- base[, variables, drop = FALSE]

# Imputación por mediana, igual que en Python y en el Tema 9
for (variable in variables) {
  faltantes <- is.na(datos[[variable]])
  datos[[variable]][faltantes] <- median(
    datos[[variable]],
    na.rm = TRUE
  )
}

cat("DATOS COMPLETOS\n")
print(datos)

matriz_corr <- cor(datos, method = "pearson")

cat("\nMATRIZ DE CORRELACIÓN\n")
print(round(matriz_corr, 4))

stopifnot(
  !anyNA(datos),
  datos["Poroy", "pm10_ugm3"] == 40
)

# Misma carpeta de salida que en Python
usuario <- Sys.getenv("USERPROFILE")

if (!nzchar(usuario)) {
  usuario <- path.expand("~")
}

carpeta <- file.path(usuario, "Downloads", "tema10")
dir.create(carpeta, recursive = TRUE, showWarnings = FALSE)

cat("\nCarpeta de resultados:", carpeta, "\n")

corr_larga <- as.data.frame(matriz_corr) |>
  rownames_to_column(var = "var1") |>
  pivot_longer(
    cols = -var1,
    names_to = "var2",
    values_to = "correlacion"
  )

print(corr_larga)

cat("\nFilas obtenidas:", nrow(corr_larga), "\n")
cat("Filas esperadas:", ncol(matriz_corr)^2, "\n")

stopifnot(nrow(corr_larga) == ncol(matriz_corr)^2)

# Columnas de izquierda a derecha en el orden original
corr_larga$var2 <- factor(
  corr_larga$var2,
  levels = variables
)

# En ggplot2 el eje vertical crece de abajo hacia arriba.
# Invertimos sus niveles para conservar el orden visual de Python.
corr_larga$var1 <- factor(
  corr_larga$var1,
  levels = rev(variables)
)

grafico_ggplot <- ggplot(
  corr_larga,
  aes(x = var2, y = var1, fill = correlacion)
) +
  geom_tile(color = "white", linewidth = 0.7) +
  geom_text(
    aes(label = sprintf("%.2f", correlacion)),
    size = 4
  ) +
  scale_fill_gradient2(
    low = "#3B4CC0",
    mid = "white",
    high = "#B40426",
    midpoint = 0,
    limits = c(-1, 1)
  ) +
  coord_fixed() +
  labs(
    title = "Correlación ambiental con ggplot2",
    x = NULL,
    y = NULL,
    fill = "Correlación\nde Pearson"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_text(angle = 0),
    plot.title = element_text(hjust = 0.5)
  )

print(grafico_ggplot)

ggsave(
  filename = file.path(carpeta, "heatmap_ggplot2.png"),
  plot = grafico_ggplot,
  width = 8,
  height = 6,
  dpi = 300
)

paleta <- colorRampPalette(
  c("#3B4CC0", "white", "#B40426")
)(100)

# Se conserva el agrupamiento por defecto de pheatmap.
# No se especifican cluster_rows ni cluster_cols.
mapa_agrupado <- pheatmap(
  matriz_corr,
  display_numbers = TRUE,
  number_format = "%.2f",
  fontsize_number = 12,
  color = paleta,
  breaks = seq(-1, 1, length.out = 101),
  border_color = "white",
  main = "Correlación con agrupamiento jerárquico",
  filename = file.path(
    carpeta,
    "heatmap_pheatmap_agrupado.png"
  ),
  width = 8,
  height = 6
)

# Mostrar también en la ventana de gráficos de RStudio
grid::grid.newpage()
grid::grid.draw(mapa_agrupado$gtable)

# Obtener el orden real del gráfico
orden_filas <- rownames(matriz_corr)[
  mapa_agrupado$tree_row$order
]

orden_columnas <- colnames(matriz_corr)[
  mapa_agrupado$tree_col$order
]

cat("\nOrden de filas con agrupamiento:\n")
print(orden_filas)

cat("\nOrden de columnas con agrupamiento:\n")
print(orden_columnas)

mapa_sin_agrupar <- pheatmap(
  matriz_corr,
  display_numbers = TRUE,
  number_format = "%.2f",
  fontsize_number = 12,
  cluster_rows = FALSE,
  cluster_cols = FALSE,
  color = paleta,
  breaks = seq(-1, 1, length.out = 101),
  border_color = "white",
  main = "Correlación sin agrupamiento",
  filename = file.path(
    carpeta,
    "heatmap_pheatmap_sin_agrupar.png"
  ),
  width = 8,
  height = 6
)

grid::grid.newpage()
grid::grid.draw(mapa_sin_agrupar$gtable)

cambio_filas <- !identical(
  orden_filas,
  rownames(matriz_corr)
)

cambio_columnas <- !identical(
  orden_columnas,
  colnames(matriz_corr)
)

cat("\nOrden original:\n")
print(colnames(matriz_corr))

cat("\n¿Cambió el orden de filas?", cambio_filas, "\n")
cat("¿Cambió el orden de columnas?", cambio_columnas, "\n")

cat("\nCorrelación NO2 y ruido:",
    round(matriz_corr["no2_ppb", "ruido_db"], 4), "\n")

