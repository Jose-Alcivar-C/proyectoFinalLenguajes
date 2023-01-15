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