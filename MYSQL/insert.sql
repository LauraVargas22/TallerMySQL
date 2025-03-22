--Paises
INSERT INTO Pais (nombre, codigo_iso) VALUES ('Colombia', 'CO'),
('México', 'MX'), ('Argentina', 'AR'), ('España', 'ES');

--Estados
INSERT INTO estado (nombre, pais_id) VALUES ('Santander', 1),('Boyacá', 1), ('Durango', 2), ('Rio Negro', 3),('Aragón', 4);

--Ciudades
INSERT INTO ciudad (nombre, estado_id) VALUES ('Bucaramanga', 11), ('Duitama', 12), ('Tunja', 12), ('Hidalgo', 13), ('Cervantes', 14), ('Zaragoza', 15);

--Clientes
INSERT INTO clientes(nombre, email) VALUES ('Laura Vargas', 'laura.vargas@email.com'), ('Carlos Mendoza', 'carlos.mendoza@email.com'), ('Ana Ramírez', 'ana.ramirez@email.com'), ('Juan Pérez', 'juan.perez@email.com'),('Sofía Gómez', 'sofia.gomez@email.com');

-- Empleados 
INSERT INTO empleados(nombre, apellido) VALUES ('Luis', 'Becerra'), ('María', 'González'), ('Pedro', 'Martínez'),('Andrea', 'López'), ('Javier', 'Torres');

INSERT INTO proveedores(nombre, apellido, telefono, direccion) VALUES ('Ricardo', 'Muñoz', '3123456789', 'Calle 10 #45-23'),
('Elena', 'Castro', '3156789012', 'Av. Principal 123'),
('Fernando', 'López', '3109876543', 'Cra 50 #12-34'),
('Isabela', 'Ramírez', '3194567890', 'Cl. 8 #27-56'),
('Jorge', 'Pérez', '3223456781', 'Av. Siempre Viva 742');

--Puestos
INSERT INTO Puestos(puesto) VALUES ('Cajero'),
('Vendedor'), ('Gerente de tienda'), ('Supervisor de ventas'),
('Asesor de servicio al cliente'), ('Encargado de inventario'), ('Gerente de operaciones'), ('Seguridad'),
('Limpieza y mantenimiento'), ('Publicidad y mercadeo');

-- Teléfono clientes
INSERT INTO telefonos(cliente_id, telefono) VALUES (1, '3123456789'), (2, '3156789012'), (3, '3109876543'),(4, '3194567890'), (5, '3223456781');

-- Ubicación
INSERT INTO ubicaciones (direccion, ciudad_id, codigo_postal) VALUES ('Calle 10 #45-23', 13, '110111'), ('Avenida Principal 123', 16, '500001'),
('Carrera 50 #12-34', 14, '760001'),
('Calle 8 #27-56', 15, '680003'),
('Avenida Siempre Viva 742', 17, '130001'), ('Calle 12 #45-23', 13, '110111'), ('Avenida Principal 12', 16, '500001'),
('Carrera 55 #12-34', 14, '760001'),
('Calle 18 #27-56', 15, '680003'),
('Avenida Viva 74', 17, '130001');

--Ubicación cliente
INSERT INTO clienteubicacion(cliente_id, ubicacion_id) VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

--Contacto Proveedores
INSERT INTO contactoproveedor(proveedor_id, contacto) VALUES (1, '3123456789'), (2, '3156789012'), (3, '3109876543'),(4, '3194567890'), (5, '3223456781');

--Datos Empleado
INSERT INTO datosempleado(empleado_id, puesto_id, salario, fecha_contratacion) VALUES
(1, 3, 2500000.00, '2023-05-10'),
(2, 1, 1800000.00, '2024-01-15'),
(3, 2, 2000000.00, '2022-09-20'),
(4, 5, 2200000.00, '2021-07-05'),
(5, 7, 1900000.00, '2023-11-30');  

--Empleado Proveedor
INSERT INTO empleadosproveedores(empleado_id, proveedor_id) VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

--Ubicación Empleado
INSERT INTO empleadoubicacion(empleado_id, ubicacion_id) VALUES (1, 6), (2, 7), (3, 8), (4, 9), (5, 10);

--Ubicación Proveedor
INSERT INTO proveedorubicacion(proveedor_id, ubicacion_id) VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

--Tipos de productos
INSERT INTO tiposproductos(tipo_nombre, descripcion, categoria_padre_id) VALUES
('Electrónica', 'Productos electrónicos y dispositivos', NULL),
('Celulares', 'Teléfonos móviles y accesorios', 1),
('Computadores', 'Laptops, PC y periféricos', 1),
('Ropa', 'Vestimenta para todas las edades', NULL),
('Calzado', 'Zapatos, sandalias y botas', 4),
('Alimentos', 'Productos alimenticios y bebidas', NULL),
('Lácteos', 'Leche, quesos y yogures', 6),
('Carnes', 'Res, pollo, cerdo y pescado', 6),
('Muebles', 'Mobiliario para hogar y oficina', NULL),
('Sofás', 'Sillones, sofás y muebles de sala', 9);

--Productos
INSERT INTO productos(nombre, precio, proveedor_id, tipo_id)  VALUES
('iPhone 14', 4200000.00, 1, 2),
('Laptop HP Pavilion', 3500000.00, 2, 3),
('Zapatillas Nike Air', 280000.00, 3, 5),
('Queso Mozzarella', 18000.00, 4, 7),
('Sofá de 3 puestos', 1200000.00, 5, 10), ('Samsung Galaxy S23', 3900000.00, 1, 2),
('Monitor LG 24"', 720000.00, 2, 3),
('Lomo de Cerdo', 12000.00, 4, 6),
('Leche Deslactosada Alpina', 4500.00, 4, 7),
('Mesa de Comedor de Madera', 850000.00, 5, 9);

--Pedidos
INSERT INTO pedidos(cliente_id, fecha) VALUES
(1, '2024-03-15'),(2, '2024-03-16'), (3, '2024-03-17'), (4, '2024-03-18'),
(5, '2024-03-19');

--Historial de pedidos
INSERT INTO historialpedidos(pedido_id, fechaCambio, accion, comentario) VALUES
(1, '2024-03-15 10:30:00', 'Creación', 'Pedido registrado en el sistema'),
(1, '2024-03-15 14:00:00', 'Pago confirmado', 'El cliente realizó el pago exitosamente'),
(2, '2024-03-16 09:45:00', 'Creación', 'Pedido registrado en el sistema'),
(2, '2024-03-16 12:30:00', 'En proceso', 'El pedido está siendo preparado'),
(3, '2024-03-17 15:20:00', 'Enviado', 'El pedido ha sido despachado al cliente');

--Detalles de pedidos
INSERT INTO detallespedido (pedido_id, producto_id, cantidad, precio) VALUES
(1, 1, 2, 4200000.00), (1, 3, 1, 280000.00),
(2, 2, 1, 3500000.00), (3, 5, 1, 1200000.00),
(4, 7, 3, 4500.00);

--Historial de detalles de pedidos
INSERT INTO historialdetallespedido(historial_id, detalle_pedido_id, producto_id, cantidad_anterior, cantidad_nueva, precio_anterior, precio_nuevo) VALUES(1, 1, 1, 2, 3, 4200000.00, 4100000.00),
(2, 2, 3, 1, 2, 280000.00, 280000.00), 
(3, 3, 2, 1, 1, 3500000.00, 3400000.00),
(4, 4, 5, 1, 1, 1200000.00, 1150000.00),
(5, 5, 7, 3, 5, 4500.00, 4400.00); 