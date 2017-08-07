 [DOCS](exdocu.md) - [DIFF](exdiferenciasoriginal.md) - [GIT](https://gitlab.com/venenux/gambasex) - [LICENSE](https://gitlab.com/venenux/gambasex/blob/master/LICENSE.md)

# Clases framework

Varios controles de Gridsviews extendidos, ordenamientos, filtrado, conversion csv...
 
## ExCfgManage
 
Clase de configuracion de aplicacion. La aplicacion crea una clase y esta por defecto 
asume un archivo de nombre de la aplicacion, en home, con un pool de configuraciones 
para bases de datos, adicional vriables de id's de ubicaciones entre otros.

## ExDbManage

En base a una cofiguracion cargada crea un pool de conexciones segun las configuradas, 
si no existe nada crea dos conexiones, una a sqlite en memoria, y otra a mysql si conecta.

## Ejemplos


``` sql
    Dim objconfs As New ExCfgManage
    Dim objdbcon As New ExDbManage
    Dim conexion As New Connection
    
    $configurado = objconfs.configuracion
    Print "creacion/lectura archivo configuracion exitoso?: " & objconfs.configurado
    $datadesdedb = objdbcon.conexciones
    Print "creacion/conesciones a base de datos disponibles?: " & objdbcon.conectados

    ' hacer consulta en la db memoria, del pool, es la primera
    $datadesdedb[0].exec("CREATE TABLE tabla1 (col1 TEXT);")

    ' forma de liberar y cerrar las conexciones
    For Each conexion In $datadesdedb
        If conexion.Opened Then conexion.Close
    Next
    
```