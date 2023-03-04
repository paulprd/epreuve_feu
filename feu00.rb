# Echauffement

# Fonctions utilisées
def is_number(str)
	return true if Float(str) rescue false
end

def are_positive_numbers(array)
	return array.all? { |element| is_number(element) && element.to_i >= 0 }
end

def rectangle(width, height)
	result = ""
	if width == 0 || height == 0
		return result
	end
	for i in 0..height-1
		for j in 0..width-1
			if j == 0 || j == width-1
				if i == 0 || i == height-1
					result += "o"
				else
					result += "|"
				end
			elsif i == 0 || i == height-1
				result += "-"
			else
				result += " "
			end
		end
		result += "\n"
	end
	return result
end

# Partie 1 : Gestion d'erreurs
if ARGV.length != 2
	puts "error: wrong number of arguments"
	exit
end

if !are_positive_numbers(ARGV)
	puts "error: bad arguments"
	exit
end

# Partie 2 : Parsing
width = ARGV[0].to_i
height = ARGV[1].to_i

# Partie 3 : Résolution
result = rectangle(width, height)

# Partie 4 : Affichage
puts result