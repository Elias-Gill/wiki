En Spring Boot, los beans son objetos gestionados por el contenedor de Spring.
El contenedor de Spring es responsable de crear, configurar y gestionar el ciclo de vida de
estos objetos.

Un bean es simplemente un objeto que es gestionado por el contenedor de Spring.
Spring maneja la creación de los beans, sus dependencias (inyección de dependencias) y su ciclo
de vida (inicio y destrucción).

Cuando defines un bean, Spring utiliza el nombre de la clase por defecto (en minúsculas) como
el nombre del bean.
Si tienes dos clases con el mismo nombre de bean, Spring no sabrá cuál usar y generará un
conflicto.
Para solucionar esto le puedes pasar un nombre personalizado al bean

**¿Cómo Spring sabe qué objetos son beans?**:
Spring identifica los beans utilizando anotaciones como:
- @Component:
  Una clase genérica que puede ser cualquier componente de Spring.
- @Service:
  Se utiliza para marcar clases de servicio.
- @Repository:
  Similar a @Service, pero más orientado a las clases que interactúan con la base de datos.
- @Controller:
  Se usa para marcar clases que sirven como controladores en una aplicación web, como un MVC
  (Modelo-Vista-Controlador).

# Gotchas

Si retornas un string en un endpoint, realmente lo que estas retornando es retornando el path a
un recurso estatico o plantilla.

Para realizar el binding al body de la respuesta debes usar la anotacion `@RequestBody`

### Reference Documentation
For further reference, please consider the following sections:

* [Official Apache Maven documentation](https://maven.apache.org/guides/index.html)
* [Spring Boot Maven Plugin Reference Guide](https://docs.spring.io/spring-boot/3.4.1/maven-plugin)
* [Create an OCI image](https://docs.spring.io/spring-boot/3.4.1/maven-plugin/build-image.html)
* [WebSocket](https://docs.spring.io/spring-boot/3.4.1/reference/messaging/websockets.html)

### Guides
The following guides illustrate how to use some features concretely:

* [Using WebSocket to build an interactive web application](https://spring.io/guides/gs/messaging-stomp-websocket/)

### Maven Parent overrides

Due to Maven's design, elements are inherited from the parent POM to the project POM.
While most of the inheritance is fine, it also inherits unwanted elements like `<license>` and
`<developers>` from the parent.
To prevent this, the project POM contains empty overrides for these elements.
If you manually switch to a different parent and actually want the inheritance, you need to
remove those overrides.
