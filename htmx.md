con htmx podes hacer lo que sigue. Donde name define el nombre de la query param que se manda
como parte del get en htmx. Todos los valores del input van a ser mandados si es que estuviese
definido en el form. Target es el componente que tiene que renderizar el valor de retorno.

```html
<form>
    <input
    type="text"
    id="myInput"
    hx-get="/filter"
    name="valor"
    hx-trigger="keyup change delay:100ms"
    hx-target="#filteredItems"
/>
</form>
```
