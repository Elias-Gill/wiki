# TODO

Manejo de usuarios:
- [x] Mensaje de error cuando no se proporcionaron datos validos
- [x] Cambiar completo el formulario de registro
- [x] Frontend feo
- [x] Verificar operaciones crud sobre usuarios
- [x] Anadir suit de test sobre usuarios
- [ ] Recuperacion de contrasena de usuario

Creacion de horarios:
- [ ] Suit de tests
- [ ] Actualizar horario
- [x] Mejor filtrado de materias en general
- [x] Orden de horarios por fecha en vez de por nombre de examen
- [x] Que te pida primero elegir la carrera y la version del excel al crear nuevo horario

Parseo del excel:
- [ ] Actualizar las materias del horario ya creado en vez de tener que crear otro horario
  completamente nuevo (y agregar muchos tests para ese caso si es que voy a hacer).
- [ ] Listar los url mas nuevos, aunque sean links de google drive
- [ ] Usar API de google drive para descargar los archivos

FIX:
- [x] Se pueden acceder a horarios ajenos poniendo el id
- [x] Guardar las fechas como formato parseado (o hacerlo en el frontend) y limpio, porque hay
  fechas que una basura la facu y por ejemplo aparece "15:00:00 hs" y otros "08:00hs", no tiene
  sentido.
- [x] Asegurarse de que no aparezca el ".csv" del nombre de la carrera
- [x] Que las listas de las materias por semestres este "undesplegada" por defecto
- [x] Fix hack de parseo del csv
 
REFACTOR:
- [ ] Cambiar los comentarios y nombre de variables para usar un lenguaje estandar (codigo en
  ingles, comentarios en espanol)
- [ ] Posiblemente sea mejor cambiar el `sysout` por los metodos del `logger` en los tests.
- [ ] Ver si es que usar cookies para poder dejar seleccionado el ultimo horario que se
  accedio.
- [x] Hacer limpieza de campos del DTO csv para mejorar los modelos actuales de Subject (poner
  tipado y demas).
  Modificar el object Mapper
- [x] Ver si esta bien el modelo de parseo, si hay suficiente separation of concerns.
 
FEATURES:
- [ ] Ver fechas de revision de los examenes
- [x] Frontend responsive
- [ ] Mostrar la lista de materias ya agregadas en la pantalla de creacion de horarios
- [ ] Buscador en la seccion de armar horarios
- [x] SEO de google para indexacion

# Ideas
- **Solucion a la actualizacion de las materias**:
  cuando sale un nuevo excel, la mayor parte de las veces uno no quiere eliminar el horario que
  ya tiene (por ejemplo, nuevo excel donde salen con las aulas de clases).
  Lo que se puede hacer es buscar las materias por nombre, si es que ya existen, entonces
  actualizar nomas (asi como su version de "sheet") en vez de crear nuevas entradas.
  Si es que no existe esa materia, entonces simplemente creo la nueva enlazada con la version.
  Ademas esto va a evitar crear demasiadas materias nuevas cuando van cambiando nomas a lo
  largo del tiempo.
- Una feature feacible es la de las mallas interactivas, pero es demasiado denso de programar y
  preparar.
  Aunque me puedo crear una suerte de DSL para generar las mallas con JS o algo raro asi.

### Web scrapper

Ya pense en traer todos los links que contengan "xlsx" y todos los que contengan /drive/

- [API Google drive](https://developers.google.com/workspace/drive/api/guides/manage-downloads)

Luego usar la api de google drive sobre cada uno de los links de drive para poder ver los
archivos de cada carpeta y obtener los nombres (para lo unico que siempre son consistentes es
que siempre la parte final del nombre cuenta con la fecha del dia que se subio, algo asi como
excel_muy_largo01042022.xlsx).

[Conversacion de chatgpt sobre la api de google drive](https://chatgpt.com/c/687669aa-ce20-8011-8103-306433ae4688)
