USE 	TestingSystem4;
-- Câu 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban Sale
CREATE VIEW Department_sale AS
	 SELECT AC.*, D.Department_name
	 FROM `account` AC 
	 JOIN department D ON AC.Department_id = D.Department_id
	 WHERE Department_name = 'sale';
-- Câu 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
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
	WHERE Question_id IN (SELECT Question_id
							FROM question
							WHERE length(Content) >90);

-- Câu 4:   Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
DROP VIEW IF EXISTS LIST_ACC_DEP;
CREATE VIEW LIST_ACC_DEP AS
	SELECT AC.Department_id, D.Department_name, count(Account_id) AS COUNT_ACC
	FROM `account` AC
	JOIN department D ON AC.Department_id = D.Department_id
	GROUP BY Department_id;
-- VIEW DANH SÁCH CHỨA CÁC PHÒNG BAN CÓ NHIỀU NHÂN VIÊN NHẤT 
CREATE VIEW DEPARTMENT_MAX_ACC AS
	SELECT  *
	FROM `account` 
	GROUP BY Department_id
	HAVING COUNT(Department_id) = (SELECT MAX(COUNT_ACC) 
								FROM LIST_ACC_DEP);
-- Câu 5:  Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
CREATE VIEW Q_CREATE_BY_NGUYEN AS 
	SELECT Q.Question_id, Q.Content, AC.FullName
	FROM question Q
	JOIN `account` AC ON Q.Creator_id = AC.Account_id
	WHERE FullName LIKE 'Nguyen%'

