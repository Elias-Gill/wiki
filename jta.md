## 🧠 ¿Qué es JTA?

**JTA** significa **Java Transaction API**, y es una **API estándar de Jakarta EE (antes Java
EE)** que permite a las aplicaciones Java realizar operaciones **transaccionales**, es decir,
operaciones que deben completarse **totalmente o no realizarse en absoluto**.

## 🧩 ¿Para qué sirve JTA?

JTA sirve para:

1. **Gestionar transacciones distribuidas** entre múltiples recursos (bases de datos, colas
   JMS, etc.).
2. Permitir que un contenedor de aplicaciones (como **WildFly** o **JBoss**) **administre
   automáticamente** el ciclo de vida de las transacciones.
3. Evitar que tengas que hacer manualmente cosas como `conn.commit()` o `conn.rollback()` en
   JDBC.

En pocas palabras:

> Te permite agrupar varias operaciones en una sola transacción, y que el servidor de aplicaciones se encargue de controlarla.

## 🧪 Ejemplo típico de uso

Cuando usás `@Transactional` en un EJB o CDI bean:

```kotlin
@Stateless
class FacturaService {

    @PersistenceContext
        lateinit var em: EntityManager

        fun crearFactura(f: Factura) {
            em.persist(f)
                // si ocurre una excepción, JTA hará rollback automático
        }
}
```

Detrás de escena, WildFly (o JBoss) usa **JTA** para iniciar una transacción antes de
`crearFactura()` y terminarla al final.

## ⚙️ ¿Cómo se configura JTA?

### 1. En `persistence.xml`

Aquí declarás que usás **JTA** y no una transacción manual (RESOURCE\_LOCAL):

```xml
<persistence-unit name="MiUnidad" transaction-type="JTA">
<jta-data-source>java:/MyDS</jta-data-source>
</persistence-unit>
```

* `transaction-type="JTA"` → le indica al contenedor que administre la transacción.
* `jta-data-source` → usás un **DataSource gestionado por el servidor**.
* **Alternativa:** `transaction-type="RESOURCE_LOCAL"` te obliga a manejar transacciones tú
  mismo (`em.getTransaction().begin()` / `commit()` / `rollback()`).

### 2. En WildFly o JBoss

#### ✔️ ¿Qué necesitas?

* **Un DataSource JTA** configurado.
* Usualmente bajo JNDI, como `java:/MyDS`.
* Este DataSource debe tener el flag `jta=true`.

#### 📍 Ejemplo de DataSource en la CLI:

```cli
/subsystem=datasources/data-source=MyDS:add(
        jndi-name=java:/MyDS,
        driver-name=h2,
        connection-url=jdbc:h2:mem:test;DB_CLOSE_DELAY=-1,
        jta=true,
        use-java-context=true,
        enabled=true
        )
```

El parámetro `jta=true` indica que el DataSource **participa en transacciones JTA**, es decir,
que el contenedor lo puede manejar.

## 🔍 Diferencias entre JTA y RESOURCE\_LOCAL

| Característica                     | JTA                               | RESOURCE\_LOCAL       |
| ---------------------------------- | --------------------------------- | --------------------- |
| Gestión de transacciones           | Contenedor (WildFly, JBoss)       | Manual (en código)    |
| Uso típico                         | EJB, CDI, aplicaciones Jakarta EE | Aplicaciones Java SE  |
| Integración con múltiples recursos | Sí                                | No                    |
| DataSource requerido               | `jta-data-source`                 | `non-jta-data-source` |

## 💡 ¿Cuándo usar JTA?

* Siempre que estés desplegando en **WildFly, JBoss, GlassFish, Payara**, etc.
* Cuando usás **EJBs**, **CDI con @Transactional**, o **JPA gestionado**.
* Cuando necesitás **simplicidad y seguridad transaccional automática**.

## 📦 En resumen

| Concepto               | Significado / Función                                                                |
| ---------------------- | ------------------------------------------------------------------------------------ |
| **JTA**                | API para manejar transacciones distribuidas y delegarlas al servidor de aplicaciones |
| **JTA DataSource**     | Un DataSource registrado en WildFly que puede ser controlado por JTA                 |
| **transaction-type**   | Declarado en `persistence.xml`: `JTA` (contenerizado) o `RESOURCE_LOCAL` (manual)    |
| **Dónde se configura** | En `persistence.xml` y en la consola o CLI de WildFly                                |

# GlassFish

> ⚠️ En GlassFish, el JNDI típico de un DataSource comienza con jdbc/.

### Opción A: Usando la consola web (admin GUI)

Ir a http://localhost:4848, Menú lateral → Resources → JDBC → JDBC Connection Pools

Crear un nuevo connection pool:
- Name:
  miDSPool
- Resource Type:
  jakarta.sql.DataSource
- Database Vendor:
  seleccioná tu base de datos (ej.Derby, MySQL, PostgreSQL...)
- Avanzado:
  asegurate de que Non-Transactional esté desmarcado (por defecto lo está)

Crear el JDBC Resource, Ir a JDBC Resources:
- Name:
  jdbc/miDS
- Pool Name:
  miDSPool

Ahora jdbc/miDS es un datasource gestionado por JTA.

### Opción B: Usando la línea de comandos (asadmin)

```bash
asadmin create-jdbc-connection-pool \ --datasourceclassname=com.mysql.cj.jdbc.MysqlDataSource 
                                    \ --restype=javax.sql.DataSource 
                                    \ --property user=root:password=admin:DatabaseName=midb:ServerName=localhost:port=3306 
                                    \ miDSPool

asadmin create-jdbc-resource --connectionpoolid miDSPool jdbc/miDS
```
