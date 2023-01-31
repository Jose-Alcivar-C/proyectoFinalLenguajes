install.packages("ggplot2")
install.packages("scales")
install.packages("hrbrthemes")
install.packages("ggeasy")

library(ggplot2)
library(scales)
library(hrbrthemes)
library(ggeasy)


#GRAFICO 1
#Top 5 de las mejores peliculas rankeadas por Genero
data_rating <- read.csv("G_peliculasRankeadas(Recalde).csv")

ggplot(data_rating, aes(x=Pelicula, y=Rating, fill=Genero))+
  geom_bar(stat = "identity")+
  theme_ipsum()+
  theme(legend.position ="right" )+
  geom_text(aes(label=Rating), nudge_y = 2)+
  
  ggtitle("Top 5 de pel?culas por g?nero")+
  ggeasy::easy_center_title()+
  coord_flip()

#GRAFICO 2
#Dispersion del rating promedio por a?o 2018-2022

data_RatingPromedio <- read.csv("G_PromedioRating(Recalde).csv")

plot(x = data_RatingPromedio$Anio, y = data_RatingPromedio$Promedio_Rating,
     main = "Dispersi?n del rating promedio por a?o", 
     xlab = "A?o de estreno",
     ylab = "Promedio de rating",
     col = c("violetred", "Red", "Green", "Lightblue", "Blue"),
     pch=19, cex=1.5)
 

#GRAFICO 3 
#Distribucion de la duraci?n de las peliculas
dataPeliculasGenero <- read.csv("peliculasPorGenero(Recalde).csv")
boxplot(dataPeliculasGenero$Duracion ~ dataPeliculasGenero$Genero,
        main = "Distribucci?n de la duraci?n de las peliculas por categor?a",
        xlab = "Categor?a",
        ylab = "Duraci?n",
        las = 1,
        col = c("violetred", "steelblue1", "salmon1", "palegoldenrod"),
        names= c("Ciencia Ficci?n", "Misterio", "Romance", "Terror")
)
