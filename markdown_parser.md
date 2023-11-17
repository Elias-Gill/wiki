# Estructura basica del proyecto

```
- parser/
    - lexer/
        - tokenizer.js   // Tokenizer implementation
    - parser/
        - parser.js      // Parser implementation
    - renderer/
        - renderer.js    // Renderer implementation
- test/
    - lexer/
        - tokenizer.test.js   // Unit tests for the tokenizer
    - parser/
        - parser.test.js      // Unit tests for the parser
    - renderer/
        - renderer.test.js    // Unit tests for the renderer
- examples/
    - example.md      // Example markdown file
    - example.js      // Example usage of the tokenizer, parser, and renderer
- README.md         // Project documentation
- package.json      // Project dependencies and scripts
```

# Pasos para parsear markdown

- \[-\] Construir un _lexer_ que se encarge de generar una lista de tokens desde un archivo markdown

  - \[-\] Definir tokens

    - \[X\] Titulo 1
    - \[X\] Titulo 2
    - \[X\] Titulo 3
    - \[X\] Titulo 4
    - \[X\] Titulo 5
    - \[X\] Titulo 6
    - \[X\] Italics (\_ o \*)
    - \[X\] Inline code (\`)
    - \[X\] Bold (doble \*)
    - \[ \] Separador (triple \*)
    - \[X\] Elemento de lista (-, +, \*)
    - \[X\] Parrafo (doble salto de linea)
    - \[X\] Bloques de codigo (triple \`)

  - \[ \] Escribir las reglas para cada token (con regexes)

    - \[ \] Titulo 1
    - \[ \] Titulo 2
    - \[ \] Titulo 3
    - \[ \] Titulo 4
    - \[ \] Titulo 5
    - \[ \] Titulo 6
    - \[ \] Italics (\_ o \*)
    - \[ \] Inline code (\`)
    - \[ \] Bold (doble \*)
    - \[ \] Separador (triple \*)
    - \[ \] Elemento de lista (-, +, \*)
    - \[ \] Parrafo (doble salto de linea)
    - \[ \] Bloques de codigo (triple \`)

- \[ \] Implementar un _parser_ que se encargue de crear el arbol de sintaxis a partir de la lista suelta de tokens del lexer

  - _TODO_

- \[ \] Crear un _renderer_ que trasncriba el arbol de sintaxis en html (en este caso) o en otros formatos si es necesario.

  - _TODO_

# NOTES

## Notas personales

### Nota personal 1, no se

aca poner mis notas

## Guias y libros

- [Marked.js](https://github.com/markedjs/marked/blob/master/src/Tokenizer.ts#L70) - [Blog post about marked.js](https://yiou.me/blog/posts/how-does-markdown-parser-work)
- [Video sobre interpretes](https://www.youtube.com/watch?v=LCslqgM48D4)
- [El libro del dragon](libros/Compilers_Principles.pdf)
- [Crafting interpreters](libros/crafting-interpreters.pdf)
- [Pragmaticas de Lenguages de programacion](libros/PL_Pragmatics.pdf)

### Anotaciones de los libros

- `Simbolos Terminales`: Los símbolos terminales representan las unidades básicas de un lenguaje de programación, como palabras clave, identificadores, operadores y constantes. Estos símbolos no pueden ser descompuestos en partes más pequeñas dentro de la gramática. Por ejemplo, en el lenguaje de programación C, los símbolos terminales pueden ser "if", "for", "+", "-", etc.

- `Simbolos No terminales`: Los símbolos no terminales representan las reglas de producción que definen la estructura y la sintaxis del lenguaje. Estos símbolos pueden ser descompuestos en otros símbolos, ya sean terminales o no terminales. Por ejemplo, en el lenguaje de programación C, los símbolos no terminales pueden ser "sentencia", "expresión", "declaración", etc. Estos símbolos no terminales se utilizan para construir la estructura del programa y definir cómo se deben combinar los símbolos terminales.

_Parse Tree_

> Formally, given a context-free grammar, a parse tree according to the gram­
> mar is a tree with the following properties:
>
> 1. The root is labeled by the start symbol.
> 1. Each leaf is labeled by a terminal or by E.
> 1. Each interior node is labeled by a nonterminal.

Info especial de Regexes en _JS_:

```
The regular expression pattern \\b(${blacklist.join("|")})\\b is composed of several elements:

\\b: This is a word boundary anchor. It matches a position between a word character (as defined by \w) and 
a non-word character (as defined by \W), or vice versa. Word characters include letters, digits, and underscores.

${blacklist.join("|")}: This is a placeholder that appears to be part of a larger code snippet. 
It suggests that the pattern will be dynamically generated based on the contents of a blacklist array. 
The join("|") method joins the elements of the blacklist array with the | symbol as the separator.

\\b: Another word boundary anchor, similar to the first one. 
```
