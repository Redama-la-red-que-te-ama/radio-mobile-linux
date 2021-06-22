

## Radio Mobile, instalación y utilizo bajo ambiente wine Linux

![](https://redama.es/Imagenes/radio_mobile.png)

Una guía sobre como instalar y utilizar el software por excelencia de planificación de explotación de red inalámbricas. [Radio Mobile](https://www.ve2dbe.com/english1.html). 

Nuestro fin es aportar en [comisión de mercado de telecomunicaciones](https://www.cnmc.es/) un proyecto para pedir la alta en el [registro de operadores en España](https://numeracionyoperadores.cnmc.es/operadores). Del cual tenemos una copia también en nuestro repositorio descargadle en formado [`zip`](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/rosce.zip?raw=true) o [`csv`](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/rosce.csv?raw=true). 

#### Instalación 

Seguir los mandos para instalar:

- [Wine](https://www.winehq.org/)
- [winetricks](https://github.com/redeltaglio/winetricks)
- [Visual Basic Runtime (Service pack 6)](https://www.microsoft.com/es-ES/download/details.aspx?id=24417)

Crear la jerarquía del sistema de archivos y descargar los archivos comprimidos de Radio Mobile.

```shell
$ sudo apt install wine64 cabextract wine64-preloader
$ cd /usr/bin
$ find . -name "wine*" | xargs -I {} readlink -f {} | xargs -I {} sudo setcap cap_net_raw+epi {}
$ cd ~/.wine/drive_c && mkdir tmp
$ cd /tmp
$ wget "https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"
$ chmod +x winetricks
$ ./winetricks vb6run
$ ./winetricks winhttp
$ mkdir -p ~/.wine/drive_c/Radio_Mobile/Geodata/{srtm3,srtm1,srtmthird,Landcover,OpenStreetMap,Terraserver,Toporama}
$ cd ~/.wine/drive_c/Radio_Mobile
$ wget https://www.ve2dbe.com/download/rmwcore.zip
$ unzip rmwcore.zip
$ wget https://www.ve2dbe.com/download/rmw1166spa.zip
$ unzip rmw1166spa.zip
$ wget https://www.ve2dbe.com/download/wmap.zip
$ unzip wmap.zip

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

Muy lamentablemente bajo `wine` Radio Mobile no puede descargar ningún tipo de fichero de información geográfica como tampoco actualización desde Internet.

![](http://redama.es/Imagenes/geodata_radio_mobile.png)

Estos datos no son simples de encontrar en la web debido a que muchos usuarios los han embebidos dentro de aplicaciones web de consulta ad hoc.

He hecho algunos respaldos en el mismo servidor de gestión de certificados activo en mi red privada `telecom.lobby` con el fin de tener los datos directamente en mi red local y no tener que descargarlos cada vez que sean necesarios. La configuración se encuentra en mi repositorio:

- [OpenBSD SSH and SSL CA server](https://github.com/redeltaglio/OpenBSD-private-CA).

Las páginas web de las cuales he creado respaldos son:

- [Index of /srtm/version2_1](https://srtm.kurviger.de/)
- [Index of /files/raw-data/land-use/USGS_LCI/](https://data.mint.isi.edu/files/raw-data/land-use/USGS_LCI/)

Para configurar un servidor OpenBSD web repositorio de ficheros de información geográfica que funcione en dominio de red local utilices `setup_geodatawww`.

Una vez obtenidos los que nos interesan según territorio y nomenclatura estándar internacional [ISO 3166](https://es.wikipedia.org/wiki/ISO_3166) lo vamos a descargar en nuestro sistema Linux con emulador `wine`:

```shell
$ cd ~/.wine/drive_c/Geodata
$ wget http://geodata.telecom.lobby/geodata-ES.tar
$ tar xvf geodata-ES.tar
```



Otra parte importante para hacer funcionar correctamente Radio Mobile con el fin de producir proyectos de cobertura de radio útiles a la alta en el registro de operadores de telecomunicaciones es la gestión de los ficheros `.ant`.

Siendo mi proyecto la creación de un proveedor de servicios IP utilizando el fabricante americano [Ubiquiti](http://ui.com/) junto a seguridad de perímetro garantizada gracias al utilizo del sistema operativo [OpenBSD](https://www.openbsd.org/) dichos ficheros pertenecen a los productos [Airmax](https://operator.ui.com/). 

```shell
$ cd ~/.wine/drive_c/Radio_Mobile/antenna
$ wget https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/raw/main/antenna.tar
$ tar xvf antenna.tar && mv antenna/* . && rm -rf antenna/
```

Para descargar los ficheros relativos a OpenStreetMap hay varias fuentes posibles, un primer listado que nos devuelve el formado [`obf`](https://web.archive.org/web/20160819015145/https://code.google.com/p/osmand/wiki/HowToInspectAnObfBinaryFile) para la aplicación por móviles que se llama [OsmAnd](https://osmand.net/) es:

- [Osmand Local Indexes List](https://osmand.net/list.php)

El formato nativo de OpenStreetMap para gestionar los archivos de mapas toma el nombre de [tile](https://wiki.openstreetmap.org/wiki/Tiles). En el repositorio he descargado todo lo necesario para la comunidad autónoma de Catalunya en `src/drive_c/Radio_Mobile/Geodata/OpenStreetMap`. Las carpetas están numeradas según el [nivel de zoom](https://wiki.openstreetmap.org/wiki/ES:Niveles_de_zoom). 

#### Utilizo 

Teniendo en cuenta que se trata de una herramienta que tenemos que utilizar para confeccionar un proyecto para la Comisión de Mercado de Telecomunicaciones que utilizaremos para diseñar el despliegue de nuestra red inalámbrica con fines de explotación del espectro electromagnético para el transporte IP y la conexión a Internet tomamos nota de los varios puntos geográficos y de la altura donde tenemos instalados nuestros dispositivos. 

Una manera fácil de encontrar las [coordenadas geográficas](https://es.wikipedia.org/wiki/Coordenadas_geogr%C3%A1ficas) es utilizar Google Earth que se puede descargar por Linux en https://www.google.com/intl/en_in/earth/versions/#download-pro. 

Apuntamos los puntos mínimos y máximos de la península ibérica que será nuestro campo de juego para la venta de Internet:

- Latitud 35, 43 N
- Longitud 0, 3 E - 0 , 9 W

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
- QRA: JN01UG

**MONTGROS-SX**

- LAT:  41°16'4.18"N
- LONG: 1°44'19.84"E
- ALT: 13 metros.
- UTM: 41.26783 , 1.766622
- QRA: JN01VG

Después de tomar nota de los puntos de transmisión añadir los transmisores utilizados que en practica son el conjunto de radio + antena y su enfoque. A cada punto de presencia corresponderán varios sistemas con diferente enfoque.

Radio Mobile guarda las informaciones de los diferentes conjuntos de sistemas transmisores, radio más antena, y sus relativas alturas de instalación en un fichero en la raíz del programa. Toma el nombre de `Radiosys.dat`. He querido añadir uno script para su configuración automática y uno libremente descargadle en este mismo repositorio,  `radiosys_config.sh`.

Los sistemas añadidos en `src/drive_c/Radio_Mobile/Radiosys.dat` son los siguientes:

- [Rocket M5](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/datasheets/RocketM_DS.pdf) + [RD30](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/datasheets/rd_ds_web.pdf) + [polarización](https://es.wikipedia.org/wiki/Polarizaci%C3%B3n_electromagn%C3%A9tica) vertical + [máximo PIRE](https://es.wikipedia.org/wiki/Potencia_Isotr%C3%B3pica_Radiada_Equivalente) + 20 metros de altura de instalación.
- [Rocket M5](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/datasheets/RocketM_DS.pdf) + [RD30](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/datasheets/rd_ds_web.pdf) + [polarización](https://es.wikipedia.org/wiki/Polarizaci%C3%B3n_electromagn%C3%A9tica) vertical + [PIRE permitido por normativa](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/raw/main/leyes/uso_de_las_bandas_libres_de_5470-5725_mhz_y_5725-5875_mhz_en_espana.pdf) + 20 metros de altura de instalación. Consideramos 4W en el rango desde `5725` hasta `5875`.
- [Rocket M5](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/datasheets/RocketM_DS.pdf) + [RD34](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/datasheets/rd_ds_web.pdf) + [polarización](https://es.wikipedia.org/wiki/Polarizaci%C3%B3n_electromagn%C3%A9tica) vertical + [máximo PIRE](https://es.wikipedia.org/wiki/Potencia_Isotr%C3%B3pica_Radiada_Equivalente) + 20 metros de altura de instalación.
- [Rocket M5](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/datasheets/RocketM_DS.pdf) + [RD34](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/datasheets/rd_ds_web.pdf) + [polarización](https://es.wikipedia.org/wiki/Polarizaci%C3%B3n_electromagn%C3%A9tica) vertical + [PIRE permitido por normativa](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/raw/main/leyes/uso_de_las_bandas_libres_de_5470-5725_mhz_y_5725-5875_mhz_en_espana.pdf) + 20 metros de altura de instalación. Consideramos 4W en el rango desde `5725` hasta `5875`.
- [Rocket M5](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/datasheets/RocketM_DS.pdf) + [AM-5G16-120](https://dl.ubnt.com/datasheets/airmaxsector/airMAX_Sector_Antennas_DS.pdf) + [polarización](https://es.wikipedia.org/wiki/Polarizaci%C3%B3n_electromagn%C3%A9tica) vertical + [máximo PIRE](https://es.wikipedia.org/wiki/Potencia_Isotr%C3%B3pica_Radiada_Equivalente) + 20 metros de altura de instalación.
- [Rocket M5](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/datasheets/RocketM_DS.pdf) + [AM-5G16-120](https://dl.ubnt.com/datasheets/airmaxsector/airMAX_Sector_Antennas_DS.pdf) + [polarización](https://es.wikipedia.org/wiki/Polarizaci%C3%B3n_electromagn%C3%A9tica) vertical + [PIRE permitido por normativa](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/raw/main/leyes/uso_de_las_bandas_libres_de_5470-5725_mhz_y_5725-5875_mhz_en_espana.pdf) + 20 metros de altura de instalación. Consideramos 1W en el rango desde `5470` hasta `5725`.
- [Rocket M5](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/datasheets/RocketM_DS.pdf) + [AM-5G17-90](https://dl.ubnt.com/datasheets/airmaxsector/airMAX_Sector_Antennas_DS.pdf) + [polarización](https://es.wikipedia.org/wiki/Polarizaci%C3%B3n_electromagn%C3%A9tica) vertical + [máximo PIRE](https://es.wikipedia.org/wiki/Potencia_Isotr%C3%B3pica_Radiada_Equivalente) + 20 metros de altura de instalación.
- [Rocket M5](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/datasheets/RocketM_DS.pdf) + [AM-5G17-90](https://dl.ubnt.com/datasheets/airmaxsector/airMAX_Sector_Antennas_DS.pdf)  + [polarización](https://es.wikipedia.org/wiki/Polarizaci%C3%B3n_electromagn%C3%A9tica) vertical + [PIRE permitido por normativa](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/raw/main/leyes/uso_de_las_bandas_libres_de_5470-5725_mhz_y_5725-5875_mhz_en_espana.pdf)+ 20 metros de altura de instalación. Consideramos 1W en el rango desde `5470` hasta `5725`.
- [Rocket M5](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/datasheets/RocketM_DS.pdf) + [AM-5G19-120](https://dl.ubnt.com/datasheets/airmaxsector/airMAX_Sector_Antennas_DS.pdf) + [polarización](https://es.wikipedia.org/wiki/Polarizaci%C3%B3n_electromagn%C3%A9tica) vertical + [máximo PIRE](https://es.wikipedia.org/wiki/Potencia_Isotr%C3%B3pica_Radiada_Equivalente) + 20 metros de altura de instalación.
- [Rocket M5](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/datasheets/RocketM_DS.pdf) + [AM-5G19-120](https://dl.ubnt.com/datasheets/airmaxsector/airMAX_Sector_Antennas_DS.pdf)  + [polarización](https://es.wikipedia.org/wiki/Polarizaci%C3%B3n_electromagn%C3%A9tica) vertical + [PIRE permitido por normativa](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/raw/main/leyes/uso_de_las_bandas_libres_de_5470-5725_mhz_y_5725-5875_mhz_en_espana.pdf) + 20 metros de altura de instalación. Consideramos 1W en el rango desde `5470` hasta `5725`.
- [Rocket M5](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/datasheets/RocketM_DS.pdf) + [AM-5G20-90](https://dl.ubnt.com/datasheets/airmaxsector/airMAX_Sector_Antennas_DS.pdf) + [polarización](https://es.wikipedia.org/wiki/Polarizaci%C3%B3n_electromagn%C3%A9tica) vertical + [máximo PIRE](https://es.wikipedia.org/wiki/Potencia_Isotr%C3%B3pica_Radiada_Equivalente) + 20 metros de altura de instalación.
- [Rocket M5](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/datasheets/RocketM_DS.pdf) + [AM-5G20-90](https://dl.ubnt.com/datasheets/airmaxsector/airMAX_Sector_Antennas_DS.pdf)  + [polarización](https://es.wikipedia.org/wiki/Polarizaci%C3%B3n_electromagn%C3%A9tica) vertical + [PIRE permitido por normativa](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/raw/main/leyes/uso_de_las_bandas_libres_de_5470-5725_mhz_y_5725-5875_mhz_en_espana.pdf) + 20 metros de altura de instalación. Consideramos 1W en el rango desde `5470` hasta `5725`.
- [Powerbeam](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/raw/main/datasheets/PowerBeam_DS.pdf) M5 300 y M5 400 + [máximo PIRE](https://es.wikipedia.org/wiki/Potencia_Isotr%C3%B3pica_Radiada_Equivalente) + 20 metros de altura de instalación.
- [Powerbeam](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/raw/main/datasheets/PowerBeam_DS.pdf) M5 300 y M5 400 + [PIRE permitido por normativa](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/raw/main/leyes/uso_de_las_bandas_libres_de_5470-5725_mhz_y_5725-5875_mhz_en_espana.pdf) + 20 metros de altura de instalación. Consideramos 1W en el rango desde `5470` hasta `5725`.

Una vez añadidos, procedemos con el individuar otros seis puntos geográficos al rededor del punto de presencia de RIBES-CENTRO y de MONTGROS-SX para estudiar la cobertura de las antenas sectoriales y saber donde podemos arrancar con el buzoneo pertinente y informar así la población de nuestro servicio de acceso a Internet, de voz sobre IP y de transporte IP.

![](https://redama.es/Imagenes/radio_mobile_units.png)

 **KONIC**

- LAT: 41°16'23.3"N 
- LONG: 1°45'2.0"E
- ALT: 10 metros.
- UTM: 41.27314 , 1.750567
- QRA: JN01VG

 **VILANOVA**

- LAT: 41°13'46.3"N 
- LONG: 1°44'17.5"E
- ALT: 20 metros.
- UTM: 41.22953 , 1.738189
- QRA: JN01UF

 **CANYELLES**

- LAT: 41°16'28.3"N 
- LONG: 1°42'24.9"E
- ALT: 20 metros.
- UTM: 41.27454 , 1.706903
- QRA: JN01UG

 **OLIVELLA**

- LAT: 41°18'36.5"N 
- LONG: 1°48'41.0"E
- ALT: 20 metros.
- UTM: 41.31013 , 1.811381
- QRA: JN01VH

 **LAS TORRES**

- LAT: 41°14'53.5"N 
- LONG: 1°47'37.0"E
- ALT: 20 metros.
- UTM: 41.24819 , 1.793614
- QRA: JN01VF

 **ST PERE WEST**

- LAT: 41°15'16.3"N 
- LONG: 1°45'30.5"E
- ALT: 20 metros.
- UTM: 41.25453 , 1.758469
- QRA: JN01VG

Vamos a conectar cada punto de transmisión a través de antenas parabólicas de punto a punto y cubrimos el territorio circunstante con tres sectores de 120 grados en cada uno de ellos.

![](https://redama.es/Imagenes/radio_mobile_network.png)

Las operaciones para obtener el mapa sobre indicado son las siguientes:

- Definir nombre de red, rango de frecuencia según normativa y tipo de [clima](https://es.wikipedia.org/wiki/Clima), que en mi caso es el [clima mediterráneo típico](https://es.wikipedia.org/wiki/Clima_mediterr%C3%A1neo_t%C3%ADpico). 

![](https://redama.es/Imagenes/radio_mobile_network1.png)

- Definir topología de red que en el caso de punto a punto y de punto a multipunto IP es red de datos, [topología estrella](https://es.wikipedia.org/wiki/Red_en_estrella).

![](https://redama.es/Imagenes/radio_mobile_network2.png)

- Seleccionar unidades y sistemas, la herramienta nos devolverá el [azimuth](https://es.wikipedia.org/wiki/Acimut) y el [angulo de elevación](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/raw/main/guias/13_Orientacion%20antena%20parabolica.pdf) de nuestra antena.

![](https://redama.es/Imagenes/radio_mobile_network3.png)

En mi caso disponemos así de siete redes inalámbricas y de los datos necesarios para su perfecto funcionamiento:

 **RIBES-CENTRO**:

- `Parabólica --> MONTGROS-SX`:
  -  Azimut: 290.9 grados.
  - Angulo de elevación: 5.53 grados.
- `Sector 120 grados --> VINYALS`:
  - Azimuth: 305 grados.
  - Angulo de elevación: 5 grados.
- `Sector 120 grados --> LASTORRES`:
  - Azimuth: 122 grados.
  - Angulo de elevación: 1 grados.
- `Sector 120 grados --> HOSPITAL`:
  - Azimuth: 250 grados.
  - Angulo de elevación: 1 grados.

**MONTGROS-SX**:

- `Parabólica --> RIBES-CENTRO`:
  -  Azimut: 110.9 grados.
  - Angulo de elevación: -5.56 grados.
- `Sector 120 grados --> VILLANOVA`:
  - Azimuth: 180 grados.
  - Angulo de elevación: -4 grados.
- `Sector 120 grados --> CANYELLES`:
  - Azimuth: 285.5 grados.
  - Angulo de elevación: -3.23 grados.
- `Sector 120 grados --> OLIVELLA`:
  - Azimuth: 52.5 grados.
  - Angulo de elevación: -1 grados.

#### Detalles de radio enlaces

Accedemos a los detalles de enlace de radio presionando la tecla de función `F2`:

![](https://redama.es/Imagenes/enlace_radio1.png)

Como podéis apreciar respectamos la normativa de explotación del espectro en frecuencia libre desde `5815` hasta `5855` MHz siendo el PIRE menor de 4 vatios. Para obtener más detalles acerca del enlace, que como se puede apreciar incluye datos acerca del tipo de terreno obtenido de ficheros `.lcv` que hemos previamente descargado y añadido a la carpeta `Landcover` bajo la raíz del programa, utilizar el menú `Editar`, `Exportar a`, `RMpath`:

![](https://redama.es/Imagenes/rmpath_radiomobile1.png)

Para obtener todavía más visión de la zona de trabajo de nuestro proyecto podemos exportar cada enlace en fichero `kml` y abrirlos con Google Earth:

![](https://redama.es/Imagenes/radiomobile_earth.png)

#### Detalles de cobertura de sectoriales

Con el mero fin de individuar los municipios y los códigos postales de cobertura de nuestras instalaciones vamos a utilizar la herramienta en manera que tengamos clara la cobertura real de nuestros sectores. Así que podremos organizar varias campañas publicitarias como buzoneo, radio y televisiones locales y prensa local. Acordaros también de paquetizar ofertas de lanzo de vuestra cartelera de productos y diferentes tipos según cliente y establecimientos.

Accedemos a la función a través la presión de la tecla `F3`:

![](https://redama.es/Imagenes/cobertura_redama_real_openstreetmap.jpg)

Se pueden apreciar los seis sectores y respectiva cobertura del territorio que en mi caso corresponde a buena parte de la comarca del [Garraf](https://es.wikipedia.org/wiki/Garraf), una pequeña parte de [Costa Dorada](https://es.wikipedia.org/wiki/Costa_Dorada_(Espa%C3%B1a)) y de [Bajo Penedés](https://es.wikipedia.org/wiki/Bajo_Pened%C3%A9s). Interesante también la combinación de diferentes tecnologías entra SRTM3, calculo de cobertura y datos de OpenStreetMap. Una vez que guardamos la imagen podemos abrir una shell para averiguar que Radio Mobile en realidad ha creado diferentes ficheros:

``` shell
$ ls -al cobertura_redama_real_openstreetmap.*
cobertura_redama_real_openstreetmap.bmp  cobertura_redama_real_openstreetmap.dat  cobertura_redama_real_openstreetmap.geo  cobertura_redama_real_openstreetmap.inf  cobertura_redama_real_openstreetmap.kml
$
```

Podemos abrir el [`.kml`](https://es.wikipedia.org/wiki/KML) con Google Earth y obtener esta imagen maravillosa por nuestro proyecto de presentar al gobierno de España:

![](https://redama.es/Imagenes/redama_cobertura_estudio.jpg)

Otra información interesante del punto de vista de la publicidad son los códigos postales:

- [Códigos postales españoles](http://www.cartociudad.es/visor/)

Y todo el servicio de cartografía del estado:

- [Sistema cartográfico nacional](http://www.scne.es/)

En mi caso los códigos postales cubierto parcialmente de mi instalación serán:

- 43881
- 08729
- 08730
- 08811
- 08734
- 08818
- 08872
- 08870
- 08810
- 08812

#### Documentación registro de operadores

Un vez conseguidos los datos de Radio Mobile bajo ambiente de emulación `wine` en Linux pasamos a preparar la documentación requirida para el modulo "[Explotación de redes y/o prestaciones de servicios de comunicaciones electrónicas](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/raw/main/cnmc/explotacion_redes_servicios_comunicaciones.pdf)".

Rellenar y volver a escanear el [modulo de notificación](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/raw/main/cnmc/notificacion_cnmc.pdf). Para acceder a la web del registro es necesario disponer de un [certificado digital](https://sedeaplicaciones.minetur.gob.es/Prestadores/) de ciudadania reconocido y emitido por el gobierno. 

Importante reconocer si la entidad que hace la petición de registro, nosotros, somos clasificado por el gobierno a nivel fiscal como persona física, empresarios autónomos, o persona jurídica, empresas.

En mi caso soy un autónomo por lo cual tengo que preocuparme de anexar a mi procedimiento de registro tales documentos:

- DNI o NIE, y si, como yo, fuera este último documento del país de proveniencia y si extra europeo pasaporte.
- Nombre Apellidos y NIF.
- Hoja de padrón.

<u>Documentación técnica de la red que se quiere explotar</u>: 

- Acerca de la documentación de la ingeniería y diseño de red incluimos:
  - Ámbito territorial de cobertura. Comarcas y códigos postales.
  - Indicar si es red propia o ajena.
  - Indicar si la implantación de la red requiere la ocupación del dominio público radioeléctrico. En mi caso por ejemplo ocupo una azotea privada y espacio en una torre de telecomunicaciones que pertenece a la empresa [Cellnex telecom](https://www.cellnextelecom.com/).
  - [Diagrama de bloques](https://es.wikipedia.org/wiki/Diagrama_de_bloques) complementario que facilite la descripción.
- Tipo de tecnologías o tecnologías a emplear.
- Descripción de las medidas de seguridad y confidencialidad que se prevén implantar en la red.
- Indicación de la red que se quiere explotar:
  - Red terrestre.
  - Red que utiliza el dominio público radioeléctrico.
  - Otra red a detallar por parte del operador.

<u>Descripción del servicio que se quiere suministrar</u>:

- Descripción funcional de los servicios, incluyendo:
  - Croquis complementario que facilite su descripción incluyendo la tecnología a utilizar.
  - Si se utilizará red propia o ajena.
  - Ámbito territorial de prestación del servicio.
- Oferta de servicios y su descripción comercial (indicando si el servicio se presta de forma gratuita o con contraprestación económica).
- Indicación del servicio o servicios a prestar, tales como:
  - Servicio telefónico en sus diferentes modalidades:
    - Servicio telefónico disponible al público, fijo o móvil (operador móvil virtual completo) con su numeración geográfica fija, red inteligente, móvil, etc.
    - Telefonía vocal en grupo cerrado de usuarios - Voz sobre redes privadas [IP CENTREX](https://www.voip-info.org/ip-centrex/)
    -  Servicio telefónico sobre redes de datos en interoperatividad con el servicio telefónico disponible al público
    - Servicios nómadas 10 (servicios vocales nómadas)
    -  Transporte de tráfico telefónico entre operadores (códigos de señalización)
    -  Radiocomunicaciones móviles terrestres en grupos cerrados de usuarios (numeración IRM)
    - Comunicaciones móviles en aeronaves (MCA) 11
    - Comunicaciones móviles en buques (MCV) 12
    - Reventa de servicios vocales:
      - Fijo: en acceso directo, indirecto o mediante la comercialización y gesión de tarjetas telefónicas de prepago (con subasignación de la numeración fija) 13
      - Operador móvil virtual prestador de servicio (con subasignación de la
        numeración móvil)
      - Móvil por satélite
      - Vocal Nómada (con subasignación de la numeración nómada)
    - Consulta telefónica sobre números de abonado:
      - Consulta telefónica sobre números de abonado (numeración 118AB) 14
      - Consulta sobre números de abonado mediante mensajes cortos (SMS)
    - Radiobúsqueda
    - Gestor del múltiple digital de televisión digital terrestre 15
    - Reventa de servicios de comunicaciones móviles en itinerancia
    - Servicios nómadas de mensajes 16
    - Reventa de servicios nómadas de mensajes 17
    - Transporte de la señal de los servicios de comunicación audiovisual
    - Transporte de la señal de los servicios de comunicaciones móviles
    - Transporte de la señal de los servicios de radiocomunicaciones móviles terrestres en grupo cerrado de usuarios
    - Servicios de transmisión de datos disponibles al público:
      - Almacenamiento y reenvío de mensajes 18 (numeración mensajes cortos de texto y mensajes multimedia) / Reventa de almacenamiento y reenvío de mensajes
      - <u>Correo electrónico</u>
      - Fax bajo demanda
      - <u>Interconexión de redes de área local</u>
      - <u>Proveedor de acceso a Internet</u>
      - <u>Reventa de capacidad de transmisión/circuitos</u>
      - <u>Suministro de conmutación de datos por paquetes o circuitos</u>
      - <u>Videoconferencia</u>

Subrayados los servicios que mi proyecto del nombre comercial  "[Redama - la red que te ama.](https://redama.es/)" piensa brindar en esta primera fase de diseño. En un segundo tiempo a través de una ampliación que estudiaremos más adelante incluyéremos los productos de telefonía sobre ip.  

#### Acceso a infraestructuras nacionales de alquiler de espacio en torres de telecomunicaciones.	

![Cellnex](http://redama.es/Imagenes/montgros_cellnex.jpg)

Una vez que tengamos el proyecto aprobado por parte de la comisión de mercado de telecomunicaciones nuestro sucesivo paso es obtener un permiso y contrato de explotación de la torre de telecomunicaciones que pensamos utilizar.

En España el mercado es subdividido entra varios proveedores, los más importantes:

- [Cellnex Telecom](https://es.wikipedia.org/wiki/Cellnex_Telecom)
- [Axion Infraestructuras](https://www.axion.es/)

Después hay varios de menor tamaño que podemos encontrar agrupados en diferentes asociaciones, entra las cuales:

- [Comunidad Unired &#8211; Web de la asociación de difusión española](https://www.uniredasociacion.es/)
  - [AST - Aragonesa de servicios telemáticos.](https://ast.aragon.es/) 
  - [IBETEC - Entidad Pública Empresarial de Telecomunicaciones y Innovación de las Illes Balears](http://www.caib.es/sites/M1311251117321911659239/ca/portada-63318/)
  - [Itelazpi | Difusio Arduratsua](http://www.itelazpi.eus/eu/)
  - [Nasertic - Navarra de Servicios y Tecnologías](https://www.nasertic.es/es)
  - [Telecomclm - Tu operadora regional de telecomunicaciones](https://telecomclm.net/)
  - [Retegal](https://www.retegal.gal/gl)
  - [Operador de telecomunicaciones | Istec](https://www.istecdigital.es/)

Conseguir un contrato no es nada del otro mundo, llevar con vosotros el proyecto aprobado y contactar con el departamento comercial de la empresa que brinda servicio desde la torre de vuestro interés. 

Un vez en comunicaciones con el proveedor pedir el `kml` que abarca todas las instalaciones para posibles ampliaciones o proyectos puntuales. Utilizando el fichero podéis hacer estudios de cobertura exactos con nuestra herramienta radio mobile.

#### Llaves de acceso

![Llaves Locken](https://cyberlock.com/wp-content/uploads/2018/01/CK-BLUE2.jpg)

Las infraestructuras nacionales están protegidas con sistemas de acceso digital por parte de llaves de seguridad con permisos temporales de acceso previa autorización de el departamento de gestión de la empresa.

Varios los sistemas que se encuentran en dichas instalaciones, los más importantes:

![Cilindro locken](https://jpmugo.files.wordpress.com/2010/03/p_2048_1536_538926c0-0022-4a96-880f-24789ea249c6.jpeg?w=640)

- Herraduras inteligentes.
- Cilindros huecos donde se colocan otras llaves de candados que pertenecen a la misma instalación.

Las llaves de seguridad disponibles ahora mismo permiten de cargar permisos de forma autónoma por parte del contratista ahorrando el viaje en las instalaciones del proveedor con el fin de hacer esta simple, pero no tanto, operación que voy a detallar en seguida:

#### Leyes y Real decretos en material de seguridad de trabajos en altura y prevención de riesgos. 

![Real decretos](https://confilegal.com/wp-content/uploads/2021/03/boe-01.jpg)

Con el fin de ejecutar los trabajos de montaje en torre de manera más segura posible, recordaros que la vida es una, las leyes españolas y los real decretos acerca de prevención de riesgo laborales y trabajos en altura prevén la obligación de pasar unos exámenes tanto teóricos cuanto prácticos acerca de las medidas adecuadas y las herramientas necesarias para que no tengamos ningún tipo de susto para portar a fin nuestro esfuerzo para ser así operadores homologados y en toda regla. Todo un éxito! 

<u>**[Ley 31/05](https://www.boe.es/buscar/pdf/1995/BOE-A-1995-24292-consolidado.pdf) de prevención de riesgos laborales.**</u>

Analizamos el articulo 14 que prevé el derecho de los trabajadores a una protección eficaz en materia de seguridad y salud, mientras que por los empresarios el deber de protección eficaz en materia de prevención de los trabajadores frente a los riesgos derivados del trabajo. El empresario deberá garantizar la seguridad y salud de los trabajadores a su servicio en todos los aspectos relacionados con el trabajo.

Entrando más en detalles se desglosa que el trabajador deberá:

- Velar, según sus posibilidades, por su seguridad y salud, y por la de aquellas otras personas a las que pueda afectar su actividad profesional.
- Ser informado y formado.
- Ser consultado y participar en las decisiones relativas a la prevención.
- Interrumpir la actividad en caso de riesgo grave o inminente.
- Recibir una vigilancia periódica de su estado de salud.
- Utilizar correctamente máquinas, aparatos, herramientas, sustancias peligrosas y equipos de transporte.
- Utilizar correctamente los equipos de protección individual.
- Usar correctamente y no poner fuera de funcionamiento los dispositivos de seguridad de las máquinas, aparatos, herramientas, instalaciones, etc.
- Informar al Superior y a los trabajadores designados en las actividades preventivas, de situaciones que entrañen un riesgo para la seguridad y salud.
- Contribuir al cumplimiento de las obligaciones para una protección eficaz en materia de seguridad y salud.
- Cooperar con el empresario y los trabajadores designados en las actividades preventivas, para que estos puedan garantizar unas condiciones de trabajo seguras.

**<u>[Real Decreto 2177/044](https://www.boe.es/boe/dias/2004/11/13/pdfs/A37486-37489.pdf)</u>**

Se trata de disposiciones mínimas de seguridad y salud para la utilización por los trabajadores de los equipos de trabajo en materia de trabajos temporales en altura. De disposiciones especificas sobre la utilización de las técnicas de acceso y de posicionamiento mediante cuerdas que cumplirá las siguientes condiciones:

El sistema constará como mínimo de dos cuerdas con sujeción independiente, una como medio de acceso, de descenso y de apoyo que se puede identificar como cuerda de trabajo y la otra como medio de emergencia conocida como cuerda auxiliar de seguridad.

A todo trabajador la empresa tiene que brindar unos arneses adecuados que deberán utilizar y conectar a la cuerda de seguridad o sistemas anti caídas.  

Gracias por tu tiempo,

Riccardo `<taglio>` Giuntoli.