--1. Crear un procedimiento para actualizar el precio de todos los productos de un proveedor.
DELIMITER $$
CREATE PROCEDURE actualizar_precio(IN id_proveedor INT, IN nuevo_precio DECIMAL(10,2))
BEGIN
	DECLARE mensaje VARCHAR(100);
	UPDATE productos SET precio = nuevo_precio WHERE proveedor_id = id_proveedor;

IF ROW_COUNT() > 0 THEN
	SET mensaje = CONCAT('Producto actualizado');
ELSE
	SET mensaje = 'No se encontró el ID';
END IF;
SELECT mensaje AS 'Mensaje';
END $$
DELIMITER ;

CALL actualizar_precio(1, 100.00);

--2. Un procedimiento que devuelva la dirección de un cliente por ID.
DELIMITER $$
CREATE PROCEDURE cliente_direccion(IN id_cliente INT)
BEGIN
SELECT d.direccion, c.nombre
FROM Clientes c
LEFT JOIN clientesdireccion cd ON c.id = cd.cliente_id
LEFT JOIN direcciones d ON cd.direccion_id = d.id
WHERE c.id = id_cliente;
END $$
DELIMITER ;
CALL cliente_direccion(1);


--3. Crear un procedimiento que registre un pedido nuevo y sus detalles.
DELIMITER $$
CREATE PROCEDURE nuevo_pedido(IN cliente_id INT, IN fecha DATE, IN total DECIMAL(10,2), IN empleado_id INT, IN nombre_producto VARCHAR(50), IN cantidad INT, IN precio DECIMAL(10,2))
BEGIN
    DECLARE producto_id INT;
	DECLARE mensaje VARCHAR(100);
	INSERT INTO pedidos(cliente_id, fecha, total, empleado_id)
	VALUES (cliente_id, fecha, total, empleado_id);

	SELECT id INTO producto_id FROM productos WHERE nombre = nombre_producto LIMIT 1;

	INSERT INTO detallespedido(pedido_id, producto_id, cantidad, precio)
	VALUES(LAST_INSERT_ID(), producto_id, cantidad, precio);

	IF ROW_COUNT() > 0 THEN
		SET mensaje = 'Registro insertado correctamente';
	ELSE 
		SET mensaje = 'Error en el registro';
	END IF;
	SELECT mensaje AS 'Mensaje';
END $$

DELIMITER ;
CALL nuevo_pedido(1, '2025-03-26', 200.00, 1, 'Optio', 2, 100.00);

--4. Un procedimiento para calcular el total de ventas de un cliente.
DELIMITER $$
CREATE PROCEDURE cliente_total_ventas(IN id_cliente INT)
BEGIN
SELECT c.nombre, SUM(p.total) AS Total_Ventas
FROM Clientes c
JOIN Pedidos p ON c.id = p.cliente_id
WHERE c.id = id_cliente
GROUP BY c.nombre;
END $$
DELIMITER ;
CALL cliente_total_ventas(1);

--5. Crear un procedimiento para obtener los empleados por puesto.
DELIMITER $$
CREATE PROCEDURE empleados_puesto(IN puesto_nombre VARCHAR(50))
BEGIN
SELECT de.nombre, pu.nombre
FROM Puestos pu
JOIN datosempleado de ON pu.id = de.puesto_id
WHERE pu.nombre = puesto_nombre;
END $$
DELIMITER ;
CALL empleados_puesto('Sports development officer');

--6. Un procedimiento que actualice el salario de empleados por puesto.
DELIMITER $$
CREATE PROCEDURE actualizar_salario(IN puesto VARCHAR(50), IN nuevo_salario DECIMAL(10,2))
BEGIN
	DECLARE mensaje VARCHAR(100);
	DECLARE id_puesto INT;

	SELECT id INTO id_puesto FROM puestos WHERE nombre = puesto LIMIT 1;
	UPDATE datosempleado SET salario = nuevo_salario WHERE puesto_id = id_puesto;

	IF ROW_COUNT() > 0 THEN
		SET mensaje = 'Correcta actualización del salario';
	ELSE 
		SET mensaje = 'Error en la actualización del salario';
	END IF;
	SELECT mensaje AS 'mensaje';
END $$
DELIMITER ;
CALL actualizar_salario('Sports development officer', 5690.00);

--7. Crear un procedimiento que liste los pedidos entre dos fechas.
DELIMITER $$
CREATE PROCEDURE pedidos_realizados(IN fecha_inicial DATE, IN fecha_final DATE)
BEGIN
	SELECT cliente_id, empleado_id, fecha, total
	FROM pedidos
	WHERE fecha BETWEEN fecha_inicial AND fecha_final;
END $$
DELIMITER ;
CALL pedidos_realizados('2024-05-03', '2025-04-08');

--8. Un procedimiento para aplicar un descuento a productos de una categoría.
DELIMITER $$
CREATE PROCEDURE descuento_producto(IN id_categoria INT, IN descuento DECIMAL(10,2))
BEGIN
	UPDATE Productos
	SET precio = precio * (1 - descuento/100)
	WHERE tipo_id = id_categoria;
END $$
DELIMITER ;
CALL descuento_producto(2, 10);


--9. Crear un procedimiento que liste todos los proveedores de un tipo de producto.
DELIMITER $$
CREATE PROCEDURE proveedor_productos(IN id_tipo_producto INT)
BEGIN
SELECT pr.nombre, tp.tipo_nombre
FROM Proveedores pr
JOIN productos p ON pr.id = p.proveedor_id
JOIN tiposproductos tp ON p.tipo_id = tp.id
WHERE tp.id = id_tipo_producto;
END $$
DELIMITER ;
CALL proveedor_productos(2);

--10. Un procedimiento que devuelva el pedido de mayor valor.
DELIMITER $$
CREATE PROCEDURE pedido_mayor_valor()
BEGIN 
SELECT id AS ID_Pedido, fecha, total AS Mayor_Valor
FROM Pedidos
ORDER BY total DESC
LIMIT 1;
END $$
DELIMITER ;
CALL pedido_mayor_valor();