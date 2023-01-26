require 'open-uri' # consultar a la plataforma
require 'nokogiri' # formatear, parsear a html
require 'csv' # escribir y leer csv
#Encabezados de archivos
CSV.open('peliculasPorGenero(Recalde).csv', 'wb') do |csv|
  csv << %w[Genero Nombre_Pelicula Rating Duracion]
end
CSV.open('peliculasPorAnio(Recalde).csv', 'wb') do |csv|
  csv << %w[Anio Nombre_Pelicula Rating]
end
class PeliculaPorGenero
    #genero
  attr_accessor :genero
    def initialize(genero)
      @genero=genero
    end
  def guardar()
  CSV.open('peliculasPorGenero(Recalde).csv', 'a') do |csv| 
      pelis=0; pag=1
        while (pelis<4)
            link = "https://www1.pelisgratishd.io/genero/#{genero}/page/#{pag}/"
            pagina = URI.open(link)
            paginaParsed = Nokogiri::HTML(pagina.read)
            itemsP= paginaParsed.css('.items')
            prueb=itemsP.css('article')
      
            prueb.each do |item|
                titulo= item.css('.data').inner_text
                rating=item.css('div').css('.rating').inner_text
                duracion= item.css('.imdb + span + span').inner_text
                csv << [@genero.to_s,titulo.to_s,rating.to_f,duracion.to_i]
              
            end
            pelis+=1
            pag+=1
      end
  end
  
  end
  end
  #genero="misterio"
  array_generos=["misterio","romance","terror","ciencia-ficcion"]
  array_generos.each do |generoP|
    genero_peliculas = PeliculaPorGenero.new(generoP)
    genero_peliculas.guardar()
  
  end
  
  array_ratingmisterio=[]
  array_ratingRomance=[]
  array_ratingTerror=[]
  array_duracionCienciaFiccion=[]
  
  cuerpo = File.read("peliculasPorGenero(Recalde).csv")
    lineas = cuerpo.split("\n")
    i=0
    lineas.each do |linea|
        cadena=linea.split(",")
      
        docrating=cadena[2]
        rating=docrating.to_f
        if(cadena[0]=="misterio")
            array_ratingmisterio.push(rating)
        elsif (cadena[0]=="romance")
            array_ratingRomance.push(rating)
        elsif (cadena[0]=="terror")
            array_ratingTerror.push(rating)
        elsif (cadena[0]=="ciencia-ficcion")
            docduracion=cadena[3]
            duracion=docduracion.to_f
            array_duracionCienciaFiccion.push(duracion)
        end
        i+=1
    end

#puts array_duracionCienciaFiccion
puts "----------Genero: Terror, Top 5 de sus mejores peliculas ----------"
top5RatingTerror=array_ratingTerror.sort! {|x, y| y <=> x}.slice(0,5)
#puts top5Votos
CSV.open('G_peliculasRankeadas(Recalde).csv', 'a') do |csv| 
csv << %w[Genero Pelicula Rating]
top5RatingTerror.each do |vo|
  archivo = File.read("peliculasPorGenero(Recalde).csv")
  lineas = archivo.split("\n")
  lineas.each do |linea|
    cadena=linea.split(",")
    docvoto=cadena[2]
    vot=docvoto.to_f
    if(cadena[0]=="terror")
      if(vot==vo)
        print cadena[1] 
        print " OBTUVO "
        print vot
        puts " en rating"
        genero="Terror"
        csv << [genero,cadena[1],vot]

      end
    end
   end
end
end

puts "----------Genero: misterio, Top 5 de sus mejores peliculas ----------"
top5Ratingmisterio=array_ratingmisterio.sort! {|x, y| y <=> x}.slice(0,5)
#puts top5Votos
CSV.open('G_peliculasRankeadas(Recalde).csv', 'a') do |csv| 
top5Ratingmisterio.each do |vo|
  archivo = File.read("peliculasPorGenero(Recalde).csv")
  lineas = archivo.split("\n")
  lineas.each do |linea|
    cadena=linea.split(",")
    docvoto=cadena[2]
    vot=docvoto.to_f
    if(cadena[0]=="misterio")
      if(vot==vo)
        print cadena[1] 
        print " OBTUVO "
        print vot
        puts " en rating"
        genero="Misterio"
        csv << [genero,cadena[1],vot]
      end
    end
   end
end
end

puts "----------Genero: Romance, Top 5 de sus mejores peliculas ----------"
top5RatingRomance=array_ratingRomance.sort! {|x, y| y <=> x}.slice(0,5)
#puts top5Votos
CSV.open('G_peliculasRankeadas(Recalde).csv', 'a') do |csv|
top5RatingRomance.each do |vo|
  archivo = File.read("peliculasPorGenero(Recalde).csv")
  lineas = archivo.split("\n")
  lineas.each do |linea|
    cadena=linea.split(",")
    docvoto=cadena[2]
    vot=docvoto.to_f
    if(cadena[0]=="romance")
      if(vot==vo)
        print cadena[1] 
        print " OBTUVO "
        print vot
        puts " en rating"
        genero="Romance"
        csv << [genero,cadena[1],vot]
      end
    end
   end
