- [DOCS](exdocu.md) - [GIT](https://gitlab.com/venenux/gambasex) - [LICENSE](htt
ps://gitlab.com/venenux/gambasex/blob/master/LICENSE.md)

# exModulos documentacion

Se pueden invocar directametne (estaticos) sus funciones.

## exModSysInfo
 
Funciones utilitarias de informacion del sistema instalado ejecutandose.

* itsRunIDE() As Integer : retorna 0 si esta ejecutando elprograma como cgi o aplication, -1 si en el ide. 

## exModSysFile
 
Funciones utilitarias de manipulacion de archivos

* caltoods(file) As String : convierte `file` a ods, mismo nombre, ruta siempre /tmp

## exModSysNet

Se detecta toda informacion de red usando `/sbin/ifconfig` esto es estandar en linux y mac 
por ende es seguro usar ruta absoluta.

Ofrece ip activa (cual se usa para obetenr los bytes d einternet/red activa)
y las ip configuradas del sistema activas, tambien los dispositivos equivalentes a las ip activas.
Las llamadas de las funciones necesitan `netstat`, `ifconfig`, `awk`, `grep` y `head`, 
los paquetes son al menos en linux: **coreutils** (`cut`,`head`), **net-tools** (`netstat`,`ifconfig`), 
asi como **nawk/gawk** (`awk`), **grep** (`grep`) y **sed** (`sed`), en mac todos siempre estan.
* los paquetes **coreutils** y **net-tools** siempre estaran tanto en linux como en mac.
* los paquetes **nawk/gawk**, **sed**, **grep**, se exige esten instalados en ***modSysInfo*** rutina.

