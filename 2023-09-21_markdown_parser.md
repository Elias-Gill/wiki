# GUIDES

- https://yiou.me/blog/posts/how-does-markdown-parser-work
- https://www.youtube.com/watch?v=LCslqgM48D4
- [El libro del dragon](libros/Compilers_Principles.pdf)
- [Crafting interpreters](libros/crafting-interpreters.pdf)
- [Pragmaticas de Lenguages de programacion](libros/PL_Pragmatics.pdf)

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

- [ ] Construir un _lexer_ que se encarge de generar una lista de tokens desde un archivo markdown
    - [ ] Definir tokens
        - [ ] Titulo 1
        - [ ] Titulo 2
        - [ ] Titulo 3
        - [ ] Titulo 4
        - [ ] Titulo 5
        - [ ] Titulo 6
        - [ ] Italics (_ o *)
        - [ ] Inline code (`)
        - [ ] Bold (doble *)
        - [ ] Separador (triple *)
        - [ ] Elemento de lista (-, +, *)
        - [ ] Parrafo (doble salto de linea)
        - [ ] Bloques de codigo (triple `)

    - [ ] Escribir las reglas para cada token (con regexes)
        - [ ] Titulo 1
        - [ ] Titulo 2
        - [ ] Titulo 3
        - [ ] Titulo 4
        - [ ] Titulo 5
        - [ ] Titulo 6
        - [ ] Italics (_ o *)
        - [ ] Inline code (`)
        - [ ] Bold (doble *)
        - [ ] Separador (triple *)
        - [ ] Elemento de lista (-, +, *)
        - [ ] Parrafo (doble salto de linea)
        - [ ] Bloques de codigo (triple `)

- [ ] Implementar un _parser_ que se encargue de crear el arbol de sintaxis a partir de la lista suelta de tokens del lexer
    - *TODO*

- [ ] Crear un _renderer_ que trasncriba el arbol de sintaxis en html (en este caso) o en otros formatos si es necesario.
    - *TODO*
