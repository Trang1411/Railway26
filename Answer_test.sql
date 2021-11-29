-- Câu 2: Viết lệnh lấy ra thông tin của khách hàng: tên, số lượng oto khách hàng đã
-- mua và sắp sếp tăng dần theo số lượng oto đã mua.
SELECT Cr.`Name`,C.Maker, COUNT(CO.OrderID)
FROM car_order CO 
JOIN customer Cr ON CO.CustomerID = Cr.CustomerID
JOIN car C ON CO.CarID = C.CarID
GROUP BY CO.CustomerID
ORDER BY COUNT(CO.OrderID) ASC
;
-- cÂU 3: Viết hàm (không có parameter) trả về tên hãng sản xuất đã bán được nhiều
-- oto nhất trong năm nay.
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER $$
CREATE FUNCTION MAKER_MAX () RETURNS VARCHAR(50)
BEGIN
	DECLARE name VARCHAR(50);
	SELECT C.Maker INTO name
	FROM car_order CR
	JOIN car C ON C.CarID = CR.CarID
	GROUP BY CR.CarID
	HAVING COUNT(OrderID) = (SELECT MAX(DEM)
							FROM (	SELECT C.Maker, COUNT(OrderID) AS DEM
									FROM car_order CR
									JOIN car C ON C.CarID = CR.CarID
									GROUP BY CR.CarID)A);
	RETURN name;
END $$
DELIMITER ;
-- Câu 4: Viết 1 thủ tục (không có parameter) để xóa các đơn hàng đã bị hủy của
-- những năm trước. In ra số lượng bản ghi đã bị xóa.

DROP PROCEDURE IF EXISTS XOA_ĐH_DA_HUY_NAM_TRC;
DELIMITER $$
CREATE PROCEDURE XOA_ĐH_DA_HUY_NAM_TRC ()
BEGIN 
	SELECT COUNT(Status) SL_DON_DA_HUY
	FROM car_order
	WHERE Status = 2 AND YEAR(OrderDate) < YEAR(NOW());

	 SET SQL_SAFE_UPDATES= 0;
	DELETE FROM car_order
	WHERE `Status` = 2 AND YEAR(OrderDate) < YEAR(NOW());
	-- SET SQL_SAFE_UPDATES= 1;
END $$
DELIMITER ;

-- cÂU 5: Viết 1 thủ tục (có CustomerID parameter) để in ra thông tin của các đơn
-- hàng đã đặt hàng bao gồm: tên của khách hàng, mã đơn hàng, số lượng oto
-- và tên hãng sản xuất.
DROP PROCEDURE IF EXISTS INF_ORDER;
DELIMITER $$
CREATE PROCEDURE INF_ORDER (IN in_CustomerID smallint UNSIGNED)
BEGIN 
	SELECT CO.OrderID, CR.`Name`, C.Maker, COUNT(CO.OrderID)
	FROM car_order CO 
	JOIN customer CR ON CO.CustomerID = CR.CustomerID
	JOIN car C ON CO.CarID = C.CarID
    WHERE CR.CustomerID =  in_CustomerID
	GROUP BY CO.CustomerID
	ORDER BY COUNT(CO.OrderID) ASC;
END $$
DELIMITER ; -- > SAI

-- CÂU 5: 
DROP PROCEDURE IF EXISTS out_INF_ORDER;
DELIMITER $$
CREATE PROCEDURE out_INF_ORDER (IN in_CustomerID smallint UNSIGNED)
BEGIN 

	SELECT CR.Name, CO.OrderID, C.Maker, CO.Amount
	FROM car_order CO
	JOIN customer CR ON CO.CustomerID = CR.CustomerID
	JOIN car C ON CO.CarID = C.CarID
	WHERE CO.CustomerID = in_CustomerID AND Status <> 2; -- Status = 2 : đã hủy đơn
    
END $$
DELIMITER ; 















