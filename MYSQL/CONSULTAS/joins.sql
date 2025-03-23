--1. Obtener la lista de todos los pedidos con los nombres de clientes usando INNER JOIN .
SELECT pedidos.id AS ID_Pedido, clientes.nombre AS Nombre_Cliente
FROM clientes
INNER JOIN pedidos ON clientes.id = pedidos.cliente_id;

--2. Listar los productos y proveedores que los suministran con INNER JOIN .
SELECT productos.nombre AS Nombre_Producto, proveedores.nombre AS Nombre_Proveedor, proveedores.apellido AS Apellido_Proveedor
FROM proveedores
INNER JOIN productos ON proveedores.id = productos.proveedor_id;

--3. Mostrar los pedidos y las ubicaciones de los clientes con LEFT JOIN .
SELECT pedidos.id AS ID_Pedido, ubicaciones.direccion AS Direccion_Cliente, ciudad.nombre AS Ciudad_Cliente, estado.nombre AS Estado_Cliente, pais.nombre AS Pais_Cliente, clientes.nombre AS Nombre_Cliente
FROM clientes
LEFT JOIN pedidos ON clientes.id = pedidos.cliente_id
LEFT JOIN clienteubicacion ON clientes.id = clienteubicacion.cliente_id
LEFT JOIN ubicaciones ON clienteubicacion.ubicacion_id = ubicaciones.id
LEFT JOIN ciudad ON ubicaciones.ciudad_id = ciudad.id
LEFT JOIN estado ON ciudad.estado_id = estado.id
LEFT JOIN pais ON estado.pais_id = pais.id;

--4. Consultar los empleados que han registrado pedidos, incluyendo empleados sin pedidos( LEFT JOIN ).
ALTER TABLE pedidos ADD COLUMN empleado_id INT;
ALTER TABLE pedidos ADD FOREIGN KEY (empleado_id) REFERENCES empleados(id);

UPDATE pedidos SET empleado_id = 1 WHERE id = 1;
UPDATE pedidos SET empleado_id = 2 WHERE id = 2;
UPDATE pedidos SET empleado_id = 3 WHERE id = 3;
UPDATE pedidos SET empleado_id = 4 WHERE id = 4;
UPDATE pedidos SET empleado_id = 4 WHERE id = 5;

SELECT empleados.nombre AS Nombre_Empleado, empleados.apellido AS Apellido_Empleado, pedidos.id AS ID_Pedido
FROM empleados
LEFT JOIN pedidos ON empleados.id = pedidos.empleado_id;

--5. Obtener el tipo de producto y los productos asociados con INNER JOIN .
SELECT tiposproductos.tipo_nombre AS Tipo_Producto, productos.nombre AS Nombre_Producto
FROM tiposproductos
INNER JOIN productos ON tiposproductos.id = productos.tipo_id;

--6. Listar todos los clientes y el número de pedidos realizados con COUNT y GROUP BY.
SELECT clientes.nombre AS Nombre_Cliente, COUNT(pedidos.id) AS Número_Pedidos
FROM clientes
LEFT JOIN pedidos ON clientes.id = pedidos.cliente_id
GROUP BY clientes.nombre;

--7. Combinar Pedidos y Empleados para mostrar qué empleados gestionaron pedidos específicos.
SELECT pedidos.id AS ID_Pedido, empleados.nombre AS Nombre_Empleado, empleados.apellido AS Apellido_Empleado
FROM empleados
INNER JOIN pedidos ON empleados.id = pedidos.empleado_id;

--8. Mostrar productos que no han sido pedidos ( RIGHT JOIN ).
SELECT productos.nombre AS Nombre_Producto
FROM detallespedido
RIGHT JOIN productos ON detallespedido.producto_id = productos.id
WHERE detallespedido.id IS NULL;

--9. Mostrar el total de pedidos y ubicación de clientes usando múltiples JOIN.
SELECT COUNT(pedidos.id) AS Total_Pedidos, ubicaciones.direccion AS Direccion_Cliente, ciudad.nombre AS Ciudad_Cliente, estado.nombre AS Estado_Cliente, pais.nombre AS Pais_Cliente, clientes.nombre AS Nombre_Cliente, clientes.id AS Cliente_ID
FROM clientes
LEFT JOIN pedidos ON clientes.id = pedidos.cliente_id
LEFT JOIN clienteubicacion ON clientes.id = clienteubicacion.cliente_id
LEFT JOIN ubicaciones ON clienteubicacion.ubicacion_id = ubicaciones.id
LEFT JOIN ciudad ON ubicaciones.ciudad_id = ciudad.id
LEFT JOIN estado ON ciudad.estado_id = estado.id
LEFT JOIN pais ON estado.pais_id = pais.id
GROUP BY clientes.id, clientes.nombre, ubicaciones.direccion, ciudad.nombre, estado.nombre, pais.nombre;

--10. Unir Proveedores , Productos , y TiposProductos para un listado completo de inventario.
SELECT proveedores.nombre AS Nombre_Proveedor, proveedores.apellido AS Apellido_Proveedor, productos.nombre AS Nombre_Producto, productos.precio AS Precio_Producto, tiposproductos.tipo_nombre AS Tipo_Producto
FROM proveedores
INNER JOIN productos ON proveedores.id = productos.proveedor_id
INNER JOIN tiposproductos ON productos.tipo_id = tiposproductos.id;