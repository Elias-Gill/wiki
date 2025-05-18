# Spring boot

[Springboot.md](springboot.md)

# Especificaciones y servidores de aplicacion

### 📘 ¿Qué son las "especificaciones" en Java EE / Jakarta EE?

Las *especificaciones* son **conjuntos de reglas y APIs estandarizadas** que definen cómo debe
comportarse cierto componente o servicio dentro del mundo Java empresarial.

* **No son implementaciones**.
* Son **interfaces y contratos**.
* Luego, los servidores (GlassFish, WildFly, etc.) proveen una **implementación oficial** de
  esas interfaces.

Ejemplo:

```java
public interface EntityManager {
    void persist(Object entity);
    // ...
}
```

→ Esta es parte de **JPA**, una especificación.
El servidor te da una implementación real (por ejemplo, EclipseLink, Hibernate).

### 🧩 ¿Por qué hay tantas especificaciones?

Porque cada especificación cubre una **necesidad diferente** en aplicaciones empresariales:

| Especificación | ¿Para qué sirve?                                                                |
| -------------- | ------------------------------------------------------------------------------- |
| **JPA**        | Mapeo objeto-relacional, persistencia (como Hibernate).                         |
| **EJB**        | Componentes de negocio con transacciones, concurrencia, seguridad automática.   |
| **JTA**        | Manejo de transacciones distribuidas entre múltiples recursos (DBs, JMS, etc.). |
| **JMS**        | Envío/recepción de mensajes (colas, tópicos).                                   |
| **JAX-RS**     | Crear APIs RESTful fácilmente.                                                  |
| **JAX-WS**     | Crear servicios SOAP.                                                           |
| **Security**   | Control de acceso, autenticación, autorización.                                 |
| **CDI**        | Inyección de dependencias estándar.                                             |
| **Servlets**   | Manejadores HTTP básicos.                                                       |
| **JSF**        | Interfaces web (ahora poco usadas).                                             |

### 🛠️ ¿Y por qué un servidor de aplicaciones lo hace más fácil?

Porque al cumplir con todas las especificaciones **ya viene con todo preconfigurado**.
No tenés que instalar ni configurar cada herramienta manualmente.
Ejemplo:

#### Con un servidor como WildFly:

```java
@Stateless
public class OrderService {
    @PersistenceContext
        EntityManager em;

    public void processOrder(Order o) {
        em.persist(o); // JPA
                       // La transacción, el pool de conexiones, etc., ya están manejados
    }
}
```

→ No tenés que configurar Hibernate, ni transacciones, ni DataSource.
El servidor lo **inyecta automáticamente** porque entiende la especificación.

### 🧱 ¿Y cómo sería "hacerlo manualmente"?

En frameworks como Spring Boot:

* Tenés que incluir e inicializar todas las dependencias a mano (Hibernate, Jackson,
  RestTemplate, etc.).
* Configurar los DataSource, transacciones, seguridad, etc.
* Cada herramienta es independiente, y vos unís las piezas.

Ejemplo en Spring:

```java
@Configuration
@EnableTransactionManagement
public class AppConfig {
    @Bean
        public DataSource dataSource() { ... }

    @Bean
        public EntityManagerFactory entityManagerFactory() { ... }

    @Bean
        public PlatformTransactionManager transactionManager() { ... }
}
```

→ Vos controlás todo.
Más flexible, pero más trabajo.

### 🎯 ¿Qué ganás usando un servidor completo?

* Integración *out of the box* de todos los servicios (JPA, JMS, JTA, etc.).
* No necesitás aprender ni configurar cada herramienta por separado.
* Despliegues estandarizados:
  subís un `.war`, el servidor lo analiza y te inyecta todo lo necesario.
* Cumplís requisitos corporativos sin reinventar ruedas (transacciones distribuidas, roles,
  mensajería, etc.).

### 🧪 Resumen

