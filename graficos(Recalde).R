library(ggplot2)
library(scales)
library(hrbrthemes)
library(ggeasy)
dataa <- read.csv(file.choose())
generoA <- dataa$Genero
duracionA <- dataa$Duracion
#GRAFICO 1 
#creación de boxplot
ggplot(dataa, aes(x=generoA, y=duracionA))+
  geom_boxplot(alpha=0.8)+
  labs(x="Categoria ",
       
       y="Duración")+
  theme_ipsum()+
  ggtitle("Distribucción de la duración de las peliculas de ciencia ficción")+
  ggeasy::easy_center_title()

#GRAFICO 2  
dataAnio <- read.csv(file.choose())

#Diagrama de dispersion
plot(x = dataAnio$Anio, y = dataAnio$Promedio_Rating,
     main = "Dispersión de los rating promedio por año", xlab = "Año de estreno", ylab = "Promedio de rating")
legend(col = c("Black", "Red", "Green", "Lightblue", "Blue"))

#GRAFICO 3 
listado_rating <- read.csv(file.choose())

#creación de gráfico de barras
ggplot(listado_rating, aes(x=Nombre, y=Rating, fill=Genero))+
  geom_bar(stat = "identity")+
  theme_ipsum()+
  theme(legend.position ="none" )+
  
  ggtitle("5 Mejores peliculas Rankeadas")+
  ggeasy::easy_center_title()+
  coord_flip()
