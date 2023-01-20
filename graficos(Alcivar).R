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

#----------

pregunta2 <- function(){
  
  archivoGeneros = read.csv("GenerosPeliculasEcuador(Alcivar).csv")
  
  ordenado = archivoGeneros[order(archivoGeneros$CantidadPeliculas, decreasing = TRUE),]
  
  genero = ordenado$Genero[1:5]
  
  peliculas = ordenado$CantidadPeliculas[1:5]
  
  print(peliculas)
  
  diagrama = barplot(height = peliculas, names = genero, ylim = c(0, 50000),
          col = c("#009ACD", "#00FF00", "#CDC673", "#AB82FF"), main = "Los cinco generos con mas peliculas en Ecuador",
          xlab = "Generos", ylab = "Cantidad de peliculas")
  
  text(diagrama, peliculas+1500, labels = peliculas)
  
}

#----------Llamar a las funciones que grafican cada pregunta----------

pregunta1()

pregunta2()