end
end
puts "----------Distribucción de la duración de las peliculas de ciencia ficción ----------"
#En pantalla se mostrará 10 distribuciones, en la grafica en R estarán todos los datos que contiene el array
puts array_duracionCienciaFiccion.slice(0,10)

class PeliculaPorAnio
    
    attr_accessor :anio
    def initialize(anio)
      @anio=anio
    end
    def guardar()
        CSV.open('peliculasPorAnio(Recalde).csv', 'a') do |csv| 
        
        
        pelis=0; pag=1
        while (pelis<4)
            
            link = "https://www1.pelisgratishd.io/estrenos/#{anio}/page/#{pag}/"
            pagina = URI.open(link)
            paginaParsed = Nokogiri::HTML(pagina.read)
            itemsP= paginaParsed.css('.items')
            prueb=itemsP.css('article')
        
            prueb.each do |item|
                titulo= item.css('.data').inner_text
                rating=item.css('div').css('.rating').inner_text
                
                duracion= item.css('.imdb + span + span').inner_text
                csv << [@anio.to_s,titulo.to_s,rating.to_f]
                
            end
            pelis+=1
            pag+=1
        end

    end
    
    end
    end
    array_anio=["2018","2019","2020","2021","2022"]
    array_anio.each do |anioP|
        anio_peliculas = PeliculaPorAnio.new(anioP)
        anio_peliculas.guardar()
    
    end
    array_rating2018=[]
    array_rating2019=[]
    array_rating2020=[]
    array_rating2021=[]
    array_rating2022=[]
  
    archivoAño = File.read("peliculasPorAnio(Recalde).csv")
        lineas = archivoAño.split("\n")
        i=0
        lineas.each do |linea|
        cadena=linea.split(",")
        docrating=cadena[2]
        rating=docrating.to_f
        if(cadena[0]=="2018")
            array_rating2018.push(rating)
        elsif (cadena[0]=="2019")
            array_rating2019.push(rating)
            elsif (cadena[0]=="2020")
            array_rating2020.push(rating)
        elsif (cadena[0]=="2021")
            array_rating2021.push(rating)
        elsif (cadena[0]=="2022")
            array_rating2022.push(rating)
            
        end
      i+=1
    end
    puts "----------Promedio rating de las peliculas del 2018 ----------"
    promedioRating2018= array_rating2018.sum(0.0) / array_rating2018.size
    puts promedioRating2018
    puts "----------Promedio rating de las peliculas del 2019 ----------"
    promedioRating2019= array_rating2019.sum(0.0) / array_rating2019.size
    puts promedioRating2019
    puts "----------Promedio rating de las peliculas del 2020 ----------"
    promedioRating2020= array_rating2020.sum(0.0) / array_rating2020.size
    puts promedioRating2020
    puts "----------Promedio rating de las peliculas del 2021 ----------"
    promedioRating2021= array_rating2021.sum(0.0) / array_rating2021.size
    puts promedioRating2021
    puts "----------Promedio rating de las peliculas del 2022 ----------"
    promedioRating2022= array_rating2022.sum(0.0) / array_rating2022.size
    puts promedioRating2022
    CSV.open('G_PromedioRating(Recalde).csv', 'a') do |csv| 
      csv << %w[Anio Promedio_Rating]
      csv << [2018,promedioRating2018.to_f]
      csv << [2019,promedioRating2019.to_f]
      csv << [2020,promedioRating2020.to_f]
      csv << [2021,promedioRating2021.to_f]
      csv << [2022,promedioRating2022.to_f]
    end


class CienciaFiccionDuracion
  def guardar()
    CSV.open('G_CienciaFiccion(Recalde).csv', 'a') do |csv| 
      csv << %w[Genero Nombre_Pelicula Duracion]
      pelis=0; pag=1
      while (pelis<5)
        link="https://www1.pelisgratishd.io/genero/ciencia-ficcion/page/#{pag}/"

        pagina = URI.open(link)
        paginaParsed = Nokogiri::HTML(pagina.read)
        itemsP= paginaParsed.css('.items')
        prueb=itemsP.css('article')
 
        prueb.each do |item|
            titulo= item.css('.data').inner_text
            rating=item.css('div').css('.rating').inner_text
            duracion= item.css('.imdb + span + span').inner_text
            genero="Ciencia Ficción"
            csv << [genero.to_s,titulo.to_s,duracion.to_f]
            
        end
        pelis+=1
        pag+=1

      end


    end

  end

end
distribucion_CienciaFiccion = CienciaFiccionDuracion.new()
distribucion_CienciaFiccion.guardar()