--1. Listar todos los pedidos y el cliente asociado.
SELECT p.id AS ID_Pedido, p.fecha, c.nombre AS Cliente
FROM Clientes c
LEFT JOIN Pedidos p ON c.id = p.cliente_id;
--2. Mostrar la ubicación de cada cliente en sus pedidos.
SELECT p.id AS ID_Pedido, p.fecha, c.nombre, d.direccion, d.ciudad
FROM Clientes c
LEFT JOIN Pedidos p ON c.id = p.cliente_id
LEFT JOIN clientesdireccion cd ON c.id = cd.cliente_id
LEFT JOIN direcciones d ON cd.direccion_id = d.id;
--3. Listar productos junto con el proveedor y tipo de producto.
SELECT p.nombre, pr.nombre, tp.tipo_nombre
FROM Productos p
JOIN proveedores pr ON p.proveedor_id = pr.id
JOIN tiposproductos tp ON p.tipo_id = tp.id;
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
SELECT COUNT(p.id) AS Total_Pedidos, c.nombre, d.ciudad
FROM Pedidos p
LEFT JOIN Clientes c ON p.cliente_id = c.id
LEFT JOIN clientesdireccion cd ON c.id = cd.cliente_id
LEFT JOIN direcciones d ON cd.direccion_id = d.id
GROUP BY c.nombre, d.ciudad;
--7. Listar clientes y proveedores en la misma ciudad.
SELECT c.nombre, pr.nombre, d.ciudad
FROM Direcciones d
JOIN clientesdireccion cd ON d.id = cd.direccion_id
JOIN clientes c ON cd.cliente_id = c.id
JOIN proveedoresdireccion pd ON d.id = pd.direccion_id
JOIN proveedores pr ON pd.proveedor_id = pr.id
GROUP BY d.ciudad, pr.nombre, c.nombre;
--8. Mostrar el total de ventas agrupado por tipo de producto.
SELECT 
    tp.id AS tipo_producto_id,
    tp.tipo_nombre  AS Tipo_producto,
    SUM(dp.cantidad * p.precio) AS total_ventas
FROM TiposProductos tp
JOIN Productos p ON tp.id = p.tipo_id
JOIN DetallesPedido dp ON p.id = dp.producto_id
GROUP BY tp.id, tp.tipo_nombre 
ORDER BY total_ventas DESC;
--9. Listar empleados que gestionan pedidos de productos de un proveedor específico.
SELECT p.id AS ID_Pedido, e.nombre AS Empleado, pr.nombre AS Proveedor
FROM Empleados e
JOIN Pedidos p ON e.id = p.empleado_id
JOIN empleadosproveedores ep ON e.id = ep.empleado_id
JOIN proveedores pr ON ep.proveedor_id = pr.id;
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