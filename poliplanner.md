# DOCUMENTO PERSONAL DE NOTAS PARA POLIPLANNER

CURRENT WORK:
- [ROADMAP para poder hacer la migracion masiva de la db](poliplanner_db_migration.md)
- [Tests de usos de memoria y demas](test_memoria_poliplanner.md)

FIX:
Ver que hacer con las materias de IEK, LGH y LCIK, porque tienen enfasis

CONTINUAR: 
- Primero revisar bien exhaustivamente lo que ya tengo que es el proceso hasta el step 2.
  Ver bien para meter peticiones con HTMX, mostrar mensajes al usuario, redireccion, logs, error
  handling, estructura del codigo, helpers y demas. 
- Ponerme a corregir el tema del selector de temas, el tema, el css del main layout
  y demas. Mejor corregir ahora que hay pocas cosas que despues cuando ya sea todo un quilombo
  de cambiar
- Finalmente continuar con los pasos 3 y 4 (secciones y confirmacion)

FIX:
- [ ] Parseado de nombres de docentes cuando hay mas de un docente (que verga lgmt)
- [ ] Parseado de emails de docentes cuando hay mas de un docente
- [ ] Carga del calendario que siempre falla
- [ ] Error de tiempo de server (igual para JWT no deberia importar porque se firma con el
  tiempo actual del server, no del user, pero da muchos problemas con el tema de logs, tambien
  de actualizacion de los excel y demas).
- [ ] El tema del tiempo de sesiones hacer bien como se debe, ahora era una solucion temporal
  nomas la que hay

TODO: 
- [ ] MIL MILLONES DE TESTS "end to end" completos
- [ ] Agregar descarga directa desde url de excel para el menu de sync
- [ ] Alguna manera de ver estadisticas como cantidad de usuarios, cantidad de conexiones e
  inicios de sesion realizados, etc.
- [ ] Servicios que corren de manera periodica, como la eliminacion de versiones demasiado
  viejas del excel y sus respectivos horarios.

FEATURES:
- [ ] Seccion de comentarios y sugerencias

REFACTOR: 
- [ ] Todo el frontend, uso de css y demas.
  Que paja, eso no quiero hacer yo la verdad
- [?] Parseado de manera directa de las horas "desde - hasta" por cada materia (capaz que pued
  servir de algo hacer eso)
- [ ] Re-revisar la arquitectura del parseo de excels, no me convence para nada la verdad.
- [ ] Revisar el uso excesivo y directo de models desde la DB
- [ ] Ver si implementar manejo de sesiones a la antigua.

Para aumentar el tiempo de sesion puedo usar un sistema con PASETO y agregar un campo de
validacion al usuario, el cual "epoch" le llama chatgpt, el cual es una version que cuando se
cambia de contrasena por ejemplo se cambia la version del epoch.
Si las versiones no concuerdan con la BD entonces se invalida el token y la sesion no se
permite.

Esto es facil y bastante trivial incluso para sqlite en terminos de rendimiento, ademas de que
permite tener varias sesiones por usuario y va a ser super facil de implementar.

[posible libreria Paseto](https://github.com/aidantwoods/go-paseto)

# Desarrollo en equipo

[notas sobre como llevar el proyecto](poliplanner_org.md)

# DISCIPLINA

Comenzar a mover la estrategia de desarrollo a una rama dev, para tener mucho mas organizado el
historial de commits, cambios y poder hacer realeses con CI de fly.io, ademas de poner las
nuevas funcionalidades.

# Ideas
- Una feature feacible es la de las mallas interactivas, pero es demasiado denso de programar y
  preparar.
  Aunque me puedo crear una suerte de DSL para generar las mallas con JS o algo raro asi.
- Construir mi propia version del parser de csv, asi puedo generar las columnas de manera
  dinamica en vez de tener que manejar de 1 por 1 las columnas.
- Para solucionar problemas por ejemplo lo de que los semestres no esten bien puestos, entonces
  puedo tratar de armar una tabla de metadatos, agrupando cosas importantes, como semestre y
  nivel.
