install.packages("ggplot2")
install.packages("treemapify")
library(ggplot2)
library(treemapify)
setwd("C:/Users/Dennisse/Desktop/proyectoFinalLenguajes")

# Cantidad de películas por país 
pais_datos = read.csv("peliculas_pais(Aguirre).csv")
pais<-pais_datos$Pais
cantidad <- pais_datos$Cantidad

grafico1 <- ggplot(pais_datos, tittle="Cantidad de películas por país",aes(fill = pais, area = cantidad, label = paste0(pais,"\n", cantidad)))
grafico1 <- grafico1 + geom_treemap()
grafico1 <- grafico1 + geom_treemap_text(colour ="white", place = "centre")
grafico1 <- grafico1 + theme(legend.position = "none") + labs( 
                                                              x=NULL, 
                                                              y=NULL, 
                                                              title="Cantidad de películas por país")
grafico1



# Las 10 películas con duración mínima
library(ggplot2)
#setwd("C:/Users/Dennisse/Desktop/proyectoFinalLenguajes")

duraciones_datos = read.csv("peliculas_duracion_minima(Aguirre).csv")
duracion<- duraciones_datos$Duracion
nombre <- duraciones_datos$Pelicula

ggplot(duraciones_datos, aes(x = reorder(nombre, duracion), y = duracion)) +
  geom_segment(aes(x = reorder(nombre, duracion),
                   xend = reorder(nombre, duracion),
                  y = 0, yend = duracion),
             color = "red", lwd = 1) +
  geom_point(size = 7 , pch = 21, bg = 4, col = 1) +
  geom_text(aes(label = duracion), color = "white", size = 3) +
  coord_flip() +
  labs(
    x = "Películas",
    y = "Duración",
    title = "Duración Mínima de películas")
    


# Las 10 mejores películas rankeadas en el 2020
library(ggplot2)
#setwd("C:/Users/Dennisse/Desktop/proyectoFinalLenguajes")
rating_datos = read.csv("peliculas_rating_mayor(Aguirre).csv")
nombre_pelicula<-rating_datos$Pelicula
imd<-rating_datos$Rating
mes<-rating_datos$Mes
mes <- factor(rating_datos$Mes, levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                                      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))

ggplot(rating_datos, aes(x=mes, y = imd, fill = nombre_pelicula)) + 
  geom_bar(stat = "identity",position="dodge") +
  geom_text(aes(label = imd), color = "black")+
  labs(
     x = "Mes",
    y = "Rating",
    title = "Las 10 Mejores películas del 2020",
    
      )



