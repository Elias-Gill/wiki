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

ejemplo de uso:



```zig
fn main() {
    // ... inicializacion 

    // Create a callback context (without passing `w`)
    const helloCallback = WebView.CallbackContext(hello).init(null);
    try window.bind("myFunction", &helloCallback);
}

// Callback function that modifies the webview
fn hello(name: [:0]const u8, args: [:0]const u8, _: ?*anyopaque) void {
    _ = name;
    std.debug.assert(window != null);

    // do something
    // NOTE: the args are passed this way as a LITERAL string like this ` ["arg1", "arg2"] `
    // Con [] y todo dentro de un string.
}
```
