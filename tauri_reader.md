# Dependencias

### Rust
- [tauri](https://tauri.app/)
- [svelte](https://svelte.dev/)
- [markdown parser](https://github.com/kivikakk/comrak)
- [syntax highlighter](https://github.com/trishume/syntect)
 
### Javascript
- [higlight.js](https://highlightjs.org/)
- [file-type icons](https://www.npmjs.com/package/file-icons-js)

# Testing
- [Mocks tauri](https://tauri.app/v1/guides/testing/mocking)

# Modelo del proyecto

## Funcionalidades

#### El lector markdown

- Debe soportar syntax highlighting para bloques de codigo y un boton de copiar para los bloques de codigo.
- LIVE RELOAD cuando el archivo actual se modifica.
- Debe poder navegar entre notas y abrir links de internet.
- La posibilidad de abrir un archivo individual con el explorardor de archivos.
- Navegacion simple con comandos de Vim.
- Un buscador de palabras

#### Arbol de archivos

- Un arbol donde se pueden ver los archivos de la carpeta.
- La posibilidad de abrir una carpeta con el explorardor de archivos.
- Navegacion simple con comandos de Vim.
- Atajos para abrir y cerrar el arbol.
- Un buscador de palabras


# Estructura

## Lector markdown 

### Rust

Debo exponer mediante tauri una api que tenga las siguientes funcionalidades:
- _openFile(file)_: Abrir un archivo markdown, el cual retornar el contenido parseado a html y _los paths_ bien configurados para ser clicados.
- _fileHasChanged()_: retornar true o false si el contenido del archivo abierto ha cambiado o no.

### Svelte

## Arbol de archivos

- _changePath(path)_: cambiar la carpeta de la aplicacion.
- _listFiles()_: listar los archivos de la carpeta actual de la aplicacion
