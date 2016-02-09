class Personne
	attr_accessor :nom, :points_de_vie, :en_vie

  def initialize(nom)
    @nom = nom
    @points_de_vie = 100
    @en_vie = true
  end
  

  def info    
			# Méthode pour renvoyer le nom et les points de vie si la personne est en vie sinon renvoie le nom et "vaincu"
    if @en_vie			
		@nom + ": #{points_de_vie}/100 points de vie."
    else
		@nom + " n'est pas si dur."
    end
  end
  

  def attaque(personne)
			# Méthode pour faire subir des dégâts à la personne passée en paramètre et affiche ce qu'il s'est passé	
    puts "#{@nom} se jette sur #{personne.nom} et le mord. #{personne.nom} pleure à chaudes larmes avant de se remettre en posture d'attaque."
		personne.subit_attaque(degats)  
  end
  

  def subit_attaque(degats_recus)
			# Méthode pour réduire les points de vie en fonction des dégâts reçus et affiche ce qu'il s'est passé	
	puts "#{@nom} perd #{degats_recus} points."    
	@points_de_vie -= degats_recus
	
			# Puis détermine si la personne est toujours en vie ou non
    if @points_de_vie <= 0 && @en_vie
       @en_vie = false
       puts "#{@nom} a été vaincu"
    end
  end
end



class Joueur < Personne
  attr_accessor :degats_bonus
  

  def initialize(nom)
			# Par défaut le joueur n'a pas de dégats bonus
    @degats_bonus = 0

			# Appelle le "initialize" de la classe mère (Personne)
    super(nom)
  end
  

  def degats
			# Méthode pour calculer les dégats et afficher ce qu'il s'est passé	
    puts "#{@nom} gagne #{@degats_bonus} points de bonus."	
	@degats_bonus + rand(10)
  end
  

  def soin
			# Méthode pour gagner de la vie et afficher ce qu'il s'est passé
    @points_de_vie += rand(18)
    puts "#{@nom} se requinque et a maintenant #{@points_de_vie} points de vie."
  end
  

  def ameliorer_degats
			# Méthode pour augmenter les dégâts bonus et afficher ce qu'il s'est passé
    @degats_bonus += rand(5)
    puts "#{@nom} est super fort avec ses #{@degats_bonus} points bonus de morsure intense."
  end  
end



class Ennemi < Personne
  def degats
			# Méthode pour calculer les dégâts
   +rand(5)
  end
end



class Jeu
  def self.actions_possibles(monde)
    puts "            VOICI LES ACTIONS POSSIBLES :"
	puts " "

    puts "0 - Se soigner"
    puts "1 - Améliorer son attaque"
	
			# On commence à 2 car 0 et 1 sont réservés pour les actions de soins et d'amélioration d'attaque    
    i = 2
    monde.ennemis.each do |ennemi|
      puts "#{i} - Attaquer #{ennemi.info}"
      i = i + 1
    end
    puts "99 - Quitter"
  end
  

  def self.est_fini(joueur, monde)
			# Méthode pour déterminer la condition de fin de jeu	
    if !joueur.en_vie || monde.ennemis_en_vie.size == 0
      true
    else
      false
	end
  end
end



class Monde
  attr_accessor :ennemis

  def ennemis_en_vie
			# Méthode pour ne retourner que les ennemis en vie
  @ennemis.select do |ennemi|
      ennemi.en_vie
    end
  end
end


##############

# Initialisation du monde
monde = Monde.new

# Ajout des ennemis
monde.ennemis = [
  Ennemi.new("Balrog"),
  Ennemi.new("Goblin"),
  Ennemi.new("Squelette")
]

			# Initialisation du joueur
joueur = Joueur.new("Jean-Michel Paladin")

			# Message d'introduction. \n signifie "retour à la ligne"
puts "\n\nAinsi débutent les aventures de #{joueur.nom}\n\n"

			# Boucle de jeu principale
100.times do |tour|
  puts "\n------------------ Tour numéro #{tour} ------------------"

			# Affiche les différentes actions possibles
  Jeu.actions_possibles(monde)

  puts "\nQUELLE ACTION FAIRE ?"
			# On range dans la variable "choix" ce que l'utilisateur renseigne
  choix = gets.chomp.to_i

			# En fonction du choix on appelle différentes méthodes sur le joueur
  if choix == 0
    joueur.soin
  elsif choix == 1
    joueur.ameliorer_degats
  elsif choix == 99
			# On quitte la boucle de jeu si on a choisi
			# 99 qui veut dire "quitter"
    break
  else
			# Choix - 2 car nous avons commencé à compter à partir de 2
			# car les choix 0 et 1 étaient réservés pour le soin et
			# l'amélioration d'attaque
    ennemi_a_attaquer = monde.ennemis[choix - 2]
    joueur.attaque(ennemi_a_attaquer)
  end

  puts "\nLES ENNEMIS RIPOSTENT !"
			# Pour tous les ennemis en vie ...
  monde.ennemis_en_vie.each do |ennemi|
			# ... le héro subit une attaque.
    ennemi.attaque(joueur)
  end

  puts "\nEtat du héros: #{joueur.info}\n"

			# Si le jeu est fini, on interompt la boucle
  break if Jeu.est_fini(joueur, monde)
end

puts "\nGame Over!\n"


			# - Afficher le résultat de la partie

unless  joueur.en_vie == false
	puts "Bravo, jeune héros fougueux ! Vous finissez la partie avec #{joueur.points_de_vie} points de vie."

else
	monde.ennemis.each do |ennemi|
		puts "On avait dit héros, pas zéro. Espèce de naze ! \n #{ennemi.nom} gagne avec #{ennemi.points_de_vie} points , face à vos minables #{joueur.points_de_vie} points de vie."
end
end