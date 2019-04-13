require "json"
require "open-uri"

puts "Olá, humano! Vamos testar seus conhecimentos de geografia, sim ou nao?"
aceitar = gets.chomp
if aceitar.downcase == "sim"
  puts "Vem comigo! Essa maquina conhece os quatro cantos do mundo."

  while true
    puts "Digite o nome de uma cidade."
    cidade = gets.chomp 
    
    find_url = "http://geodb-free-service.wirefreethought.com/v1/geo/cities?namePrefix=#{cidade}&limit=1&offset=0&hateoasMode=false"
    find_response = JSON.parse(open(find_url).read())
    
    if find_response["data"][0] != nil
      find_response = find_response["data"][0]
    
      city_id = find_response["id"]
    
      data_url = "http://geodb-free-service.wirefreethought.com/v1/geo/cities/#{city_id}"
      data_response = JSON.parse(open(data_url).read())
    
      if data_response["data"] != nil
        data_response = data_response["data"]
    
        population = data_response["population"].to_f
        city_name = data_response["city"]

        print "Eu ja sei o numero de habitantes de #{city_name}, mas, e voce, consegue adivinhar? Tente um número mais próximo."
        puts "\n"
        pop = gets.chomp.to_f
        radius = pop / population

        if radius >= 0.9 and radius <= 1.1
          p "Voce acertou! #{city_name} tem #{population.to_i} habitantes."
        else 
          p "Voce errou! #{city_name} tem #{population.to_i} habitantes."
        end
        
      else
          p "Não foi possivel encontrar os dados da cidade."
      end
    else
      p "Cidade com o nome de #{cidade} nao foi encontrada, ou nao existe ou eh na PQP."
    end
  end
else 
  puts "Vem tranquilo."
end
