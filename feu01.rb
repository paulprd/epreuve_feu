# Évaluer une expression

# Fonctions utilisées
def evaluer(expression)
	expression = expression.gsub(" ", "")
	operandes = []
	operateurs = []

	i = 0
	while i < expression.length
		char = expression[i]

		if char.match(/\d/)
			nombre = char.to_i

			j = i + 1
			while j < expression.length && expression[j].match(/\d/)
				nombre = (nombre * 10) + expression[j].to_i
				j += 1
			end

			operandes.push(nombre)
			i = j - 1

		elsif char.match(/[\+\-\*\/\%]/)
			operateurs.push(char)

		elsif char == "("
			j = i + 1
			niveau = 1

			while j < expression.length && niveau > 0
				if expression[j] == "("
					niveau += 1
				elsif expression[j] == ")"
					niveau -= 1
				end
				j += 1
			end

			operandes.push(evaluer(expression[i+1...j-1]))
			i = j - 1
		end

		i += 1
	end

	while operateurs.include?("*") || operateurs.include?("/") || operateurs.include?("%")
		index_op = operateurs.index { |x| x == "*" || x == "/" || x == "%" }
		operateur = operateurs[index_op]

		case operateur
		when "*"
			operandes[index_op] *= operandes[index_op+1]
		when "/"
			operandes[index_op] /= operandes[index_op+1]
		when "%"
			operandes[index_op] %= operandes[index_op+1]
		end

		operandes.delete_at(index_op+1)
		operateurs.delete_at(index_op)
	end

	for operateur in operateurs
		case operateur
		when "+"
			operandes[0] += operandes[1]
		when "-"
			operandes[0] -= operandes[1]
		end
		operandes.delete_at(1)
	end

	return operandes[0]
end

# Partie 1 : Gestion d'erreurs
if ARGV.length != 1
	puts "error: wrong number of arguments"
	exit
end

# Partie 2 : Parsing
expr = "4 + 21 * (1 - 2 / 2) + 38"
# expr = ARGV[0]

# Partie 3 : Résolution
result = evaluer(expr)

# Partie 4 : Affichage
puts result
