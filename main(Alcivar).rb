require 'open-uri' # consultar a la plataforma
require 'nokogiri' # formatear, parsear a html
require 'csv' # escribir y leer csv

#------------------------------------------------------------Jose Alcivar------------------------------------------------------------
class PeliculasPorPais
	
	attr_accessor :enlace, :diccionarioPaises

	def initialize()
		@enlace = "https://www.justwatch.com"
		
		@diccionarioPaises = {"Canada"=>"/ca", "Estados Unidos"=>"/us", "Islas Bermudas"=>"/bm", "Mexico"=>"/mx", "Argentina"=>"/ar",
		"Bolivia"=>"/bo", "Brasil"=>"/br", "Chile"=>"/cl", "Colombia"=>"/co", "Ecuador"=>"/ec", "Paraguay"=>"/py", "Peru"=>"/pe", 
		"Uruguay"=>"/uy", "Venezuela"=>"/ve", "Alemania"=>"/de", "Andorra"=>"/ad", "Ciudad del Vaticano"=>"/va", "Croacia"=>"/hr", 
		"Dinamarca"=>"/dk", "Espana"=>"/es", "Gibraltar"=>"/gi", "Grecia"=>"/gr", "Guernsey"=>"/gg", "Irlanda"=>"/ie", "Islandia"=>"/is", 
		"Italia"=>"/it", "Liechtenstein"=>"/li", "Paises Bajos"=>"/nl", "Moldavia"=>"/md", "Noruega"=>"/no", "Reino Unido"=>"/uk", 
		"Rumania"=>"/ro", "San Marino"=>"/sm", "Serbia"=>"/rs", "Suiza"=>"/ch", "Turquia"=>"/tr", "Corea del Sur"=>"/kr", "Filipinas"=>"/ph",
		"Hong Kong"=>"/hk", "India"=>"/in", "Indonesia"=>"/id", "Japon"=>"/jp", "Malasia"=>"/my", "Pakistan"=>"/pk", "Singapur"=>"/sg", 
		"Tailandia"=>"/th", "Taiwan"=>"/tw", "El Salvador"=>"/sv", "Guatemala"=>"/gt", "Honduras"=>"/hn", "Panama"=>"/pa", "Argelia"=>"/dz",
		"Ghana"=>"/gh", "Guinea Ecuatorial"=>"/gq", "Kenia"=>"/ke", "Libia"=>"/ly", "Marruecos"=>"/ma", "Nigeria"=>"/ng", "Tunez"=>"/tn", 
		"Uganda"=>"/ug", "Zambia"=>"/zm", "Australia"=>"/au", "Fiyi"=>"/fj", "Nueva Zelanda"=>"/nz", "Emiratos Arabes Unidos"=>"/ae", 
		"Lebanoni"=>"/il"}

		CSV.open('peliculasPorPais(Alcivar).csv', 'w') do |csv|
			csv << %w[pais cantidadPeliculas]
		end

		recorrerDatos()
	end

	def recorrerDatos()

		puts("--------------------Extrayendo cantidad de peliculas por pais--------------------\n\n")

		@diccionarioPaises.each do |pais, url|
			enlaceActual1 = @enlace+url

			paginaLeer1 = URI.open(enlaceActual1)
			paginaLeida1 = paginaLeer1.read
			paginaNoko1 = Nokogiri::HTML(paginaLeida1)
			contenedorPrincipal1 = paginaNoko1.css('.filter-bar-content-type').css(".filter-bar-content-type__item")
			proximoEnlace = @enlace+contenedorPrincipal1[1].css('a').attr("href")

			paginaLeer2 = URI.open(proximoEnlace)
			paginaLeida2 = paginaLeer2.read
			paginaNoko2 = Nokogiri::HTML(paginaLeida2)

			resultado = paginaNoko2.css(".total-titles").inner_text.strip
			separador = resultado.split(" ", -1)
			
			if (separador[0].include?(",") || separador[0].include?(".") || separador[0].include?("’"))
				if separador[0].include?(",")
					valor = separador[0].split(",", -1)
					cantidad = (valor[0]+valor[1]).to_i

				elsif separador[0].include?(".")
					valor = separador[0].split(".", -1)
					cantidad = (valor[0]+valor[1]).to_i

				elsif separador[0].include?("’")
					valor = separador[0].split("’", -1)
					cantidad = (valor[0]+valor[1]).to_i
				end

			elsif (separador[1].include?(",") || separador[1].include?(".") || separador[1].include?("’"))
				if separador[1].include?(",")
					valor = separador[1].split(",", -1)
					cantidad = (valor[0]+valor[1]).to_i

				elsif separador[1].include?(".")
					valor = separador[1].split(".", -1)
					cantidad = (valor[0]+valor[1]).to_i

				elsif separador[1].include?("’")
					valor = separador[1].split("’", -1)
					cantidad = (valor[0]+valor[1]).to_i
				end
			end
				
			CSV.open('peliculasPorPais(Alcivar).csv', 'a') do |csv|
				csv << [pais, cantidad]     
			end

			puts("Se hizo scraping a #{pais} en la url " + proximoEnlace + "\n")

		end

		puts("\n--------------------Peliculas por pais, finalizado--------------------\n")
	
	end
	
end


class GenerosPeliculasEcuador
	attr_accessor :enlaceEcuador, :generosPeliculas

	def initialize()
		@enlaceEcuador = "https://www.justwatch.com/ec/peliculas"

		@generosPeliculas = {"Accion y Aventura"=>"act", "Comedia"=>"cmy", "Documental"=>"doc", "Fantasia"=>"fnt", "Terror"=>"hrr", 
			"Musica"=>"msc", "Romance"=>"rma", "Deporte"=>"spt", "Western"=>"wsn", "Animacion"=>"ani", "Crimen"=>"crm", "Drama"=>"drm",
			"Historia"=>"hst", "Familia"=>"fml", "Misterio y Suspenso"=>"trl", "Ciencia ficcion"=>"sfc", "Guerra"=>"war", "Reality TV"=>"rly"}


		CSV.open('GeneroPeliculasEcuador(Alcivar).csv', 'w') do |csv|
			csv << %w[Genero cantidadPeliculas]
		end

		realizarProceso()

	end

	def realizarProceso()
		
		puts("\n------------------------------Extrayendo cantidad de peliculas por genero en Ecuador------------------------------")

		@generosPeliculas.each do |generoPeli, enlaceConsulta|
			
			urlConsulta = "#{enlaceEcuador}?genres=#{enlaceConsulta}"
			
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

			puts("\n#{generoPeli}, consultando la url #{urlConsulta}")

			CSV.open("GeneroPeliculasEcuador(Alcivar).csv", "a") do |csv|
				csv << [generoPeli, cantidadPeliculas]     
			end

		end 

		puts("\n------------------------------Cantidad de peliculas por genero en Ecuador, finalizado------------------------------\n")

	end

end

peliculasEcuador = GenerosPeliculasEcuador.new()

#peliculas = PeliculasPorPais.new()