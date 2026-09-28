# Leer el archivo CSV
df <- read_csv("C:/Users/51950/Downloads/estudiantes (1).xls")

# Mostrar la estructura
glimpse(df)

# Contar valores faltantes por columna
colSums(is.na(df))
# Eliminar filas donde falta la nota
df_limpio <- df %>%
  drop_na(nota) %>%
  mutate(asistencia_pct = replace_na(
    asistencia_pct,
    mean(asistencia_pct, na.rm = TRUE)
  ))

# Verificar que no queden valores faltantes
colSums(is.na(df_limpio))

# Mostrar los datos limpios
df_limpio

# Promedio de nota por curso
promedio_por_curso <- df_limpio %>%
  group_by(curso) %>%
  summarise(promedio_nota = mean(nota))

print(promedio_por_curso)
# Guardar el archivo limpio
write_csv(df_limpio, "estudiantes_limpio_R.csv")

print("Archivo estudiantes_limpio_R.csv guardado correctamente.")
