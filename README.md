# Dictar Vocabulario
Script shell que muestra una línea al azar de un documento pasado como arguento con `cowsay`. 
Útil para estudiar vocabulario que fue puesto en un documento con una palabra por línea. 
Las líneas en el documento de vocabulario que comienzan con "# " son ignoradas. 
Si `cowsay` no está instalado muestra la línea en un formato simple.

Yo lo uso para generar palabras al azar en griego antiguo para que mis alumnos elaboren oraciones con ellas.
Adjunto el este repositorio un documento de vocabulario.txt de ejemplo.

<img src="https://user-images.githubusercontent.com/69062188/192077269-b7009735-6787-4b2b-8f3c-25b73e7a6d18.jpg" width="80%"></img>

Se ejecuta desde la terminal como cualquier script shell:
- Guarda el fichero `dictado.sh` en el directorio que prefieras
- Navega con la terminal hasta el directorio en que lo guardaste con `cd <ruta>` 
- Dale permisos de ejecución: `chmod u+x dictado.sh`
- Ejecuta el script pasándole el nombre o ruta del fichero de vocabulario:
- ```./dictado.sh vocabulario.txt```
