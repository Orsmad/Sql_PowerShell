SELECT DEPT.name AS 'DEPARTMENT-NAME', EMPLOYEES.name AS 'EMPLOYEE-NAME', EMPLOYEES.hiredate AS 'EMPLOYEE-HIREDATE'
FROM DEPT
JOIN EMPLOYEES ON DEPT.id = EMPLOYEES.deptid
ORDER BY DEPT.name, EMPLOYEES.hiredate DESC, EMPLOYEES.name;
