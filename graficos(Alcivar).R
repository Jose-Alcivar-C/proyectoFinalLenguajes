pregunta1 <- function(){
  
  archivoPaises = read.csv("PeliculasCentroamerica(Alcivar).csv")
  archivoPaises$Pais = factor(archivoPaises$Pais, labels = c("El Salvador", "Guatemala",
                                                 "Honduras", "Panama"))
  
  paises = archivoPaises$Pais
  anio = archivoPaises$Anio
  peliculas = archivoPaises$CantidadPeliculas
  
  colores = c("#009ACD", "#00FF00", "#CDC673", "#AB82FF")
  
  plot(anio, peliculas, col= colores[paises], pch = 19, xlab = "Año", ylab = "Películas",
       main = "Distribución de las películas en países de Centroamérica",
       sub = "Relación entre el año y la cantidad de películas en cada país.")
  
  axis(1, tck = 1, lty = 2, col = "gray")
  
  axis(2, tck = 1, lty = 2, col = "gray")
  
  legend(x = "topleft", legend = c("El Salvador", "Guatemala", "Honduras", "Panama"), 
        fill = colores, title = "Paises")
  
}

pregunta1()