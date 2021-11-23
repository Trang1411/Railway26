DROP DATABASE IF EXISTS EXTRA;
CREATE DATABASE EXTRA;
USE 			EXTRA;

DROP TABLE IF EXISTS Fresher_Training_Management;
CREATE TABLE Fresher_Training_Management (
	TraineeID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Full_Name				VARCHAR(50) NOT NULL,
    Birth_Date				DATE,
    Gender					ENUM('Male', 'Felame', 'unkonw') NOT NULL,
    ET_IQ					TINYINT NOT NULL,
    ET_Gmath				TINYINT NOT NULL,
    ET_English				TINYINT NOT NULL,
    Training_Class			VARCHAR(10) NOT NULL,
    Evaluation_Notes		VARCHAR(200)
);

ALTER TABLE Fresher_Training_Management ADD VTI_Account VARCHAR(20) NOT NULL UNIQUE KEY;

INSERT INTO Fresher_Training_Management(Full_Name, Birth_Date, Gender, ET_IQ , ET_Gmath , ET_English, Training_Class, Evaluation_Notes, VTI_Account)
VALUES 
		('Nguyễn Cao Minh', 19990410, 'Male', 8,7,6, 'ML01', 'KHÔNG CÓ GÌ ĐỂ ĐÁNH GIÁ', 'VTI_Account_01'),
        ('Nguyễn Ngọc Ánh', 19990410, 'Felame', 8,8,9, 'ML02', 'KHÔNG CÓ GÌ ĐỂ ĐÁNH GIÁ', 'VTI_Account_02'),
        ('Hoàng Ngọc Bích', 19920410, 'Felame', 6,7,6, 'ML02', 'KHÔNG CÓ GÌ ĐỂ ĐÁNH GIÁ', 'VTI_Account_03'),
        ('Lê Thị Hường', 19860620, 'Felame', 8,5,6, 'ML03','KHÔNG CÓ GÌ ĐỂ ĐÁNH GIÁ', 'VTI_Account_04'),
        ('Tống Yến Thanh', 19950415, 'Felame', 5,7,6, 'ML04', 'KHÔNG CÓ GÌ ĐỂ ĐÁNH GIÁ', 'VTI_Account_05'),
        ('Ngô Thái An', 19940810, 'Male', 9,6,8, 'ML04', 'KHÔNG CÓ GÌ ĐỂ ĐÁNH GIÁ', 'VTI_Account_06'),
        ('Nguyễn Ngọc Khánh', 20000612, 'Male', 6,3,8, 'ML01', 'KHÔNG CÓ GÌ ĐỂ ĐÁNH GIÁ', 'VTI_Account_07'),
        ('Trần Mỹ Duyên', 19990415, 'Felame', 4,6,6, 'ML02', 'KHÔNG CÓ GÌ ĐỂ ĐÁNH GIÁ', 'VTI_Account_08'),
        ('Trần Duy Linh', 19991126, 'Male', 7,8,6, 'ML08', 'KHÔNG CÓ GÌ ĐỂ ĐÁNH GIÁ', 'VTI_Account_09'),
        ('Nguyễn Vân Anh', 20031123, 'Felame', 6,8,9, 'ML10', 'KHÔNG CÓ GÌ ĐỂ ĐÁNH GIÁ', 'VTI_Account_010'),
        ('Lê Thu Uyên', 19951025, 'Felame', 8,5,6, 'ML06', 'KHÔNG CÓ GÌ ĐỂ ĐÁNH GIÁ', 'VTI_Account_011'),
        ('Dương Quang Ninh', 19981212, 'Male', 7,7,6, 'ML09', 'KHÔNG CÓ GÌ ĐỂ ĐÁNH GIÁ', 'VTI_Account_012')
;

/*================================================== Asssignment 3 ==================================================*/

-- question 2: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào
-- nhóm chúng thành các tháng sinh khác nhau
-- (giả sử từ 8 điểm bài IQ và Math và từ 6 điểm bài English trở lên được coi là vượt qua)
  
SELECT MONTH(Birth_Date), COUNT(Full_Name)
FROM fresher_training_management
WHERE ET_IQ >= 8 AND ET_Gmath >= 8 AND ET_English >=6
GROUP BY MONTH(Birth_Date)
;
-- question 3: Viết lệnh để lấy ra thực tập sinh có tên dài nhất 
SELECT Full_Name, Gender, ET_IQ, ET_Gmath, ET_English, LENGTH(Full_Name)
FROM fresher_training_management
WHERE LENGTH(Full_Name) = (	SELECT MAX(Length_name)
							FROM 	(SELECT *, LENGTH(Full_Name) AS Length_name
									FROM fresher_training_management)A )
;
SELECT *, LENGTH(Full_Name) 
FROM fresher_training_management
;

SELECT *, MAX(Length_name)
FROM 	(SELECT *, LENGTH(Full_Name) AS Length_name
		FROM fresher_training_management)A 
        ;
-- Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là 
-- những người đã vượt qua bài test đầu vào và thỏa mãn số điểm như sau:
--  ET_IQ + ET_Gmath>=15
--  ET_IQ>=8
--  ET_Gmath>=8
--  ET_English>=6
SELECT *
FROM fresher_training_management
WHERE (ET_IQ + ET_Gmath >= 15) AND ET_IQ >= 8 AND ET_Gmath >= 8 AND ET_English >= 6;

-- Question 5: xóa thực tập sinh có TraineeID = 3
DELETE 
FROM fresher_training_management
WHERE TraineeID = 3;

-- Question 6:  Thực tập sinh có TraineeID = 5 được chuyển sang lớp "2". Hãy cập nhật 
-- thông tin vào database
UPDATE fresher_training_management
SET Training_Class = 'ML02'
WHERE TraineeID = 5
;
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
						('Nguyễn Công Minh'	, 1),
                        ('Ngô Thái An'		, 1),
                        ('Nguyễn Ngọc Ánh'	, 1),
                        ('Nguyễn Ngọc Khánh', 1),
                        ('Ngô Đăng Lâm'		, 1),
                        ('Trần Văn An'		, 1),
                        ('Trịnh Thu Ngân'	, 1),
                        ('Nguyễn Hải Anh'	, 1),
                        ('Tống Yến Thanh'	, 1),
                        ('Hoàng Ngọc Linh'	, 1),
                        ('Nguyễn Minh Đức'	, 1),
                        ('Hoàng Thái Vũ'	, 1);
                        
DROP TABLE IF EXISTS Employee_Skill;
CREATE TABLE Employee_Skill(
Employee_Number 		TINYINT UNSIGNED,
Skill_Code 				TINYINT NOT NULL,
Date_Registered			DATE NOT NULL,
FOREIGN KEY (Employee_Number) REFERENCES Employee(Employee_Number)
);
 INSERT INTO Employee_Skill (Employee_Number, Skill_Code, Date_Registered)
 VALUES 					(1				, 1			, 20201010),
							(2				, 1			, 20201010),
                            (3				, 1			, 20201010),
                            (4				, 1			, 20201010),
                            (5				, 1			, 20201010),
                            (6				, 1			, 20201010),
                            (7				, 1			, 20201010),
                            (8				, 1			, 20201010),
                            (9				, 1			, 20201010),
                            (10				, 1			, 20201010),
                            (11				, 1			, 20201010),
                            (12				, 1			, 20201010),
                            (13				, 1			, 20201010);











