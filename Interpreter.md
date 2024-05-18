# TODO's
- [x] Solucionar la lectura de archivos para la evaluacion
- [ ] Solucionar el problema de parsear llamadas a funciones sin argumentos

# "Making an interpreter in Go" de Thorsten Ball
Un interprete cuenta con 3 partes escenciales: el lexer (tokenizer), el parser y el interprete.

## Lexer
Posiblemente la parte mas sencilla (pero no menos hermosa) de nuestro interprete.

El lexer genera tokens genericos a partir de un input de palabras. Este input de palabras es dividido en "tokens", los cuales no son mas que expresiones mas 
sencillas que tienen "valor" por si mismas. Un ejemplo vale mas que mil palabras:
```txt
"var input = 123 + 4;" => 
["var" VAR]
["input" IDENT]
["=" ASIGN]
["123" INTEGER]
["+" PLUS]
["4" INTEGER]
[";" SEMICOLON]
["" EOF]
```
Esto se puede realizar facilmente poniendo los identificadores en un loop hasta EOF con un switch, 
donde primero se descartan todas las palabras clave y caracteres especiales u operadores, y como default se generan identificadores
(si dentro de ellos se encuentran caracteres que no validos, se retorna un token _ILLEGAL_).

Es menester contar con una funcion "consumir espacios" para evitar problemas con espacios multiples o saltos de linea 
(esto obviamente varia con la sintaxis que quiera ser implementada para el lenguaje).

## Vaughan Pratt parser ("top to down precedence parser")

El algoritmo funciona de la siguiente manera:

El programa principal se encarga de ir iterando sobre todos los tokens hasta encontrar el token de EOF. Por cada token encontrado, el 
programa principal llama a una funcion "parse statement" el cual decide como parsear un "statement" ("declaracion" para los compas).

Una _sentencia_ (statement) es un conjunto de instrucciones (compuestas por expresiones) que no producen un resultado explícito. 
Por ejemplo (al menos en lenguajes C like): Declaraciones de variables, declaraciones de funciones, 
retornos y declaraciones en bloque (como la consecuencia de un if). 

Una _expresión_ (expression) es un conjunto de instrucciones que producen un resultado.
Las expresiones, mas bien, todo los que no sean "statements", son delegadas a otra funcione llamada "parse expression", 
la cual recibe la precedencia de la expresion anterior como parte de su argumento.

> Statements shouldn't return a value. 
> Obviously, a program is composed by statements and expressions

El Pratt parser se fundamenta en que el parser de un token puede estar asociado a como maximo dos funciones principales. Funciones _infijas_ (infixFn) y _prefijas_(prefixFn).

Los prefijos son operadores de tipo unario, es decir, actuan solo con el valor o expresion que les sucede. Ejemplos: `-X` o `!X`, donde - y ! son operadores prefijos.
Las funciones de parseo prefijo se utilizan para todas las declaraciones, tokens agrupadores y expresiones literales. Estas no reciben expresiones como argumento.

Los infijos son operadores de tipo binario, es decir, que cuentan con una expresion "izquierda" y otra "derecha". Ejemplos obvios son los operadores matematicos.
Estos operadores van asociados con su respectiva funcion de parseo infijo, la cual _toma la expresion anterior_ como su parte izquierda y continua recursivamente 
parseando a su derecha. Por tanto las funciones infijas reciben como argumento la parte "izquierda" de la expresion (la cual es parseada por el prefijo)

### Precedencia

La precedencia es el factor clave de la validez del Pratt parser. La precedencia se pasa a la funcion de "parsear expresion" 
(por defecto en la primera iteracion es LOWEST, la encargada de cambiar dicha precedencia en la funcion infija que llama recursivamente a "parsear expresion").

Esta precedencia determina cuales operadores van a ser parseados primero. En el caso de nuestro interprete la tabla de precedencia es:

```go
const(
    LOWEST    // precedencia por defecto
    EQUALS    // ==
    GREATLESS // < >
    SUM       // + -
    PROD      // * /
    PREFIX    // -X  !X
    CALL      // foo(bar)
)
```
