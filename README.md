## Radio Mobile, instalación y utilizo bajo ambiente wine Linux
![](https://redama.es/Imagenes/radio_mobile.png)

Una guía sobre como instalar y utilizar el software por excelencia de planificación de explotación de red inalámbricas. [Radio Mobile](https://www.ve2dbe.com/english1.html). 

Nuestro fin es aportar en [comisión de mercado de telecomunicaciones](https://www.cnmc.es/) un proyecto para pedir la alta en el [registro de operadores en España](https://numeracionyoperadores.cnmc.es/operadores). Del cual tenemos una copia también en nuestro repositorio descargadle en formado [`zip`](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/rosce.zip?raw=true) o [`csv`](https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/rosce.csv?raw=true). 

#### Instalación 

Seguir los mandos y tener claro que el fichero de [Visual Basic](https://es.wikipedia.org/wiki/Visual_Basic) 6 tiene que ser extraído en la carpeta `tmp` en la raíz del disco C de windows emulado por [wine](https://www.winehq.org/). 

```shell
$ sudo apt install wine64
$ cd ~/.wine/drive_c && mkdir tmp
$ cd /tmp
$ wget https://github.com/Redama-la-red-que-te-ama/radio-mobile-linux/blob/main/VB6.0-KB290887-X86.exe?raw=true
$ mv VB6.0-KB290887-X86.exe\?raw\=true VB6.0-KB290887-X86.exe
$ wine VB6.0-KB290887-X86.exe #extraer en C:\tmp
$ cd ~/.wine/drive_c/tmp/
$ wine vbrun60sp6.exe
```

