--1. Seleccionar todos los productos con precio mayor a $50.
SELECT nombre, precio 
FROM Productos
WHERE precio > 50;

--2. Consultar clientes registrados en una ciudad específica.
SELECT c.primer_nombre, c.primer_apellido, u.direccion
FROM Clientes c 
LEFT JOIN clienteUbicacion cu  ON c.id = cu.cliente_id
LEFT JOIN Ubicaciones u  ON cu.ubicacion_id = u.id
LEFT JOIN ciudad ON u.ciudad_id = ciudad.id
LEFT JOIN estado ON ciudad.estado_id = estado.id
LEFT JOIN Pais p  ON estado.pais_id = p.id
WHERE ciudad.nombre = 'Duitama';
--3. Mostrar empleados contratados en los últimos 2 años.
SELECT empleados.nombre, empleados.apellido, datosempleado.fecha_contratacion
SELECT e.nombre, e.apellido, de.fecha_contratacion
FROM Empleados e 
LEFT JOIN DatosEmpleado de  ON e.id = de.empleado_id
WHERE YEAR(de.fecha_contratacion) >= YEAR(CURDATE()) - 2;

--4. Seleccionar proveedores que suministran más de 5 productos.
SELECT p.nombre, p.apellido, COUNT(p2.id) AS Productos_Sumnistrados
FROM Proveedores p 
INNER JOIN Productos p2 ON p.id = p2.proveedor_id
GROUP BY p.nombre, p.apellido
HAVING COUNT(p2.id) > 5;

--5. Listar clientes que no tienen dirección registrada en UbicacionCliente .