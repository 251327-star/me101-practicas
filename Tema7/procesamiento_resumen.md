resumen = f"""# Procesamiento de imágenes — Tema 7

## a) Figuras y colores

Creé una caricatura de 120 × 120 píxeles inspirada en mi fotografía.
Utilicé un fondo celeste, cabello negro largo con flequillo,
un vestido verde y un bolso claro.

Dibujé el rostro, los ojos y las flores con elipses; el vestido
y los corazones con polígonos; y los brazos y detalles con líneas.
Agregué flores rosadas, moradas y naranjas con centros amarillos.

## b) Comparación de escala de grises

Para el píxel de fondo {p_fondo}, cuyo RGB es {img.getpixel(p_fondo)},
Pillow produjo {valor_pillow} y scikit-image produjo
{valor_skimage:.4f}, ambos expresados en la escala de 0 a 255.

La diferencia se debe a los distintos pesos aplicados a los canales
RGB y al redondeo del resultado entero de Pillow.

## c) Umbral de Otsu

El umbral obtenido fue {umbral_otsu:.6f} en la escala de 0 a 1.
La proporción de píxeles por encima del umbral fue
{proporcion_true:.6f}, equivalente al {proporcion_true * 100:.2f} %.

También guardé la imagen con GaussianBlur de radio 2 y la imagen
procesada con FIND_EDGES.
"""

Path("procesamiento_resumen.md").write_text(resumen, encoding="utf-8")

print(resumen)
print("Archivo guardado en:", Path("procesamiento_resumen.md").resolve())
