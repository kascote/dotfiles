################## Comienza Script "GrabaRadio.sh" ################################$!/bin/ sh
#Idea general
# mplayer se conecta al servidor y me da el sonido en formato wav
# En lugar de dirigir la salida a un archivo común .wav, lo redirijo a un archivo fifo
# Tomo los datos del archivo fifo, y los comprimo con lame# La salida de lame será un archivo mp3
# Datosurl=mms://2x4.telecomdatacenter.com.  ar/2x4Nombre="La 2x4"Genero=Tango
# otras radios. Comentar y descomentar con 
#
#url=http://www.fmurquiza.com/fmurquiza.asx
#Nombre="FM Urquiza"#Genero="JAZZ"
#url=mms://200.59.146.10/radioaspen-ba;Nombre="aspen";Genero=PopClasic

cd $HOME
#Creo un archivo fifo...Le doy extensión .wav porque creo que lo necesita
mplayer.mv -f ./audiodump.wav ./audiodump.wav.bkp
#No es necesario esto...  pero me garantiza que no haya un audiodump.wav en el directorio...y lo salvo por las dudas...
mkfifo $HOME/audiodump.wav
# ... y así crear sin problemas uno nuevo
# Allí mplayer enviará los datos de audio en formato wav.# Luego la data la redirijo al comando lame para guardar

#Inicio la compresión a mp3, aunque todavía no llegue nada a "audiodump.wav", ya que no empezó mplayer. Estará en espera...
# Al nombre del archivo .mp3 que se crea, le agrego la fecha en que inicia el script (Habría que corregir esto, ya que comenzará a grabar más tarde..)
lame -V2 - $HOME/audioradio_"$Nombre"_"`date`".mp3 < $HOME/audiodump.wav & 
# como coño lo mato cuando termina??? : Retengo su PID...
PID_lame=$! 
#recojo el pid del proceso
# Nota: el comando lame aparece en listado que tira ls -A con el nombre que le den a este script... Cuando mplayer se conecta y empieza a tirar datos al fifo, ¡¡cambia el nombre del proceso que da ls -A, del nombre de este script a "lame"
# Usaré esto para saber si se estableció la conexión
#pregunto por la hora de comienzo.  Sólo funciona dentro de las 24 hs (a mejorar...)
#Ingresar por ejemplo:
# 9hs 58 min am -> 0958
# 9hs 58 min pm -> 2158
Xdialog - -title "Ingresar..." --inputbox "Hora comienzo (0000)" 0 0 2>/tmp/tempread Ini < /tmp/temp
#Duración de la grabación en seg.  Ejemplo: 3600 una hora
Xdialog --title "Ingresar..." --inputbox "Duración en segundos" 0 0 2>/tmp/tempread Seg < /tmp/temp
# arranca a las $Ini
# Dura $Segs
Xdialog --title "Esperando la hora de conexión" --msgbox "La conexión empieza a las $Ini durante $Seg seg . ¡OJO! Comienza a grabar instantes después, luego de conectarse! El PID de lame es $PID_lame" 0 0 &PID_espera=$! 
#obtengo el PID del Xdialog...
#Espero a que llegue el momento de empezar...
while test "`date +%H%M`" != "$Ini" 
  # Sofisticado Timer ;-)
  do
    echo >/dev/null
  done
                                               

# Llegó el momento de empezar a grabar.
# Mato el Xdialog de espera
kill $PID_espera
mplayer -ao pcm $url &
#tardara unos segundos en conectarse con el servidor...
PID_mplayer=$! #conservo el pid de mplayer
Xdialog --title "Comenzando la conexión" --msgbox "Conectando a ruc $Nombre..." 0 0 &PID_msgConectando=$!
# Espero a que se establezca la conexión...
# Del comando lame conozco su PID.
# Si el nombre que le corresponde en ps -A es el de este script, todavía no se conectó
# Si el nombre que le corresponde en ps -A es "lame" se conectó... (Ver nota más arriba)
ps - A |grep $PID_lame|grep lame>/dev/null
conectado=$? #resultado del último grep
while test "$conectado" = "1" do #Todavía no se conectó, me fijo de nuevo...
  ps -A |grep $PID_lame|grep lame>/dev/null
  conectado=$?
done
#se conectó!!
kill $PID_msgConectando # Mato el Xdialog "Comenzando la...
#Doy aviso que comienza la grabación...
Xdialog --title "** Grabando de $Nombre **" --msgbox "Grabando $Seg seg desde las `date +%H%M%S` (y no desde las $Ini !!)" 0 0 &PID_msgGrabando=$!
#Conservo el pid de Xdialog
sleep $Seg
# tiempo de grabación $Seg
# Recontra Sofisticado Timer ;-))
# Tiempo de grabación Terminado
# Mata los procesos que habían quedado en segundo plano 
# 
kill $PID_lame
#No resultó necesario para lame, muere al cerrar el script
kill $PID_mplayer
#mplayer
kill $PID_msgGrabando
# mensaje Xdialog "grabando..."
Xdialog --title " Listo ! " - -msgbox "Grabación Finalizada." 0 0 &
#necesita presionar ok
################## Fin Script ###############################

