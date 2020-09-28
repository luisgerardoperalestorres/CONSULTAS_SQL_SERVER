
SELECT
         D.DEPARTMENT_ID
        ,D.DEPARTMENT_NAME
        ,(SELECT COUNT(*) 
            FROM EMPLOYEES E 
            WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) CANT_EMPLOYEES
        ,(SELECT NVL(SUM(SALARY), 0)
            FROM EMPLOYEES E
            WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) SALARY_PA
    FROM DEPARTMENTS D;
    
SELECT  
         L.LOCATION_ID
        ,L.CITY
        ,L.STREET_ADDRESS
        ,(SELECT COUNT(*)
            FROM DEPARTMENTS D 
            WHERE D.LOCATION_ID = L.LOCATION_ID) CANT_DEPTS
        ,(SELECT COUNT(*)
            FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
            WHERE D.LOCATION_ID = L.LOCATION_ID) CANT_EMPLOYEES    
    FROM LOCATIONS L;
    
SELECT COUNT(*)
    FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE D.LOCATION_ID = 1400;
    

SELECT *
    FROM 
        EMPLOYEES E 
        JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
    WHERE L.COUNTRY_ID = 'UK';    
    
SELECT 
         C.COUNTRY_ID
        ,C.COUNTRY_NAME
        ,(SELECT COUNT(*)
            FROM 
                EMPLOYEES E 
                JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
            WHERE L.COUNTRY_ID = C.COUNTRY_ID)
         CANT_EMPLOYEES    
    FROM COUNTRIES C
    ORDER BY CANT_EMPLOYEES;

SELECT *
    FROM
        (SELECT 
                 C.COUNTRY_ID
                ,C.COUNTRY_NAME
                ,(SELECT COUNT(*)
                    FROM 
                        EMPLOYEES E 
                        JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                        JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
                    WHERE L.COUNTRY_ID = C.COUNTRY_ID)
                 CANT_EMPLOYEES    
            FROM COUNTRIES C) T1
    WHERE T1.CANT_EMPLOYEES > 0
    ORDER BY T1.CANT_EMPLOYEES;

-- En una consulta obtener todas las regiones y cuantos departamentos
-- hay en cada region.
-- Columnas: region_name, cant_departments
SELECT
         REGION_NAME
        ,(SELECT COUNT(*)
            FROM 
                DEPARTMENTS D JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
                JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
            WHERE C.REGION_ID = R.REGION_ID) CANT_DEPTS
    FROM REGIONS R;    

SELECT 
         R.REGION_NAME
        ,COUNT(*) CANT_DEPTS
    FROM 
        DEPARTMENTS D JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
        JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
        JOIN REGIONS R ON C.REGION_ID = R.REGION_ID
    GROUP BY R.REGION_NAME; 
    
    
SELECT    
         R.REGION_NAME
        ,NVL(T1.CANT_DEPTS, 0) CANT_DEPARTMENTS
    FROM    
        (SELECT 
                 C.REGION_ID
                ,COUNT(*) CANT_DEPTS
            FROM 
                DEPARTMENTS D JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
                JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
            GROUP BY C.REGION_ID) T1
        RIGHT OUTER JOIN REGIONS R ON T1.REGION_ID = R.REGION_ID;    

-- Obtener todos los paises y cu�ntos departments hay en cada pa�s,
-- adem�s de saber cuanto se paga de salarios en cada pais.
-- country_name, cant_depts, total_salary

SELECT
         COUNTRY_NAME
        ,(SELECT COUNT(*)
            FROM 
                DEPARTMENTS D JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
            WHERE L.COUNTRY_ID = C.COUNTRY_ID) CANT_DEPTS
        ,(SELECT TO_CHAR(NVL(SUM(SALARY), 0), '$999,999,990.99')
            FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
            WHERE L.COUNTRY_ID = C.COUNTRY_ID) SALARIES
    FROM COUNTRIES C;






