require 'open-uri' # consultar a la plataforma
require 'nokogiri' # formatear, parsear a html
require 'csv' # escribir y leer csv

#------------------------------------------------------------Jose Alcivar------------------------------------------------------------
class PeliculasPorAnioCentroamerica
	
	attr_accessor :diccionarioPaises, :enlaceBase

	def initialize()

		@enlaceBase = "https://www.justwatch.com"

		@diccionarioPaises = {"El Salvador"=>"/sv", "Guatemala"=>"/gt", "Honduras"=>"/hn", "Panama"=>"/pa"}

		realizarProceso()

	end 

	def realizarProceso()
		
		puts("\n------------------------------Extrayendo peliculas de genero drama por anio en Centroamerica------------------------------\n")
		
		CSV.open("PeliculasCentroamerica(Alcivar).csv", "wb") do |csv|
			
			csv << %w[Pais Anio CantidadPeliculas]
			
			@diccionarioPaises.each do |pais, ruta|

				puts("")

				for anio in (2000..2022)
					
					enlace = "#{@enlaceBase}#{ruta}/peliculas?genres=drm&release_year_from=#{(anio).to_s}&release_year_until=#{(anio).to_s}"

					puts("#{pais} en el anio #{(anio).to_s}, consultando url #{enlace}")

					paginaLeer = URI.open(enlace)
					paginaLeida = paginaLeer.read
					paginaNoko = Nokogiri::HTML(paginaLeida)

					resultado = paginaNoko.css(".total-titles").inner_text.strip
					resultadoSeparado = resultado.split(" ", -1)

					preCantidadPeliculas = resultadoSeparado[0]

					if( preCantidadPeliculas.include?(","))
						numero = preCantidadPeliculas.split(",")
						cantidadPeliculas = (numero[0]+numero[1]).to_i
					else
						cantidadPeliculas = (preCantidadPeliculas).to_i
					end
					
					csv << [pais, anio, cantidadPeliculas]     
					
				end 

			end

		end

		puts("\n------------------------------Peliculas de genero drama por anio en Centroamerica, finalizado------------------------------\n")

	end

end

############################################################################

class GenerosPeliculasEcuador
	
	attr_accessor :enlaceEcuador, :generosPeliculas

	def initialize()
		@enlaceEcuador = "https://www.justwatch.com/ec/peliculas"

		@generosPeliculas = {"Accion y Aventura"=>"act", "Comedia"=>"cmy", "Documental"=>"doc", "Fantasia"=>"fnt", "Terror"=>"hrr", 
			"Musica"=>"msc", "Romance"=>"rma", "Deporte"=>"spt", "Western"=>"wsn", "Animacion"=>"ani", "Crimen"=>"crm", "Drama"=>"drm",
			"Historia"=>"hst", "Familia"=>"fml", "Misterio y Suspenso"=>"trl", "Ciencia ficcion"=>"sfc", "Guerra"=>"war", "Reality TV"=>"rly"}

		realizarProceso()

	end

	def realizarProceso()
		
		puts("\n\n\n------------------------------Extrayendo cantidad de peliculas por genero en Ecuador------------------------------\n\n")

		CSV.open("GenerosPeliculasEcuador(Alcivar).csv", "wb") do |csv|

			csv << %w[Genero CantidadPeliculas]

			@generosPeliculas.each do |generoPeli, enlaceConsulta|
				
				urlConsulta = "#{enlaceEcuador}?genres=#{enlaceConsulta}"

				puts("#{generoPeli}, consultando la url #{urlConsulta}")

				paginaLeer = URI.open(urlConsulta)
				paginaLeida = paginaLeer.read
				paginaNoko = Nokogiri::HTML(paginaLeida)
				
				resultado = paginaNoko.css(".total-titles").inner_text.strip
				resultadoSeparado = resultado.split(" ", -1)

				preCantidadPeliculas = resultadoSeparado[0]

				if( preCantidadPeliculas.include?("."))
					numero = preCantidadPeliculas.split(".")
					cantidadPeliculas = (numero[0]+numero[1]).to_i
				else
					cantidadPeliculas = (preCantidadPeliculas).to_i
				end

				csv << [generoPeli, cantidadPeliculas]     

			end 
		
		end

		puts("\n------------------------------Cantidad de peliculas por genero en Ecuador, finalizado------------------------------\n")

	end

end

############################################################################

class GenerosPorAnioEcuador

	attr_accessor :generosPeliculas, :enlaceBase

	def initialize()
		
		@generosPeliculas = {"Comedia"=>"cmy", "Animacion"=>"ani", "Familia"=>"fml"}
		
		@enlaceBase = "https://www.justwatch.com/ec/peliculas"

		realizarProceso()

	end 

	def realizarProceso()

		puts("\n\n\n------------------------------Extrayendo peliculas de comedia, animacion y familia por anio en Ecuador------------------------------\n")

		CSV.open("GenerosPorAnioEcuador(Alcivar).csv", "wb") do |csv|

			csv << %w[Genero Anio CantidadPelis]
			
			@generosPeliculas.each do |genero, ruta|

				puts("")

				for anio in (2015..2022)
					enlace = "#{enlaceBase}?genres=#{ruta}&release_year_from=#{(anio).to_s}&release_year_until=#{(anio).to_s}"

					puts("#{genero} en el anio #{(anio).to_s}, consultando la url #{enlace}")

					paginaLeer = URI.open(enlace)
					paginaLeida = paginaLeer.read
					paginaNoko = Nokogiri::HTML(paginaLeida)

					resultado = paginaNoko.css(".total-titles").inner_text.strip
					resultadoSeparado = resultado.split(" ", -1)

					preCantidadPeliculas = resultadoSeparado[0]

					if( preCantidadPeliculas.include?("."))
						numero = preCantidadPeliculas.split(".")
						cantidadPeliculas = (numero[0]+numero[1]).to_i
					else
						cantidadPeliculas = (preCantidadPeliculas).to_i
					end
					
					csv << [genero, anio, cantidadPeliculas]

				end

			end 
		
		end

		puts("\n------------------------------Peliculas de comedia, animacion y familia por anio en Ecuador, finalizado------------------------------\n")

	end 

end 

############################################################################

peliculasCentroamerica = PeliculasPorAnioCentroamerica.new() #peliculas de genero drama en paises de centroamerica entre 2000 y 2022

generosPeliculasEcuador = GenerosPeliculasEcuador.new() #cantidad de peliculas por cada genero en Ecuador

generosPorAnio = GenerosPorAnioEcuador.new() #generos comedia, animacion y familia en Ecuador entre 2015 y 2022
