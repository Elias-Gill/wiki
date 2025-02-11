En Spring Boot, los beans son objetos gestionados por el contenedor de Spring.
El contenedor de Spring es responsable de crear, configurar y gestionar el ciclo de vida de
estos objetos.

Un bean es simplemente un objeto que es gestionado por el contenedor de Spring.
Spring maneja la creación de los beans, sus dependencias (inyección de dependencias) y su
ciclo de vida (inicio y destrucción).

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
