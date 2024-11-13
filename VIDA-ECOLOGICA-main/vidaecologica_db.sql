-- Crear de la base de datos
CREATE DATABASE vidaecologica_db;
USE vidaecologica_db;

-- Tabla de Categorías
CREATE TABLE categoria (
    categoria_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    parent_category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_category_id) REFERENCES categoria(categoria_id)
);



-- Tabla de Marcas
CREATE TABLE marca (
    marca_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    pais_de_origen VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Tabla de Productos
CREATE TABLE producto (
    producto_id INT PRIMARY KEY AUTO_INCREMENT,
    sku VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    categoria_id INT NOT NULL,
    marca_id INT NOT NULL,
    precio_base DECIMAL(10,2) NOT NULL,
    precio_actual DECIMAL(10,2) NOT NULL,
    genero ENUM('M', 'F', 'U') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id),
    FOREIGN KEY (marca_id) REFERENCES marca(marca_id)
    );


-- Tabla de Variantes de Producto (Combinación de producto, talla y color)
CREATE TABLE variante_producto (
    variante_id INT PRIMARY KEY AUTO_INCREMENT,
    producto_id INT NOT NULL,
    sku_variant VARCHAR(50) UNIQUE NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    min_stock_level INT NOT NULL DEFAULT 5,
    max_stock_level INT NOT NULL DEFAULT 100,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (producto_id) REFERENCES producto(producto_id)
);

-- Tabla de Historial de Inventario
CREATE TABLE historial_inventario (
    historial_id INT PRIMARY KEY AUTO_INCREMENT,
    variante_id INT NOT NULL,
    tipo_transaccion ENUM('entrada', 'salida', 'ajuste') NOT NULL,
    cantidad INT NOT NULL,
    cantidad_previa INT NOT NULL,
    nueva_cantidad INT NOT NULL,
    razon VARCHAR(255),
    fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    creado_por VARCHAR(50) NOT NULL,
    FOREIGN KEY (variante_id) REFERENCES variante_producto(variante_id)
);

-- Tabla de Predicción de Demanda
CREATE TABLE prediccion_demanda (
    prediccion_id INT PRIMARY KEY AUTO_INCREMENT,
    variante_id INT NOT NULL,
    predicccion_demand INT NOT NULL,
    nivel_certeza DECIMAL(5,2),
    fecha_preddiccion DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (variante_id) REFERENCES variante_producto(variante_id)
);

-- Tabla de Ventas
CREATE TABLE venta (
    venta_id INT PRIMARY KEY AUTO_INCREMENT,
    variante_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    monto_total DECIMAL(10,2) NOT NULL,
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    channel VARCHAR(50) NOT NULL,
    FOREIGN KEY (variante_id) REFERENCES variante_producto(variante_id)
);

-- Tabla de Proveedores
CREATE TABLE proveedores (
    proveedor_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_proveedor VARCHAR(100) NOT NULL,
    persona_contacto VARCHAR(100),
    email VARCHAR(100),
    telefono INT NOT NULL,
    direccion TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla de ordenes de Compra a proveedores
CREATE TABLE orden_compra (
    orden_id INT PRIMARY KEY AUTO_INCREMENT,
    proveedor_id INT NOT NULL,
    orden_fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estimado_entrega DATE,
    status ENUM('pendiente', 'enviada', 'recibida', 'cancelada') NOT NULL DEFAULT 'pendiente',
    precio_final DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(proveedor_id)
);

-- Tabla de Detalles de ordenes de Compra
CREATE TABLE detalles_compra (
    detalles_id INT PRIMARY KEY AUTO_INCREMENT,
    orden_id INT NOT NULL,
    variante_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    precio_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (orden_id) REFERENCES orden_compra(orden_id),
    FOREIGN KEY (variante_id) REFERENCES variante_producto(variante_id)
);

-- indices para optimizar consultas frecuentes
CREATE INDEX idx_product_category ON producto(categoria_id);
CREATE INDEX idx_variant_product ON variante_producto(producto_id);
CREATE INDEX idx_sales_date ON ventas(fecha_venta);
CREATE INDEX idx_inventory_history_date ON historial_inventario(fecha_transaccion);
CREATE INDEX idx_demand_predictions_date ON prediccion_demanda(fecha_prediccion);

select * from tables categoria
