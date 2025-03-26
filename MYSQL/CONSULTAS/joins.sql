--1. Obtener la lista de todos los pedidos con los nombres de clientes usando INNER JOIN .
SELECT p.id, c.nombre, p.fecha
FROM Clientes c
INNER JOIN Pedidos p ON c.id = p.cliente_id;
--2. Listar los productos y proveedores que los suministran con INNER JOIN .
SELECT pr.nombre AS Proveedor, p.nombre AS Producto, p.id AS ID_Producto
FROM Proveedores pr
INNER JOIN Productos p ON pr.id = p.proveedor_id;
--3. Mostrar los pedidos y las ubicaciones de los clientes con LEFT JOIN .
SELECT p.id AS Id_Pedido, c.nombre AS Cliente, d.direccion, d.ciudad
FROM Clientes c
LEFT JOIN Pedidos p ON c.id = p.cliente_id
LEFT JOIN clientesdireccion cd ON c.id = cd.cliente_id
LEFT JOIN Direcciones d ON cd.direccion_id = d.id;
--4. Consultar los empleados que han registrado pedidos, incluyendo empleados sin pedidos( LEFT JOIN ).
SELECT Empleados.nombre AS Empleado, Pedidos.id AS ID_Pedido
FROM Empleados
LEFT JOIN Pedidos ON Empleados.id = Pedidos.empleado_id;
--5. Obtener el tipo de producto y los productos asociados con INNER JOIN .
SELECT tp.tipo_nombre AS Tipo_Producto, p.nombre AS Nombre_Producto
FROM TiposProductos tp 
INNER JOIN Productos p  ON tp.id = p.tipo_id;
--6. Listar todos los clientes y el número de pedidos realizados con COUNT y GROUP BY.
SELECT c.nombre AS Cliente, COUNT(p.id) AS Número_Pedidos
FROM Clientes c 
LEFT JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.nombre;
--7. Combinar Pedidos y Empleados para mostrar qué empleados gestionaron pedidos específicos.
SELECT p.id AS ID_Pedido, e.nombre AS Empleado
FROM Empleados e 
INNER JOIN Pedidos p ON e.id = p.empleado_id;

--8. Mostrar productos que no han sido pedidos ( RIGHT JOIN ).
SELECT p.nombre AS Producto
FROM detallespedido dp
RIGHT JOIN Productos p ON dp.producto_id = p.id
WHERE dp.id IS NULL;

--9. Mostrar el total de pedidos y ubicación de clientes usando múltiples JOIN.
SELECT COUNT(p.id) AS Total_Pedidos, c.nombre AS Cliente, d.direccion, d.ciudad
FROM Clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
LEFT JOIN clientesdireccion cd ON c.id = cd.cliente_id
LEFT JOIN Direcciones d ON cd.direccion_id = d.id
GROUP BY c.nombre, d.direccion, d.ciudad;
--10. Unir Proveedores , Productos , y TiposProductos para un listado completo de inventario.
SELECT p.nombre AS Proveedor, p2.nombre AS Nombre_Producto, p2.precio AS Precio_Producto, tp.tipo_nombre AS Tipo_Producto
FROM Proveedores p 
INNER JOIN Productos p2 ON p.id = p2.proveedor_id
INNER JOIN TiposProductos tp  ON p2.tipo_id = tp.id;