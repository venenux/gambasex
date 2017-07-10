 [DOCS](exdocu.md) - [README](README.md) - [GIT](https://gitlab.com/venenux/gambasex) - [LICENSE](https://gitlab.com/venenux/gambasex/blob/master/LICENSE.md)

Este trabajo fue basado en gambas-extra-functions o GEF de los foros gambas-es, 
sin embargo esta tiene un monton de errores, los cuales se listan aqui:

## Re-organizacion

Esto no es propiamente un error, **dado es una recopilacion, las funciones estan 
segun su origen**, es decir, diferentes autores colocan sus pocas funciones en 
un solo modulo o clase, al recopilarlas, se organizan segun el modulo o archivo 
del author, y no segun su ambito.

El proyecto **exgambas** las organiza segun su ambito, 
siendo los principales el de redes, el de archivo y el de sistema.

## Errores y fallos

Muchas funciones o procedimientos estan incorrectos o son ilogicos:

### MData

Toda la clase es ilogica, al ser un modulo no se tiene en cuenta el bloqueo, 
ya que solo trabaja con Sqlite, el archivo si se accede mas de una vez ocurre 
interseccion de datos.
Esta clase en la totalidad es reinventar la rueda, ya que añade una capa extra 
a las implementaciones de gambas.

Se reimplementa en un miniframework, que levanta en base a un archivo de configuracion.
* manejo de configuracion
* instancia de pool de base de datos
* instancia de pool de configuraciones
* base de datos en memoria para manipulacion local
* manejo de datos y controles segun la configuracion y bases de datos

Las nuevas clases que implementan esto son `exCfgManage` y `exDbManage` en desarrollo.

### Msys - LS

Todo un pedazo de codigo para devolver la asalida de "ls" en consola?
Esto es ilogico ya que la funcion ofrece un string no manejable, y para 
manejar la info de dicho string hay que extraerla. Si al menos la devolviese 
en un arreglo cada elemento seria pausible.

### Msys - AddressIP y LastNIP incorrectas

Devolver la ip y el ultimo octeto de la ip son funciones utiles, pero 
la forma en que se realiza esto es incorrecta, el primer comando espera 
varios errores:
* que ifconfig pueda ser ejecutado, falso la ruta de ifconfig es /sbin no usuarios
* que la cadena "inet:" exista, es solo en BSD, pues viene "inet addre" en linux

`ifconfig | grep inet: |cut -d ':' -f2|cut -d ' ' -f1" To sIPs`

`ifconfig | grep inet: | grep Difus.|cut -d '.' -f5|cut  -d ' ' -f1`

Esto se sustituye por una forma mas optimia y distro-agnostic en el issue #12 asi:

``` bash
NET_IF=`netstat -rn | awk '/^0.0.0.0/ {thif=substr($0,74,10); print thif;} /^default.*UG/ {thif=substr($0,65,10); print thif;}'`
NET_IP=ifconfig ${NET_IF} | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
```

Esta funciones se mejoraron y organizaron en un modulo de red como:
**getIpDef**  para la ip y **getIfDef** para el nombre del dispositivo de red, 
cabe destacar que usara y asumira el dispositivo en uso y no el mejor o el primario.

### Msys - DistroShort y Dist

Detecta ineficientemente el nombre corto, cuando el mismo `lsb_release` lo provee, 
se cambia el comando por el equivalente de LSB y se devuelve sin modificaciones.
Esto permite eliminar codigo extra 

### MUtility - Capital

El nombre esta incorrecto, confunde creer que devuelve todo el texto en mayusculas, 
ademas su funcion real es minima, solo pone mayuscula la primera palabra.

Se cambio en `ucfirst` y se creo adicional `ucwords` que deveulve todas las palabras con 
la primera letra en mayuscula. Los nombres se crearon iguales que en php, para mejor.

