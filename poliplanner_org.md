Ver [como organizar](github_org.md)

Esto es un problema de **gobernanza técnica**, no de herramientas.
Las herramientas solo refuerzan reglas claras.
Voy a plantearlo como un sistema operativo social-técnico, no como “tips sueltos”.

Voy por partes, de lo estructural a lo humano.

Primero:
principios base (esto define todo lo demás).

1. Nadie trabaja directo en `main`.
   Nunca.
1. Todo cambio deja rastro:
   issue → PR → merge.
1. El repositorio es la fuente de verdad, no el chat.
1. La fricción es deliberada, pero baja.
1. La calidad es responsabilidad colectiva, no del “lead”.

Si estas cinco cosas se cumplen, el resto fluye.

______________________________________________________________________

Segundo:
ramas y política de merge.

Modelo recomendado (simple y probado):

- `main`:
  siempre deployable.
- `dev` (opcional):
  solo si el equipo es grande; si no, se puede omitir.
- ramas por feature o fix:
  `feat/xxx`, `fix/xxx`, `chore/xxx`, `refactor/xxx`.

Reglas duras:

- `main` protegida:

  - PR obligatorio
  - al menos 1 review aprobada (2 si el cambio es grande)
  - CI pasando (tests, lint, build)

- Squash merge por defecto:

  - historia limpia
  - un commit = una intención

No “merge commits”, no “push directo porque es rápido”.

______________________________________________________________________

Tercero:
Issues (la columna vertebral).

Todo empieza con un issue.
Incluso tareas chicas.

Tipos claros:

- Bug
- Feature
- Refactor
- Tech debt
- Docs

Buenas prácticas:

- Un issue = un problema concreto

- Descripción corta + criterio de aceptación

- Labels claros:

  - `good first issue`
  - `help wanted`
  - `blocked`
  - `high impact`
  - `low priority`

Esto permite que:

- Nuevos contribuyentes sepan dónde entrar
- El proyecto no dependa de una sola persona

Importante:
Si algo se habla por WhatsApp, **se baja a un issue**.
El chat no es memoria.

______________________________________________________________________

Cuarto:
Pull Requests (el contrato social).

Un PR no es solo código, es una propuesta.

Plantilla mínima de PR:

- Qué cambia
- Por qué cambia
- Qué no cubre
- Cómo probarlo

Reglas implícitas:

- PRs pequeños > PRs enormes
- Si es difícil de reviewear, está mal dividido
- El autor revisa su propio PR antes de pedir review

Cultura de review:

- Se critica el código, no a la persona
- Se explica el “por qué”, no solo el “no”
- Si algo es subjetivo, se documenta el criterio

______________________________________________________________________

Quinto:
Milestones (ritmo, no presión).

Milestones no son fechas mágicas, son **objetivos agrupados**.

Uso recomendado:

- Milestones por versión o hito funcional

  - “v0.3 – Excel parsing estabilizado”
  - “v0.4 – UX rewrite”

- Issues asignados al milestone

- Si algo no llega, se mueve.
  No pasa nada.

Evitar:

- Milestones con 40 issues
- Milestones sin cierre real

Cerrar milestones da sensación de progreso real.
Eso mantiene motivación.

______________________________________________________________________

Sexto:
Roadmap (dirección, no promesa).

Un roadmap es:

- Qué queremos hacer
- En qué orden
- Con qué prioridad

No es:

- Una promesa
- Un contrato
- Un cronograma rígido

Formato simple:

- Now
- Next
- Later

Documento versionado en el repo.
Cambios al roadmap → PR.
Transparencia total.

______________________________________________________________________

Séptimo:
Projects / Boards (flujo, no burocracia).

Usar boards solo si:

- Ayudan a visualizar
- No duplican trabajo

Board simple:

- Backlog
- Ready
- In Progress
- Review
- Done

Cada issue vive en **un solo lugar**.
Nada de mantener lo mismo en cinco lados.

______________________________________________________________________

Octavo:
Calidad de código (sin matar el entusiasmo).

Reglas técnicas mínimas:

- Formatter automático
- Linter
- Tests básicos en CI
- Convenciones escritas (README o CONTRIBUTING)

Lo clave:

- Las reglas las impone el sistema, no una persona.
- El CI dice “no”, no el maintainer.

Eso evita conflictos personales.

______________________________________________________________________

Noveno:
CONTRIBUTING y expectativas.

Archivo `CONTRIBUTING.md` obligatorio con:

- Cómo clonar y correr el proyecto
- Cómo crear issues
- Cómo abrir PRs
- Qué se espera de una review
- Qué no se acepta

Esto:

- Reduce preguntas repetidas
- Da seguridad a nuevos
- Profesionaliza sin rigidez

______________________________________________________________________

Décimo:
Mantener al grupo entusiasmado sin perder seriedad.

Esto es lo más difícil.

Algunas claves reales:

- Celebrar merges, no solo features grandes
- Dar crédito visible (README, releases, changelog)
- Aceptar contribuciones pequeñas
- No sobre-optimizar demasiado temprano
- Explicar decisiones técnicas importantes (docs, issues)

Muy importante:

- El proyecto no puede depender del “héroe”.
- Si alguien se va, el proyecto sigue.

______________________________________________________________________

Resumen brutalmente honesto.

Un proyecto open source sano:

- Tiene reglas claras
- Tiene procesos simples
- Tiene memoria escrita
- Tiene fricción justa
- No depende del chat
- No depende de una persona

Si querés, en el próximo mensaje podemos:

- Definir una política concreta de merge para Poliplanner
- Escribir un `CONTRIBUTING.md` base
- Armar una estructura real de labels, milestones y boards
- O diseñar un “primer issue pack” para atraer gente nueva

Decime por dónde seguimos.
