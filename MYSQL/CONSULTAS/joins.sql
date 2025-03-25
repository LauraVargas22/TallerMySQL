--1. Obtener la lista de todos los pedidos con los nombres de clientes usando INNER JOIN .
SELECT Pedidos.id AS ID_Pedido, Clientes.primer_nombre  AS Nombre_Cliente
FROM Clientes
INNER JOIN Pedidos ON Clientes.id = Pedidos.cliente_id;

--2. Listar los productos y proveedores que los suministran con INNER JOIN .
SELECT Productos.nombre AS Nombre_Producto, Proveedores.nombre AS Nombre_Proveedor, Proveedores.apellido AS Apellido_Proveedor
FROM Proveedores
INNER JOIN Productos ON Proveedores.id = Productos.proveedor_id;

--3. Mostrar los pedidos y las ubicaciones de los clientes con LEFT JOIN .
SELECT Pedidos.id AS ID_Pedido, Ubicaciones.direccion AS Direccion_Cliente, ciudad.nombre AS Ciudad_Cliente, estado.nombre AS Estado_Cliente, Pais.nombre AS Pais_Cliente, Clientes.primer_nombre  AS Nombre_Cliente
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
LEFT JOIN clienteUbicacion ON Clientes.id = clienteUbicacion.cliente_id
LEFT JOIN Ubicaciones ON clienteUbicacion.ubicacion_id = Ubicaciones.id
LEFT JOIN ciudad ON Ubicaciones.ciudad_id = ciudad.id
LEFT JOIN estado ON ciudad.estado_id = estado.id
LEFT JOIN Pais ON estado.pais_id = Pais.id;

--4. Consultar los empleados que han registrado pedidos, incluyendo empleados sin pedidos( LEFT JOIN ).
ALTER TABLE Pedidos ADD COLUMN empleado_id INT;
ALTER TABLE Pedidos ADD FOREIGN KEY (empleado_id) REFERENCES Empleados(id);
UPDATE Pedidos SET empleado_id = 1 WHERE id = 1;
UPDATE Pedidos SET empleado_id = 2 WHERE id = 2;
UPDATE Pedidos SET empleado_id = 3 WHERE id = 3;
UPDATE Pedidos SET empleado_id = 4 WHERE id = 4;
UPDATE Pedidos SET empleado_id = 4 WHERE id = 5;

SELECT Empleados.nombre AS Nombre_Empleado, Empleados.apellido AS Apellido_Empleado, Pedidos.id AS ID_Pedido
FROM Empleados
LEFT JOIN Pedidos ON Empleados.id = Pedidos.empleado_id;


--5. Obtener el tipo de producto y los productos asociados con INNER JOIN .
SELECT tp.tipo_nombre AS Tipo_Producto, p.nombre AS Nombre_Producto
FROM TiposProductos tp 
INNER JOIN Productos p  ON tp.id = p.tipo_id;

--6. Listar todos los clientes y el número de pedidos realizados con COUNT y GROUP BY.
SELECT c.primer_nombre AS Nombre_Cliente, COUNT(p.id) AS Número_Pedidos
FROM Clientes c 
LEFT JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.primer_nombre;

--7. Combinar Pedidos y Empleados para mostrar qué empleados gestionaron pedidos específicos.
SELECT p.id AS ID_Pedido, e.nombre AS Nombre_Empleado, e.apellido AS Apellido_Empleado
FROM Empleados e 
INNER JOIN Pedidos p ON e.id = p.empleado_id;

--8. Mostrar productos que no han sido pedidos ( RIGHT JOIN ).
SELECT p.nombre AS Nombre_Producto
FROM DetallesPedido dp 
RIGHT JOIN Productos p ON dp.producto_id = p.id
WHERE dp.id IS NULL;

--9. Mostrar el total de pedidos y ubicación de clientes usando múltiples JOIN.
SELECT COUNT(p.id) AS Total_Pedidos, u.direccion AS Direccion_Cliente, ciudad.nombre AS Ciudad_Cliente, estado.nombre AS Estado_Cliente, p2.nombre AS Pais_Cliente, c.primer_nombre  AS Nombre_Cliente, c.id AS Cliente_ID
FROM Clientes c 
LEFT JOIN Pedidos p ON c.id = p.cliente_id
LEFT JOIN clienteUbicacion cu  ON c.id = cu.cliente_id
LEFT JOIN Ubicaciones u  ON cu.ubicacion_id = u.id
LEFT JOIN ciudad ON u.ciudad_id = ciudad.id
LEFT JOIN estado ON ciudad.estado_id = estado.id
LEFT JOIN Pais p2  ON estado.pais_id = p2.id
GROUP BY c.id, c.primer_nombre, u.direccion, ciudad.nombre, estado.nombre, p2.nombre;

--10. Unir Proveedores , Productos , y TiposProductos para un listado completo de inventario.
SELECT p.nombre AS Nombre_Proveedor, p.apellido AS Apellido_Proveedor, p2.nombre AS Nombre_Producto, p2.precio AS Precio_Producto, tp.tipo_nombre AS Tipo_Producto
FROM Proveedores p 
INNER JOIN Productos p2 ON p.id = p2.proveedor_id
INNER JOIN TiposProductos tp  ON p2.tipo_id = tp.id;