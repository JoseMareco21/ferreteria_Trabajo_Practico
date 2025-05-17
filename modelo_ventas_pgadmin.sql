
-- Tabla: clientes
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    documento VARCHAR(20) UNIQUE,
    tipo_cliente VARCHAR(20) CHECK (tipo_cliente IN ('minorista', 'mayorista', 'crédito')),
    direccion VARCHAR(150),
    telefono VARCHAR(15)
);

-- Tabla: usuarios (vendedores)
CREATE TABLE usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    rol VARCHAR(20) CHECK (rol IN ('vendedor', 'admin')),
    usuario_login VARCHAR(50) UNIQUE NOT NULL,
    contraseña VARCHAR(100) NOT NULL
);

-- Tabla: productos
CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    precio_unitario NUMERIC(10,2) NOT NULL,
    stock INT DEFAULT 0
);

-- Tabla: ventas
CREATE TABLE ventas (
    id_venta SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES clientes(id_cliente),
    id_usuario INT REFERENCES usuarios(id_usuario),
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total NUMERIC(10,2) NOT NULL,
    estado VARCHAR(20) DEFAULT 'activa' CHECK (estado IN ('activa', 'anulada'))
);

-- Tabla: detalle_venta
CREATE TABLE detalle_venta (
    id_detalle SERIAL PRIMARY KEY,
    id_venta INT REFERENCES ventas(id_venta) ON DELETE CASCADE,
    id_producto INT REFERENCES productos(id_producto),
    cantidad INT NOT NULL,
    precio_unitario NUMERIC(10,2) NOT NULL,
    subtotal NUMERIC(10,2) NOT NULL
);

-- Tabla: pagos
CREATE TABLE pagos (
    id_pago SERIAL PRIMARY KEY,
    id_venta INT REFERENCES ventas(id_venta),
    forma_pago VARCHAR(20) CHECK (forma_pago IN ('efectivo', 'tarjeta', 'transferencia', 'crédito')),
    monto NUMERIC(10,2) NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
