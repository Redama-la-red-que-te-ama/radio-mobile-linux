## Radio Mobile, instalación y utilizo bajo ambiente wine Linux
![](https://redama.es/Imagenes/radio_mobile.png)

Una guía sobre como instalar y utilizar el software por excelencia de planificación de explotación de red inalámbricas. [Radio Mobile](https://www.ve2dbe.com/english1.html). 

Nuestro fin es aportar en [comisión de mercado de telecomunicaciones](https://www.cnmc.es/) un proyecto para pedir la alta en el [registro de operadores en España](https://numeracionyoperadores.cnmc.es/operadores). Del cual tenemos una copia también en nuestro repositorio descargadle en formado [`zip`](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/rosce.zip?raw=true) o [`csv`](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/rosce.csv?raw=true). 

#### Instalación 

Seguir los mandos para instalar:

- [winetricks](https://github.com/redeltaglio/winetricks)
- [Visual Basic Runtime (Service pack 6)](https://www.microsoft.com/es-ES/download/details.aspx?id=24417)

Crear la jerarquía del sistema de archivos y descargar los archivos comprimidos de Radio Mobile.

```shell
$ sudo apt install wine64
$ cd ~/.wine/drive_c && mkdir tmp
$ cd /tmp
$ wget "https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"
$ chmod +x winetricks
$ ./winetricks vb6run
$ mkdir -p ~/.wine/drive_c/Radio_Mobile/Geodata/{srtm3,srtm1,srtmthird,Landcover,OpenStreetMap,Terraserver,Toporama}
$ cd ~/.wine/drive_c/Radio_Mobile
$ wget https://www.ve2dbe.com/download/rmwcore.zip
$ unzip rmwcore.zip
$ wget https://www.ve2dbe.com/download/rmw1166spa.zip
$ unzip rmw1166spa.zip
$ wget https://www.ve2dbe.com/download/wmap.zip

```

#### Configuración 

![SRTM](https://www2.jpl.nasa.gov/srtm/images/SRTM_2-24-2016.gif)

Por primera vez ejecutamos Radio Mobile:

```shell
$ wine rmwspa.exe
```

Configuramos las carpetas en las cuales nuestro programa tiene que buscar los ficheros de [información geográfica](https://es.wikipedia.org/wiki/Informaci%C3%B3n_geogr%C3%A1fica) de los varios estándares disponibles, entra ellos:

- [Misión Topográfica Shuttle Radar](https://es.wikipedia.org/wiki/Misi%C3%B3n_topogr%C3%A1fica_Radar_Shuttle) cuyo acrónimo es [SRTM](https://www2.jpl.nasa.gov/srtm/). Los datos son disponibles con resolución de 90 metros, 3 [arcsec](https://es.wikipedia.org/wiki/Segundo_sexagesimal), reconocibles en Radio Mobile a través de la etiqueta SRTM1, o bien en resolución de 30 metros, 1 arcsec, SRTM3. Las imagenes provienen de misiones NASA.
- [Land cover](https://en.wikipedia.org/wiki/Land_cover) que son capas de imágenes que reflejan la naturaleza de la mayoría del territorio analizado. Con una resolución de 100 metros, 4 arcsec, provienen la [programa Copérnico](https://es.wikipedia.org/wiki/Programa_Cop%C3%A9rnico) de la [ESA](https://es.wikipedia.org/wiki/Agencia_Espacial_Europea). 
- [OpenStreetMap](https://es.wikipedia.org/wiki/OpenStreetMap), un proyecto libre para crear mapas editables.
- [Toporama](https://atlas.gc.ca/toporama/en/index.html) otros proyecto de topografía desde satélite que detalla Canada y [España](http://www.toporama.es/web/) entra otros. 

![](http://redama.es/geodata_radio_mobile.png)

Estos datos no son simples de encontrar en la web debido a que muchos usuarios los han embebidos dentro de aplicaciones web de consulta ad hoc.

He hecho algunos respaldos en el mismo servidor de gestión de certificados activo en mi red privada `telecom.lobby` con el fin de tener los datos directamente en mi red local y no tener que descargarlos cada vez que sean necesarios. La configuración se encuentra en mi repositorio:

- [OpenBSD SSH and SSL CA server](https://github.com/redeltaglio/OpenBSD-private-CA).

Las páginas web de las cuales he creado respaldos son:

- [Index of /srtm/version2_1](https://srtm.kurviger.de/)
- [Index of /files/raw-data/land-use/USGS_LCI/](https://data.mint.isi.edu/files/raw-data/land-use/USGS_LCI/)

Para configurar un server OpenBSD web que funcione en dominio de red local utilices `setup_geodatawww` en un sistema OpenBSD.

Otra parte importante para hacer funcionar correctamente Radio Mobile con el fin de producir proyectos de cobertura de radio útiles a la alta en el registro de operadores de telecomunicaciones es la gestión de los ficheros `.ant`.

Siendo mi proyecto la creación de un proveedor de servicios IP utilizando el fabricante americano [Ubiquiti](http://ui.com/) junto a seguridad de perímetro garantizada gracias al utilizo del sistema operativo [OpenBSD](https://www.openbsd.org/) dichos ficheros pertenecen a los productos [Airmax](https://operator.ui.com/). 

```shell
$ cd ~/.wine/drive_c/Radio_Mobile/antenna
$ wget https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/raw/main/antenna.tar
$ tar xvf antenna.tar && mv antenna/* . && rm -rf antenna/
```

#### Utilizo 

Teniendo en cuenta que se trata de una herramienta que tenemos que utilizar para confeccionar un proyecto para la Comisión de Mercado de Telecomunicaciones que utilizaremos para diseñar el despliegue de nuestra red inalámbrica con fines de explotación del espectro electromagnético para el transporte IP y la conexión a Internet tomamos nota de los varios puntos geográficos y de la altura donde tenemos instalados nuestros dispositivos. 

Una manera fácil de encontrar las [coordenadas geográficas](https://es.wikipedia.org/wiki/Coordenadas_geogr%C3%A1ficas) es utilizar Google Earth que se puede descargar por Linux en https://www.google.com/intl/en_in/earth/versions/#download-pro. 

![](https://redama.es/google_earth_latlong.png)	

Teclear la dirección en el programa, utilizar un marcador para individuar el punto exacto, marcador cuyas propiedades nos brindaran latitud y longitud. 

En mi caso:

 **RIBES-CENTRO**

- LAT: 41°15'29.56"N 
- LONG: 1°46'21.26"E
- ALT: 20 metros.

**MONTGROS-SX**

- LAT:  41°16'4.18"N
- LONG: 1°44'19.84"E
- ALT: 13 metros.

Posicionamos en Radio Mobile los dos centros de transmisión.

![](https://redama.es/Imagenes/radio_mobile_unidades.png)



Podemos apreciar la conversión automática de latitud y longitud en [sistema de coordenadas universal transversal de Mercator](https://es.wikipedia.org/wiki/Sistema_de_coordenadas_universal_transversal_de_Mercator) como además referencia al antiguo sistema de posicionamiento utilizado por radio aficionados [QRA](https://en.wikipedia.org/wiki/QRA_locator). Así que tomamos nota en nuestros puntos de presencia:

 **RIBES-CENTRO**

- LAT: 41°15'29.56"N 
- LONG: 1°46'21.26"E
- ALT: 20 metros.
- UTM: 41.25821 , 1.738845
- QRA: KN01UG

**MONTGROS-SX**

- LAT:  41°16'4.18"N
- LONG: 1°44'19.84"E
- ALT: 13 metros.
- UTM: 41.26783 , 1.766622
- QRA: JN01VG

Después de tomar nota de los puntos de transmisión añadir los transmisores utilizados que en practica son el conjunto de radio + antena y su enfoque. A casa punto de presencia corresponderán varios sistemas con diferente enfoque. 

En mi caso:

- RIBES-CENTRO
  - BR-01-RKM5 

Gracias por tu tiempo,

Riccardo `<taglio>` Giuntoli.