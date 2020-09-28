--------------------------------------------------------------- CREACION DE LAS TABLAS ------------------------------------------------------------------------------
DROP TABLE USUARIOS;
CREATE TABLE USUARIOS(
ID_USUARIO NUMBER(16) NOT NULL PRIMARY KEY
,NOMBRE VARCHAR2(64) NOT NULL
,APELLIDO_PATERNO VARCHAR2(64) NOT NULL
,APELLIDO_MATERNO VARCHAR2(64) NOT NULL
,FECHA_NACIMIENTO DATE NOT NULL
,DOMICILIO VARCHAR2 (64) NOT NULL
,EMAIL VARCHAR2 (64) NOT NULL
,FECHA_REGISTRO DATE NOT NULL
,CONTRASE�A VARCHAR2 (64) NOT NULL
,SEXO VARCHAR2(2) NOT NULL
);

DROP TABLE ESTABLECIMIENTOS;
CREATE TABLE ESTABLECIMIENTOS(
ID_ESTABLECIMIENTO NUMBER(16) NOT NULL PRIMARY KEY
,NOMBRE_SUCURSAL VARCHAR2 (30) NOT NULL
,CIUDAD VARCHAR2(64) NOT NULL
);

DROP TABLE EMPLEADOS;
CREATE TABLE EMPLEADOS(
ID_EMPLEADO NUMBER (6) NOT NULL PRIMARY KEY
,ID_ESTABLECIMIENTO NUMBER (6) NOT NULL
,NOMBRE VARCHAR2(24) NOT NULL 
,APELLIDO_PATERNO VARCHAR2(64) NOT NULL
,APELLIDO_MATERNO VARCHAR2(64) NOT NULL
,FECHA_NACIMIENTO DATE NOT NULL
,EMAIL VARCHAR2 (128) NOT NULL
,CONTRASE�A VARCHAR2 (24) NOT NULL
,TELEFONO NUMBER(13) 
,FECHA_CONTRATACION DATE NOT NULL
,FECHA_FIN_TRABAJO DATE NOT NULL
,CONSTRAINT EMPLEADO_DEPARTAMENTO_FK FOREIGN KEY (ID_ESTABLECIMIENTO) REFERENCES ESTABLECIMIENTOS
,SEXO VARCHAR2(2) NOT NULL
);

DROP TABLE INVENTARIO;
CREATE TABLE INVENTARIO(
ID_VEHICULO NUMBER(5) NOT NULL PRIMARY KEY
,ID_ESTABLECIMIENTO NUMBER (6) NOT NULL
,MARCA VARCHAR2(64) NOT NULL
,MODELO VARCHAR2(128) NOT NULL
,A�O NUMBER(4) NOT NULL
,COLOR VARCHAR2(64) NOT NULL
,CANTIDAD_PASAJEROS VARCHAR2(128) NOT NULL
,RENDIMIENTO_GASOLINA NUMBER (6) NOT NULL
,KILOMETRAJE_ACTUAL NUMBER (6) NOT NULL
,KILOMETRAJE_PROMEDIO NUMBER (6) NOT NULL
,CONSTRAINT INVENTARIO_ESTABLECIMIENTO_FK FOREIGN KEY (ID_ESTABLECIMIENTO) REFERENCES ESTABLECIMIENTOS
,FECHA_ADQUISICION DATE NOT NULL
); 

DROP TABLE CAMBIOS;
CREATE TABLE CAMBIOS(
ID_CAMBIO NUMBER(5) NOT NULL PRIMARY KEY
,ID_EMPLEADO NUMBER(5) NOT NULL
,ID_ESTABLECIMIENTO NUMBER(10) NOT NULL
,PUESTO VARCHAR2(64) NOT NULL
,CONSTRAINT ID_CAMBIO_EMPLEADOS_FK FOREIGN KEY (ID_EMPLEADO) REFERENCES EMPLEADOS
,CONSTRAINT ID_CAMBIOS_ESTABLECIMIENTO_FK FOREIGN KEY (ID_ESTABLECIMIENTO) REFERENCES ESTABLECIMIENTOS
);

