# Uso los mismos valores enteros que en Python
valores <- floor(seq(0, 255, length.out = 5))

gris <- matrix(
  rep(valores, times = 5),
  nrow = 5,
  ncol = 5,
  byrow = TRUE
)

print(gris)
print(dim(gris))
print(mean(gris))#primera parte
rgb <- array(0, dim = c(4, 4, 3))

# Cada mitad contiene 8 píxeles
rgb[, 1:2, ] <- rep(c(255, 0, 0), each = 8)
rgb[, 3:4, ] <- rep(c(0, 255, 0), each = 8)

print(dim(rgb))
print(rgb[1, 1, ])
print(rgb[1, 4, ])#2da parte
gris_luminosidad <- (
  0.299 * rgb[, , 1] +
    0.587 * rgb[, , 2] +
    0.114 * rgb[, , 3]
)

# Elimino los decimales para coincidir con Python
gris_luminosidad <- floor(gris_luminosidad)

print(gris_luminosidad)#era parte
