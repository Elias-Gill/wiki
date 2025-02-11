Para anadir funciones de zig a webview, puedo usar lo siguiente:

```zig
webview.bind(name: string, ctx: *const CallbackContext) WebViewError!void)
```

Donde `CallbackContext` es un struct que recibe como parametro para inicializar una funcion que
recibe como parametro `any` y retorna `any` (`fn (anytype) anytype`).

Para llamar a la funcion callback nativa, se utiliza el objeto window desde javascript:

```js
function buttonPressed() {
    window.<name>.<callback>()
}
```
