CREATE DATABASE TiendaEcoDB;

USE TiendaEcoDB;

-- Table 1
CREATE TABLE clientes (
    Id_clientes INT PRIMARY KEY,
    nombre_cliente VARCHAR(200) NOT NULL,
    email_cliente VARCHAR(200) NOT NULL,
    direccion_cliente VARCHAR(200) NOT NULL
);

INSERT INTO clientes(Id_clientes, nombre_cliente, email_cliente, direccion_cliente)
VALUES (1, 'juan perez', 'juanperezoso@gmail.com', 'chalatenango');

INSERT INTO clientes(Id_clientes, nombre_cliente, email_cliente, direccion_cliente)
VALUES (2, 'jolyne kujo', 'yareyaredawa@gmail.com', '');

-- Table 2
CREATE TABLE categorias (
    Id_categoria INT PRIMARY KEY,
    nombre_categoria VARCHAR(200) NOT NULL
);
INSERT INTO categorias(Id_categoria, nombre_categoria)
VALUES (1, 'Articulos para el hogar');
-- Table 3
CREATE TABLE producto (
    Id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(200) NOT NULL,
    descripcion VARCHAR(1000) NOT NULL,
    precio DECIMAL(10,2),
    Id_categoria INT,
    FOREIGN KEY (Id_categoria) REFERENCES categorias(Id_categoria)
);
INSERT INTO producto(Id_producto, nombre_producto, descripcion, precio, Id_categoria)
VALUES (2, 'bowl de coco', 'bowl biodegradable hecho de estopa de coco', 3.50, 1 );


-- Table 4
CREATE TABLE pedidos (
    Id_pedidos INT PRIMARY KEY,
    Id_clientes INT,
    FOREIGN KEY (Id_clientes) REFERENCES clientes(Id_clientes)
);

-- Table 5
CREATE TABLE detalle_pedido (
    Id_detalle INT PRIMARY KEY,
    Id_pedidos INT,
    Id_producto INT,
    cantidad INT NOT NULL,
    precio_total DECIMAL(10,2),
    FOREIGN KEY (Id_pedidos) REFERENCES pedidos(Id_pedidos),
    FOREIGN KEY (Id_producto) REFERENCES producto(Id_producto)
);

SELECT * FROM producto
