-- Creación de la base de datos
CREATE DATABASE vtaszfs;
USE vtaszfs;
-- Tabla Clientes
CREATE TABLE IF NOT EXISTS Clientes (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100),
email VARCHAR(100) UNIQUE
);
-- Tabla UbicacionCliente
CREATE TABLE IF NOT EXISTS UbicacionCliente (
id INT PRIMARY KEY AUTO_INCREMENT,
cliente_id INT,
direccion VARCHAR(255),
ciudad VARCHAR(100),
estado VARCHAR(50),
codigo_postal VARCHAR(10),
pais VARCHAR(50),
FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);
-- Tabla Empleados
CREATE TABLE IF NOT EXISTS Empleados (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100),
puesto VARCHAR(50),
salario DECIMAL(10, 2),
fecha_contratacion DATE
);
-- Tabla Proveedores
CREATE TABLE IF NOT EXISTS Proveedores (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100),
contacto VARCHAR(100),
telefono VARCHAR(20),
direccion VARCHAR(255)
);
-- Tabla TiposProductos
CREATE TABLE IF NOT EXISTS TiposProductos (
id INT PRIMARY KEY AUTO_INCREMENT,
tipo_nombre VARCHAR(100),
descripcion TEXT
);
-- Tabla Productos
CREATE TABLE IF NOT EXISTS Productos (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100),
precio DECIMAL(10, 2),
proveedor_id INT,
tipo_id INT,
FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id),
FOREIGN KEY (tipo_id) REFERENCES TiposProductos(id)
);
-- Tabla Pedidos
CREATE TABLE IF NOT EXISTS Pedidos (
id INT PRIMARY KEY AUTO_INCREMENT,
cliente_id INT,
fecha DATE,
total DECIMAL(10, 2),
FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);
-- Tabla DetallesPedido
CREATE TABLE IF NOT EXISTS DetallesPedido (
id INT PRIMARY KEY AUTO_INCREMENT,
pedido_id INT,
producto_id INT,
cantidad INT,
precio DECIMAL(10, 2),
FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
FOREIGN KEY (producto_id) REFERENCES Productos(id)
);