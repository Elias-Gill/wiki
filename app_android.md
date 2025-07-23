- [TODOS](app_android_todos.md)
- [Descripcion de la app](project_tracker.md)

---

# ROADMAP

## 1. Definición Inicial
- [ ] Definir propósito y alcance claro de la app.
- [ ] Definir entidades principales:
  Proyecto, Objetivo, Bitácora, Recurso.
- [ ] Esquematizar relaciones entre entidades (diagrama sencillo).

[Difinicion](#Definicion)

## 2. Diseño UI/UX
- [ ] Bocetar pantallas principales:
    - Lista de Proyectos
    - Crear / Editar Proyecto
    - Vista Detallada (Objetivos, Notas, Recursos, Estadísticas)
    - Configuración / Exportación
- [ ] Definir navegación (BottomNav, Drawer, Tabs).
- [ ] Diseñar los flujos UX:
  Crear → Gestionar → Terminar Proyecto.

[Diseno](#Diseno)

## 3. Estructura Técnica del Proyecto
- [ ] Configurar proyecto Android Studio.
- [ ] Definir arquitectura (MVVM recomendado).
- [ ] Configurar Room para base de datos local.
- [ ] Definir modelos Entity y DAOs iniciales.
- [ ] Crear repositorios y viewmodels.

[Estructura](#Estructura)

## 4. Funcionalidades Core
### Proyectos
- [ ] Crear / Editar / Eliminar proyecto.
- [ ] Ver lista de proyectos con estado y progreso rápido.

### Objetivos
- [ ] Añadir / Completar / Eliminar objetivos.
- [ ] Mostrar progreso en porcentaje.

### Bitácora
- [ ] Añadir entradas con fecha y hora.
- [ ] Mostrar entradas en orden cronológico.

### Recursos
- [ ] Añadir links y archivos como recursos.
- [ ] Abrir recursos con intent ACTION_VIEW.

## 5. Funcionalidades Complementarias
- [ ] Notificaciones de inactividad.
- [ ] Exportar datos (JSON, PDF, CSV).
- [ ] Compartir notas o avances mediante ACTION_SEND.
- [ ] Sincronización manual con "servidor local" (API REST falsa).

## 6. Mejora UX/UI
- [ ] Añadir animaciones suaves (transiciones, feedback visual).
- [ ] Mejorar navegación y flujos de usuario.
- [ ] Agregar íconos, colores, tipografía consistente.

## 7. Testing y Refinamiento
- [ ] Pruebas de integración básica.
- [ ] Validar flujos de creación, edición y exportación.
- [ ] Corregir errores y mejorar estabilidad.

## 8. Deploy / Release
- [ ] Configurar firma y build final.
- [ ] Probar en dispositivos reales.
- [ ] Documentar el proyecto.

# Especificaciones

## Definicion

## Diseno

## Estructura
