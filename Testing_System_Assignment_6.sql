USE 	TestingSystem4;

DROP PROCEDURE IF EXISTS longest_name;
DELIMITER $$
CREATE PROCEDURE longest_name(IN dept_id INT,OUT longest_name_char VARCHAR(50))
BEGIN 
	SELECT FullName INTO longest_name_char
    FROM `Account`
    WHERE length(FullName) = ( SELECT MAX(length(FullName))
								FROM `Account`
                                WHERE Department_id = dept_id)
	LIMIT 1;
END$$longest_name
DELIMITER ;

-- USE PROCEDURE
SET @SELECT_longest_name = '';
CALL longest_name(5, @SELECT_longest_name );
SELECT @select_longest_name;

-- logic
SELECT MAX(length(FullName))
FROM `Account`
WHERE Department_id = 5;


-- cach 2
DROP PROCEDURE IF EXISTS procedure_length;
DELIMITER $$
CREATE PROCEDURE procedure_length(IN dept_id INT, OUT length_value INT)
BEGIN 
	SELECT MAX(length(FullName)) INTO length_value
	FROM `Account`
	WHERE Department_id = dept_id;
END$$
DELIMITER ;

SET @SELECT_longest_length = '';
CALL procedure_length(5, @SELECT_longest_length);
SELECT @select_longest_length;

SELECT	*
FROM	`Account`
WHERE	Department_id = 5 AND LENGTH(FullName) = @select_longest_length;

-- CREATE function
SET GLOBAL log_bin_trust_function_creators = 1; -- muốn tạo function phải chạy câu này đàu tiên -> lấy quyền tạo function
DROP FUNCTION IF EXISTS LONGEST_LENGTH;
DELIMITER $$
CREATE FUNCTION LONGEST_LENGTH(Dept_id INT) RETURNS INT 
BEGIN
	DECLARE do_dai INT;
	SELECT MAX(length(FullName)) INTO do_dai
	FROM `Account`
	WHERE Department_id = Dept_id;
    
    RETURN do_dai;
END$$
DELIMITER ;

SELECT LONGEST_LENGTH(2);
SELECT *
FROM `Account`
WHERE Department_id=2;

SELECT LONGEST_VALUE(2);
/*=========================================Assignment 6=========================================*/
/*==============================================================================================*/

-- Câu 1:  Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các 
 -- account thuộc phòng ban đó
DROP PROCEDURE DEPT_ACC;
DELIMITER $$
CREATE PROCEDURE DEPT_ACC( IN IN_Dept_name varchar(50))
BEGIN 
	SELECT AC.*, D.Department_name
		 FROM `account` AC 
		 JOIN department D ON AC.Department_id = D.Department_id
		 WHERE Department_name = IN_Dept_name;
END$$
DELIMITER ;
CALL DEPT_ACC('Maketing');
 -- Câu 2: Tạo store để in ra số lượng account trong mỗi group 
 DELIMITER $$
 CREATE PROCEDURE OUT_ACC_IN_EACH_G()
 BEGIN 
	SELECT G.GroupName, COUNT(Account_id)
	FROM GroupAcount GA 
	JOIN `group` G ON GA.Group_id = G.Group_id
	GROUP BY GA.Group_id;
END$$
DELIMITER ;
-- Câu 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo 
-- trong tháng hiện tại
SELECT Type_id, COUNT(Question_id)
FROM question
WHERE MONTH(CreateDate) = MONTH (NOW()) AND YEAR(CreateDate) = YEAR(NOW())
GROUP BY Type_id;

-- Câu 4: tạo store để trả ra id của type question có nhiều câu hỏi nhất 
-- đếm số type_id
SELECT Type_id, COUNT(Type_id) AS SL
FROM question
GROUP BY Type_id;
-- tạo view  bảng đếm type_id
-- lấy ra type_id được sử dụng nhiều nhất
SELECT MAX(SL)
FROM (	SELECT Type_id, COUNT(Type_id) AS SL
		FROM question
		GROUP BY Type_id) dem_type;
-- tạo reocedure
DROP PROCEDURE IF EXISTS MAX_TQ;
DELIMITER $$
CREATE PROCEDURE MAX_TQ()
BEGIN 
	SELECT Type_id
	FROM question
    GROUP BY Type_id
	HAVING COUNT(Type_id) = (	SELECT MAX(SL)
								FROM (	SELECT Type_id, COUNT(Type_id) AS SL
										FROM question
										GROUP BY Type_id) dem_type
							);
