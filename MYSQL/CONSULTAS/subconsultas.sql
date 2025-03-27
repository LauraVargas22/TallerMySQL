-- 1. Consultar el producto más caro en cada categoría.
SELECT tp.tipo_nombre AS Categoria, p.nombre AS Producto, p.precio
FROM productos p 
JOIN tiposproductos tp ON p.tipo_id = tp.id
WHERE p.precio = (SELECT MAX(p.precio) FROM productos);

-- 2. Encontrar el cliente con mayor total en pedidos
SELECT c.nombre, COUNT(p.id) AS PedidosCliente
FROM Clientes c
JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.nombre, c.id
HAVING COUNT(p.id) = (
    SELECT MAX(PedidosCliente) 
    FROM (
        SELECT COUNT(id) AS PedidosCliente
        FROM Pedidos
        GROUP BY cliente_id
    ) AS ConteoClientes
);
-- 3. Listar empleados que ganan más que el salario promedio
SELECT id, nombre, salario
FROM Empleados
WHERE Salario > (
    SELECT AVG(Salario) 
    FROM Empleados
);

-- 4. Consultar productos que han sido pedidos más de 5 veces
SELECT p.id, p.nombre, COUNT(dp.producto_id) AS VecesPedido
FROM Productos p
JOIN DetallesPedido dp ON p.id = dp.producto_id
GROUP BY p.id, p.nombre
HAVING COUNT(dp.producto_id) > 5;

-- 5. Listar pedidos cuyo total es mayor al promedio de todos los pedidos
SELECT id, total
FROM Pedidos
WHERE Total > (
    SELECT AVG(Total) 
    FROM Pedidos
);

-- 6. Seleccionar los 3 proveedores con más productos
SELECT pr.nombre, p.nombre, COUNT(p.proveedor_id) AS Productos_Suministrados
FROM Proveedores pr
JOIN Productos p ON pr.id = p.proveedor_id
GROUP BY pr.nombre, p.nombre
ORDER BY COUNT(p.proveedor_id) DESC
LIMIT 3;
-- 7. Consultar productos con precio superior al promedio en su tipo
SELECT pr.nombre, tp.tipo_nombre, pr.precio
FROM tiposproductos tp 
JOIN productos pr ON tp.id = pr.tipo_id
WHERE pr.precio > (
    SELECT AVG(precio) 
    FROM productos 
    WHERE tipo_id = pr.tipo_id
)
GROUP BY tp.tipo_nombre, pr.nombre, pr.precio;

-- 8. Mostrar clientes que han realizado más pedidos que la media
SELECT c.id, c.nombre, COUNT(p.id) AS NumeroPedidos
FROM Clientes c
JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre
HAVING COUNT(p.id) > (
    SELECT AVG(PedidosPorCliente)
    FROM (
        SELECT COUNT(id) AS PedidosPorCliente
        FROM Pedidos
        GROUP BY id
    ) AS ConteoClientes
);

-- 9. Encontrar productos cuyo precio es mayor que el promedio de todos los productos
SELECT id, nombre, precio
FROM Productos
WHERE precio > (
    SELECT AVG(precio)
    FROM Productos
);

-- 10. Mostrar empleados cuyo salario es menor al promedio del departamento
