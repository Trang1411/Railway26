DROP DATABASE IF EXISTS TestingSystem2;
CREATE DATABASE 	TestingSystem2;
USE 				TestingSystem2;
    
/*======================================= Assignment_3 =======================================*/
/*============================================================================================*/

 -- Câu 2: lấy ra tất cả từ Department   
SELECT *  FROM Department;

-- Câu 3: Lấy ra id của phòng ban 'Sale' 
SELECT Department_id  FROM  Department
WHERE Department_name = 'Sale';

-- Câu 4: lấy ra FullName dài nhất  trong bảng Account
SELECT *  FROM `Account`
WHERE length(FullName) = ( SELECT max(length(FullName))
							FROM `Account`);

-- Câu 5: lấy ra FullName dài nhất có Department_id = 3  trong bảng Account
SELECT *  FROM `Account`
WHERE Department_id = 3 AND length(FullName) = ( SELECT max(length(FullName)) 
													FROM `Account`);
   
CREATE VIEW AC_d3 AS
	SELECT * FROM `Account`
	WHERE Department_id = 3;

SELECT MAX(length(FullName))
FROM AC_d3;

-- Câu 6: Lấy ra tên group đã tham gia trước ngày '08-11-2020' 
SELECT Group_id FROM GroupAcount
					WHERE JoinDate > '20201108';
SELECT GroupName FROM `Group`
WHERE Group_id IN(5,6,7);

SELECT GroupName FROM `Group`
WHERE Group_id IN((SELECT Group_id FROM GroupAcount
					WHERE JoinDate > '20201108')) ;
                    
-- Câu 7:  Lấy ra ID của question có >= 4 câu trả lời
SELECT Question_id, count(Answer_id)
FROM answer
GROUP BY Question_id
HAVING  count(Answer_id) >= 3;

-- Câu 8: lấy ra các mã đè thi có thời gian thi trên 60 phút và được tạo trước ngày 10-01-2021                
SELECT Exam_id FROM Exam
WHERE Duration >= 60 AND CreateDate >20210110;

-- Câu 9: Lấy ra 5 group được tạo gần đây nhất
SELECT * FROM `Group`
ORDER BY CreateDate DESC
LIMIT 5;

-- Câu 10: đếm số nhân viên thuộc department có id = 2
SELECT COUNT(Account_id)  FROM `Account`
WHERE Department_id = 2;

-- Câu 11: Lấy ra Nhân viên có fullname bắt đầu bằng 'N' và kết thúc bằng 'n'
SELECT * FROM `Account`
WHERE FullName LIKE "N%n";

-- Câu 12: Xóa Question_ID = 2 trong bảng ExamQuestion
DELETE 
FROM ExamQuestion
WHERE Question_ID = 2;

-- Câu 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
DELETE
FROM Question
WHERE Content LIKE "Cau hoi% abc";

SET SQL_SAFE_UPDATES = 0;
-- Cau 14: update thong tin cua account co id = 5 thanh ten "Nguyen Ba Loc" va email thanh loc.nguyenba@vti.com.vn

UPDATE `Account`
SET
		FullName = 'Nguyễn Bá Lộc',
        UserName = ' Baloc',
         Email = 'loc.nguyenba@vti.com.vn'
WHERE Account_id = 5;

-- câu 15: update account có id = 5 sẽ thuộc group có id = 4

UPDATE groupacount
SET 
	Group_id = 4
WHERE Account_id = 5;
