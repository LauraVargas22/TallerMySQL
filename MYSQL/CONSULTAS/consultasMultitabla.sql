--1. Listar todos los pedidos y el cliente asociado.
SELECT p.id AS id_Pedido, c.primer_nombre, c.primer_apellido, p.fecha AS fecha_pedido
FROM Clientes c
LEFT JOIN Pedidos p ON c.id = p.cliente_id;

--2. Mostrar la ubicación de cada cliente en sus pedidos.
SELECT Pedidos.id AS ID_Pedido, Ubicaciones.direccion AS Direccion_Cliente, ciudad.nombre AS Ciudad_Cliente, estado.nombre AS Estado_Cliente, Pais.nombre AS Pais_Cliente, Clientes.primer_nombre  AS Nombre_Cliente
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
LEFT JOIN clienteUbicacion ON Clientes.id = clienteUbicacion.cliente_id
LEFT JOIN Ubicaciones ON clienteUbicacion.ubicacion_id = Ubicaciones.id
LEFT JOIN ciudad ON Ubicaciones.ciudad_id = ciudad.id
LEFT JOIN estado ON ciudad.estado_id = estado.id
LEFT JOIN Pais ON estado.pais_id = Pais.id;
--3. Listar productos junto con el proveedor y tipo de producto.
SELECT 
    p.id AS producto_id,
    p.nombre AS nombre_producto,
    p.precio,
    pr.nombre AS nombre_proveedor,
    tp.descripcion  AS tipo_producto
FROM Productos p
JOIN Proveedores pr ON p.proveedor_id = pr.id
JOIN TiposProductos tp ON p.tipo_id = tp.id
ORDER BY tp.descripcion , p.nombre;
--4. Consultar todos los empleados que gestionan pedidos de clientes en una ciudad específica.
--5. Consultar los 5 productos más vendidos.
SELECT 
    p.id AS producto_id,
    p.nombre AS nombre_producto,
    SUM(dp.cantidad) AS cantidad_total_vendida
FROM Productos p
JOIN DetallesPedido dp ON p.id = dp.producto_id
GROUP BY p.id, p.nombre
ORDER BY cantidad_total_vendida DESC
LIMIT 5;
--6. Obtener la cantidad total de pedidos por cliente y ciudad.
--7. Listar clientes y proveedores en la misma ciudad.
--8. Mostrar el total de ventas agrupado por tipo de producto.
SELECT 
    tp.id AS tipo_producto_id,
    tp.descripcion  AS nombre_tipo_producto,
    SUM(dp.cantidad * p.precio) AS total_ventas
FROM TiposProductos tp
JOIN Productos p ON tp.id = p.tipo_id
JOIN DetallesPedido dp ON p.id = dp.producto_id
GROUP BY tp.id, tp.descripcion 
ORDER BY total_ventas DESC;
--9. Listar empleados que gestionan pedidos de productos de un proveedor específico.

--10. Obtener el ingreso total de cada proveedor a partir de los productos vendidos.
SELECT 
    pr.id AS proveedor_id,
    pr.nombre AS nombre_proveedor,
    SUM(dp.cantidad * p.precio) AS ingreso_total
FROM Proveedores pr
JOIN Productos p ON pr.id = p.proveedor_id
JOIN DetallesPedido dp ON p.id = dp.producto_id
GROUP BY pr.id, pr.nombre
ORDER BY ingreso_total DESC;