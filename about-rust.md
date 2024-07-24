Para los retornos de tipo Result<tipo,error> se utilizan la sentencia match con Ok y Err

```rust
fn get_user_home() -> String {
    // home_dir retorna un Result<bufpath, string>
    match home_dir() {
        Ok(path) => format!("Hello, {}! You've been greeted from Rust!", path.display()),
        Err(err) => format!("No se pudo traer el archivo: {}", err),
    }
}
```

Para los retornos de tipo Option<t> se utilizan la sentencia match con Some y None

```rust
fn get_user_home() -> String {
    // home_dir retorna un Option<bufpath>
    match home_dir() {
        Some(path) => format!("Hello, {}! You've been greeted from Rust!", path.display()),
        None => format!("No se pudo traer"),
    }
}
```
