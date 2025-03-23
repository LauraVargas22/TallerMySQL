--1. Seleccionar todos los productos con precio mayor a $50.
SELECT nombre, precio 
FROM productos
WHERE precio > 50;

--2. Consultar clientes registrados en una ciudad específica.
SELECT clientes.nombre, ubicaciones.direccion
FROM clientes
LEFT JOIN clienteubicacion ON clientes.id = clienteubicacion.cliente_id
LEFT JOIN ubicaciones ON clienteubicacion.ubicacion_id = ubicaciones.id
LEFT JOIN ciudad ON ubicaciones.ciudad_id = ciudad.id
LEFT JOIN estado ON ciudad.estado_id = estado.id
LEFT JOIN pais ON estado.pais_id = pais.id
WHERE ciudad.nombre = 'Duitama';

--3. Mostrar empleados contratados en los últimos 2 años.
SELECT empleados.nombre, empleados.apellido, datosempleado.fecha_contratacion
FROM empleados
LEFT JOIN datosempleado ON empleados.id = datosempleado.empleado_id
WHERE YEAR(datosempleado.fecha_contratacion) >= YEAR(CURDATE()) - 2

--4. Seleccionar proveedores que suministran más de 5 productos.
SELECT proveedores.nombre, proveedores.apellido, COUNT(productos.id) AS Productos_Sumnistrados
FROM proveedores
INNER JOIN productos ON proveedores.id = productos.proveedor_id
GROUP BY proveedores.nombre, proveedores.apellido
HAVING COUNT(productos.id) > 5;

--5. Listar clientes que no tienen dirección registrada en UbicacionCliente .