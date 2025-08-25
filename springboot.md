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

# Spring Security: Funcionamiento Interno y Configuración

Spring Security es un framework de seguridad potente y altamente personalizable para
aplicaciones Java.
Vamos a profundizar en su arquitectura interna y mecanismos de funcionamiento.

## TL;DR

Spring security se configura con el tag de `@Configuration`.
Dentro de esta configuracion se ponen los endpoints que estaran protegidos, cual es la pagina
de login y cual es el servicio de autenticacion (el que se encarga de buscar el usuario).

Los endpoints protegidos se piden autenticacion y las sesiones funcionan con cookies de spring
boot.
Para el encriptado de la contrasena se pasa dentro de la configuracion de Spring, cual es el
servicio de encriptado de contrasenas, despues spring se encarga del _DESENCRIPTADO_ de manera
automatica usando un `PasswordEncoder` el cual puede ser custom (el encriptado debe hacerse en
el servicio a parte para buscar usuarios)

Diagrama de flujo de Spring Security:
```txt
┌─────────────┐    ┌─────────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│             │    │                     │    │                  │    │                 │
│   Usuario   ├───>│  Formulario Login   ├───>│ Spring Security  ├───>│ UserDetailsSvc  │
│             │    │                     │    │                  │    │                 │
└─────────────┘    └──────────┬──────────┘    └────────┬─────────┘    └────────┬────────┘
                              │                        │                       │
                              │                        │                       │
┌─────────────┐    ┌──────────▼──────────┐    ┌────────▼─────────┐    ┌────────▼────────┐
│             │    │                     │    │                  │    │                 │
│   Cliente   │    │  Envía credentials  │    │ Verifica creds   │    │  Busca usuario  │
│  (Browser)  │<───┤                     │<───┤ con PasswordEnc  │<───┤   en BD/API     │
│             │    │                     │    │                  │    │                 │
└─────────────┘    └──────────┬──────────┘    └────────┬─────────┘    └─────────────────┘
                              │                        │
                              │                        │
                    ┌─────────▼────────┐      ┌────────▼─────────┐
                    │                  │      │                  │
                    │  Redirección a   │      │  Crea sesión y   │
                    │   página privada │      │    set-cookie    │
                    │                  │      │    JSESSIONID    │
                    └──────────────────┘      └──────────────────┘
```

## Arquitectura Principal

Spring Security se basa en una cadena de filtros (FilterChain) que se integra con el Servlet
Container.
La seguridad se aplica antes de que las solicitudes lleguen a tus controladores.

### Componentes Clave:

1. **SecurityFilterChain**:
   Cadena de filtros que procesa las solicitudes HTTP
2. **AuthenticationManager**:
   Coordina el proceso de autenticación
3. **ProviderManager**:
   Implementación principal de AuthenticationManager
4. **AuthenticationProvider**:
   Proporciona lógica específica de autenticación
5. **UserDetailsService**:
   Carga datos específicos del usuario
6. **PasswordEncoder**:
   Codifica y verifica contraseñas
7. **SecurityContext**:
   Mantiene la información de seguridad del hilo actual

## Flujo de Autenticación

1. **Filtrado inicial**:
   `DelegatingFilterProxy` delega en `FilterChainProxy` de Spring Security
2. **Selección de cadena**:
   `FilterChainProxy` selecciona el `SecurityFilterChain` apropiado
3. **Autenticación**:
- `UsernamePasswordAuthenticationFilter` intercepta solicitudes de login
- Crea un `Authentication` objeto no autenticado
- `ProviderManager` delega en los `AuthenticationProvider` adecuados
- `DaoAuthenticationProvider` (común) usa `UserDetailsService` y `PasswordEncoder`
4. **Resultado**:
- Si es exitoso, crea un `Authentication` autenticado
- Lo almacena en `SecurityContextHolder`
5. **Autorización**:
   Los filtros posteriores verifican los permisos

## Configuración Profunda

La configuración moderna se basa en `SecurityFilterChain` (desde Spring Security 5.7+).

