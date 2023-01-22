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






library(ggplot2)
duraciones_datos = read.csv("peliculas_duracion_minima(Aguirre).csv")
duracion<- duraciones_datos$Duracion
nombre <- duraciones_datos$Pelicula


#ggplot(duraciones_datos, aes(x = reorder(nombre, duracion), y = duracion)) +
 # geom_segment(aes(x = reorder(nombre, duracion),
  #                 xend = reorder(nombre, duracion),
   #                y = 0, yend = duracion),
    #           color = "red", lwd = 1) +
  #geom_point(size = 7 , pch = 21, bg = 4, col = 1) +
  #geom_text(aes(label = duracion), color = "white", size = 3) +
  #scale_x_discrete(labels = paste0("G_", 1:10))+
  #coord_flip() +
  #labs(
   # x = "Películas",
    #y = "Duración",
    #title = "Duración Mínima de películas",
    
#  )