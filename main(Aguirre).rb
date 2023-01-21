class Pelicula
  attr_accessor :nombre,:pais, :duracion, :año,:votos
  def initialize(nombre,pais,duracion,año,votos)
    @nombre=nombre
    @pais=pais
    @duracion=duracion
    @año=año
    @votos=votos
    
     
  end
  def guardar()
    
    CSV.open("peliculas_info.csv", "a") do |csv|
       if(@pais=="")
         @pais="No especifica"
       end
      if(@duracion=="")
         @duracion="No especifica"
       end
       if(@votos=="")
         @votos="No aplica"
       end
       
       csv<< [@nombre,@pais,@duracion,@año,@votos]
    end
   
  end
end

class Pais_peli
  attr_accessor :nombre,:cantidad
  def initialize(nombre,cantidad)
    @nombre=nombre
    @cantidad=cantidad
    
     
  end
  def guardar()
    
    CSV.open("peliculas_pais.csv", "a") do |csv|
       csv<< [@nombre,@cantidad]   
    end
   
  end
end

class Duracion_peli
  attr_accessor :peli,:duracion
  def initialize(peli,duracion)
    @peli=peli
    @duracion=duracion
    
     
  end
  def guardar()
    
    CSV.open("peliculas_duracion_minima.csv", "a") do |csv|
       csv<< [@peli,@duracion]   
    end
   
  end
end

class Rating_peli
  attr_accessor :peli,:imd
  def initialize(peli,imd)
    @peli=peli
    @imd=imd
    
     
  end
  def guardar()
    
    CSV.open("peliculas_rating.csv", "a") do |csv|
       csv<< [@peli,@imd]   
    end
   
  end
end

class Rating_mayor_peli
  attr_accessor :peli,:rating
  def initialize(peli,rating)
    @peli=peli
    @rating=rating
    
     
  end
  def guardar()
    
    CSV.open("peliculas_rating_mayor.csv", "a") do |csv|
       csv<< [@peli,@rating]   
    end
   
  end
end

require 'open-uri' #consultar a la plataforma
require 'nokogiri' #formatear, parsear a html
require 'csv' #escribir y leer csv

#Poner encabezados

   CSV.open("peliculas_info.csv", "wb") do |csv|
     csv << %w[nombre,pais,duracion,año,votos]

   end
   CSV.open("peliculas_pais.csv", "wb") do |csv|
     csv << %w[pais,cantidad]

   end
   CSV.open("peliculas_duracion_minima.csv", "wb") do |csv|
     csv << %w[pelicula,duracion]

   end
   CSV.open("peliculas_rating.csv", "wb") do |csv|
     csv << %w[pelicula,IMDb]

  end

   CSV.open("peliculas_rating_mayor.csv", "wb") do |csv|
     csv << %w[pelicula,rating]

  end
  
  
pag=1
link=''
# scrapeando peliculas de forma general

while(pag<8)
  if pag==1
    link = 'https://play.pelishouse.me/movies/'
  else
    link = "https://play.pelishouse.me/movies/page/#{pag}/"
  end
  pagina=URI.open(link)
  puts "Scrapeando --#{link}"
  paginaParsed=Nokogiri::HTML(pagina.read)
  post=paginaParsed.css('#archive-content')
  post.css('.item.movies').each do |peli|
    titulos=peli.css('div.data').css('h3').inner_text
    links_peli=peli.css('div.data').css('h3').css('a').attr("href")
    pagina_peli=URI.open(links_peli)
    paginaParsed2=Nokogiri::HTML(pagina_peli.read)
    paginaParsed2.css('.content.right') .each do |pub|
      
nombre=pub.css('div.data').css('h1').inner_text.gsub ",", " "

pais=pub.css('div.sheader').css('div.extra').css('span.country').inner_text
duracion=pub.css('div.sheader').css('div.extra').css('span.runtime').inner_text
fecha=pub.css('div.extra').css('span.date').inner_text.split(",")
año=fecha[1].strip()

dato=pub.css('div.custom_fields').css('span.valor').css('b').inner_text.split(' ')
imd=dato[0]
    #  puts nombre,pais,duracion,año,imd
