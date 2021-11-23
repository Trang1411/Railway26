USE 	TestingSystem4;
-- Câu 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban Sale
DROP VIEW IF EXISTS Department_sale;
CREATE VIEW Department_sale AS
	 SELECT AC.*, D.Department_name
	 FROM `account` AC 
	 JOIN department D ON AC.Department_id = D.Department_id
	 WHERE Department_name = 'sale';
-- Câu 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất

DROP VIEW IF EXISTS ACCOUNT_JOIN_MAX_GROUP;
CREATE VIEW ACCOUNT_JOIN_MAX_GROUP AS
	SELECT * 
	FROM `account`
	-- GROUP BY Account_id
	WHERE Account_id IN (SELECT Account_id
						FROM COUNT_ACCOUNT_JOIN_GROUP
						WHERE SL_GROUP = (SELECT MAX(SL_GROUP)
													FROM COUNT_ACCOUNT_JOIN_GROUP));
-- Câu 3: : Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ  được coi là quá dài) và xóa nó đi
DROP VIEW IF EXISTS LENGTH_QUESTION ;
CREATE VIEW LENGTH_QUESTION AS
	SELECT *
	FROM question
	WHERE Question_id IN (	SELECT Question_id
							FROM question
							WHERE length(Content) >90);
                            
DROP VIEW IF EXISTS LENGTH_QUESTION_2 ;    
                                                   
CREATE VIEW LENGTH_QUESTION_2 AS
	SELECT	Question_id
    FROM	question
    WHERE	length(Content) >90;
    
	SELECT *
    FROM LENGTH_QUESTION;
    
    SELECT *
    FROM LENGTH_QUESTION_2;
    
    DELETE FROM question
    WHERE Question_id IN ( 	SELECT Question_id
							FROM LENGTH_QUESTION_2);

-- Câu 4:   Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất

-- VIEW DANH SÁCH CHỨA CÁC PHÒNG BAN CÓ NHIỀU NHÂN VIÊN NHẤT 
DROP VIEW IF EXISTS DEPARTMENT_MAX_ACC;
CREATE VIEW DEPARTMENT_MAX_ACC AS
	SELECT  *
	FROM `account` 
	GROUP BY Department_id
	HAVING COUNT(Department_id) = (	SELECT MAX(COUNT_ACC) 
									FROM (SELECT count(Account_id) AS COUNT_ACC
										FROM `account` 
										GROUP BY Department_id) AB);
-- Câu 5:  Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
DROP VIEW IF EXISTS Q_CREATE_BY_NGUYEN ;
CREATE VIEW Q_CREATE_BY_NGUYEN AS 
	SELECT Q.Question_id, Q.Content, AC.FullName
	FROM question Q
	JOIN `account` AC ON Q.Creator_id = AC.Account_id
	WHERE FullName LIKE 'Nguyen%';
-- Cách khác
SELECT Q.Question_id, Q.Content
	FROM question Q
	WHERE Creator_id IN ( SELECT Account_id
								FROM `Account`
                                WHERE FullName LIKE 'Nguyen%');


DROP VIEW IF EXISTS v_question;
CREATE VIEW v_question AS
SELECT *
FROM question 
WHERE creator_id = ANY (SELECT account_id  -- câu này cũng có thể dùng IN
						FROM account
							WHERE fullname LIKE 'Nguyễn%');
SELECT * FROM v_question;


