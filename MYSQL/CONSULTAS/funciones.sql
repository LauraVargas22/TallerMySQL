--1. Crear una función que reciba una fecha y devuelva los días transcurridos.
DELIMITER $$
CREATE FUNCTION dias_transcurridos(fecha DATE) RETURNS INT
DETERMINISTIC
BEGIN
	RETURN DATEDIFF (CURDATE(), fecha);
END $$
DELIMITER ;

SELECT dias_transcurridos('2025-02-20');

--2. Crear una función para calcular el total con impuesto de un monto.
DELIMITER $$
CREATE FUNCTION valor_total(monto DECIMAL(10,2)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE impuesto DECIMAL(10,2);
    DECLARE valorTotal DECIMAL(10,2);
	SET impuesto = monto * 0.19;
	SET valorTotal = monto + impuesto;
    RETURN valorTotal;
END $$
DELIMITER ;

SELECT valor_total(100.00);

--3. Una función que devuelva el total de pedidos de un cliente específico.
DELIMITER $$
CREATE FUNCTION total_pedidos_cliente(id_cliente INT) RETURNS INT
DETERMINISTIC
BEGIN
DECLARE TotalPedidos INT;

SELECT COUNT(p.id) INTO TotalPedidos
FROM pedidos p
WHERE p.cliente_id = id_cliente;

RETURN TotalPedidos;
END $$
DELIMITER ;

SELECT total_pedidos_cliente(1);

--4. Crear una función para aplicar un descuento a un producto.
DELIMITER $$
CREATE FUNCTION descuento_producto(id_producto INT, descuento DECIMAL(10,2)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE precioInicial DECIMAL(10,2);
	DECLARE precioFinal DECIMAL(10,2);

    SELECT precio INTO precioInicial
    FROM productos
    WHERE id = id_producto;

	SET precioFinal = precioInicial * (1 - descuento/100);

	UPDATE productos 
    SET precio = precioFinal 
    WHERE id = id_producto;

    RETURN precioFinal;
END $$
DELIMITER ;

SELECT descuento_producto(3, 2);

--5. Una función que indique si un cliente tiene dirección registrada.
DELIMITER $$
CREATE FUNCTION validar_direccion(id_cliente INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE validar_direccion BOOLEAN;
    
    SELECT EXISTS (
        SELECT 1 
        FROM clientesdireccion cd
        JOIN direcciones d ON cd.direccion_id = d.id
        WHERE cd.cliente_id = id_cliente
        AND d.direccion IS NOT NULL
    ) INTO validar_direccion;
    
    RETURN validar_direccion;
END $$
DELIMITER ;

SELECT validar_direccion(1);

--6. Crear una función que devuelva el salario anual de un empleado.
DELIMITER $$
CREATE FUNCTION salario_anual(id_empleado INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE salarioAnual DECIMAL(10,2);
DECLARE salarioMensual DECIMAL(10,2);
SELECT salario INTO salarioMensual
FROM empleados
WHERE id = id_empleado;

SET salarioAnual = salarioMensual * 12;
RETURN salarioAnual;
END $$
DELIMITER ;

SELECT salario_anual(1);

--7. Una función para calcular el total de ventas de un tipo de producto.
DELIMITER $$
CREATE FUNCtION total_ventas_producto(tipo_id INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN 
    DECLARE totalVentas DECIMAL(10, 2);
    SELECT SUM(dp.precio * dp.cantidad) INTO totalVentas
    FROM DetallesPedido dp
    JOIN Productos p ON dp.producto_id = p.id
    WHERE p.tipo_id = tipo_id;
    RETURN totalVentas;
END $$

DELIMITER ;

SELECT total_ventas_producto(1);

--8. Crear una función para devolver el nombre de un cliente por ID.
DELIMITER $$
CREATE FUNCTION nombre_cliente(id_cliente INT) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE nombre_cliente VARCHAR(50);
	SELECT nombre INTO nombre_cliente
	FROM clientes
	WHERE id = id_cliente;
	RETURN nombre_cliente;
END $$
DELIMITER ;

SELECT nombre_cliente(1);


--9. Una función que reciba el ID de un pedido y devuelva su total.
DELIMITER $$
CREATE FUNCTION total_pedido(id_pedido INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE total_pedido DECIMAL(10,2);
	SELECT total INTO total_pedido
	FROM pedidos
	WHERE id = id_pedido;

	RETURN total_pedido;
END $$
DELIMITER ;

SELECT total_pedido(1);

--10. Crear una función que indique si un producto está en inventario.
DELIMITER $$
CREATE FUNCTION producto_inventario(producto_id INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE existe BOOLEAN;
    
    SELECT EXISTS(
        SELECT 1 
        FROM Productos 
        WHERE id = producto_id
    ) INTO existe;
    
    RETURN existe;
END $$
DELIMITER ;

SELECT producto_inventario(1);