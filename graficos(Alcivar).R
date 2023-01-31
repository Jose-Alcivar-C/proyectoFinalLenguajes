
pregunta1 <- function(){
  
  archivoPaises = read.csv("PeliculasCentroamerica(Alcivar).csv")
  archivoPaises$Pais = factor(archivoPaises$Pais, labels = c("El Salvador", "Guatemala",
                                                 "Honduras", "Panama"))
  
  paises = archivoPaises$Pais
  anio = archivoPaises$Anio
  peliculas = archivoPaises$CantidadPeliculas
  
  colores = c("#009ACD", "#00FF00", "#CDC673", "#AB82FF")

  
  plot(x = anio, y = peliculas, col= colores[paises], pch = 19, xlab = "Año", ylab = "Películas",
       main = "Distribución de las películas en países de Centroamérica",
       sub = "Relación entre el año y la cantidad de películas en cada país.")
   
  legend(x = "topleft", inset = c(0, 0),  cex = 0.7, legend = c("El Salvador", "Guatemala", "Honduras", "Panama"), 
         lty = c(1,1,1,1), col = colores, lwd = 5, title = "Paises", horiz = FALSE)
  
}

#----------

pregunta2 <- function(){
  
  archivoGeneros = read.csv("GenerosPeliculasEcuador(Alcivar).csv")
  
  ordenado = archivoGeneros[order(archivoGeneros$CantidadPeliculas, decreasing = TRUE),]
  
  genero = ordenado$Genero[1:5]
  
  peliculas = ordenado$CantidadPeliculas[1:5]
  
  print(peliculas)
  
  diagrama = barplot(height = peliculas, names = genero, ylim = c(0, 50000),
          col = c("#009ACD", "#00FF00", "#CDC673", "#AB82FF"), main = "Los cinco géneros con mas películas en Ecuador",
          xlab = "Géneros", ylab = "Cantidad de películas")
  
  text(diagrama, peliculas+1500, labels = peliculas)
  
}

#----------

pregunta3 <- function(){
  
  archivoPeliculas = read.csv("GenerosPorAnioEcuador(Alcivar).csv")
  
  genero = archivoPeliculas$Genero
  anio=archivoPeliculas$Anio
  cantidad = archivoPeliculas$CantidadPelis
  
  str(archivoPeliculas)
  
  library(ggplot2)
  
  ggplot( archivoPeliculas, aes(x=anio, y=cantidad, group = genero, colour = genero)) +  
    geom_line(size=1) + geom_point( size=3, shape=21, fill="white") + theme_minimal()+ 
    labs(title="Peliculas de animación, comedia y familia, en Ecuador (2015 - 2022)", x="Año", y="Cantidad de películas") + 
    theme(plot.title = element_text(hjust = 0.5))

}

#----------Llamar a las funciones que grafican cada pregunta----------

pregunta1()

pregunta2()

pregunta3()
