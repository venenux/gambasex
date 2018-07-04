 [DOCS](exdocu.md) - [DIFF](exdiferenciasoriginal.md) - [GIT](https://gitlab.com/venenux/gambasex) - [LICENSE](https://gitlab.com/venenux/gambasex/blob/master/LICENSE.md)

# Clases framework: Extended Managers

controles ampliados de clases base, colleciones, base de datos y configuracion en modo de manejo por pool.
 
## excfg
 
**ExCfgManage**: clase de configuracion inicial, inicia parametros de la aplicacion sea cliente o servidor 
y establece a donde se conectara asi como datos de entidad y conectividad. La aplicacion crea una clase 
y esta por defecto asume un archivo de nombre de la aplicacion, con un pool de configuraciones 
para bases de datos, adicional vriables de id's de ubicaciones entre otros.

La ruta de ubicacion del archivo se puede pasar en el constructor sino este es el orden en que se busca:
1. en Application.path
2. en Application.path un directorio arriba
3. en USER.home
4. en /etc/<Application.name>

El nombre sera por defecto <Application.name>.conf si no se especifica, sino se seguira la siguiente logica
1. <Application.name>.conf
2. exappconfig.conf

Esta clase es autoinstanciable por el modulo [exapp](exapp.md)

## exdb

**ExDbManage**: En base a una configuracion cargada crea un pool de conexciones segun las configuradas, 
si no existe nada crea una a sqlite en memoria, usara la logica de la calse de configuracion, 
y despues en dicha ruta buscara el archivo de configuraciones de base de datos `exdatabase.conf` desde 
donde haya ya encontrado el de configuracion de archivo.

## Ejemplos


``` sql
    Dim dbobj As New Exdb
    
    ' realizar un query tomando la conexion del archivo conf llamada conex2
    dbobj["conex2"].Exec("select 'pepe' as ba")
    
    ' imprimir el valor de configuracion del archivo de base de datos conex0 la parte de hostname
    Print exapp.cf.cfgdb["conex0/hostname"]
    
```

