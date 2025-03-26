--1. Seleccionar todos los productos con precio mayor a $50.
SELECT nombre, precio 
FROM Productos
WHERE precio > 50;
--2. Consultar clientes registrados en una ciudad específica.
SELECT c.nombre AS Cliente, d.direccion
FROM Clientes c
LEFT JOIN clientesdireccion cd ON c.id = cd.cliente_id
LEFT JOIN direcciones d ON cd.direccion_id = d.id
WHERE ciudad = 'Toledo'; 
--3. Mostrar empleados contratados en los últimos 2 años.
SELECT nombre, fecha_contratacion
FROM datosempleado
WHERE YEAR(fecha_contratacion) >= YEAR(CURDATE()) - 2;
--4. Seleccionar proveedores que suministran más de 5 productos.
SELECT p.nombre, COUNT(p2.id) AS Productos_Sumnistrados
FROM Proveedores p 
INNER JOIN Productos p2 ON p.id = p2.proveedor_id
GROUP BY p.nombre
HAVING COUNT(p2.id) > 5;
--5. Listar clientes que no tienen dirección registrada en UbicacionCliente.
SELECT c.nombre, c.id AS cliente_id
FROM Clientes c
LEFT JOIN clientesdireccion cd ON c.id = cd.cliente_id
LEFT JOIN direcciones d ON cd.direccion_id = d.id
WHERE d.direccion IS NULL;
--6. Calcular el total de ventas por cada cliente.
SELECT 
    c.id AS cliente_id, 
    c.nombre, 
    COALESCE(SUM(de.precio), 0) AS total_ventas
FROM Clientes c
LEFT JOIN Pedidos p ON c.id = p.cliente_id
LEFT JOIN DetallesPedido de ON p.id = de.pedido_id
GROUP BY c.id, c.nombre
ORDER BY total_ventas DESC;
--7. Mostrar el salario promedio de los empleados.
SELECT AVG(salario) AS Salario_Promedio
FROM DatosEmpleado;
--8. Consultar el tipo de productos disponibles en TiposProductos.
SELECT tipo_nombre, descripcion
FROM tiposproductos;
--9. Seleccionar los 3 productos más caros.
SELECT nombre, precio
FROM Productos
ORDER BY precio DESC
LIMIT 3;
--10. Consultar el cliente con el mayor número de pedidos.
SELECT 
    c.id AS cliente_id, 
    c.nombre, 
    COUNT(p.id) AS numero_de_pedidos
FROM Clientes c
JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre
ORDER BY numero_de_pedidos DESC
LIMIT 1;