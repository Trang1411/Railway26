DROP DATABASE IF EXISTS TEST_OUT;
CREATE DATABASE TEST_OUT ;
USE TEST_OUT;

DROP TABLE IF EXISTS CUSTOMER;
CREATE TABLE CUSTOMER (
CustomerID 			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
`Name`				VARCHAR(50),
Phone 				VARCHAR(15),
Email 				VARCHAR(50),
Address				VARCHAR(100),
Note 				VARCHAR(100)
);
INSERT INTO CUSTOMER ( `Name`		, Phone		, Email					, Address		, Note				)
VALUES				('Nguyen Van An', '01234567', 'NguyenAn@gmail.com'	, 'Sóc Sơn_Hà Nội', 'khach hang so 1'),
					('Nguyen Van Be', '01231237', 'NguyenBe@gmail.com'	, 'Mê Linh_Hà Nội','khach hang so 2'),
                    ('Nguyen Van C'	, '01223467', 'NguyenC@gmail.com'	, 'Sóc Sơn_Hà Nội','khach hang so 3'),
                    ('Nguyen Thi Anh', '01284557', 'NguyenAnh@gmail.com', 'Đông Anh_Hà Nội','khach hang so 4'),
                    ('Ngo Van Anh'	, '01245637', 'NgoAnh@gmail.com'	, 'Cầu Giấy _Hà Nội','khach hang so 5'),
                    ('Nguyen Trinh Nghi', '02345567', 'NguyenNghi@gmail.com', 'Tây Hồ _Hà Nội','khach hang so 6')
;
DROP TABLE IF EXISTS CAR;
CREATE TABLE CAR (
CarID	 			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Maker				ENUM('HONDA', 'TOYOTA', 'NISSAN'),
Model 				VARCHAR(50),
`Year` 				SMALLINT UNSIGNED,
Color				VARCHAR(50),
Note 				VARCHAR(100)
);
INSERT INTO CAR (Maker	, Model				, `Year`, Color		, Note)
VALUES 			('HONDA', 'Honda Jazz'		, 2020	, 'red'		, 'không có gì'),
				('HONDA', 'Honda Civic'		, 2021	, 'purple'	, 'không có gì'),
                ('TOYOTA', 'Corolla Altis'	, 2019	, 'black'	, 'không có gì'),
                ('TOYOTA', 'Wigo'			, 2020	, 'yellow'	, 'không có gì'),
                ('NISSAN', 'Nissan Almera'	, 2021	, 'blue'	, 'không có gì')
;

DROP TABLE IF EXISTS CAR_ORDER;
CREATE TABLE CAR_ORDER (
OrderID	 			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
CustomerID			SMALLINT UNSIGNED NOT NULL,
CarID 				SMALLINT UNSIGNED,
Amount 				TINYINT UNSIGNED DEFAULT 1, 
SalePrice			INT UNSIGNED,
OrderDate 			Date,
DeliveryDate		Date,
DeliveryAddress		VARCHAR(100),
`Status`			TINYINT UNSIGNED DEFAULT 0, -- 0 : ĐÃ ĐẶT, 1: ĐÃ GIAO,  2: ĐÃ HỦY
Note 				VARCHAR(100),
FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
FOREIGN KEY (CarID) REFERENCES CAR(CarID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

INSERT INTO CAR_ORDER 	(CustomerID	, CarID	, Amount, SalePrice	, OrderDate	, DeliveryDate	, DeliveryAddress	, `Status`, Note)
VALUES					(1			, 1		, 1		, 1230000	, 20201110	, 20201120	,'Sóc Sơn_Hà Nội'	, 0, 'KHông note gì cả'), 
						(2			, 2		, 1		, 3230000	, 20191012	, 20191101	, 'Mê Linh_Hà Nội'	, 2, 'Giao thành công'), 
                        (3			, 3		, 8		, 4130000	, 20180225	, 20180320	, 'Sóc Sơn_Hà Nội'	, 0, 'Giao thành công'), 
                        (4			, 4		, 1		, 3500000	, 20210512	, 20210610	, 'Đông Anh_Hà Nội'	, 0, 'Giao thành công'), 
                        (2			, 3		, 2		, 3230000	, 20191012	, 20191101	, 'Mê Linh_Hà Nội'	, 0, 'Giao thành công'), 
                        (2			, 3		, 6		, 4130000	, 20180225	, 20180320	, 'Sóc Sơn_Hà Nội'	, 0, 'Giao thành công'), 
                        (4			, 2		, 10	, 3500000	, 20210512	, 20210610	, 'Đông Anh_Hà Nội'	, 0, 'Giao thành công'), 
						(4			, 4		, 1		, 3500000	, 20210512	, 20210610	, 'Đông Anh_Hà Nội'	, 2, 'Giao thành công'), 
                        (1			, 3		, 2		, 3230000	, 20191012	, 20191101	, 'Mê Linh_Hà Nội'	, 2, 'Giao thành công'), 
                        (2			, 3		, 6		, 4130000	, 20180225	, 20180320	, 'Sóc Sơn_Hà Nội'	, 2, 'Giao thành công'), 
                        (3			, 2		, 10	, 3500000	, 20210512	, 20210610	, 'Đông Anh_Hà Nội'	, 2, 'Giao thành công'), 
                        (5			, 5		, 1		, 3510000	, 20210608	, 20210806	,'Tây Hồ _Hà Nội'	, 0, 'Giao thành công');




