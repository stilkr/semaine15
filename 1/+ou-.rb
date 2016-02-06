#3ème exercice en ruby : jeu du + et -

nombre = rand(100)																#l'ordinateur choisit un nombre
		puts "Devinez un nombre entre 1 & 100"
		
devine = gets.to_i

essais = 1

until devine == nombre do														#si le nombre de l'ordinateur est égal à celui de l'utilisateur

  if devine < nombre 
		puts "Trop bas"															#si le nombre de l'ordinateur est inférieur
  
  elsif devine > nombre 
		puts "Trop haut"														#si le nombre de l'ordinateur est supérieur
  
  end
  
  devine = gets.to_i
  
  essais += 1
  
end
		puts "Bingo. Vous avez deviné #{nombre} en #{essais} essais!"