Pelicula.new(nombre,pais,duracion,año,imd).guardar
  

 
    end
    

      
     
 end
   pag+=1 
end


# ¿Cuál es la cantidad de películas por país que tiene la página?
 
array_paises=[]
cuerpo = File.read("peliculas_info.csv")
lineas = cuerpo.split("\n")
lineas.each do |linea|
    cad=linea.split(",")
    pais=cad[1]
    if pais!="No especifica" and pais!="Unknown"and pais!="pais" 
      array_paises.push(pais)
    end 
end
datos_paises={}
for p in array_paises
   if datos_paises.has_key?(p)
	datos_paises[p] += 1
  else
	datos_paises[p] = 1
  end
    
end
#puts datos_paises
datos_paises.each do |llave, valor|
 #puts "#{llave}, con #{valor} peliculas"
   Pais_peli.new(llave,valor).guardar
end

#¿Cuáles son las 10 películas que tienen una duración en minutos mínima en la página?
 

datos_duracion={}
array_duracion=[]
cuerpo = File.read("peliculas_info.csv")
lineas = cuerpo.split("\n")
lineas.each do |linea|
    cad=linea.split(",")
  duracion_peli=cad[2]
  if(duracion_peli!="No especifica" and duracion_peli!="duracion" )
    separando=duracion_peli.split(" ")
    duracion_1=separando[0]
     duracion_min= duracion_1.to_i
     array_duracion.push(duracion_min)
     nombre_peli=cad[0]
    datos_duracion[duracion_min]=nombre_peli
     
  end
end

duracion_minima=array_duracion.sort! {|x, y| x <=> y}.slice(0,10)
duracion_minima.each do |duracion_min_peli|
    pelicula_ord=datos_duracion[duracion_min_peli]
    #puts "#{pelicula_ord}, con #{duracion_min_peli} min"
    Duracion_peli.new(pelicula_ord,duracion_min_peli).guardar
end

#¿Cuáles son las 10 mejores películas rankeadas en el 2020?


pagina=1
link2=''

while(pagina<8)
  if pagina==1
    link2 = "https://play.pelishouse.me/release/2020/"
  else
    link2 = "https://play.pelishouse.me/release/2020/page/#{pagina}/"
   
  end
 # puts "Scrapeando --#{link2} "
  pagina2=URI.open(link2)
  paginaParsed2=Nokogiri::HTML(pagina2.read)
  post2=paginaParsed2.css('div.items.normal')
  post2.css('.item.movies').each do |peli2|
     links_peli2=peli2.css('div.data').css('h3').css('a').attr("href")
     
    pagina_peli2=URI.open(links_peli2)
    paginaParsed2=Nokogiri::HTML(pagina_peli2.read)
    paginaParsed2.css('.content.right') .each do |pub2|
      nombre2=pub2.css('div.data').css('h1').inner_text.gsub ",", " "
dato2=pub2.css('div.custom_fields').css('span.valor').css('b').inner_text.split(' ')
  imd2=dato2[0]
  puts "#{nombre2}, con #{imd2}"
  Rating_peli.new(nombre2,imd2).guardar
  
      
    end
  end
  pagina+=1
  
end

datos_rating={}
array_rating=[]
pelis=[]
cuerpo2 = File.read("peliculas_rating.csv")
lineas2 = cuerpo2.split("\n")
lineas2.each do |linea2|
  cad2=linea2.split(",")
  rating_peli=cad2[1]
  rating= rating_peli.to_f
 
  if rating!=0.0 and array_rating.include?(rating)!=true
     array_rating.push(rating)
     nombre_peli2=cad2[0]
     datos_rating[rating]=nombre_peli2
  end
  
  
end
 
rating_mayor=array_rating.sort! {|x, y| y <=> x}.slice(0,10)
puts datos_rating 
rating_mayor.each do |rating_max_peli|
  pelicula_max=datos_rating[rating_max_peli]
  puts "#{rating_max_peli}"
  Rating_mayor_peli.new(pelicula_max,rating_max_peli).guardar
      
  end



