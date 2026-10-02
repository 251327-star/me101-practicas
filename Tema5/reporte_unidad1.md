# Reporte de la Unidad I

Analicé las notas y la asistencia de cinco estudiantes
utilizando los datos limpios del Tema 4.

## a) Estadísticos descriptivos principales

| Variable | Media | Desviación estándar muestral | CV (%) |
|---|---:|---:|---:|
| nota | 16.0000 | 1.5811 | 9.8821 |
| asistencia_pct | 91.2500 | 2.5860 | 2.8340 |

La nota promedio fue de 16 puntos y la asistencia promedio
fue de 91.25 %.

## b) Nivel de dispersión

La función clasificar_dispersion clasificó ambas columnas
con dispersión baja, porque sus coeficientes de variación
son menores que 15 %.

Las notas tienen mayor dispersión relativa que la asistencia,
porque su CV es 9.8821 %, frente al 2.8340 % de la asistencia.

## c) Diferencias entre bibliotecas

La varianza de las notas fue 2 con NumPy y 2.5 con R.
Esto ocurre porque NumPy utiliza n como divisor por defecto,
mientras que R utiliza n - 1 para calcular la varianza muestral.

También encontré diferencias en la curtosis: pandas dio -1.2
y e1071 dio -1.912. Estas bibliotecas utilizan distintas
correcciones para calcularla.
