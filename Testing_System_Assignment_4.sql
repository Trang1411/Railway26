DROP DATABASE IF EXISTS TestingSystem3;
CREATE DATABASE 	TestingSystem3;
USE 				TestingSystem3;

CREATE TABLE Department (
	Department_id		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Department_name 	VARCHAR(50) UNIQUE KEY
);
INSERT INTO Department(Department_name)
VALUE 
		( "Maketing" 				),
        ( "Sale" 					),
        ( "Security"	 			),
        ( "Human Resouces"	 		),
        ( "Technical"				),
        ( "Account"	 				),
        ("Customer Care"			),
        ("Purchasing"				),
        ( "Information Technology"  );

DROP TABLE IF EXISTS Position;
CREATE TABLE  Position (
	 Position_id		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	 Position_name 		ENUM('Dev', 'Test', 'Maintenance', 'Scrum Master', 'PM', 'Giám đốc', 'Thư ký', 'Trưởng phòng') NOT NULL UNIQUE KEY
);
INSERT INTO Position (Position_name)
VALUE 
		('Dev' 				),
        ('Test' 			),
        ('Maintenance'		),
        ('PM'				),
        ('Scrum Master'	 	),
        ('Giám đốc'	 		),
        ('Thư ký'	 		),
        ('Trưởng phòng'		);

DROP TABLE IF EXISTS `Account`;
CREATE TABLE  `Account` (
  Account_id		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  Email				VARCHAR(30) NOT NULL,
  UserName 			VARCHAR(50) NOT NULL,
  FullName 			VARCHAR(50),
  Department_id		TINYINT UNSIGNED,
  Position_id		TINYINT UNSIGNED,
  CreateDate 		DATE NOT NULL,
  FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

INSERT INTO `Account`( Email, UserName, FullName, Department_id, Position_id, CreateDate)
VALUE 
	('NguyenAn123@gmail.com', 'NguyenAn', 'NguyenVanAn', 5,2,20211107),
    ('ThuHa123@gmail.com', 'ThuHa', 'NguyenThuHa', 4,1,20211108),
    ('Nguyen Du123@gmail.com', 'VanDu', 'NguyenVandU', 3,2,20211101),
    ('NgoNam123@gmail.com', 'TuanNam', 'NgoTuanNam', 2,2,20211107),
    ('TranTu123@gmail.com', 'MinhTu', 'TranMinhTu', 1,1,20211102),
    ('HoangLan123@gmail.com', 'NgocLinh', 'HoangNgocLinh', 3,5,20211101),
    ('NguyenTuan123@gmail.com', 'AnhTuan', 'NguyenAnhTuan', 4,5,20211107),
    ('TranAnh123@gmail.com', 'HaiAnh', 'TranHaiAnh', 5,2,20211108),
    ('DangAn123@gmail.com', 'ThaiAn', 'DangThaiAn', 1,3,20211107),
    ('NgoLam123@gmail.com', 'DangLam', 'NgoDanglam', 3,3,20211106),
    ('NguyenBe123@gmail.com', 'NguyenBe', 'NguyenChiBe', 2,4,20211105);
    
CREATE TABLE `Group`(
Group_id 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
GroupName			VARCHAR(50) UNIQUE KEY,
Creator_id 			TINYINT UNSIGNED UNIQUE KEY,
CreateDate 			DATE,
FOREIGN KEY (Creator_id) REFERENCES  `Account`(Account_id)
);
INSERT INTO  `Group`(GroupName, Creator_id, CreateDate)
VALUE 
	('G01',1,20201102	),
	('G02',2,20201101	),
	('G03',3,20201105	),
	('G04',4,20201108	),
	('G05',5,20211106	),
	('G06',6,20211102	),
    ('G07',7,20211106	);
    
CREATE TABLE GroupAcount (
Group_id 			TINYINT UNSIGNED AUTO_INCREMENT,
Account_id			TINYINT UNSIGNED UNIQUE KEY,
JoinDate 			DATE,
FOREIGN KEY (Account_id) REFERENCES `Account`(Account_id),
FOREIGN KEY (Group_id ) REFERENCES  `Group`(Group_id )
);
INSERT INTO GroupAcount (Account_id, JoinDate)
VALUE 
	(1,20201102		),
    (3,20201101		),
    (6,20201105		),
    (4,20201108		),
    (8,20211106		),
    (2,20211102		),
    (5,20211106		);
    
CREATE TABLE TypeQuestion (
Type_id 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
TypeName			VARCHAR(50) UNIQUE KEY
);
INSERT INTO TypeQuestion(TypeName)
VALUE 	
	('Essay'			),
    ('True-False'		),
    ('Short-Answer'		),
    ('Fill-in-the-blank'),
    ('Matching'			),
    ('Multiple-Choice'	);
    
CREATE TABLE CategoryQuestion(
Category_id 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
CategoryName 		varchar(50) UNIQUE KEY
);
INSERT INTO CategoryQuestion(CategoryName )
VALUE 
	('Java'		),
    ('.NET'		),
    ('SQL'		),
    ('Postman'	),
    ('Ruby'		);

DROP TABLE IF EXISTS Question;
CREATE TABLE Question (
Question_id 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Content 			varchar(200) NOT NULL,
Category_id 		TINYINT UNSIGNED,
Type_id 			TINYINT UNSIGNED,
Creator_id 			TINYINT UNSIGNED,
CreateDate 			DATE NOT NULL,
FOREIGN KEY (Category_id) REFERENCES CategoryQuestion (Category_id),
FOREIGN KEY (Type_id) REFERENCES TypeQuestion (Type_id),
FOREIGN KEY (Creator_id) REFERENCES  `Account`(Account_id)
);
INSERT INTO Question(Content, Category_id, Type_id, Creator_id, CreateDate)
VALUE
	('Question1', 1, 1, 1, 20201110),
    ('Question2', 2, 2, 1, 20201220),
    ('Question3', 3, 3, 1, 20201110),
    ('Question4', 4, 4, 1, 20201110),
    ('Question5', 5, 5, 1, 20201220),
    ('Question6', 4, 6, 1, 20201110),
    ('Question7', 2, 5, 1, 20201110),
    ('Question8', 1, 4, 1, 20201220),
    ('Question9', 2, 3, 1, 20201110),
	('Question10', 3, 2, 1, 20201110);

DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
Answer_id 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Content 			VARCHAR(50) NOT NULL,
Question_id 		TINYINT UNSIGNED UNIQUE KEY,
isCorrect			ENUM('TRUE', 'FALES', 'UNKNOWN'),
FOREIGN KEY (Question_id) REFERENCES Question (Question_id)
);
INSERT INTO Answer(Content, Question_id, isCorrect)
VALUE
	('Answer1', 1, 'TRUE'		),
    ('Answert2', 2, 'FALES'		),
    ('Answer3', 3, 'UNKNOWN'	),
    ('Answer4', 4, 'TRUE'		),
    ('Answer5', 5, 'FALES'		),
    ('Answer6', 6, 'TRUE'		),
    ('Answer7', 7, 'UNKNOWN'	),
    ('Answer8', 8, 'TRUE'		),
    ('Answer9', 9, 'FALES'		),
    ('Answer15', 10, 'UNKNOWN'	);

DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam (
Exam_id 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
`Code` 				VARCHAR(20) NOT NULL,
Title				VARCHAR(50) NOT NULL,
Category_id 		TINYINT UNSIGNED,
Duration 			TINYINT UNSIGNED NOT NULL,
Creator_id 			TINYINT UNSIGNED,
CreateDate 			DATE,
FOREIGN KEY(Category_id) REFERENCES CategoryQuestion(Category_id),
FOREIGN KEY (Creator_id) REFERENCES `Account`(Account_id)
);
INSERT INTO Exam (`Code`, Title, Category_id, Duration, Creator_id, CreateDate)
VALUE 
	('Code1', 'title1', 1, 45, 1, 20201010),
    ('Code2', 'title2', 2, 60, 2, 20201110),
    ('Code3', 'title3', 3, 30, 4, 20201210),
    ('Code4', 'title4', 4, 90, 5, 20210110),
    ('Code5', 'title5', 5, 45, 6, 20210210),
    ('Code6', 'title6', 4, 15, 7, 20210310),
    ('Code7', 'title7', 3, 15, 6, 20210410),
    ('Code8', 'title8', 2, 30, 5, 20210510),
    ('Code9', 'title9', 1, 45, 4, 20210610),
    ('Code10', 'title10', 2, 60, 1, 20210810);

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
Exam_id 			TINYINT UNSIGNED ,
Question_id 		TINYINT UNSIGNED,
FOREIGN KEY (Exam_id) REFERENCES Exam (Exam_id),
FOREIGN KEY(Question_id) REFERENCES Question (Question_id)
);
INSERT INTO ExamQuestion (Exam_id, Question_id )
VALUE
	(1,1	),
    (2,2	),
    (3,3	),
    (4,4	),
    (5,8	),
    (6,6	),
    (7,7	),
    (8,8	),
    (9,9	),
    (5,6	),
    (6,7	),
    (7,8	),
    (8,5	),
    (9,6	),
    (10,10	);
    
    
/*======================================= Assignment_4 =======================================*/
/*============================================================================================*/

-- câu 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ

SELECT `Account`.Account_id,  `Account`.UserName, `Account`.FullName, department.Department_id, department.Department_name
FROM `Account`, department
WHERE  `Account`.Department_id = department.Department_id;

-- CÁCH KHÁC, SỬ DỤNG 'JOIN'
SELECT `Account`.Account_id,  `Account`.UserName, `Account`.FullName, department.Department_id, department.Department_name
FROM `Account`
JOIN department ON `Account`.Department_id = department.Department_id
ORDER BY Account_id;

-- CÂU 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010 
SELECT Creator_id, CreateDate 
 FROM `Group`
 WHERE CreateDate > 20201108;
 
 -- Câu 3:  Viết lệnh để lấy ra tất cả các developer 
 SELECT `Account`.Account_id,  `Account`.UserName, `Account`.FullName, position.Position_id, position.Position_name
FROM `Account`, position
WHERE  `Account`.Position_id = position.Position_id AND Position_name = 'Dev';

-- Câu 4:  Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT Department_id, COUNT(*) AS TONG_SO_NHAN_VIEN
FROM `Account`
GROUP BY Department_id;

-- Câu 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất 
