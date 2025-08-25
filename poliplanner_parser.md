# API

- El parser lo unico que debe poder hacer es tomar un excel y parsearlo.
- Los datos que se mueven son SubjectsDTO
- Otra tipo de manipulacion de datos no es necesaria.

El parser va a contar con una sola funcion publica expuesta:

```java
public Map<String, List<SubjectsDTO>> parseExcel(Path file) { }
```

El Service va a contar con la siguiente interface: 
```java
public void parseAndPersistExcel(Path excel) {}
public boolean autonomousExcelSync() {}
```

Dejemos al Mapper que se encargue de hacer las transformaciones de fechas, limpieza y demas.

### Flujo de ejecucion

```text
    +----------+  SubjectsDTO   +---------+                 +-----------------+
    |  Parser  | -------------> | Mapper  | -- limpiar -->  | Subject (model) |
    +----------+                +---------+                 +-----------------+
      ^
      |          source
      +----------provee---------+
                                |
+----------+   source    +---------+
| Scrapper | --return--> | Service |
+----------+             +---------+
  ^                             |
  |                             |
  +-----------request-----------+
```

El web scrapper solo debe contar con la interfaz:
```java
public ExcelDownloadSource findLatestDownloadSource() throws IOException {
```
