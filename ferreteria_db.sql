CREATE TABLE empresa (
    id_emp SERIAL PRIMARY KEY,
    des_emp VARCHAR(255)
);

CREATE TABLE sucursal (
    id_suc SERIAL PRIMARY KEY,
    direc_suc VARCHAR(255) UNIQUE,
    desc_suc VARCHAR(255) UNIQUE,
    email_suc VARCHAR(255) UNIQUE,
    num_tel_suc INTEGER,
    fecha_de_apertur_suc DATE,
    hora_de_apertura_suc TIMESTAMP,
    id_emp INTEGER,
    FOREIGN KEY (id_emp) REFERENCES empresa(id_emp) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE horario_de_caja (
    id_horario_de_caja SERIAL PRIMARY KEY,
    apertura_caja TIMESTAMP,
    cierre_de_caja TIMESTAMP
);

CREATE TABLE cajero (
    id_cajero SERIAL PRIMARY KEY,
    nom_cajero VARCHAR(255),
    apell_cajero VARCHAR(255),
    ci_cajero INTEGER,
    email_cajero VARCHAR(255),
    id_horario_de_caja INTEGER,
    FOREIGN KEY (id_horario_de_caja) REFERENCES horario_de_caja(id_horario_de_caja) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE empleado (
    id_emple SERIAL PRIMARY KEY,
    nom_emple VARCHAR(255),
    apell_emple VARCHAR(255),
    ci_emple INTEGER,
    num_emple INTEGER,
    emial_emple VARCHAR(255),
    fecha_de_ingreso_emple DATE,
    cargo_emple VARCHAR(255),
    id_suc INTEGER,
    id_cajero INTEGER,
    FOREIGN KEY (id_suc) REFERENCES sucursal(id_suc) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_cajero) REFERENCES cajero(id_cajero) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE item (
    id_item SERIAL PRIMARY KEY,
    desc_item VARCHAR(255),
    prec_item DECIMAL(10,2)
);

CREATE TABLE stock (
    id_stock SERIAL PRIMARY KEY,
    id_item INTEGER,
    cant_stock INTEGER,
    id_suc INTEGER,
    FOREIGN KEY (id_item) REFERENCES item(id_item) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_suc) REFERENCES sucursal(id_suc) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nom_cliente VARCHAR(255),
    apelli_cliente VARCHAR(255),
    ci_cliente INTEGER,
    ruc_cliente INTEGER NOT NULL,
    tel_cliente INTEGER,
    estado_cliente VARCHAR(100)
);

CREATE TABLE pedido_venta_cab (
    id_pedido_venta_cab SERIAL PRIMARY KEY,
    num_pedido INTEGER,
    fecha_pedido DATE
);

CREATE TABLE pedido_venta_det (
    id_pedido_venta_det SERIAL PRIMARY KEY,
    desc_pedido VARCHAR(255),
    precio_pedido INTEGER,
    cant_solicitada INTEGER,
    id_pedido_venta_cab INTEGER,
    id_stock INTEGER,
    id_cliente INTEGER,
    FOREIGN KEY (id_pedido_venta_cab) REFERENCES pedido_venta_cab(id_pedido_venta_cab) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_stock) REFERENCES stock(id_stock) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE NO ACTION ON UPDATE NO ACTION
);