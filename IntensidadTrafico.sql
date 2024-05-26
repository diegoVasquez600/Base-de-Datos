-- Eliminar la base de datos si existe
DROP DATABASE IF EXISTS intensidadtrafico;

-- Crear la base de datos llamada "IntensidadTrafico"
CREATE DATABASE IntensidadTrafico;

-- Conectar a la base de datos "IntensidadTrafico"
--\c IntensidadTrafico;

-- Crear tabla "Dias"
CREATE TABLE Dias (
    codigo_dia SERIAL PRIMARY KEY,
    dia VARCHAR(20)
);

-- Crear tabla "Meses"
CREATE TABLE Meses (
    codigo_mes SERIAL PRIMARY KEY,
    mes VARCHAR(20)
);

-- Crear tabla "Sentidos"
CREATE TABLE Sentidos (
    codigo_sentido SERIAL PRIMARY KEY,
    sentido VARCHAR(20)
);

-- Crear tabla "TipoSubSistema"
CREATE TABLE TipoSubSistema (
    codigo_tipo_sub_sistema SERIAL PRIMARY KEY,
    tipo_sub_sistema VARCHAR(20)
);

-- Crear tabla "TipoOperacion"
CREATE TABLE TipoOperacion (
    codigo_tipo_operacion SERIAL PRIMARY KEY,
    tipo_operacion VARCHAR(20)
);

CREATE TABLE Categorias(
    codigo_categoria SERIAL PRIMARY KEY,
    categoria VARCHAR(20)
);


-- Crear tabla "Corredores"
CREATE TABLE Corredores (
    codigo_corredor SERIAL PRIMARY KEY,
    nombre_corredor VARCHAR(50)
);

-- Crear tabla "Carriles"
CREATE TABLE Carriles (
    codigo_carril SERIAL PRIMARY KEY,
    nombre_carril VARCHAR(50)
);

-- Crear tabla "Comunas"
CREATE TABLE Comunas (
    codigo_comuna SERIAL PRIMARY KEY,
    numero_comuna INT,
    nombre_comuna VARCHAR(50)
);

-- Crear tabla "ComunasCarriles"
CREATE TABLE ComunasCarriles (
    codigo_comuna_carril SERIAL PRIMARY KEY,
    codigo_comuna INT,
    codigo_carril INT,
    FOREIGN KEY (codigo_comuna) REFERENCES Comunas(codigo_comuna),
    FOREIGN KEY (codigo_carril) REFERENCES Carriles(codigo_carril)
);

-- Crear tabla "Lecturas"
CREATE TABLE Lecturas (
    codigo_lectura SERIAL PRIMARY KEY,
    codigo_corredor INT,
    codigo_carril INT,
    codigo_dia INT,
    codigo_mes INT,
    codigo_sentido INT,
    codigo_tipo_sub_sistema INT,
    codigo_tipo_operacion INT,
    codigo_comuna INT,
    fecha VARCHAR(100),
    ano NUMERIC(4),
    hora INT,
    velocidad_km_h INT,
    intensidad INT,
    ocupacion INT,
    longitud VARCHAR(20),
    latitud VARCHAR(20),
    identificador_f_v BOOLEAN,
    FOREIGN KEY (codigo_dia) REFERENCES Dias(codigo_dia),
    FOREIGN KEY (codigo_mes) REFERENCES Meses(codigo_mes),
    FOREIGN KEY (codigo_sentido) REFERENCES Sentidos(codigo_sentido),
    FOREIGN KEY (codigo_tipo_sub_sistema) REFERENCES TipoSubSistema(codigo_tipo_sub_sistema),
    FOREIGN KEY (codigo_tipo_operacion) REFERENCES TipoOperacion(codigo_tipo_operacion),
    FOREIGN KEY (codigo_comuna) REFERENCES Comunas(codigo_comuna),
    FOREIGN KEY (codigo_corredor) REFERENCES Corredores(codigo_corredor),
    FOREIGN KEY (codigo_carril) REFERENCES Carriles(codigo_carril)
);

-- Crear tabla "LecturasCategoria"
CREATE TABLE LecturasCategoria (
    codigo_lectura_categoria SERIAL PRIMARY KEY,
    codigo_lectura INT,
    codigo_categoria INT,
    cantidad INT,
    FOREIGN KEY (codigo_lectura) REFERENCES Lecturas(codigo_lectura),
    FOREIGN KEY (codigo_categoria) REFERENCES Categorias(codigo_categoria)
);
