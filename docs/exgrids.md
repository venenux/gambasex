 [DOCS](exdocu.md) - [DIFF](exdiferenciasoriginal.md) - [GIT](https://gitlab.com/venenux/gambasex) - [LICENSE](https://gitlab.com/venenux/gambasex/blob/master/LICENSE.md)

# Controls Grids

Varios controles de Gridsviews extendidos, ordenamientos, filtrado, conversion csv...
 
## ExGridview ExGridFilter
 
Un "extended gridview" (`egv` + `egf`), con ordenamiento, data en memoria y busqueda indexada, 
la fuente se mantiene en ram, similar a tabletools.
El exGridfilter (`egf`) implementa su manejo de formulario, integra una barra de capacidades 
de busqueda y permite definir un menu de exportacion y acciones customizadas. 
Esta es la implementacion de exGridview (`egv`).

### Limitantes

Actualmente si la fuente es un resultado de una consulta de base de datos, 
fallara si la conexcion es `odbc`, esto porque en gambas dependiendo de la implementacion 
del `modulo unixodbc` puede que el cursor sea `Foward-only`, esto imposibilita 
obtener un `Count` y mucho menos iterar aleatoriamente en los resultados.
Si no se puede iterar aleatoriamente en los resultados no se puede llenar rapido el grid

Sin embargo, se puede usar una base de datos SQLite como "man in the middle", el framework 
implementara esto en ExDBManager (`edbm`) de manera automatica ya que levantara por defecto una db en ram.

### Uso y propiedades

### Ejemplo exGridview

Extiende de `Gridview` usa una propiedad `source` para manejar los datos todos en ram:

``` VBScript
' elformato de la fuente source si es matrix, es primera linea titulos, resto filas
titulos = ["tcel1", "tcel2"]
filas.Add(titulos, 0)
filas.Add(["cel1", "cel2"], 1)
filas.Add(["cel3", "cel4"], 1)
' titulos se pueden sobreescribir por defecto son detectados de la fuente source
titulos = ["colum1", "colum2"]          ' para eso hay que ponerlos primero de las fuentes
egvobj.setHeads = True           ' forzar la habilitacion
egvobj.titles = titulos          ' entonces coloco los titulos, despues desabilitarlos
' egvobj esta pegado en el form, la fuente puede ser un Result desde db
egvobj.setHeads = False          ' si quiero todas las filas, primero sin titulo
egvobj.source = filas            ' entonces añade todo incluso la primera fila
```

#### Menus 

Se puede definir un menu y asignarlo en las propiedades, sin embargo al instanciar o 
el `egf` se puede directamente a la propiedad `menuDefault` = True

#### columnas, contenido y ancho
El ancho se controla con la propiedad widths  que es un integer[] en la que se puede 
poner un ancho fijo, -1 para un ancho estándar y -2 para un ancho adaptativo por cada
columna.

Esta propiedad está relaciona con otra `expandcols` de tipo bóolean. El comportamient

a. Si definido ancho de una columna en la propiedad widths, ese ancho se respeta siem
b. Si indefinido ancho para una columna y expandcols es true, esa columna se adaptará
c. Si indefinido ancho para una columna y expandcols es false, esa columna tomará un 

Ejemplo:

``` VBScript
miGrid.rows.count=5 'cinco columnas
miGrid.expandcols=true
miGrid.widths=[100,50]  
``` 
Las dos primeras columnas serán de 100 y 50 de ancho respectivamente y el resto se ad

``` VBScript
miGrid.widths=[100,50,-2,-1,-1]
```
Las dos primeras serán fijas, la tercera se adaptará y las dos últimas tendrán un anc
Si no estableces ningún valor para widths, entonces, todas las columnas se adaptarán 

En widths puedes poner tantos valores como columnas haya o menos. Si una columna adap

### filas y wordwrap

`WordWrap` lo que hace es adaptar el alto de la línea para que quepa todo el contenid
del campo. Si es `false`, sólo aparecerá el que quepa en el ancho de la columna.

