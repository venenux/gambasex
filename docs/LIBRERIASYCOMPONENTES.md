# Modules
 
## exInfosys
 
Funciones utilitarias de informacion del sistema instalado ejecutandose.

## exExportfile
 
Funciones de exportacion a distintos formatos, sea odt o csv (en desarrollo)
 
# Controls
 
## ExGridview ExGridFilter
 
Un "extended gridview", con ordenamiento, data en memoria y busqueda indexada, 
la fuente se mantiene en ram, similar a tabletools.
El exGridfilter implementa su manejo de formulario, integra una barra de capacidades 
de busqueda y permite definir un menu de exportacion y acciones customizadas. 
Esta es la implementacion de exGridview.

### Limitantes

Actualmente si la fuente es un resultado de una consulta de base de datos, 
fallara si la conexcion es `odbc`, esto porque en gambas dependiendo de la impelmenta
del `modulo unixodbc` puede que el cursor sea `Foward-only`, esto imposibilita 
obtener un `Count` y mucho menos iterar aleatoriamente en los resultados.
si no se puede iterar aleatoriamente en los resultados no se puede llenar rapido el g

### Uso y propiedades

### Ejemplo exGridview

Extiende de `Gridview` usa una propiedad `source` para manejar los datos todos en ram:

``` java
Dim titulos as new String[]
Dim filas as new Variant[]

titulos = ["til1", "til2"]
filas.add(titulos)
filas.add(["cel1", "cel2"])
filas.add(["cel3", "cel4"])
filas.add(["cel5", "cel6"])

exGridview1.source = filas
```

#### Menus 

Se puede definir un menu y asignarlo en las propiedades, sin embargo al instanciar o 
el `exgridfilter` se puede directamente a la propiedad `menuDefault` = True

#### columnas, contenido y ancho
El ancho se controla con la propiedad widths  que es un integer[] en la que se puede 
poner un ancho fijo, -1 para un ancho estándar y -2 para un ancho adaptativo por cada
columna.

Esta propiedad está relaciona con otra `expandcols` de tipo bóolean. El comportamient

a. Si definido ancho de una columna en la propiedad widths, ese ancho se respeta siem
b. Si indefinido ancho para una columna y expandcols es true, esa columna se adaptará
c. Si indefinido ancho para una columna y expandcols es false, esa columna tomará un 

Ejemplo:

``` basic
miGrid.rows.count=5 'cinco columnas
miGrid.expandcols=true
miGrid.widths=[100,50]  
``` 
Las dos primeras columnas serán de 100 y 50 de ancho respectivamente y el resto se ad

``` basic
miGrid.widths=[100,50,-2,-1,-1]
```
Las dos primeras serán fijas, la tercera se adaptará y las dos últimas tendrán un anc
Si no estableces ningún valor para widths, entonces, todas las columnas se adaptarán 

En widths puedes poner tantos valores como columnas haya o menos. Si una columna adap

### filas y wordwrap

`WordWrap` lo que hace es adaptar el alto de la línea para que quepa todo el contenid
del campo. Si es `false`, sólo aparecerá el que quepa en el ancho de la columna.

