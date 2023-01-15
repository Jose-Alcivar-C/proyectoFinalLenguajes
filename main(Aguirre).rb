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



require 'open-uri' #consultar a la plataforma
require 'nokogiri' #formatear, parsear a html
require 'csv' #escribir y leer csv
datos_paises=[]
#Poner encabezados
   CSV.open("peliculas_info.csv", "wb") do |csv|
     csv << %w[nombre,pais,duracion,año,votos]

   end
  
pag=1
link=''
# scrapeando peliculas de forma general
while(pag<9)
  if pag==1
    link = 'https://play.pelishouse.me/movies/'
  else
    link = "https://play.pelishouse.me/movies/page/#{pag}/"
  end
  pagina=URI.open(link)
  paginaParsed=Nokogiri::HTML(pagina.read)
  post=paginaParsed.css('#archive-content')
  post.css('.item.movies').each do |peli|
    titulos=peli.css('div.data').css('h3').inner_text
    links_peli=peli.css('div.data').css('h3').css('a').attr("href")
    pagina_peli=URI.open(links_peli)
    paginaParsed2=Nokogiri::HTML(pagina_peli.read)
    paginaParsed2.css('.content.right') .each do |pub|
      
nombre=pub.css('div.data').css('h1').inner_text

pais=pub.css('div.sheader').css('div.extra').css('span.country').inner_text
duracion=pub.css('div.sheader').css('div.extra').css('span.runtime').inner_text
fecha=pub.css('div.extra').css('span.date').inner_text.split(",")
año=fecha[1].strip()

dato=pub.css('div.custom_fields').css('span.valor').css('b').inner_text.split(' ')
imd=dato[0]
Pelicula.new(nombre,pais,duracion,año,imd).guardar
  

 
    end
    

      
     
 end
   pag+=1 
end