### Ejemplo de Configuración Detallada:

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
        public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
            http
                // Configuración de autorización
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/public/**").permitAll()
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .anyRequest().authenticated()
                        )

                // Configuración de autenticación
                .formLogin(form -> form
                        .loginPage("/login")
                        .loginProcessingUrl("/auth")
                        .defaultSuccessUrl("/dashboard", true)
                        .failureHandler(authenticationFailureHandler())
                        )

                // Configuración de sesión
                .sessionManagement(session -> session
                        .maximumSessions(1)
                        .expiredUrl("/session-expired")
                        )

                // Configuración CSRF
                .csrf(csrf -> csrf
                        .ignoringRequestMatchers("/api/**")
                     )

                // Configuración de excepciones
                .exceptionHandling(exceptions -> exceptions
                        .accessDeniedHandler(accessDeniedHandler())
                        );

            return http.build();
        }

    @Bean
        public AuthenticationManager authenticationManager(
                UserDetailsService userDetailsService, 
                PasswordEncoder passwordEncoder) {

            DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
            provider.setUserDetailsService(userDetailsService);
            provider.setPasswordEncoder(passwordEncoder);

            return new ProviderManager(provider);
        }

    @Bean
        public UserDetailsService userDetailsService() {
            return username -> {
                // Lógica para cargar usuario desde BD u otra fuente
                UserDetails user = ...;
                if (user == null) {
                    throw new UsernameNotFoundException(username);
                }
                return user;
            };
        }

    @Bean
        public PasswordEncoder passwordEncoder() {
            return new BCryptPasswordEncoder();
        }
}
```

## Personalización Avanzada

### Autenticación Personalizada:

1. Implementa `AuthenticationProvider`:
```java
public class CustomAuthProvider implements AuthenticationProvider {
    @Override
        public Authentication authenticate(Authentication auth) {
            // Lógica de autenticación personalizada
            if (/* credenciales válidas */) {
                return new UsernamePasswordAuthenticationToken(
                        principal, credentials, authorities);
            }
            throw new BadCredentialsException("...");
        }

    @Override
        public boolean supports(Class<?> authentication) {
            return authentication.equals(UsernamePasswordAuthenticationToken.class);
        }
}
```

2. Registra el proveedor:
```java
@Bean
public AuthenticationManager authenticationManager(
        CustomAuthProvider customProvider) {
    return new ProviderManager(customProvider);
}
```

### Filtros Personalizados:

```java
public class CustomFilter extends OncePerRequestFilter {
    @Override
        protected void doFilterInternal(HttpServletRequest request, 
                HttpServletResponse response, FilterChain chain) {

            // Lógica previa al procesamiento
            if (isValid(request)) {
                chain.doFilter(request, response);
            } else {
                response.setStatus(HttpStatus.FORBIDDEN.value());
            }
            // Lógica posterior al procesamiento
        }
}

// En la configuración:
http.addFilterBefore(new CustomFilter(), BasicAuthenticationFilter.class);
```

## Manejo de Tokens (JWT)

Para autenticación stateless:

```java
public class JwtFilter extends OncePerRequestFilter {

    @Override
        protected void doFilterInternal(HttpServletRequest request,
                HttpServletResponse response, FilterChain chain) {

            String token = extractToken(request);
            if (token != null && validateToken(token)) {
                Authentication auth = createAuthentication(token);
                SecurityContextHolder.getContext().setAuthentication(auth);
            }
            chain.doFilter(request, response);
        }
}

// Configuración:
http.addFilterBefore(new JwtFilter(), UsernamePasswordAuthenticationFilter.class)
    .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS));
```

## Aspectos Internos Clave

1. **ThreadLocal SecurityContext**:
   La seguridad se mantiene por hilo usando `SecurityContextHolder`
2. **Delegación Estratégica**:
   `ProviderManager` delega en `AuthenticationProvider`s específicos
3. **Inmutabilidad**:
   Los objetos `Authentication` son inmutables después de la autenticación
4. **Jerarquía de Roles**:
   Los roles usan el prefijo `ROLE_` por convención
5. **Votación de Acceso**:
   Múltiples `AccessDecisionVoter`s deciden sobre la autorización

Spring Security es altamente configurable porque casi todos sus componentes son interfaces que
puedes implementar o reemplazar según tus necesidades específicas.

## Ejemplo basico de Spring Security

```java
package com.example.securingweb;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig {

    @Bean
        public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
            http
                .authorizeHttpRequests((requests) -> requests
                        .requestMatchers("/", "/home").permitAll()
                        .anyRequest().authenticated()
                        )
                .formLogin((form) -> form
                        .loginPage("/login")
                        .permitAll()
                        )
                .logout((logout) -> logout.permitAll());

            return http.build();
        }

    @Bean
        public UserDetailsService userDetailsService() {
            UserDetails user =
                User.withDefaultPasswordEncoder()
                .username("user")
                .password("password")
                .roles("USER")
                .build();

            return new InMemoryUserDetailsManager(user);
        }
}
```

# Inyeccion de dependencias de spring

## 1️⃣ Búsqueda de constructores

Cuando Spring necesita crear un bean:

* Escanea la clase para encontrar **constructores públicos** (y a veces protegidos si se
  permite).
* Identifica si alguno está anotado con `@Autowired`.

  * Si hay **exactamente uno** con `@Autowired`, usa ese, aunque haya otros disponibles.
* Si **ninguno** tiene `@Autowired`:

  * Si hay **un único constructor** (aunque tenga parámetros), lo usa.
  * Si hay **más de uno**, Spring intenta elegir uno cuyos parámetros pueda resolver **sin
    ambigüedad**.

    * Si encuentra más de uno posible → lanza error (`NoUniqueBeanDefinitionException`).

### 2️⃣ Cómo resuelve los parámetros

Para cada parámetro del constructor:

* Busca un bean del mismo **tipo** en el contexto de Spring.
* Si hay **exactamente uno**, lo inyecta.
* Si hay varios candidatos:

  * Usa `@Qualifier` o el nombre del parámetro para decidir.
  * Si sigue sin poder decidir → error.
* Si no hay ningún bean compatible → error (`NoSuchBeanDefinitionException`).

### 3️⃣ Reglas especiales

* Si hay **constructor sin parámetros** y otro con parámetros, Spring normalmente prefiere el
  **con parámetros** si puede satisfacerlo.
* `@Autowired(required = false)` permite que el constructor se use incluso si faltan beans
  (pero no es muy común en constructores).
* La elección de constructor ocurre **en tiempo de creación del bean**, no en tiempo de
  compilación.

**Resumido en una frase:** Spring intenta usar el constructor más “rico” (con más dependencias)
que pueda completar con los beans disponibles, prefiriendo uno marcado con `@Autowired`, y si
no hay ninguno claro, lanza error.
