#!/bin/bash

# Toma un fichero como argumento e imprime una
# línea aleatoria cada vez que se presiona enter.
# Útil para estudiar vocabulario organizado en un
# doc una palabra por renglón. La líneas que empiezan
# con '#' o con espacios son ignoradas.
# https://github.com/oliver-almaraz/DictarVocabulario/

export LANG=C.UTF-8

if [[ -z $1 ]]
# No hay primer argumento
then
	printf "Pasa la ruta a un documento como argumento\n"
	exit 1
elif [[ ! -f $1 ]]
then
	printf "El documento pasado como argumento no existe.\n"
	exit 2
fi

NR_LINES=$(wc -l < $1)
OLD_WORD=''

# Comprobar si cowsay está instalado
cowsay -T U "Preiona Enter para mostrar una palabra al azar. \
Para salir presiona Ctrl + c" 2> /dev/null

if [[ $? -eq 0 ]]
# Si cowsay está instalado:
then
	# Selección personal entre las cows disponibles
#	COWS=(
#           blowfish bud-frogs bunny cheese cower default dragon
#           dragon-and-cow elephant elephant-in-snake
#           koala meow moofasa moose sheep skeleton
#           stegosaurus turkey turtle tux vader
#       )

	# O usar todos los cows disponibles:
	declare -a COWS=($(cowsay -l | awk 'NR>1 {gsub(" ","\n"); print $0}'))
else
	printf "Preiona Enter para mostrar una palabra al azar.\n\
Para salir presiona Ctrl + c\n"
fi

read WAIT_FOR_LINEFEED
clear

# Comienza el LOOP
while :
do
	# Numero aleat entre 1 y N_LINES inclusive
	RAND=$((1 + ${RANDOM} % ${NR_LINES} +1 ))
	# Regex que ignora líneas vacías o que empiezan con #
	NEW_WORD=$(awk "NR==${RAND} && ! /^[[:space:]#]+|^\$/ {print \$0}" ${1})

	# Evitar repeticiones inmediatas
	if [[ $NEW_WORD = $OLD_WORD ]] || [[ $NEW_WORD = "" ]]
	then
		continue
	else
		OLD_WORD=${NEW_WORD}
		if [[ -n ${COWS} ]]
		# Si está instalado cowsay el array COWS fue definido
		then
			#Rand int entre 0 y el número de elmt en arr -1
			RAND_INDEX=$((${RANDOM} % ${#COWS[@]}))
			cowsay -f ${COWS[${RAND_INDEX}]} "${NEW_WORD}"
		else
			printf "\
:::::::::::::::::::::::::::::::::::::::::\n\
\t${NEW_WORD}\n\
:::::::::::::::::::::::::::::::::::::::::\n"
		fi
	fi

	read WAIT_FOR_LINEFEED
	clear
done

