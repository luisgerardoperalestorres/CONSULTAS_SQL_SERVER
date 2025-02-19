
SELECT LAST_NAME, FIRST_NAME, CITY, DEPARTMENT_NAME
    FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
    WHERE 
        E.DEPARTMENT_ID = D.DEPARTMENT_ID AND
        L.LOCATION_ID = D.LOCATION_ID
    ORDER BY L.CITY;
    
SELECT LAST_NAME, FIRST_NAME, CITY, DEPARTMENT_NAME
    FROM
        EMPLOYEES E JOIN DEPARTMENTS D
                ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
            JOIN LOCATIONS L
                ON D.LOCATION_ID = L.LOCATION_ID
    ORDER BY L.CITY;            
    
SELECT LAST_NAME, FIRST_NAME, JOB_TITLE, CITY, DEPARTMENT_NAME
    FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, JOBS J
    WHERE 
        E.DEPARTMENT_ID = D.DEPARTMENT_ID AND
        L.LOCATION_ID = D.LOCATION_ID AND
        E.JOB_ID = J.JOB_ID 
    ORDER BY L.CITY;

SELECT LAST_NAME, FIRST_NAME, JOB_TITLE, CITY, DEPARTMENT_NAME
    FROM
        EMPLOYEES E JOIN DEPARTMENTS D
            ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN LOCATIONS L
            ON D.LOCATION_ID = L.LOCATION_ID
        JOIN JOBS J
            ON E.JOB_ID = J.JOB_ID
    ORDER BY L.CITY;            

    