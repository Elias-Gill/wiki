## Refactorización masiva de base de datos — Checklist

[Como hacer las transformaciones del DTO al nuevo modelo](migracion_notas.md)

Usar Migrate y Version para correr esta migracion masiva para que la base de datos este en un
estado mas sano.

**NOTA SOBRE ELECTIVAS Y OPTATIVAS**:
Para las materias Electivas y optativas, estas se guardan simplemente como "electiva x", la
informacion extra (es decir, el nombre del curso como tal) se guarda en el curso de cada
periodo, puesto que las electivas y optativas son fijas por semestre, pero las materias
disponibles para tomar cambian por semestre.

Entonces permite tener informacion de la malla mas detallada, pero no rellenar demasiado
informacion.

Puede servir para extraer informacion para armar el visor de mallas interactivo.

### Fase 0 – Preparación
- [x] Congelar cambios no relacionados con la refactorización
- [x] Crear rama dedicada a la refactorización
- [ ] Realizar y verificar backup completo de la base de datos
- [ ] Definir métricas de éxito (integridad, conteos, endpoints)
- [x] Documentar modelo actual vs. modelo objetivo

### Fase 1 – Migración estructural (sin datos)
- [x] Crear migraciones para nuevas tablas normalizadas
- [x] Definir claves primarias, foráneas, índices y constraints

### Fase 2 – Actualización del parser
- [x] Adaptar parser al nuevo modelo de datos
- [x] Implementar reglas de normalización
- [x] Crear tests para múltiples profesores
- [x] Crear tests para variaciones de nombres
- [ ] Crear tests para datos inválidos
- [ ] Completar funciones del mapper de DTO a modelos actuales
- [ ] Poner en NULL (ignorar) el campo docente de los cursos cuyo docente se encuentra "a
  confirmar"

### Fase 3 – Backend
- [ ] Agregar nuevos storers con versiones actualizadas de los metodos actuales y actualizar
  las querys.
- [ ] Desacoplar los services de los "models" (hacer que los repositorios retornen structs
  coherentes pero condensados segun utilidad).
- [ ] Actualizar services (inputs y outputs) para utilizar los nuevos storers y la nueva logica
  de parseo.
- [ ] Añadir tests de integración críticos
- [ ] Actualizar los controllers para usar las versiones mas actualizadas de los services

### Fase 4 – Migración de datos antiguos

_NOTA_:
para la migracion de las materias a datos mas nuevos, puedo simplemente descartar completamente
las tablas antiguas y forzar una actualizacion del excel.
Entonces una vez que ya tengo resueltos los datos nuevos extraidos, de ahi puedo tratar de
hacer las migraciones de horarios a las versiones nuevas de las materias.

- [ ] Implementar scripts/procesos de migración de datos antiguos
    - [ ] Materias
        - [ ] Normalizar y cargar nombres de materias desde tablas antiguas
        - [ ] Implementar sistema de resolucion para materias mal escritas
    - [ ] Docentes
        - [ ] Implementar sistema de resolucion para docentes mal escritos
        - [ ] Carga de profesor con nombres multiples
        - [ ] Normalizar y cargar nombres de docentes desde tablas antiguas
    - [ ] Evitar duplicados (definir estrategia explícita)
    - [ ] Crear correctamente relaciones y tablas puente para horarios de los usuarios
    - [ ] Migrar horarios antiguos de usuarios a nuevas tablas de cursos
        - [ ] Generar avisos de horarios que no pudieron ser migrados (para ver como hacerlo de
          manera correcta)
- [ ] Ejecutar migración en entorno de prueba
- [ ] Validar conteos esperados
- [ ] Validar integridad referencial
- [ ] Validar casos borde conocidos

### Fase 5 – Eliminación del modelo antiguo
- [ ] Crear migración para eliminar tablas viejas
- [ ] Eliminar columnas obsoletas
- [ ] Verificar que no existan referencias al modelo antiguo
- [ ] Marcar funciones de migracion como "DEPRECATED" para eliminarlas en versiones
  posteriores.

### Fase 6 – Frontend
- [ ] Actualizar consumo de endpoints
- [ ] Adaptar modelos de estado
- [ ] Actualizar vistas afectadas
- [ ] Verificar flujos críticos
- [ ] Eliminar dependencias del modelo antiguo
- [ ] Sistema de notificaciones por email para errores de parseo de hojas.

### Fase 7 – Validación final
- [ ] Ejecutar migración completa en staging
- [ ] Realizar smoke tests funcionales
- [ ] Comparar datos antes/después (muestreo)
- [ ] Revisar performance
- [ ] Aprobar despliegue a producción
