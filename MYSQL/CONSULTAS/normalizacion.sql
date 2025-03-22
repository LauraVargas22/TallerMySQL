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

-- 2. Evaluar la tabla Clientes para eliminar datos redundantes y normalizar hasta 3NF.
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

-- 5. Normalizar Proveedores para tener ContactoProveedores en otra tabla.
-- Se elimina el atributo contacto de la tabla proveedores y se crea la tabla ContactoProveedores.
ALTER TABLE proveedores DROP COLUMN telefono;

CREATE TABLE IF NOT EXISTS ContactoProveedor(
    id INT PRIMARY KEY AUTO_INCREMENT,
    proveedor_id INT,
    contacto VARCHAR(100),
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id)
)

--Se normaliza el nombre del proveedor
ALTER TABLE Proveedores DROP COLUMN nombre;
ALTER TABLE Proveedores ADD COLUMN nombre VARCHAR(50);
ALTER TABLE Proveedores ADD COLUMN apellido VARCHAR(50);

--6. Crear una tabla de Telefonos para almacenar múltiples números por cliente

CREATE TABLE IF NOT EXISTS Telefonos(
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    telefono VARCHAR(20),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
)

--7. Transformar TiposProductos en una relación categórica jerárquica
--Una relación categórica jerárquica me permite definir la relación padre-hijo entre los tipos de productos.

ALTER TABLE TiposProductos ADD COLUMN categoria_padre_id INT NULL;
ALTER TABLE TiposProductos ADD FOREIGN KEY (categoria_padre_id) REFERENCES TiposProductos(id);

--8. Normalizar Pedidos y DetallesPedido para evitar inconsistencias de precios.
--El atributo total en Pedidos puede tener inconsistencias por lo que este podira ser calculado a partir de los detalles de pedido.
ALTER TABLE Pedidos DROP COLUMN total;

ALTER TABLE proveedores DROP COLUMN direccion;

--9. Usar una relación de muchos a muchos para Empleados y Proveedores .
--Al tener una relación de michos a muchos se crea una tabla intermedia EmpleadosProveedores que las relacione.

CREATE TABLE IF NOT EXISTS EmpleadosProveedores(
    id INT PRIMARY KEY AUTO_INCREMENT,
    empleado_id INT,
    proveedor_id INT,
    FOREIGN KEY (empleado_id) REFERENCES Empleados(id),
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id)
)

--10. Convertir la tabla UbicacionCliente en una relación genérica de Ubicaciones.
--Se crea una tabla de ubicaciones que almacene las ubicaciones de los clientes, empleados y proveedores.

CREATE TABLE IF NOT EXISTS Ubicaciones(
    id INT PRIMARY KEY AUTO_INCREMENT,
    direccion VARCHAR(255),
    ciudad_id INT,
    codigo_postal VARCHAR(10),
    FOREIGN KEY (ciudad_id) REFERENCES ciudad(id)
)

DROP TABLE UbicacionCliente;

--Crear tabla para proveedor
CREATE TABLE IF NOT EXISTS proveedorUbicacion(
    proveedor_id INT,
    ubicacion_id INT,
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id),
    FOREIGN KEY (ubicacion_id) REFERENCES Ubicaciones(id)
)

--Crear tabla para empleados
CREATE TABLE IF NOT EXISTS empleadoUbicacion(
    empleado_id INT,
    ubicacion_id INT,
    FOREIGN KEY (empleado_id) REFERENCES Empleados(id),
    FOREIGN KEY (ubicacion_id) REFERENCES Ubicaciones(id)
)

--Crear tabla para clientes
CREATE TABLE IF NOT EXISTS clienteUbicacion(
    cliente_id INT,
    ubicacion_id INT,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id),
    FOREIGN KEY (ubicacion_id) REFERENCES Ubicaciones(id)
)
