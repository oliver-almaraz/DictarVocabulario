#!/bin/bash

# Toma un fichero como argumento e imprime una
# línea aleatoria cada vez que se presiona enter.
# Útil para estudiar vocabulario organizado en un
# doc una palabra por renglón. La líneas que empiezan
# con '# ' son ignoradas.
# https://github.com/oliver-almaraz/DictarVocabulario/

export LANG=C.UTF-8

if [[ -z $1 ]]
# No hay primer argumento
then
	printf "Pasa la ruta a documento como argumento\n"
	exit 1
elif [[ ! -f $1 ]]
then
	printf "El documento pasado como argumento no existe.\n"
	exit 2
fi

NO_LINES=$(awk 'END{print NR -1}' $1)
OLD_WORD=''

# Comprobar si cowsay está instalado
cowsay -T U "Preiona Enter para mostrar una palabra al azar. \
Para salir presiona Ctrl + c" 2> /dev/null

if [[ $? -eq 0 ]]
# Si cowsay está instalado:
then
	# Selección personal entre las cows disponibles
#	COWS=(blowfish bud-frogs bunny cheese cower default dragon \
# dragon-and-cow elephant elephant-in-snake \
# koala meow moofasa moose sheep skeleton \
# stegosaurus turkey turtle tux vader)

	# O usar todos los cows disponibles:
	COWS=$(ls -l /usr/share/cows/*.cow | awk '{split($9,array,"/"); print array[5]}')
else
	printf "Preiona Enter para mostrar una palabra al azar.\n\
Para salir presiona Ctrl + c\n"
fi

read WAIT_FOR_LINEFEED

# Comienza el LOOP
while :
do
	# Numero aleat entre 1 y N_LINES inclusive
	RAND=$((1 + ${RANDOM} % ${NO_LINES} +1 ))
	NEW_WORD=$(awk "NR==${RAND} {print \$0}" ${1})

	# Evitar repeticiones inmediatas e ignorar líneas que comienzen con '# '
	if [[ $NEW_WORD = $OLD_WORD ]] || [[ $(echo $NEW_WORD | awk '{print $1}') = '#' ]]
	then
		continue
	else
		OLD_WORD=${NEW_WORD}
		if [[ -n ${COWS} ]]
		# Si está instalado cowsay
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

