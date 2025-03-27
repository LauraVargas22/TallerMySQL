-- 1. Trigger para registrar cambios en el salario de empleados en HistorialSalarios
DELIMITER $$
CREATE TRIGGER after_update_salary
AFTER UPDATE ON datosempleado
FOR EACH ROW
BEGIN
    IF OLD.salario <> NEW.salario THEN
        INSERT INTO HistorialSalarios (empleado_id, salario_anterior, salario_nuevo, fecha_cambio)
        VALUES (NEW.id, OLD.salario, NEW.salario, NOW());
    END IF;
END $$
DELIMITER ;

UPDATE datosempleado SET salario = 50000 WHERE id = 1;

-- 2. Trigger para evitar borrar productos con pedidos activos
DELIMITER $$
CREATE TRIGGER before_delete_producto
BEFORE DELETE ON Productos
FOR EACH ROW
BEGIN
    DECLARE pedidos_activos INT DEFAULT 0;
    
    SELECT COUNT(*) INTO pedidos_activos
    FROM detallespedido
    WHERE producto_id = OLD.id;
    
    IF pedidos_activos > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar el producto, ya está en un pedido activo';
    END IF;
END $$
DELIMITER ;

-- 3. Trigger para registrar actualizaciones en Pedidos en HistorialPedidos
DELIMITER $$
CREATE TRIGGER after_update_order
AFTER UPDATE ON pedidos
FOR EACH ROW
BEGIN
    INSERT INTO historialpedidos(pedido_id, cliente_id, fecha_modificacion, cambio)
    VALUES (pedido_id, cliente_id, NOW(), '2');
END $$
DELIMITER ;

-- 4. Trigger para actualizar el inventario al registrar un pedido

-- 5. Trigger para evitar actualizaciones de precio a menos de $1
DELIMITER $$
CREATE TRIGGER before_price_update
BEFORE UPDATE ON productos
FOR EACH ROW
BEGIN
    IF NEW.precio < 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio no puede ser menor a $1';
    END IF;
END $$
DELIMITER ;

-- 6. Trigger para registrar la fecha de creación de un pedido en HistorialPedidos
DELIMITER $$
CREATE TRIGGER after_order_insert_date
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
    INSERT INTO historialpedidos(fecha_modificacion, cambio)
    VALUES (NOW(), 1);
DELIMITER ;

-- 7. Trigger para mantener el precio total de cada pedido en Pedidos

DELIMITER $$
CREATE TRIGGER after_details_insert
AFTER INSERT ON DetallesPedido
FOR EACH ROW
BEGIN
    DECLARE total DECIMAL(10, 2) DEFAULT 0;
    
    -- Calcular el total de cada pedido después de la inserción de un detalle de pedido
    SELECT SUM(cantidad * precio) INTO total
    FROM detallespedido
    WHERE pedido_id = NEW.pedido_id;
    
    -- Actualizar el total del pedido
    UPDATE pedidos
    SET total = total
    WHERE id = NEW.pedido_id;
END $$
DELIMITER ;

-- 8. Trigger para validar que UbicacionCliente no esté vacío al crear un cliente
DELIMITER $$
CREATE TRIGGER before_cliente_insert
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    DECLARE ubicacion_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO ubicacion_count
    FROM direcciones
    WHERE entidad_id = NEW.id AND entidad_tipo = 'Cliente';
    
    IF ubicacion_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El cliente debe tener al menos una ubicación asociada';
    END IF;
END $$
DELIMITER ;

-- 9. Trigger para registrar en LogActividades cada modificación en Proveedores
DELIMITER $$
CREATE TRIGGER after_supplier_update
AFTER UPDATE ON proveedores
FOR EACH ROW
BEGIN
    INSERT INTO LogActividades (accion, entidad_id, accion, fecha)
    VALUES ('Proveedor', NEW.id, 'Actualización', NOW());
END $$
DELIMITER ;

-- 10. Trigger para registrar en HistorialContratos cada cambio en Empleados
DELIMITER $$
CREATE TRIGGER after_employee_update
AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO historialcontratos (empleado_id, puesto_anterior, puesto_nuevo, fecha_cambio, fecha_cambio)
    VALUES (NEW.id, OLD.puesto, NEW.puesto, NOW());
END $$
DELIMITER ;