END$$
DELIMITER ;
-- use procedure
-- SET @select_MAX_TQ = '';
CALL MAX_TQ();
 
 -- FUNCTION
  SET GLOBAL log_bin_trust_function_creators = 1;
  DELIMITER $$
  CREATE FUNCTION MAX_TQ() RETURNS INT
  BEGIN 
	 DECLARE SL_TQ INT;
     SELECT MAX(SL) INTO SL_TQ
     FROM SL_TQ;
	RETURN SL_TQ;
END$$
DELIMITER ;
-- USE FUNCTION
SELECT MAX_TQ(2);
 -- Câu 5: Sử dụng store ở question 4 để tìm ra tên của type question
 DROP PROCEDURE IF EXISTS NAME_MAX_TQ;
DELIMITER $$
CREATE PROCEDURE NAME_MAX_TQ()
BEGIN 
	SELECT Q.Type_id, TQ.TypeName
	FROM question Q
    JOIN typequestion TQ ON Q.Type_id = TQ.Type_id
    GROUP BY Q.Type_id
	HAVING COUNT(Question_id) = (	SELECT MAX(SL)
									FROM (	SELECT Type_id, COUNT(Type_id) AS SL
											FROM question
											GROUP BY Type_id) dem_type
							);
END$$
DELIMITER ;

 -- câu 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên 
 -- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa 
-- chuỗi của người dùng nhập vào

DROP PROCEDURE IF EXISTS OUT_NAME;
DELIMITER $$
CREATE PROCEDURE OUT_NAME (IN IN_CHARECTER VARCHAR(50))
BEGIN 
	SELECT UserName
    FROM `account`
    WHERE UserName LIKE CONCAT ('%',IN_CHARECTER,'%');
    
     SELECT GroupName
     FROM `group`
     WHERE GroupName LIKE CONCAT ('%',IN_CHARECTER,'%');
END$$
DELIMITER ;

CALL OUT_NAME('e');
-- Câu 8: VIết 1 store cho phép người dùng nhập vào type_name để thống kê câu hỏi có content dài nhất
DELIMITER $$
CREATE PROCEDURE OUT_MAX_LENGTH_CONTEN_Q(IN IN_TYNAME varchar(50))
BEGIN 
	SELECT Q.Content, TQ.TypeName
	FROM question Q 
	JOIN typequestion TQ ON Q.Type_id = TQ.Type_id
	WHERE length(Q.Content) = ( SELECT MAX(length(Q.Content))
								FROM question Q 
								JOIN typequestion TQ ON Q.Type_id = TQ.Type_id
								WHERE TQ.TypeName = IN_TYNAME  
									) ;
END$$
DELIMITER ;
CALL OUT_MAX_LENGTH_CONTEN_Q('Multiple-Choice' );

-- Câu 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DROP PROCEDURE IF EXISTS DELETE_EXAM;
DELIMITER $$
CREATE PROCEDURE DELETE_EXAM(IN IN_Exam_id tinyint UNSIGNED)
BEGIN 
	DELETE 
	FROM exam
	WHERE Exam_id = IN_Exam_id;
END$$
DELIMITER ;
CALL DELETE_EXAM(3);

 -- Câu 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử
-- dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi
-- removing
DELIMITER $$
DROP PROCEDURE IF EXISTS loopWhile$$
CREATE PROCEDURE loopWhile(OUT IN_Exam_id INT)
BEGIN
		SELECT Exam_id  INTO IN_Exam_id
		FROM Exam
		WHERE year(CreateDate)  <= year(now())-3
        LIMIT 1;
END$$
DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS loopWhile1$$

CREATE PROCEDURE loopWhile1()
BEGIN
		DECLARE quantity INT;
        SET quantity = 0;
		SET @IN_Exam_id = '';
		CALL loopWhile(@IN_Exam_id);
		-- SELECT @ID;
		WHILE (@IN_Exam_id IS NOT NULL) DO
			
			CALL loopWhile(@IN_Exam_id);
			
            CALL Del_Exam(@IN_Exam_id);
           
            
        END WHILE;
	
		
END$$
DELIMITER ;
SET @quantity = '';
CALL loopWhile1();
SELECT @quantity;
SELECT * FROM Exam;

 