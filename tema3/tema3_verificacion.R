# Tema 3 - Verificacion en R

notas <- c(11, 14, 20, 8, 16, 13)

primero <- notas[1]
ultimo <- notas[6]

print(notas)
print(primero)
print(ultimo)

promedio <- mean(notas)
maximo <- max(notas)
cantidad_aprobados <- sum(notas >= 10.5)

print(paste("Promedio:", promedio))
print(paste("Maximo:", maximo))
print(paste("Aprobados:", cantidad_aprobados))

library(tidyverse)

datos <- data.frame(
  nombre = c("Nicol", "Luis", "Mary", "Paul", "Sofia"),
  nota = c(15, 9, 18, 12, 8),
  asistencia_pct = c(90, 65, 85, 75, 80)
)

print(datos)

filtrados <- datos[
  datos$nota >= 10.5 & datos$asistencia_pct >= 70,
]

print(filtrados)
