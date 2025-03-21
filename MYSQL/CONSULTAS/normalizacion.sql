--Crear una tabla HistorialPedidos que almacene cambios en los pedidos
--La tabla pedidos tendrá una relación 1:N con la tabla historialPedidos, además una relación N:N con la tabla detallespedido, por lo que se crea una tabla intermedia historialDetallesPedido.

CREATE TABLE IF NOT EXISTS historialPedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT,
    fechaCambio DATE,
    accion VARCHAR(50),
    comentario TEXT,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id)
)

CREATE TABLE IF NOT EXISTS historialDetallesPedido(
    id INT PRIMARY KEY AUTO_INCREMENT,
    historial_id INT,
    detalle_pedido_id INT,
    producto_id INT,
    cantidad_anterior INT,
    cantidad_nueva INT,
    precio_anterior DECIMAL(10, 2),
    precio_nuevo DECIMAL(10, 2),
    FOREIGN KEY (historial_id) REFERENCES historialPedidos(id),
    FOREIGN KEY (detalle_pedido_id) REFERENCES DetallesPedido(id),
    FOREIGN KEY (producto_id) REFERENCES Productos(id)
)