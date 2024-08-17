# Principal

TAREA:
Desmembrar los requerimientos funcionales y los casos de uso.
Entrega de casos de uso, luego empezar con el disenho (diagrama de clases, secuencia y demas).

NOTA 1:
TOdos los cambios a los requerimientos se deben poner con justificacion.

NOTA 2:
Pizarra de esto
https://docs.google.com/document/d/-6IaM9lkk5_wAXxH2k9UESM97BlMlJJIcr7i87LMKkIDI/edit

# Gestion de roles y permisos

**Permisos**: 
- Suscriptor
- Visitante
- Editor
- Autor
- Publicador

**Consideraciones**: 
- Administrador (NO puede crear usuarios, pero si eliminarlos, no puede generar articulos.
  Solo crear roles y asignar roles y categorias)
- El publicador no puede editar ni crear, solo puede revisar para publicar.
- Los roles son por conjuntos, es decir son tags especificas del usuario (onda `["publicador",
  "editor", etc]`).
  NO ES una jerarquia.
- Solo el autor tiene una categoria asociada.
  Los publicadores y editores son globales.
- Se mantiene la posibilidad de crear roles personalizados
- Se debe presentar las estadisticas segun el rol que se tenga.

# Contenido y estados de la publicacion

Tenemos que teneer un estado para el editor del articulo, es necesario que pase por el editor.
Se debe agregar un estado "en edicion".

```txt

                                          ┌──────────────────┐
                                          ∨                  │
┌────────────────┐     ┌──────────┐     ┌────────────┐     ┌────────────────────────┐     ┌───────────┐     ┌──────────┐
│ estado inicial │ ──> │ borrador │ ──> │ en edicion │ ──> │ en espera del publicar │ ──> │ publicado │ ──> │ inactivo │
└────────────────┘     └──────────┘     └────────────┘     └────────────────────────┘     └───────────┘     └──────────┘
                         ∧                                   │
                         └───────────────────────────────────┘
```

- Suspender el tema de plantillas.
  El blog tiene una unica "plantilla" estatica.
- Los contenidos multimedia se guardaran en la nube de terceros
- La publicacion debe tener titulo e imagen de referencia (hacer de rapida descarga, lo que
  implica peso maximo y tamanho).
  La imagen es opcional
- Las publicaciones deben tener tags.
- Los estados de las publicaciones se deben administrar en tablero canvan.
- Los articulos deben de estar en un historial y se deben poder ver las versiones anteriores de
  la publicacion.
  Estas historias no se modifican ni borran.
- Se cancela las subcategorias, solo se mantienen las categorias.
- Los articulos SOLO pueden pertenecer a _UNA_ sola categoria
- Se tienen categorias de interes para el suscriptor (categorias favoritas)
- Se debe implementar un sistema de busqueda de articulos
- Se debe poder reportar contenido (se notifica al admin)
- Las publicaciones pueden ser programadas para su publicacion y vigencia

Las estadisticas que se deben reportar:

- Compartidos
- Likes
- Comentarios
- vistas

# Mas consideraciones

- Los comentarios se deben registrar en una plataforma externa (onda comentarios de facebook).
- Se cancela el tema de SSO (inicio de sesion con terceros como Google)
- NO se considera el performance
- Se debe implementar una pasarela de pagos y categorias de pago
- Se mantiene las notificaciones por correo
- Se deben generar reportes de Historial de las publicaciones.

# Notas

NOTA 1:
para el cambio de estado se debe guardar en un log, ademas de que se debe requerir un
comentario de la revision en cada paso.

NOTA 2:
empezar con la parte de seguridad y los permisos, en base a eso levantar todo.

NOTA 3:
prohibido usar el usuario ADMIN nativo de django.
Se debe crear un usuario administrador que puede hacer todo menos crear articulos.

NOTA 4:
No se califica la estetica como tal, pero debe de ser coherente y usable.
MANTENER una misma normal para los nombres (onda:
guardar siempre, no que sea uno:
guardar, ok, aceptar).

NOTA 5:
Planificar el codigo para poder tener una entrega CALIFICABLE, o sea que se pueda usar

NOTA 6:
NO se puede usar `django.cms`

NOTA 7:
Guardar todos los epics en Jira, y hacer todo el historial en Jira

NOTA 8:
Esa lista de categorias podemos hacer por paginas, usando htmx, entonces hacemos paginado
ESTATICO para las vistas de interes (onda, de 10, 7 articulos de interes y 3 de otras)

NOTA 9:
se me ocurre que por cada rol se pueda tener un metodo especial para listar sus estadisticas.
Entonces en la ui se va a ver algo asi:

```txt
--- Estadisticas de publicador ---
...
--- Estadisticas de editor ---
...
```

# Cambios v2

## Notas del profesor

- Si sos editor te tiene que cargar tu kanban de las publicaciones.
- Podes ir a inicio, claro que podes.
- si le saco el rol de editor por ej a una persona, va a tener el rol de suscriptor, ya que un
  usuario puede tener N roles.
- Un autor puede publicar en cualquier categoría.
  Asi como el editor y publicador
- Un autor puede crear contenido y publicarlo directamente sin editor o publicado en una
  categoría no moderada.
  Si es moderado pasa por editor y publicador
- Las categorías pueden ser públicas, pagadas y para suscriptores.La categoría para
  suscriptor no se paga, se ingresa solo si estas registrado, las categorías pagadas tenes
  que estar registrado y pagar, las categorías públicas poder ver sin estar registrado. 
- El pago Va a ser pago único, no mensual, y va a ser por categoría.
- Si sos usuario no registrado poder ver como una prevista de la categoría pago o categoría
  para suscriptor.
- Todo lo que sea interacción:
  me gusta, comentar, agregar a favoritos, es solo para suscriptores.
  El reporte de publicaciones y comentarios lo puede hacer cualquier persona.
- El administrador puede visualizar los comentarios o publicaciones reportadas y dar de baja si
  así lo desea.
- Solo el admin y el autor puede inactivar un contenido.
- El autor va a ver los reportes solamente de su publicación, el admin editor y publicador
  pueden ver todos.
- El autor puede definir la fecha de publicación y vigencia de su contenido.
- Los responsables de la contenido son el autor y el editor.
- se notifica todo prácticamente exceptuando comentarios al ser este de terceros.
- Editar y eliminar categoría solo es opcional, obviamente eliminar si tiene contenidos no se
  puede eliminar.

## Desgloce
