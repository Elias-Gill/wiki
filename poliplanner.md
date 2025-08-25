# TODO

[notas del parser](poliplanner_parser.md)

FIX:
- Boton de eliminar materia en formulario de nuevo horario
- [?] `Fix` Notificaciones de nuevo excel disponible para que no sean tan molestas
- [ ] Ver el caso donde en el excel no estan puestas las casillas de "aula".
  Mejor simplemente tener dos versiones del DTO.
  No deberia de ser tan complicado ver cual version usar dependiendo de la estructura del csv.
- [?] Error con IS2 que me mostro Zinri al usar la herramienta de migracion.
- Asignaturas con el mismo nombre pero de diferente carrera se pueden mezclar en la migration
  tool.

RE-INGENIERIA:
- [x] Reescritura completa del parser.
    * [x] Limpiador de encabezados del CSV (para que no importe si no me mueven una casilla)
    * [x] Que se peudan extraer las columnas de manera dinamica (por ejemplo si no ponen AULA)
- [ ] Usar la BD que me pasaron como Metadata, especialmente para los semestres.
- [ ] Ver para dejar de depender de Gnumeric

REFACTOR:
- [ ] Ver si usar cookies para poder dejar seleccionado el ultimo horario que se accedio.
- [ ] (Parser) Extraer los indices de las columnas del layout y guardar en alguna estructura de
  datos seria mejor.

FEATURES:
- [ ] Ver fechas de revision de los examenes en las vistas de informacion
- [ ] Exportar a pdf o imagen los horarios (no deberia se dificil hacer con algo de custom JS
  nomas).
- [?] Recuperacion de contrasena de usuario (pero involucra contar con email de recuperacion y
  hacer mandar mails, asi que posiblemente no al final)
- [?] Update materias de horario existente

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
