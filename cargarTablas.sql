-- Insertar valores únicos en las tablas de referencia
INSERT INTO Dias (dia)
VALUES 
    ('Lunes'),
    ('Martes'),
    ('Miércoles'),
    ('Jueves'),
    ('Viernes'),
    ('Sábado'),
    ('Domingo');

INSERT INTO Meses (mes)
VALUES 
    ('Enero'),
    ('Febrero'),
    ('Marzo'),
    ('Abril'),
    ('Mayo'),
    ('Junio'),
    ('Julio'),
    ('Agosto'),
    ('Septiembre'),
    ('Octubre'),
    ('Noviembre'),
    ('Diciembre');

INSERT INTO Categorias (categoria)
VALUES 
    ('Categoria 1'),
    ('Categoria 2'),
    ('Categoria 3');

INSERT INTO Sentidos (sentido)
SELECT DISTINCT sentido FROM public.velocidad_e_intensidad_vehicular_en_medellin;

INSERT INTO TipoSubSistema (tipo_sub_sistema)
SELECT DISTINCT tipo_subsistema FROM public.velocidad_e_intensidad_vehicular_en_medellin;

INSERT INTO TipoOperacion (tipo_operacion)
SELECT DISTINCT operacion FROM public.velocidad_e_intensidad_vehicular_en_medellin;


INSERT INTO Corredores (nombre_corredor)
SELECT DISTINCT corredor FROM public.velocidad_e_intensidad_vehicular_en_medellin;

INSERT INTO Carriles (nombre_carril)
SELECT DISTINCT carril FROM public.velocidad_e_intensidad_vehicular_en_medellin;

INSERT INTO Comunas (numero_comuna, nombre_comuna)
SELECT DISTINCT codigo_comuna, nombre_comuna FROM public.velocidad_e_intensidad_vehicular_en_medellin;

-- UPDATE public.velocidad_e_intensidad_vehicular_en_medellin veim
-- SET fecha = to_date(veim.dia_num || '/' || veim.mes_num || '/' || veim.ano, 'DD/MM/YYYY')
-- WHERE veim.fecha <> to_date(veim.dia_num || '/' || veim.mes_num || '/' || veim.ano, 'DD/MM/YYYY');

-- Insertar valores en la tabla "Lecturas"
INSERT INTO Lecturas (
    codigo_corredor, codigo_carril, codigo_dia, codigo_mes, codigo_sentido,
    codigo_tipo_sub_sistema, codigo_tipo_operacion, codigo_comuna, fecha, ano,
    hora, velocidad_km_h, intensidad, ocupacion, longitud, latitud, identificador_f_v
)
SELECT
    (SELECT codigo_corredor FROM Corredores WHERE nombre_corredor = veim.corredor),
    (SELECT codigo_carril FROM Carriles WHERE nombre_carril = veim.carril),
    (SELECT codigo_dia FROM Dias WHERE dia = veim.dia),
    (SELECT codigo_mes FROM Meses WHERE mes = veim.mes),
    (SELECT codigo_sentido FROM Sentidos WHERE sentido = veim.sentido),
    (SELECT codigo_tipo_sub_sistema FROM TipoSubSistema WHERE tipo_sub_sistema = veim.tipo_subsistema),
    (SELECT codigo_tipo_operacion FROM TipoOperacion WHERE tipo_operacion = veim.operacion),
    (SELECT codigo_comuna FROM Comunas WHERE numero_comuna = veim.codigo_comuna),
    veim.fecha::VARCHAR(100),
    veim.ano::NUMERIC(4),
    veim.hora::INT,
    veim.velocidad_km_h::INT,
    veim.intensidad::INT,
    veim.ocupacion::INT,
    veim.longitud::VARCHAR(20),
    veim.latitud::VARCHAR(20),
    CASE WHEN veim.identificador_f_v = 'V' THEN TRUE ELSE FALSE END
FROM public.velocidad_e_intensidad_vehicular_en_medellin veim;

-- Insertar valores en la tabla "LecturasCategoria" para cada categoría
INSERT INTO LecturasCategoria (codigo_lectura, codigo_categoria, cantidad)
SELECT
    l.codigo_lectura,
    (SELECT codigo_categoria FROM Categorias WHERE categoria = 'Categoria 1'),
    veim.categoria_1::INT
FROM public.velocidad_e_intensidad_vehicular_en_medellin veim
JOIN Lecturas l ON l.codigo_corredor = (SELECT codigo_corredor FROM Corredores WHERE nombre_corredor = veim.corredor)
                AND l.codigo_carril = (SELECT codigo_carril FROM Carriles WHERE nombre_carril = veim.carril)
                AND l.fecha = veim.fecha_trafico::DATE
                AND l.hora = veim.hora::TIME;

INSERT INTO LecturasCategoria (codigo_lectura, codigo_categoria, cantidad)
SELECT
    l.codigo_lectura,
    (SELECT codigo_categoria FROM Categorias WHERE categoria = 'Categoria 2'),
    veim.categoria_2::INT
FROM public.velocidad_e_intensidad_vehicular_en_medellin veim
JOIN Lecturas l ON l.codigo_corredor = (SELECT codigo_corredor FROM Corredores WHERE nombre_corredor = veim.corredor)
                AND l.codigo_carril = (SELECT codigo_carril FROM Carriles WHERE nombre_carril = veim.carril)
                AND l.fecha = veim.fecha_trafico::DATE
                AND l.hora = veim.hora::TIME
WHERE veim.categoria_2 IS NOT NULL;

INSERT INTO LecturasCategoria (codigo_lectura, codigo_categoria, cantidad)
SELECT
    l.codigo_lectura,
    (SELECT codigo_categoria FROM Categorias WHERE categoria = 'Categoria 3'),
    veim.categoria_3::INT
FROM public.velocidad_e_intensidad_vehicular_en_medellin veim
JOIN Lecturas l ON l.codigo_corredor = (SELECT codigo_corredor FROM Corredores WHERE nombre_corredor = veim.corredor)
                AND l.codigo_carril = (SELECT codigo_carril FROM Carriles WHERE nombre_carril = veim.carril)
                AND l.fecha = veim.fecha_trafico::DATE
                AND l.hora = veim.hora::TIME
WHERE veim.categoria_3 IS NOT NULL;

