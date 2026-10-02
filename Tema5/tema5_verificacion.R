library(tidyverse)
library(e1071)

estudiantes_limpio_R <- read_csv("estudiantes_limpio_R.csv")
View(estudiantes_limpio_R)

notas <- estudiantes_limpio_R$nota

media <- mean(notas, na.rm = TRUE)
mediana <- median(notas, na.rm = TRUE)
desv_std <- sd(notas, na.rm = TRUE)
varianza <- var(notas, na.rm = TRUE)
q1 <- quantile(notas, 0.25, na.rm = TRUE)
q3 <- quantile(notas, 0.75, na.rm = TRUE)
iqr <- IQR(notas, na.rm = TRUE)

cat("Media:", media, "\n")
cat("Mediana:", mediana, "\n")
cat("Desviación estándar:", desv_std, "\n")
cat("Varianza muestral:", varianza, "\n")
cat("Q1:", q1, "\n")
cat("Q3:", q3, "\n")
cat("IQR:", iqr, "\n")
asimetria <- e1071::skewness(notas, na.rm = TRUE)
curtosis <- e1071::kurtosis(notas, na.rm = TRUE)

cat("Asimetría:", asimetria, "\n")
cat("Curtosis:", curtosis, "\n")
resumen_estadistico <- function(vector, decimales = 4) {
  datos <- vector[!is.na(vector)]
  
  media <- mean(datos)
  mediana <- median(datos)
  desv_std <- sd(datos)
  
  if (is.na(media) || media == 0) {
    cv_pct <- NA_real_
  } else {
    cv_pct <- desv_std / media * 100
  }
  
  return(list(
    n = length(datos),
    media = round(media, decimales),
    mediana = round(mediana, decimales),
    desv_std = round(desv_std, decimales),
    cv_pct = round(cv_pct, decimales)
  ))
}

print(resumen_estadistico(estudiantes_limpio_R$nota))
clasificar_dispersion <- function(cv_pct) {
  if (is.na(cv_pct)) {
    return("No calculable")
  } else if (cv_pct < 15) {
    return("Baja")
  } else if (cv_pct < 30) {
    return("Moderada")
  } else {
    return("Alta")
  }
}

for (columna in c("nota", "asistencia_pct")) {
  datos <- estudiantes_limpio_R[[columna]]
  datos <- datos[!is.na(datos)]
  
  resumen <- resumen_estadistico(datos)
  
  if (is.na(mean(datos)) || mean(datos) == 0) {
    cv <- NA_real_
  } else {
    cv <- sd(datos) / mean(datos) * 100
  }
  
  cat("\nColumna:", columna, "\n")
  print(resumen)
  cat("Dispersión:", clasificar_dispersion(cv), "\n")
}