## 📝 Qué debe poder hacer la App (Features/Requisitos):

### 1️⃣ Gestión de Proyectos Personales

Cada "mini proyecto" tendrá:

* Nombre, Descripción, Fecha de Inicio, Estado (activo, en pausa, terminado)
* Objetivos / Fases (pueden ser checklists simples)
* Bitácora / Notas (registro de avances, reflexiones, aprendizajes)
* Recursos Asociados (links, archivos, etc.)

### 2️⃣ Seguimiento / Estadísticas

* Cuánto tiempo lleva activo.
* Progreso sobre objetivos (completados vs totales).
* Número de entradas de bitácora.
* Estadísticas visuales (opcional).

### 3️⃣ Sincronización Básica

* Guardar todo localmente (SQLite / Room).
* Opción de sincronizar/exportar JSON con un "servidor casero" (API REST falsa, por ejemplo en
  tu PC con Express / Flask).

### 4️⃣ Funcionalidades Generales

* Notificaciones (ej:
  "Hace 7 días que no avanzas en proyecto X").
* Backup / Restore.
* Exportar en PDF o CSV (por mail, por ejemplo).

---

## 🔄 Flujo de la App (User Flow)

```plaintext
Inicio (Listado de proyectos)
 ├── Crear nuevo proyecto
 ├── Configuración (sincronización / exportación)
 └── Ver proyecto
      ├── Objetivos
      ├── Bitácora
      ├── Recursos
      └── Estadísticas
```

### Flujo resumido típico:

1. Usuario crea proyecto.
2. Agrega objetivos (pueden ser tareas/fases).
3. Escribe notas de progreso (bitácora).
4. Adjunta recursos si quiere.
5. Revisa su avance.
6. Termina o pausa proyecto.

---

## 🎨 Interfaz Gráfica (Pantallas necesarias)

**Pantalla Principal (Listado de proyectos)**

* Botón "+ Proyecto"
* Lista de proyectos con estados y progreso rápido.

**Pantalla Crear / Editar Proyecto**

* Formulario para nombre, descripción, fechas, estado.

**Pantalla de Detalle de Proyecto (tabs o secciones):**

* **Objetivos (checklist)**
* **Bitácora (timeline de notas con fecha)**
* **Recursos (links / archivos)**
* **Estadísticas (progreso, duración)**

**Pantalla Configuración / Exportación**

* Exportar a JSON / PDF / CSV
* Sincronizar con "servidor casero"

**Pantalla de Notificaciones Recientes (opcional)**

* Últimos recordatorios, avances.

---

## 📋 Pasos recomendados para diseñar y construir

### 🔹 1. Diseño Conceptual

* Define tu **data model** primero (qué es un proyecto, qué es un objetivo, etc.).
* Piensa el ciclo de vida:
  crear → editar → cerrar.

### 🔹 2. Mockups UI

* Bocetos rápidos de las 5 pantallas clave que mencioné.
* Define navegación (tabs, menú hamburguesa, bottom bar, etc.).

### 🔹 3. UX Flow

* Esquematiza los flujos de usuario (crear, consultar, exportar).

---

## 🛠️ Pasos Técnicos para Desarrollar

### 1️⃣ Crea la estructura base:

* Navegación
* Pantallas vacías

### 2️⃣ Define la base de datos local (Room / SQLite)

* Entidades:
  `Project`, `Objective`, `LogEntry`, `Resource`

### 3️⃣ Implementa CRUD por partes:

* Proyectos
* Objetivos
* Bitácora
* Recursos

### 4️⃣ Agrega funcionalidad progresiva:

* Notificaciones locales
* Estadísticas básicas (porcentaje, fechas)
* Exportación de datos (JSON / PDF)

### 5️⃣ Simula sincronización:

* Backend simple en tu PC (Express / Flask)
* API endpoints:
  GET / POST / PUT / DELETE proyectos
* Desde app, sincroniza manualmente (un botón es suficiente para pruebas)

### 6️⃣ Pulir la UX/UI

* Animaciones suaves
* Navegación clara
* Transiciones de estado (inactivo, terminado, etc.)

---

## 🔗 Cómo enlazar Notas y Recursos

Recomendado:

* **Bitácora como timeline ordenado por fecha.**
* Recursos enlazados por `URL` o `ruta de archivo`.
* Relación directa por `project_id` en la DB.
* Cuando estés en la vista del proyecto, accesos rápidos a:

* "Nueva Nota"
* "Agregar recurso"
* "Marcar objetivo"

---

## 📡 "Servidor casero" (para simular red)

* **Tu PC como API REST (localhost o red local)**
* JSON storage (`projects.json`)
* Node (Express) o Python (Flask)
* Endpoints:

* `/projects`
* `/projects/:id`
* Desde app:
  Retrofit / Volley para consumir.

# 📲 Dónde usar `Intents` en tu proyecto

## 1️⃣ **Notificaciones (Imprescindible usar Intents)**

Cuando envías una notificación:

* Se define un `PendingIntent` para abrir la app o una vista específica (por ejemplo, abrir
  directamente el proyecto donde falta avanzar).
* Es la forma oficial para que la notificación "salte" a tu app.

---

## 2️⃣ **Editor Externo para Notas (Markdown)**

Si quieres evitar escribir tu propio editor rich-text/markdown, puedes usar un
`Intent.ACTION_EDIT` para lanzar editores externos que soporten `.md` (aunque depende de las
apps que tenga instaladas el usuario).

**Ejemplo:**

```kotlin
val intent = Intent(Intent.ACTION_EDIT).apply {
setDataAndType(Uri.parse("file://path/to/note.md"), "text/markdown")
}
startActivity(intent)
```

**Problema:** No todos los usuarios tienen apps que soporten esto.
Y si tu app es más completa, mejor incluyes un simple editor de texto plano (con soporte de
markdown básico como preview).

---

## 3️⃣ **Compartir Recursos / Notas**

Si quieres que el usuario comparta:

* Una nota en texto plano.
* Un reporte en PDF.
* Un enlace relacionado.

Usarías `Intent.ACTION_SEND`.

```kotlin
val sendIntent = Intent().apply {
action = Intent.ACTION_SEND
putExtra(Intent.EXTRA_TEXT, "Mira mi progreso en este proyecto: ...")
type = "text/plain"
}
startActivity(Intent.createChooser(sendIntent, null))
```

---

## 4️⃣ **Abrir Links / Recursos Externos**

Si el usuario guarda un enlace o archivo como recurso, usarías `Intent.ACTION_VIEW` para que lo
abra:

* Navegador web
* PDF viewer
* App de archivos

```kotlin
val intent = Intent(Intent.ACTION_VIEW, Uri.parse("https://ejemplo.com"))
startActivity(intent)
```

---

## 5️⃣ **Sincronización Manual (opcional)**

Podrías usar `IntentService` si quieres practicar con background workers para simular la
sincronización local, aunque con `WorkManager` es lo moderno.

---

## 🧑‍💻 Recomendación realista para tu caso:

| Función         | Usar Intent Externo | Mejor In-App |
| --------------- | ------------------- | ------------ |
| Notificaciones  | ✅ Obligatorio       | -            |
| Editar Markdown | ❓ Si quieres probar | ✅ Más seguro |
| Compartir Notas | ✅ Acción natural    | -            |
| Abrir Recursos  | ✅ Acción natural    | -            |
| Background Sync | WorkManager mejor   | -            |

---
