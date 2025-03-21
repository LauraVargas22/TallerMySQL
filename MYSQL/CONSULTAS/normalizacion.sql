--1. Crear una tabla HistorialPedidos que almacene cambios en los pedidos
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

-- 2. Evaluar la tabla Clientes para eliminar datos redundantes y normalizar hasta 3NF.
-- Se eliminó el atributo nombre, ya que es un valor atómico y se crearon atributos separados para el primer y segundo nombre, así como para el primer y segundo apellido.
--Con esto se evita la redundancia de datos y se normaliza la tabla hasta la tercera forma normal.
ALTER TABLE clientes DROP COLUMN nombre;
ALTER TABLE clientes ADD COLUMN primer_nombre VARCHAR(50);
ALTER TABLE clientes ADD COLUMN segundo_nombre VARCHAR(50) NULL;
ALTER TABLE clientes ADD COLUMN primer_apellido VARCHAR(50);
ALTER TABLE clientes ADD COLUMN segundo_apellido VARCHAR(50) NULL;

-- 3. Separar la tabla Empleados en una tabla de DatosEmpleados y otra para Puestos .
--Eliminamos los datos de la tabla principal empleados
ALTER TABLE empleados DROP COLUMN puesto;
ALTER TABLE empleados DROP COLUMN fecha_contratacion;
ALTER TABLE empleados DROP COLUMN salario;
ALTER TABLE empleados ADD COLUMN apellido VARCHAR(50);

--Creamos la tabla de puestos
CREATE TABLE IF NOT EXISTS Puestos(
    id INT PRIMARY KEY AUTO_INCREMENT,
    puesto VARCHAR(50)
)

--Creamos la tabla de datos empleados
CREATE TABLE IF NOT EXISTS DatosEmpleado(
    id INT PRIMARY KEY AUTO_INCREMENT,
    empleado_id INT,
    puesto_id INT,
    salario DECIMAL(10, 2),
    fecha_contratacion DATE,
    FOREIGN KEY (empleado_id) REFERENCES Empleados(id),
    FOREIGN KEY (puesto_id) REFERENCES Puestos(id)
)

-- 4. Revisar la relación Clientes y UbicacionCliente para evitar duplicación de datos.
--Se eliminaron los atributos ciudad, estado y país de ubicación cliente creando tablas para cada uno de ellos.
ALTER TABLE UbicacionCliente DROP COLUMN ciudad;
ALTER TABLE ubicacioncliente DROP COLUMN estado;
ALTER TABLE ubicacioncliente DROP COLUMN pais;

CREATE TABLE IF NOT EXISTS Pais(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    codigo_iso VARCHAR(10) UNIQUE
)

CREATE TABLE IF NOT EXISTS estado(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    pais_id INT,
    FOREIGN KEY (pais_id) REFERENCES Pais(id)
)

CREATE TABLE IF NOT EXISTS ciudad(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    estado_id INT,
    FOREIGN KEY (estado_id) REFERENCES Estado(id)
)

ALTER TABLE ubicacioncliente ADD COLUMN ciudad_id INT;
ALTER TABLE ubicacioncliente ADD FOREIGN KEY (ciudad_id) REFERENCES ciudad(id);
