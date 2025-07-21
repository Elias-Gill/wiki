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
└── Crear nuevo proyecto
    └── Ver proyecto
├── Objetivos
├── Bitácora
├── Recursos
└── Estadísticas
    └── Configuración (sincronización / exportación)
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