| Enfoque              | Servidor de Aplicaciones           | "Manual" (como Spring Boot)         |
| -------------------- | ---------------------------------- | ----------------------------------- |
| Estándar corporativo | ✅                                 | ❌ (más flexible, pero no estándar) |
| Configuración        | Mínima (preconfigurado)            | Manual                              |
| Flexibilidad         | Limitada a lo que define la spec   | Total                               |
| Curva de aprendizaje | Menor para proyectos empresariales | Mayor, pero más control             |
| Tiempo de setup      | Rápido                             | Lento si no usás auto-config        |



# Applets, Servlets y demas "lets"

## 🖼️ **Applet** (hoy en día obsoleto)

* **Qué es**:
  Un **componente Java que se ejecuta dentro de un navegador web**, embebido en una página
  HTML.
* **Propósito original**:
  Correr interfaces gráficas (Swing/AWT) en la web antes de que existiera JavaScript moderno.
* **Cómo funcionaba**:
  El navegador descargaba el `.class` o `.jar` y lo ejecutaba en una JVM local (plugin de Java
  en el navegador).
* **Ejemplo de uso clásico**:
  Gráficos interactivos, visualizaciones, formularios avanzados en la era pre-JavaScript
  (90s–2000s).
* **Estado actual**:
  🪦 **Muerto**.
  Inseguro, eliminado de todos los navegadores modernos.

```java
public class MiApplet extends Applet {
    public void paint(Graphics g) {
        g.drawString("Hola desde un Applet", 20, 20);
    }
}
```

## 🌐 **Servlet**

* **Qué es**:
  Una **clase Java que maneja peticiones HTTP**.
  Es la base de cualquier aplicación web en Java.
* **Especificación**:
  Sí, parte de **Jakarta EE** (antes Java EE).
* **Responsabilidad**:
  Manejar `GET`, `POST`, sesiones, cookies, redirecciones, autenticación simple, etc.
* **Dónde vive**:
  Dentro de un **servidor web compatible con la especificación Servlet**, como Tomcat, Jetty,
  GlassFish.
* **Estado actual**:
  ✅ **Vigente**.
  Aunque hoy en día muchas veces se usan frameworks encima (Spring MVC, Jakarta REST, etc.),
  **los servlets siguen siendo la base**.

```java
@WebServlet("/hello")
public class HelloServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        res.getWriter().write("Hola desde un Servlet!");
    }
}
```

## 🧩 ¿Y qué pasa con los "lets"? ¿Qué significa ese sufijo?

El sufijo "`-let`" en Java no es formal, pero históricamente se usó para denotar **componentes
especializados que "se insertan" en un entorno mayor**, y que siguen cierto ciclo de vida
controlado por un *contenedor*.

### Comparación rápida:

| Componente  | Corre en...             | Propósito                             | ¿Sigue vigente? |
| ----------- | ----------------------- | ------------------------------------- | --------------- |
| **Applet**  | Navegador con JVM       | Interfaz gráfica embebida en web      | ❌              |
| **Servlet** | Servidor web Java       | Responder peticiones HTTP             | ✅              |
| **Portlet** | Portal Server (Liferay) | Componentes web modulares en portales | ⚠️ en desuso    |

### 🧠 Características comunes de los `*-let`:

* Son manejados por un *contenedor* (navegador, servidor web, portal).
* Tienen **ciclo de vida estándar**:
  inicialización, manejo de eventos/peticiones, destrucción.
* Interactúan con su entorno a través de APIs específicas.

## 🛠️ ¿Por qué son importantes los servlets hoy en día?

Porque:

* Son **la base técnica de todos los frameworks web en Java** (Spring MVC, Jakarta REST, JSF,
  Struts, etc.).
* Toda aplicación web en Java, cuando se ejecuta, en algún punto es una serie de **servlets
  bajo el capó**.
* Proveen lo esencial para que un servidor web pueda hablar en HTTP con navegadores.

## 🔚 En resumen

* **Applet**:
  UI en navegador (ya muerto).
* **Servlet**:
  Backend web que responde a HTTP (sigue siendo base de todo).
* **Otros `-let`**:
  Casos específicos, ya no muy comunes hoy.
