## 1. Qué es Flyway y por qué usarlo

Flyway es una herramienta de migración de bases de datos que permite versionar y aplicar
cambios estructurales a tu base de datos mediante scripts controlados.
Su objetivo es asegurar que todos los entornos (desarrollo, staging, producción) mantengan el
mismo esquema de base de datos, evitando errores por diferencias estructurales.

Se integra directamente con Spring Boot y se ejecuta automáticamente en el arranque de la
aplicación.
A diferencia de enfoques automáticos como `ddl-auto=update`, Flyway proporciona trazabilidad,
control de versiones y seguridad en entornos productivos.

## 2. Principios de funcionamiento

Flyway basa su funcionamiento en el concepto de versiones aplicadas de manera incremental.
Cada archivo de migración tiene una versión única y una descripción, y se aplica una sola vez
en orden secuencial.
Las migraciones quedan registradas en una tabla interna (`flyway_schema_history`), que permite
rastrear qué scripts se han ejecutado y detectar posibles conflictos o corrupciones en el
historial.

El motor evalúa los scripts ubicados en una carpeta predefinida (`db/migration`) dentro del
classpath.
Al iniciar la aplicación, compara las migraciones disponibles con las ya ejecutadas y aplica
las nuevas en orden.

## 3. Configuración general

Para habilitar Flyway en un proyecto Spring Boot, basta con agregar la dependencia
`flyway-core`.
Spring Boot lo detecta automáticamente.
No es necesario activarlo manualmente a menos que quieras deshabilitarlo en algunos perfiles.
La configuración se realiza vía `application.yml` o `application.properties`, y permite definir
la ubicación de los scripts, el esquema por defecto, y opciones como limpieza, baseline y
validación.

Una configuración típica puede incluir la ruta a los scripts (`locations`), el esquema a
utilizar (`schemas`), y el comportamiento cuando ya existe una base no vacía
(`baseline-on-migrate=true`).
También puedes activar validaciones para evitar inconsistencias entre scripts y base.

## 4. Organización de los scripts

Los scripts SQL deben tener nombres versionados siguiendo una convención estricta:
`V1__descripcion.sql`, `V2__otra_migracion.sql`.
La parte de versión debe ser única, incremental, y la descripción debe ir separada por doble
guión bajo.
Esta estructura garantiza orden y legibilidad.

Se recomienda mantener todos los scripts en un único directorio fuente para evitar
divergencias.
Los scripts deben estar en SQL plano, pero Flyway también admite migraciones Java si se
requiere lógica condicional avanzada (no común en la mayoría de los proyectos).

## 5. Integración con JPA

Cuando se usa Flyway junto con JPA (Hibernate), es importante evitar la colisión entre los
cambios estructurales realizados manualmente vía Flyway y la generación automática de esquemas.
Por eso, en entornos productivos se recomienda desactivar la generación automática
(`ddl-auto=none`) y usar Flyway como única fuente de verdad para el esquema.

Flyway puede convivir con JPA siempre que las migraciones reflejen fielmente los modelos
definidos en el código.
El ciclo normal de trabajo es:
modificar entidades → crear script Flyway correspondiente → ejecutar aplicación → verificar
consistencia entre entidades y base.

## 6. Ciclo de trabajo en desarrollo

El flujo típico consiste en definir primero los cambios estructurales necesarios (nuevas
tablas, columnas, constraints), luego escribir los scripts de migración en SQL y versionarlos.
Estos scripts son aplicados automáticamente al ejecutar la aplicación en local o en CI/CD.
En producción, se recomienda que las migraciones sean revisadas, auditadas y probadas antes del
despliegue.

Flyway admite migraciones repetibles (`R__nombre.sql`), útiles para procedimientos o funciones
que pueden redeclararse.
También permite migraciones condicionales en Java si fuera necesario, pero en la mayoría de los
casos no se requieren.

## 7. Integración en despliegue

Flyway se ejecuta automáticamente al arrancar el contexto de Spring Boot, lo que permite
integrarlo sin herramientas externas.
En entornos más complejos, se puede separar la ejecución de migraciones del arranque de la
aplicación, por ejemplo, ejecutando Flyway desde CLI, scripts de CI/CD, o integrándolo como
paso separado en pipelines.

También es posible aplicar migraciones en entornos intermedios (testing, staging) y validar que
la aplicación arranque correctamente antes de permitir el despliegue en producción.

## 8. Consideraciones de seguridad y control
 
Flyway proporciona validación automática de checksums de los scripts ya aplicados.
Si un script versionado es modificado después de haberse ejecutado, Flyway detendrá el
arranque, lo cual previene alteraciones inadvertidas.
Para resolver estos casos, se debe regenerar el script con una nueva versión o usar la opción
de reparación (`flyway.repair`).

Para garantizar seguridad en entornos de producción, se recomienda usar una cuenta de base de
datos con permisos restringidos solo a las operaciones necesarias, y mantener los scripts bajo
control de versiones con revisiones de cambios.
