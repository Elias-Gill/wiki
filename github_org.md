# Organización del proyecto en GitHub

Este documento resume **qué va en cada sección de GitHub**, con el objetivo de mantener el
proyecto ordenado, profesional y fácil de sostener como open source.

______________________________________________________________________

## Drafts (Pull Request Drafts)

**Qué va acá**

- Trabajo en progreso (WIP)
- Implementaciones incompletas
- Experimentos técnicos
- Refactors grandes que todavía no están listos para revisión

**Para qué sirven**

- Mostrar en qué se está trabajando sin bloquear el repo
- Recibir feedback temprano
- Evitar PRs “terminados a medias”

**Buenas prácticas**

- Marcar claramente qué falta
- No mezclar múltiples objetivos
- Convertir a PR normal solo cuando esté listo para review

______________________________________________________________________

## Discussions

**Qué va acá**

- Preguntas abiertas
- Propuestas de ideas
- Debates de arquitectura
- Feedback general
- Anuncios del proyecto
- Ideas que todavía no son issues

**Qué NO va**

- Bugs
- Tareas concretas
- Trabajo asignable

**Uso recomendado**

- Una discusión -> puede terminar en:
  - Un issue
  - Un PR
  - O descartarse

______________________________________________________________________

## Issues

**Qué va acá**

- Bugs reproducibles
- Tasks técnicas
- Requests claros de features
- Mejoras concretas
- Deuda técnica

**Qué debe tener un issue**

- Descripción clara
- Contexto
- Resultado esperado
- (Si aplica) pasos para reproducir

**Tipos comunes**

- `bug`
- `enhancement`
- `refactor`
- `docs`
- `good first issue`

______________________________________________________________________

## Pull Requests (PRs)

**Qué va acá**

- Código terminado y listo para revisión
- Cambios alineados a un issue o decisión previa
- Implementaciones claras y acotadas

**Buenas prácticas**

- Un PR = un objetivo
- Referenciar el issue correspondiente
- No mezclar refactors con features
- Tests/documentación si corresponde

______________________________________________________________________

## Projects (Boards)

**Qué va acá**

- Estado del trabajo
- Seguimiento visual del progreso

**Columnas**

- Requiere discusion:
  features, bugs, drafts y requests que requieren de discusion son el equipo y no presentan una
  prioridad para analizar.
- *En analisis*:
  todos los PR e Issues caen por defecto en esta categoria, requieren intervencion manual del
  equipo para asignarles una prioridad
- *TODO*:
  bugs que deben corregirse y estan entre las prioridades del equipo
- *In Progress*:
  Issues en los que ya se estan trabajando
- *Waiting Aproval*:
  Todos los PRs que ya fueron revisados y cuentan con aprovacion de merge, ademas de PRs que
  tienen enlazados issues.
- Done:
  PRs mergeados y sus issues enlazados.

**Qué se mueve**

- Issues
- PRs

**Qué NO es**

- Un lugar para discutir
- Un roadmap largo plazo

______________________________________________________________________

## Milestones

**Qué va acá**

- Objetivos con fecha o versión
- Entregables claros

**Ejemplos**

- `v0.1 – MVP`
- `Refactor Frontend`
- `Excel Parser Stabilization`

**Uso**

- Agrupar issues
- Medir progreso real
- Evitar scope creep

______________________________________________________________________

## Wiki

**Qué va acá**

- Documentación viva
- Explicaciones largas
- Guías internas
- Decisiones técnicas

**Ejemplos**

- Arquitectura del sistema
- Flujo de parseo del Excel
- Convenciones del proyecto
- Cómo contribuir
- Decisiones importantes (ADR simplificado)

**Qué NO va**

- Changelogs
- Bugs
- Ideas sueltas

______________________________________________________________________

## README

**Qué va acá**

- Qué es el proyecto
- Cómo correrlo
- Requisitos
- Estado general
- Limitaciones conocidas
- Enlaces importantes

**Debe ser**

- Corto
- Claro
- Accesible para nuevos contributors

______________________________________________________________________

## Resumen rápido

- **Draft PR** -> trabajo en progreso
- **Discussions** -> conversación
- **Issues** -> trabajo a hacer
- **PRs** -> trabajo hecho
- **Projects** -> estado del trabajo
- **Milestones** -> objetivos
- **Wiki** -> conocimiento
- **README** -> puerta de entrada

______________________________________________________________________

## Regla de oro

> Si algo requiere acción -> Issue
> Si algo requiere conversación -> Discussion
> Si algo es conocimiento -> Wiki
> Si algo es código terminado -> PR
