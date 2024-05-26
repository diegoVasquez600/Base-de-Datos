import psycopg2
import pandas as pd
from sqlalchemy import create_engine
# Create Connection to Postgres
connection = psycopg2.connect(dbname="intensidadtrafico", user="postgres", password="Diego123*", host="localhost")

# Create Temporal table in Postgres
cur = connection.cursor()
cur.execute(''' 
CREATE TABLE IF NOT EXISTS velocidad_e_intensidad_vehicular_en_medellin (
    carril VARCHAR(200),
    fecha_trafico VARCHAR(200),
    fecha VARCHAR(200),
    hora VARCHAR(20),
    dia VARCHAR(20),
    dia_num VARCHAR(20),
    mes_num VARCHAR(20),
    mes VARCHAR(20),
    ano VARCHAR(20),
    velocidad_km_h VARCHAR(20),
    corredor VARCHAR(200),
    sentido VARCHAR(10),
    operacion VARCHAR(50),
    intensidad VARCHAR(20),
    categoria_1 VARCHAR(20),
    categoria_2 VARCHAR(20),
    categoria_3 VARCHAR(20),
    ocupacion VARCHAR(20),
    tipo_subsistema VARCHAR(100),
    longitud VARCHAR(20),
    latitud VARCHAR(20),
    identificador_f_v VARCHAR(100),
    comuna VARCHAR(100),
    codigo_comuna VARCHAR(20),
    nombre_comuna VARCHAR(100)
);
''')
connection.commit()
#Load and read csv using pandas
data = pd.read_csv('data/velocidad_e_intensidad_vehicular_en_medellin.csv')
print(data.head(20))

# Create the Engine
engine = create_engine('postgresql+psycopg2://postgres:Diego123*@localhost/intensidadtrafico')
# Load data in temporal table in postgres
data.to_sql('velocidad_e_intensidad_vehicular_en_medellin', engine, if_exists='replace', index=False)

connection.close()


# Load csv data to python
# with open('data/velocidad_e_intensidad_vehicular_en_medellin.csv', 'r') as file:
#     reader = csv.reader(file)
#     cur.copy_from(reader, 'velocidad_e_intensidad_vehicular_en_medellin', sep=',')
#     next(file)
#     cur = connection.cursor()
#     connection.commit()
#     cur.close()
#     connection.close()