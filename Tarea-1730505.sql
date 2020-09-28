/*
1.- Consultar los registro de la tabla COUNTRIES uniendo con la tabla REGIONS.
     uniendo con la tabla REGIONS.
     Proyección: COUNTRY_NAME, REGION_NAME.
     NOTA: Usar NATURAL JOIN, JOIN CON USING Y JOIN CON ON.
*/
SELECT COUNTRY_NAME ,REGION_NAME
  FROM COUNTRIES NATURAL JOIN REGIONS;
  
  
 
 SELECT COUNTRY_NAME ,REGION_NAME 
 FROM COUNTRIES 
 JOIN REGIONS USING (REGION_ID);
 
 
 
 SELECT  COUNTRY_NAME ,REGION_NAME
FROM COUNTRIES c JOIN REGIONS r ON (c.REGION_ID = r.REGION_ID);

/*
2.- Consultar los registros de la union de la tabla LOCATIONS con COUNTRIES.
     Proyección: STREET_ADDRESS, POSTAL_CODE, CITY. STATE_PROVINCE.
     COUNTRY_NAME..
    NOTA: Usar NATURAL JOIN, JOIN CON USING Y JOIN CON ON.
*/

SELECT STREET_ADDRESS ,POSTAL_CODE ,STATE_PROVINCE ,COUNTRY_NAME
  FROM LOCATIONS NATURAL JOIN COUNTRIES;
   
 
 
SELECT  STREET_ADDRESS ,POSTAL_CODE,STATE_PROVINCE ,COUNTRY_NAME
FROM LOCATIONS lo JOIN COUNTRIES co ON (lo.COUNTRY_ID = co.COUNTRY_ID);
/*
3.- Consultar los DEPARTMENTS y su MANAGER (EMPLOYEES table),
      Proyección: DEPARTMENT_NAME, FULL_ NAME del manager (concatenar)
      Seleccion: Solo los departaments que tenga manager.
*/
SELECT DEPARTMENT_NAME, FIRST_NAME ||' '|| LAST_NAME  FULL_NAME ,DEPARTMENTS.MANAGER_ID ,EMPLOYEES.MANAGER_ID EMPLOYEES_MANAGER_ID
  FROM DEPARTMENTS CROSS JOIN EMPLOYEES
  WHERE DEPARTMENTS.MANAGER_ID IS NOT NULL;