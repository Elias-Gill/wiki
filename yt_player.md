# Simple YT player 

Sirve como un "frontend" a mpv y con conexion a la API de youtube para listar lo videos y
canciones.

### Dependencias

- mpv
- [youtube_dl](https://github.com/ytdl-org/youtube-dl)
- [mpv library](https://pkg.go.dev/github.com/gdrens/mpv#section-readme)

Para mas informacion acerca de la api rpc de mpv consultar:
https://mpv.io/manual/master/#properties

# TODOs

- Restore last player status (search list and search input)
- Cola de reproduccion
- Canciones favoritas
- Listar y reproducir playlists
- Completado de historia en las busquedas
- Historial (listado) de busquedas previas (para minimizar el uso de la api)
- Completado inputs de busquedas

# Fixes

- El stutter de la barra de tiempo
- Resize de las ventanas 
- Cantidad de canciones listadas

# Proximamente

- Ver si puedo dejar de utilziar la api de youtube y usar solo youtube-dl
