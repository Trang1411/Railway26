DROP DATABASE IF EXISTS EXTRA_4;
CREATE DATABASE EXTRA_4;
USE EXTRA_4;

/*================================================== Asssignment 4 ==================================================*/
-- Question 1:  Tạo table với các ràng buộc và kiểu dữ liệu
DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
Department_Number		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 Department_Name		VARCHAR(50)
 );
 INSERT INTO Department( Department_Name)
 VALUES 	( "Maketing" 				),
			( "Sale" 					),
			( "Security"	 			),
			( "Human Resouces"	 		),
			( "Technical"				),
			( "Account"	 				),
			("Customer Care"			),
			("Purchasing"				),
			( "Information Technology"  );
 
 
 DROP TABLE IF EXISTS Employee;
 CREATE TABLE Employee (
 Employee_Number 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 Employee_Name			VARCHAR(50) NOT NULL,
 Department_Number		TINYINT UNSIGNED,
 FOREIGN KEY (Department_Number) REFERENCES Department(Department_Number)
 );
 INSERT INTO Employee (Employee_Name		, Department_Number)
 VALUES 				('Nguyễn Cao Minh'	, 1),
						('Nguyễn Công Minh'	, 2),
                        ('Ngô Thái An'		, 2),
                        ('Nguyễn Ngọc Ánh'	, 4),
                        ('Nguyễn Ngọc Khánh', 5),
                        ('Ngô Đăng Lâm'		, 6),
                        ('Trần Văn An'		, 7),
                        ('Trịnh Thu Ngân'	, 8),
                        ('Nguyễn Hải Anh'	, 9),
                        ('Tống Yến Thanh'	, 8),
                        ('Hoàng Ngọc Linh'	, 6),
                        ('Nguyễn Minh Đức'	, 3),
                        ('Hoàng Thái Vũ'	, 1);
                        
DROP TABLE IF EXISTS Employee_Skill;
CREATE TABLE Employee_Skill(
Employee_Number 		TINYINT UNSIGNED,
Skill_Code 				ENUM('JAVA', 'PYTHON', 'C++') NOT NULL,
Date_Registered			DATE NOT NULL,
FOREIGN KEY (Employee_Number) REFERENCES Employee(Employee_Number)
);
 INSERT INTO Employee_Skill (Employee_Number, Skill_Code, Date_Registered)
 VALUES 					(1				, 'JAVA'	, 20201010),
							(2				, 'C++'		, 20201010),
                            (3				, 'JAVA'	, 20191110),
                            (4				, 'JAVA'	, 20180210),
                            (5				, 'PYTHON'	, 20290510),
                            (6				, 'C++'		, 20190410),
                            (7				, 'JAVA'	, 20201210),
                            (8				, 'PYTHON'	, 20181010),
                            (9				, 'JAVA'	, 20200810),
                            (10				, 'JAVA'	, 20200610),
                            (11				, 'C++'		, 20181010),
                            (12				, 'PYTHON'	, 20211010),
                            (10				, 'PYTHON'	, 20200610),
                            (11				, 'JAVA'	, 20181010),
                            (12				, 'JAVA'	, 20201010),
                            (13				, 'PYTHON'	, 20151010);

-- Question 3: Lấy ra danh sách nhân viên cso skill Java (dùng UNION)
SELECT *
FROM Employee

UNION

SELECT Employee_Number, Skill_Code
FROM Employee_Skill
WHERE Skill_Code = 'JAVA';

SELECT E.Employee_Number, E.Employee_Name, ES.Skill_Code
FROM Employee E 
JOIN Employee_Skill ES ON E.Employee_Number = ES.Employee_Number
WHERE Skill_Code = 'JAVA'
;
-- Question 4: Lấy ra danh sách các phòng ban có nhiều hơn 3 nhân viên
SELECT D.Department_Name, COUNT(E.Department_Number) AS SL_Employee
FROM employee E 
JOIN department D ON E.Department_Number = D.Department_Number
GROUP BY E.Department_Number
HAVING COUNT(E.Department_Number) >=3;

-- Question 5:  Viết lệnh để lấy ra danh sách nhân viên của mỗi văn phòng ban (sd GROUP BY)
SELECT D.Department_Name, COUNT(E.Department_Number) AS SL_NV
FROM employee E 
JOIN department D ON E.Department_Number = D.Department_Number
GROUP BY E.Department_Number;

-- Question 6: Viết lệnh để lấy ra danh sách nhân viên có > 1 skills. (sd DISTINCT)
SELECT Employee_Number, COUNT(Skill_Code) AS Count_skill
FROM employee_skill
GROUP BY Employee_Number
HAVING   COUNT(Skill_Code) >1


