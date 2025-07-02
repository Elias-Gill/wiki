## 🧩 1. **Atributo central**

Todos los atributos de Thymeleaf comienzan con `th:` y reemplazan o complementan el HTML
estático.

## 📝 2. **Expresiones**

Thymeleaf soporta distintas expresiones, similares a SpEL:

| Tipo de expresión | Ejemplo                         | Uso común                        |
| ----------------- | ------------------------------- | -------------------------------- |
| Variable          | `${user.name}`                  | Obtener propiedades de un objeto |
| Selección         | `*{name}`                       | Dentro de `th:object`            |
| Mensaje i18n      | `#{welcome.message}`            | Archivos `messages.properties`   |
| URL               | `@{/login}`                     | Generación de URLs               |
| Literales         | `'Hello'`, `42`, `true`         | Literales                        |
| Operadores        | `+`, `-`, `!`, `==`, `?:`, etc. | Lógica condicional               |
| Acceso seguro     | `${user?.name}`                 | Null-safe (`Elvis`)              |

## 🔗 3. **Atributos principales de Thymeleaf**

| Atributo  | Descripción                                                  |
| --------- | ------------------------------------------------------------ |
| `th:text` | Reemplaza el contenido del elemento con texto HTML escapado. |

```html
<span th:text="${user.name}"></span>
```

>| `th:utext`      | Igual que `th:text`, pero sin escape (renderiza HTML).
>| `th:value`      | Establece el valor de un input, textarea, etc.
>| `th:href`       | Establece el `href` de un enlace.
>| `th:src`        | Establece el `src` de una imagen.
>| `th:each`       | Bucle `for`.

```html
<tr th:each="user : ${users}">...</tr>
```

>| `th:if` / `th:unless` | Condicionales.

```html
<div th:if="${user.admin}">Es admin</div>
```

>| `th:switch`, `th:case` | Switch case estilo Java.\| `th:classappend` | Agrega clases condicionalmente.

```html
<div th:classappend="${user.active} ? 'active' : 'inactive'"></div>
```

>| `th:attr` | Modifica varios atributos al mismo tiempo.

```html
<img th:attr="src=${user.avatar}, title=${user.name}" />
```

>| `th:object` | Define el objeto base para formularios (`*{}` se refiere a él).

```html
<form th:object="${user}" th:action="@{/save}" method="post">
<input th:field="*{name}" />
</form>
```

>| `th:field` | Bindea automáticamente el valor, el `id`, `name`, etc.

## 📄 4. **Formularios**

```html
<form th:action="@{/signup}" th:object="${user}" method="post">
<input type="text" th:field="*{username}" />
<div th:if="${#fields.hasErrors('username')}" th:errors="*{username}">Error</div>
<input type="submit" value="Enviar" />
</form>
```

## 🗂️ 5. **Fragmentos y layouts**

Permite reutilizar secciones HTML como componentes o layouts.

**Definir un fragmento:**

```html
<!-- fragments/header.html -->
<div th:fragment="header(title)">
<h1 th:text="${title}">Título</h1>
</div>
```

**Incluir un fragmento:**

```html
<div th:replace="fragments/header :: header('Bienvenido')"></div>
```

## 📚 6. **Internacionalización**

Archivos `messages.properties`:

```properties
welcome.message=Bienvenido, {0}!
```

HTML:

```html
<p th:text="#{welcome.message(${user.name})}"></p>
```

## 📎 7. **Utilidades útiles (`#` objetos de utilidad)**

| Utilidad   | Descripción                      |
| ---------- | -------------------------------- |
| `#dates`   | Formato de fechas                |
| `#numbers` | Formato de números               |
| `#strings` | Manipulación de strings          |
| `#lists`   | Operaciones sobre listas         |
| `#maps`    | Operaciones sobre mapas          |
| `#fields`  | Manejo de errores en formularios |
| `#ids`     | Generación de IDs únicos         |

Ejemplo:

```html
<p th:text="${#dates.format(user.birthDate, 'dd/MM/yyyy')}"></p>
```

## ⚠️ 8. **Errores comunes (como el tuyo)**

**Error**:

> `Could not bind form errors using expression "*"`

**Solución**:
asegúrate de tener un `th:object` dentro del `<form>`, por ejemplo:

```html
<form th:action="@{/signup}" th:object="${userForm}" method="post">
<!-- Aquí se puede usar *{...} sin problema -->
</form>
```
