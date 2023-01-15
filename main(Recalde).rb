require 'open-uri' # consultar a la plataforma
require 'nokogiri' # formatear, parsear a html
require 'csv' # escribir y leer csv
class PeliculaPorGenero
    #genero
  attr_accessor :genero
    def initialize(genero)
      @genero=genero
    end
  def guardar()
  CSV.open('prueba.csv', 'a') do |csv| 
      csv << %w[Genero Nombre_Pelicula Rating Duracion] 
      pelis=0; pag=1
        while (pelis<7)
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
  genero="accion"
  array_generos=["accion","romance","terror","ciencia-ficcion"]
  array_generos.each do |generoP|
    genero_peliculas = PeliculaPorGenero.new(generoP)
    genero_peliculas.guardar()
  
  end
  
  array_ratingAccion=[]
  array_ratingTerror=[]
  array_duracionCienciaFiccion=[]
  
  cuerpo = File.read("prueba.csv")
    lineas = cuerpo.split("\n")
    i=0
    lineas.each do |linea|
        cadena=linea.split(",")
      
        docrating=cadena[2]
        rating=docrating.to_f
        if(cadena[0]=="accion")
            array_ratingAccion.push(rating)
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
top5RatingTerror=array_ratingTerror.sort! {|x, y| y <=> x}.slice(0,3)
#puts top5Votos
top5RatingTerror.each do |vo|
  archivo = File.read("prueba.csv")
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
        puts " votos"
      end
    end
   end
end

puts "----------Genero: Accion, Top 5 de sus mejores peliculas ----------"
top5RatingAccion=array_ratingAccion.sort! {|x, y| y <=> x}.slice(0,4)
#puts top5Votos
top5RatingAccion.each do |vo|
  archivo = File.read("prueba.csv")
  lineas = archivo.split("\n")
  lineas.each do |linea|
    cadena=linea.split(",")
    docvoto=cadena[2]
    vot=docvoto.to_f
    if(cadena[0]=="accion")
      if(vot==vo)
        print cadena[1] 
        print " OBTUVO "
        print vot
        puts " votos"
      end
    end
   end
end

puts "----------Genero: Romance, Top 5 de sus mejores peliculas ----------"
top5RatingRomance=array_ratingRomance.sort! {|x, y| y <=> x}.slice(0,5)
#puts top5Votos
top5RatingRomance.each do |vo|
  archivo = File.read("prueba.csv")
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
        puts " votos"
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
        CSV.open('pruebaAnio.csv', 'a') do |csv| 
        csv << %w[Anio Nombre_Pelicula Rating] 
        
        pelis=0; pag=1
        while (pelis<5)
            
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
  
    archivoAño = File.read("pruebaAnio.csv")
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
    puts array_rating2018.sum(0.0) / array_rating2018.size
    puts "----------Promedio rating de las peliculas del 2019 ----------"
    puts array_rating2019.sum(0.0) / array_rating2019.size
    puts "----------Promedio rating de las peliculas del 2020 ----------"
    puts array_rating2020.sum(0.0) / array_rating2020.size
    puts "----------Promedio rating de las peliculas del 2021 ----------"
    puts array_rating2021.sum(0.0) / array_rating2021.size
    puts "----------Promedio rating de las peliculas del 2022 ----------"
    puts array_rating2022.sum(0.0) / array_rating2022.size