DROP TABLE APARTADOS;
CREATE TABLE APARTADOS(
ID_APARTADO NUMBER(6) NOT NULL PRIMARY KEY
,FECHA_APARTADO DATE NOT NULL
,ID_CLIENTE NUMBER(5) NOT NULL
,ID_VEHICULO NUMBER(6) NOT NULL
,STATUS_APARTADO VARCHAR2(64) NOT NULL
,ID_SUCURSAL NUMBER(6) NOT NULL
,CONSTRAINT ID_APARTADOS_USUARIOS_FK FOREIGN KEY (ID_CLIENTE) REFERENCES USUARIOS
,CONSTRAINT ID_APARTADOS_VEHICULO_FK FOREIGN KEY (ID_VEHICULO) REFERENCES INVENTARIO
,CONSTRAINT ID_APARTADOS_SUCURSAL_FK FOREIGN KEY (ID_SUCURSAL) REFERENCES ESTABLECIMIENTOS
);

DROP TABLE RENTAS;
CREATE TABLE RENTAS(
ID_RENTA NUMBER (5) NOT NULL PRIMARY KEY
,FECHA_ENTREGA DATE  NOT NULL
,ID_APARTADO NUMBER (5) NOT NULL
,ID_CLIENTE NUMBER (5) NOT NULL
,KM_SALIDA_VEHICULO NUMBER (6) NOT NULL
,FECHA_RENTA DATE NOT NULL
,CONSTRAINT ID_RENTAS_USUARIOS_FK FOREIGN KEY (ID_CLIENTE) REFERENCES USUARIOS
,CONSTRAINT ID_RENTASS_APARTADOS_FK FOREIGN KEY (ID_APARTADO) REFERENCES APARTADOS
);

DROP TABLE RETORNO_VEHICULO;
CREATE TABLE RETORNO_VEHICULO(
ID_RENTA NUMBER (5) NOT NULL PRIMARY KEY
,FECHA_ENTREGA DATE NULL
,HORA_ENTREGA DATE NOT NULL
,DIAS_RETRASO VARCHAR2(2) NOT NULL
,HORAS_RETRASO NUMBER(2) NOT NULL
,KM_ENTREGA NUMBER(24) NOT NULL
,CONSTRAINT ID_RETORNO_RENTAS_FK FOREIGN KEY (ID_RENTA) REFERENCES RENTAS
);

---------------------------------------------------------- INSERTAR DATOS ------------------------------------------
INSERT INTO USUARIOS 
    VALUES (1, 'PEDRO', 'DE LEON', 'REYES','19/01/1998', '24 CARRERA', '1810015@hotmail.com', '19/08/2019', '1810015', 'M');  
INSERT INTO USUARIOS 
    VALUES (2, 'DANIEL', 'LUNA', 'CARANZA','20/06/1999', '24 PAZ', '173015@hotmail.com', '19/07/2019', 'LUNA', 'M');
INSERT INTO USUARIOS 
    VALUES (3, 'DANIEL', 'TORRES', 'CARANZA','14/02/1997', '15 BRAVO', '173425@hotmail.com', '01/05/2019', 'TORRES', 'M');

INSERT INTO ESTABLECIMIENTOS
    VALUES (4, 'EMPRESA CV', 'CIUDAD VICTORIA');
INSERT INTO ESTABLECIMIENTOS
    VALUES (1, 'EMPRESA TAMPICO', 'TAMPICO');

INSERT INTO INVENTARIO 
    VALUES (1, 4, 'FORD', 'FIESTA','2019', 'ROJO', 5, 10.58, 2323, 2000, '18/07/2019');
INSERT INTO INVENTARIO 
    VALUES (2, 1, 'NISSAN', 'SENTRA','2005', 'NEGRO', 5, 18.54, 2234, 9999, '02/12/2006');
INSERT INTO INVENTARIO 
    VALUES (3, 4, 'CHEVROLET', 'SPARK','2012', 'VERDE', 5, 9.43, 12999, 9999, '02/12/2006');

INSERT INTO RENTAS
    VALUES (1, '19/07/2019', 1, 1,  '1000', '17/07/2019');
INSERT INTO RENTAS
    VALUES (2, '19/08/2019', 2, 2,  '1500', '20/08/2019');

INSERT INTO APARTADOS 
    VALUES (1, '17/07/2019', 1, 1, 'ACTIVO', 4);
INSERT INTO APARTADOS 
    VALUES (2, '18/08/2019', 2, 2, 'ACTIVO', 4);
