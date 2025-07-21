# TODO

Manejo de usuarios:
- [x] Mensaje de error cuando no se proporcionaron datos validos
- [x] Cambiar completo el formulario de registro
- [x] Frontend feo
- [x] Verificar operaciones crud sobre usuarios
- [x] Anadir suit de test sobre usuarios

Creacion de horarios:
- [ ] Suit de tests
- [x] Mejor filtrado de materias en general
- [x] Orden de horarios por fecha en vez de por nombre de examen
- [x] Que te pida primero elegir la carrera y la version del excel al crear nuevo horario

Parseo del excel:
- [x] Actualizar las materias del horario ya creado en vez de tener que crear otro horario
  completamente nuevo (y agregar muchos tests para ese caso si es que voy a hacer).
- [x] Listar los url mas nuevos, aunque sean links de google drive
- [x] Usar API de google drive para descargar los archivos
- [?] `Fix` Notificaciones de nuevo excel disponible para que no sean tan molestas
- [ ] Testing intensivo para la herramienta de migracion de horarios
- [x] Mejorar la comparacion de fechas con el sync manual.
  Anadir comparacion de fechas en vez de url, porque puede ser que subi un excel manual mas
  nuevo, pero siempre se sobreescribe por la actualizacion automatica.

FIX:
- [x] Se pueden acceder a horarios ajenos poniendo el id
- [x] Guardar las fechas como formato parseado (o hacerlo en el frontend) y limpio, porque hay
  fechas que una basura la facu y por ejemplo aparece "15:00:00 hs" y otros "08:00hs", no tiene
  sentido.
- [x] Asegurarse de que no aparezca el ".csv" del nombre de la carrera
- [x] Que las listas de las materias por semestres este "undesplegada" por defecto
- [x] Fix hack de parseo del csv
- [ ] Ver el caso donde en el excel no estan puestas las casillas de "aula".
  Mejor simplemente tener dos versiones del DTO.
  No deberia de ser tan complicado ver cual version usar dependiendo de la estructura del csv.
- [ ] Anadir mensajes de error y aviso, asi como respuestas de error y aviso al endpoint de
  sincronizacion.
- [ ] Error con IS2 que me mostro Zinri al usar la herramienta de migracion.
 
REFACTOR:
- [ ] Cambiar los comentarios y nombre de variables para usar un lenguaje estandar (codigo en
  ingles, comentarios y avisos en espanol)
- [ ] Posiblemente sea mejor cambiar el `sysout` por los metodos del `logger` en los tests.
- [ ] Ver si es que usar cookies para poder dejar seleccionado el ultimo horario que se
  accedio.
- [x] Hacer limpieza de campos del DTO csv para mejorar los modelos actuales de Subject (poner
  tipado y demas).
  Modificar el object Mapper
- [x] Ver si esta bien el modelo de parseo, si hay suficiente separation of concerns.
 
FEATURES:
- [ ] Ver fechas de revision de los examenes en las vistas de informacion
- [x] Frontend responsive
- [ ] Mostrar la lista de materias ya agregadas en la pantalla de creacion de horarios
- [ ] Buscador en la seccion de armar horarios
- [x] SEO de google para indexacion
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
