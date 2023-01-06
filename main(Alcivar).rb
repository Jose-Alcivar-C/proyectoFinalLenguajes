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
	
	#def iniciarTodo()
	#	paginaLeer = URI.open(@enlace)
	#	paginaLeida = paginaLeer.read
	#	paginaNoko = Nokogiri::HTML(paginaLeida)

	#	contenedorPrincipal = paginaNoko.css(".row.hidden-xs")

	#	print("Obteniendo los paises disponibles, un momento...\n")

	#	contenedorPrincipal.css(".countries-list__region-content").each do |grupoPaises|
	#		listaPaises = grupoPaises.css("li")

	#		total = 1
	#		listaPaises.each do |seccionPais|
	#			nombrePais = seccionPais.css("a").inner_text.strip
	#			enlacePais = seccionPais.css("a").attr("href").inner_text.strip
	#			
	#			@diccionarioPaises[nombrePais] = enlacePais
	#		end
	#	end

	#	recorrerDatos()

	#end

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

peliculas = PeliculasPorPais.new()