INSERT INTO APARTADOS 
    VALUES (3, '18/08/2019', 1, 3, 'ACTIVO', 1);

----------------------------------- CONSULTAS -----------------------------------------------------------------------
-- Vehiculos asignados a X sucursal
-- Columnas: Nombre de la Marca, Modelo, A�o del Modelo, Kilometraje actual.
SELECT I.MARCA, I.MODELO, I.A�O, I.KILOMETRAJE_ACTUAL
FROM INVENTARIO I INNER JOIN ESTABLECIMIENTOS E ON I.ID_ESTABLECIMIENTO = E.ID_ESTABLECIMIENTO
WHERE E.NOMBRE_SUCURSAL = 'EMPRESA CV';

-- Vehiculos de X municipio. (Consulta seg�n el identificador del mpio).
--Columnas: Nombre de la Marca, Modelo, A�o del Modelo, Kilometraje actual, Nombre de la Sucursal.
SELECT I.MARCA, I.MODELO, I.A�O, I.KILOMETRAJE_ACTUAL, E.NOMBRE_SUCURSAL
FROM INVENTARIO I INNER JOIN ESTABLECIMIENTOS E ON E.ID_ESTABLECIMIENTO = I.ID_ESTABLECIMIENTO
WHERE E.CIUDAD = 'CIUDAD VICTORIA';

-- Vehiculos que tienen un kilometraje mayor del promedio
--   Columnas: Nombre de la Marca, Modelo, A�o del Modelo, Kilometraje actual, Nombre de la Sucursal. 
SELECT I.MARCA, I.MODELO, I.A�O, I.KILOMETRAJE_ACTUAL, E.NOMBRE_SUCURSAL
FROM INVENTARIO I INNER JOIN ESTABLECIMIENTOS E ON E.ID_ESTABLECIMIENTO = I.ID_ESTABLECIMIENTO
WHERE I.KILOMETRAJE_PROMEDIO > I.KILOMETRAJE_ACTUAL;
                                                                                              
-- Todos los clientes y cuantos carros ha rentado
-- Columnas: Nombre Completo del Cliente, Cantidad de Veh�culos Rentados.
SELECT NOMBRE || ' ' || APELLIDO_PATERNO || ' '|| APELLIDO_MATERNO AS "NOMBRE COMPLETO", 
    (SELECT COUNT (ID_RENTA)
        FROM RENTAS) AS "CANTIDAD VEHICULOS RENTADOS"
FROM USUARIOS;

-- Todos los clientes, cu�ntos carros ha rentado, cuantos ha regresado a destiempo.
-- Columnas: Nombre Completo del Cliente, Cantidad de Veh�culos Rentados, Cantidad de Veh�culos regresados a destiempo.
SELECT NOMBRE || ' ' || APELLIDO_PATERNO || ' '|| APELLIDO_MATERNO AS "NOMBRE COMPLETO", 
    (SELECT COUNT (ID_RENTA)
        FROM RENTAS) AS "CANTIDAD VEHICULOS RENTADOS", (SELECT COUNT (ID_RENTA)
                                                            FROM RETORNO_VEHICULO
                                                                WHERE DIAS_RETRASO <> 0) AS "CANTIDAD VEHICULOS REGRESADOS A DESTIEMPO"
FROM USUARIOS;

-- Todos los empleados y cu�ntos veh�culos ha concretado la renta, en un rango de fechas especificado.
-- Columnas: Nombre completo del empleado, Nombre del Departamento en el que est�, Nombre del Municipio del Departamento, Cantidad de carros que ha concretado la renta.
SELECT EM.NOMBRE || ' ' || EM.APELLIDO_PATERNO || ' '|| EM.APELLIDO_MATERNO AS "NOMBRE COMPLETO", EST.NOMBRE_SUCURSAL AS "NOMBRE DEPARTAMENTO" , EST.CIUDAD
    , (SELECT COUNT (ID_RENTA)
        FROM RENTAS
            WHERE FECHA_ENTREGA BETWEEN '20/07/2019' AND '20/08/2019') AS "CANTIDAD DE CARROS QUE HA CONCRETADO LA RENTA"
        FROM EMPLEADOS EM INNER JOIN ESTABLECIMIENTOS EST ON EM.ID_ESTABLECIMIENTO = EST.ID_ESTABLECIMIENTO;