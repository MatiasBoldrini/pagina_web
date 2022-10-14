#!/bin/bash
title="System Information for $HOSTNAME"
fecha_hora="1) Fecha y hora: $(date +"%x %r ")"
autor="2) Autor: $(stat -c '%U' m.boldrini.sh)"
espacio_usado="3) Espacio: $(df -h / --output=used)" 
cant_proc="4) Procesadores: $(lscpu | egrep -m 1 'CPU\(s\)':)"
lista_procesos="5)Lista de procesos en ejecucion: $(ps -u m.boldrini)"

case $(who | cut -d " " -f 1 | sort -u | wc -l) in
    1) msg="6) Solo estoy yo" ;;
    *) msg="6) Somos varios" ;;
esac
# punto 7
echo "bueeeenas" >> /home/mz/so2022/m.boldrini/saludo
if [ -f "/home/mz/so2022/m.boldrini/saludo" ]; then
    mostrar_saludo_existe="7) El archivo saludo existe, mostrando su contenido.."
fi
mostrar_contenido_saludo="8) $(cat /home/mz/so2022/m.boldrini/saludo)"
rm /home/mz/so2022/m.boldrini/saludo
if [ ! -f "/home/mz/so2022/m.boldrini/saludo" ]; then
    borrar_saludo="9) El archivo saludo ya no existe"
fi

echo "Selecciona una ubicación para el backup :"
echo "1. /var/www/html/so/m.boldrini/"
echo "2. /home/mz/so2022/m.boldrini/"
echo "3. /home/mz/so2022/compartido/"
echo "4. No hacer nada"
read ch

case $ch in
  1) echo "Iniciando backup en /var/www/html/so/m.boldrini/"
    location="/var/www/html/so/m.boldrini/"
    cp index.html /var/www/html/so/m.boldrini/
  ;;
  2) echo "Iniciando backup en /home/mz/so2022/m.boldrini/" 
    location="/home/mz/so2022/m.boldrini/"
    cp index.html /home/mz/so2022/m.boldrini/
  ;;
  3) echo "Iniciando backup en /home/mz/so2022/compartido/" 
    location="/home/mz/so2022/compartido/"
    cp index.html /home/mz/so2022/compartido/
  ;;
  4) echo "Continuando..";;
  *) echo "Ha ocurrido un error. Opción no reconocida"
  exit 1 
  ;;
esac
if [ -f $location/index.html ]; then
   echo Backup Realizado correctamente
else
  echo "Ha ocurrido un error. No se ha podido realizar el backup"
fi
cat > index.html <<- _EOF_
    <html>
    <head>
        <title>
        $title
        </title>
    </head>
    <body>
    <h1>Parcial sistemas operativos</h1>
    <p>$fecha_hora</p>
    <p>$autor</p>
    <p>$espacio_usado</p>
    <p>$cant_proc</p>
    <p>$lista_procesos</p>
    <p>$msg</p>
    <p>$mostrar_saludo_existe</p>
    <p>$mostrar_contenido_saludo</p>
    <p>$borrar_saludo</p>
    <p>$TIME_STAMP</p>
    </body>
    </html>
_EOF_
