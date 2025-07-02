# Desarrollo movil Android

**NOTA**:
[documentacion oficial](https://developer.android.com/topic/architecture/intro)

## The R class

En el desarrollo de apps Android, los archivos **R** son archivos Java generados
automáticamente que sirven como referencia a los distintos **recursos** del proyecto, como
**layouts**, **cadenas de texto**, **imágenes**, **colores**, **estilos**, entre otros.

Cuando se compila el proyecto (usando Gradle), estos recursos definidos en XML se convierten en
identificadores únicos que se almacenan en el archivo `R.java`, ubicado en el directorio
generado (`gen`).

Gracias a estos IDs, puedes acceder fácilmente a los recursos desde tu código en Java o Kotlin,
con **seguridad de tipos** y eficiencia.

Aunque existen métodos alternativos, como acceder a los recursos dinámicamente con
`getResources()` o definir constantes manualmente, **estas opciones son menos seguras y más
propensas a errores**, especialmente en proyectos grandes, ya que los IDs pueden cambiar con
cada compilación o actualización.

En resumen, aunque existen otras formas, el uso de archivos R sigue siendo la opción **más
segura, práctica y recomendada** en el desarrollo Android.
