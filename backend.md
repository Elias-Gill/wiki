# TODO
- Ver como guardar las mesas que se van a usar
- Poder traer las mesas que no estan en uso
- Cerrar consumision de una mesa
- Cargar consumision de una mesa
- Recuperar el resumen de consumo de una mesa
- Operaciones de update SOLO sobre el cliente y el estado en la consumision
- Hacer el frontend
- Generar pdf de los datos de la consumision (ver libreria)

# Notas
Las mesas sin consumision activa son mesas disponibles.

Hacer metodos para determinar si la mesa esta activa, para ver listar la consumision, para
hacer detalles, etc.

Escribir muchos tests para todo eso, la API ya tenes que tener corriendo HOY, manhana el front
como desquiciado.

Una consumision que se ya esta "pagada" (pagado = true) no se puede volver a modificar.

Una consumision creada ya no se puede borrar, solo se puede "pagar", dejando la consumision
vacia si acaso.
