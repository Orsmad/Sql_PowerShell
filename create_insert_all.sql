CREATE TABLE DEPT (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
);

CREATE TABLE EMPLOYEES (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    sal DECIMAL(20, 2),
    hiredate DATETIME,
    deptid INT,
    FOREIGN KEY (deptid) REFERENCES DEPT(id)
);

INSERT INTO DEPT (name) VALUES
    ('Sales'),
    ('Marketing'),
    ('Engineering');


INSERT INTO EMPLOYEES (name, sal, hiredate, deptid) VALUES
    ('John Doe', 3000.50, '2023-06-01 09:00:00', 1),      
    ('Jane Smith', 2500.75, '2023-06-02 10:30:00', 1),    
    ('David Johnson', 3500.25, '2023-06-03 11:15:00', 1), 
    ('Emily Brown', 2800.50, '2023-06-04 12:45:00', 2),  
    ('Michael Davis', 3200.75, '2023-06-05 13:20:00', 2),
    ('Sarah Wilson', 2900.25, '2023-06-06 14:10:00', 2), 
    ('Robert Taylor', 3800.50, '2023-06-07 15:30:00', 3), 
    ('Jennifer Clark', 4100.75, '2023-06-08 16:45:00', 3),
    ('Daniel Lee', 3400.25, '2023-06-09 17:55:00', 3),   
    ('Olivia Miller', 4000.50, '2023-06-10 18:20:00', 3);




