# Resumen de mapas de calor — Tema 10

**Estudiante:** Nicol Yasmin Labra Qqueccaño  
**Curso:** Programación Estadística y Visualización de Datos

## Datos utilizados

Utilicé los mismos datos ambientales del Tema 9, correspondientes
a cinco estaciones: Centro, San Jerónimo, Wanchaq, San Sebastián
y Poroy. Seleccioné las variables PM10, NO₂ y ruido.

El dato faltante de PM10 de Poroy se reemplazó por la mediana
de los valores disponibles, que fue 40. Después calculé
la matriz de correlación de Pearson.

## Herramienta más rápida de utilizar

Seaborn me pareció la herramienta más rápida para construir
un mapa de calor anotado. Con sns.heatmap() pude configurar
los colores, mostrar los coeficientes y agregar la barra de color
en una sola llamada.

Con imshow() necesité agregar las etiquetas y las anotaciones
manualmente. En ggplot2 tuve que convertir primero la matriz
a formato largo. Por su parte, pheatmap facilitó la incorporación
del agrupamiento jerárquico.

## Agrupamiento con pheatmap

Con estos datos, el orden obtenido con el agrupamiento por defecto
se mantiene como PM10, NO₂ y ruido, igual que en la versión
sin agrupamiento.

NO₂ y ruido ya estaban adyacentes en el orden original y tienen
los perfiles de correlación más semejantes. Su correlación
de Pearson es aproximadamente 0.9844.

Aunque el orden no cambie, los dendrogramas permiten observar
cómo se agrupan las variables según su semejanza.

## Matriz de correlación de Pearson

| Variable | pm10_ugm3 | no2_ppb | ruido_db |
|---|---:|---:|---:|
| pm10_ugm3 | 1.0000 | 0.8522 | 0.7940 |
| no2_ppb | 0.8522 | 1.0000 | 0.9844 |
| ruido_db | 0.7940 | 0.9844 | 1.0000 |

Las tres asociaciones son positivas. La relación más alta
corresponde a NO₂ y ruido, seguida de PM10 y NO₂.
La asociación entre PM10 y ruido es la menor de las tres,
aunque también es elevada.

Estos resultados describen únicamente las cinco estaciones
analizadas. El tamaño pequeño de la muestra y la imputación
de un dato deben considerarse al interpretar las correlaciones.
Una correlación alta no demuestra causalidad.

## Máscara triangular

La matriz completa contiene nueve celdas. Al ocultar el triángulo
superior y la diagonal, quedan tres correlaciones únicas visibles.
Esto evita repetir información, porque la matriz es simétrica.
