class Pelicula
  attr_accessor :nombre,:pais, :duracion
  def initialize(nombre,pais,duracion)
    @nombre=nombre
    @pais=pais
    @duracion=duracion
    
    
     
  end
  def guardar()
    
    CSV.open("peliculas_info(Aguirre).csv", "a") do |csv|
       if(@pais=="")
         @pais="No especifica"
       end
      if(@duracion=="")
         @duracion="No especifica"
       end
       
       csv<< [@nombre,@pais,@duracion]
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
    
    CSV.open("peliculas_pais(Aguirre).csv", "a") do |csv|
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
    
    CSV.open("peliculas_duracion_minima(Aguirre).csv", "a") do |csv|
       csv<< [@peli,@duracion]   
    end
   
  end
end

class Rating_peli
  attr_accessor :peli,:imd,:mes
  def initialize(peli,imd,mes)
    @peli=peli
    @imd=imd
    @mes=mes
    
     
  end
  def guardar()
    
    CSV.open("peliculas_rating(Aguirre).csv", "a") do |csv|
       csv<< [@peli,@imd,@mes]   
    end
   
  end
end

class Rating_mayor_peli
  attr_accessor :peli,:rating,:mes
  def initialize(peli,rating,mes)
    @peli=peli
    @rating=rating
    @mes=mes
    
     
  end
  def guardar()
    
    CSV.open("peliculas_rating_mayor(Aguirre).csv", "a") do |csv|
       csv<< [@peli,@rating,@mes]   
    end
   
  end
end

require 'open-uri' #consultar a la plataforma
require 'nokogiri' #formatear, parsear a html
require 'csv' #escribir y leer csv

#Poner encabezados

   CSV.open("peliculas_info(Aguirre).csv", "wb") do |csv|
     csv << %w[Nombre Pais Duracion]

   end
   CSV.open("peliculas_pais(Aguirre).csv", "wb") do |csv|
     csv << %w[Pais Cantidad]

   end
   CSV.open("peliculas_duracion_minima(Aguirre).csv", "wb") do |csv|
     csv << %w[Pelicula Duracion]

   end
   CSV.open("peliculas_rating(Aguirre).csv", "wb") do |csv|
     csv << %w[Pelicula IMDb Mes]

  end

   CSV.open("peliculas_rating_mayor(Aguirre).csv", "wb") do |csv|
     csv << %w[Pelicula Rating Mes]

  end
  

pag=1
link=''
# scrapeando peliculas de forma general
puts "-----------------------------Primer scraping----------------------------------------------------"
while(pag<6)
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
    titulo=peli.css('div.data').css('h3').inner_text.gsub ",", " "
    duracion=peli.css('div.metadata').css('span:nth-child(3)').inner_text
    links_peli=peli.css('div.data').css('h3').css('a').attr("href")
    pagina_peli=URI.open(links_peli)
    paginaParsed2=Nokogiri::HTML(pagina_peli.read)
    pais=""
    paginaParsed2.css('.content.right') .each do |pub|
      pais=pub.css('div.sheader').css('div.extra').css('span.country').inner_text
    end
    Pelicula.new(titulo,pais,duracion).guardar
  
    

      
     
 end
   pag+=1 
end

# ¿Cuál es la cantidad de películas por país que tiene la página?
 
array_paises=[]
cuerpo = File.read("peliculas_info(Aguirre).csv")
lineas = cuerpo.split("\n")
lineas.each do |linea|
    cad=linea.split(",")
    pais=cad[1]
    if pais!="No especifica" and pais!="Unknown"and pais!="Pais" 
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
cuerpo = File.read("peliculas_info(Aguirre).csv")
lineas = cuerpo.split("\n")
lineas.each do |linea|
    cad=linea.split(",")
  duracion_peli=cad[2]
  if(duracion_peli!="No especifica" and  cad[0]!="Nombre" )
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
puts "-----------------------------Segundo scraping----------------------------------------------------"
while(pagina<8)
  if pagina==1
    link2 = "https://play.pelishouse.me/release/2020/"
  else
    link2 = "https://play.pelishouse.me/release/2020/page/#{pagina}/"
   
  end
 
  pagina2=URI.open(link2)
  puts "Scrapeando --#{link2} "
  paginaParsed2=Nokogiri::HTML(pagina2.read)
  post2=paginaParsed2.css('div.items.normal')
  post2.css('.item.movies').each do |peli2|
     
     titulo=peli2.css('div.data').css('h3').css('a').inner_text
     dato=peli2.css('div.data').css('span').inner_text.split(".")
     mes=dato[0].strip()
     imd=peli2.css('div.rating').inner_text
    
    
    Rating_peli.new(titulo,imd,mes).guardar
  
      
    
  end
  pagina+=1
  
end

datos_rating={}
datos_mes={}
array_rating=[]
pelis=[]
cuerpo2 = File.read("peliculas_rating(Aguirre).csv")
lineas2 = cuerpo2.split("\n")
lineas2.each do |linea2|
  cad2=linea2.split(",")
  rating_peli=cad2[1]
  rating= rating_peli.to_f
 
  if  array_rating.include?(rating)!=true
     array_rating.push(rating)
     nombre_peli2=cad2[0]
     mes=cad2[2]
     datos_rating[rating]=nombre_peli2
     datos_mes[nombre_peli2]=mes
  end
  
  
end

rating_mayor=array_rating.sort! {|x, y| y <=> x}.slice(0,10)
#puts datos_rating 
rating_mayor.each do |rating_max_peli|
  pelicula_max=datos_rating[rating_max_peli]
  mes=datos_mes[pelicula_max]
  #puts "#{rating_max_peli}"
  Rating_mayor_peli.new(pelicula_max,rating_max_peli,mes).guardar
      
end

