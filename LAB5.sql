﻿CREATE DATABASE QLDA
GO
USE QLDA
GO

-- CREATE TABLES
CREATE TABLE DEAN
(
	TENDA NVARCHAR(15),
	MADA INT NOT NULL,
	DDIEM_DA NVARCHAR(15) NOT NULL,
	PHONG INT NOT NULL,
	
	PRIMARY KEY (MADA)
)

CREATE TABLE PHONGBAN
(
	TENPHG NVARCHAR(15),
	MAPHG INT NOT NULL,
	TRPHG NVARCHAR(9),
	NG_NHANCHUC DATE,
	
	PRIMARY KEY (MAPHG)
)

CREATE TABLE DIADIEM_PHG
(
	MAPHG INT NOT NULL,
	DIADIEM NVARCHAR(15),
	
	PRIMARY KEY (MAPHG, DIADIEM)
)

CREATE TABLE NHANVIEN
(
	HONV NVARCHAR(15),
	TENLOT NVARCHAR(15),
	TENNV NVARCHAR(15),
	MANV NVARCHAR(9) NOT NULL,
	NGSINH DATE,
	DCHI NVARCHAR(30),
	PHAI NVARCHAR(3),
	LUONG FLOAT,
	MA_NQL NVARCHAR(9),
	PHG INT NOT NULL,
	
	PRIMARY KEY (MANV)
)

CREATE TABLE THANNHAN
(
	MA_NVIEN NVARCHAR(9) NOT NULL,
	TENTN NVARCHAR(15),
	PHAI NVARCHAR(3),
	NGSINH DATE,
	QUANHE NVARCHAR(15),
	
	PRIMARY KEY (MA_NVIEN, TENTN)
)

CREATE TABLE CONGVIEC
(
	MADA INT NOT NULL,
	STT INT NOT NULL,
	TEN_CONG_VIEC NVARCHAR(50),
	
	PRIMARY KEY (MADA, STT)
)

CREATE TABLE PHANCONG
(
	MA_NVIEN NVARCHAR(9) NOT NULL,
	MADA INT NOT NULL,
	STT INT NOT NULL,
	THOIGIAN FLOAT,
	
	PRIMARY KEY (MA_NVIEN, MADA, STT)
)

-- Cài đặt ràng buộc khóa ngoại cho các bảng 
ALTER TABLE DEAN
ADD CONSTRAINT FK_DEAN_PHONG
FOREIGN KEY (PHONG)
REFERENCES PHONGBAN (MAPHG)

ALTER TABLE PHONGBAN
ADD CONSTRAINT FK_PHONGBAN_NHANVIEN
FOREIGN KEY (TRPHG)
REFERENCES NHANVIEN (MANV)

ALTER TABLE DIADIEM_PHG
ADD CONSTRAINT FK_DIADIEM_PHG_PHONGBAN
FOREIGN KEY (MAPHG)
REFERENCES PHONGBAN (MAPHG)

ALTER TABLE CONGVIEC
ADD CONSTRAINT FK_CONGVIEC_DEAN
FOREIGN KEY (MADA)
REFERENCES DEAN (MADA)

ALTER TABLE NHANVIEN
ADD CONSTRAINT FK_NHANVIEN_PHONGBAN
FOREIGN KEY (PHG)
REFERENCES PHONGBAN (MAPHG)

ALTER TABLE NHANVIEN
ADD CONSTRAINT FK_NHANVIEN_NHANVIEN
FOREIGN KEY (MA_NQL)
REFERENCES NHANVIEN (MANV)

ALTER TABLE PHANCONG
ADD CONSTRAINT FK_PHANCONG_DEAN
FOREIGN KEY (MADA)
REFERENCES DEAN (MADA)

ALTER TABLE PHANCONG
ADD CONSTRAINT FK_PHANCONG_NHANVIEN
FOREIGN KEY (MA_NVIEN)
REFERENCES NHANVIEN (MANV)

ALTER TABLE THANNHAN
ADD CONSTRAINT FK_THANNHAN_NHANVIEN
FOREIGN KEY (MA_NVIEN)
REFERENCES NHANVIEN (MANV)

BEGIN /** NHANVIEN **/
	ALTER TABLE NHANVIEN
	NOCHECK CONSTRAINT ALL
	INSERT INTO NHANVIEN (HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG)
	VALUES (N'Đinh', N'Bá', N'Tiến', '009', '02/11/1960', N'119, Cống Quỳnh, TP.HCM', N'Nam', 30000, '005', 5)
	INSERT INTO NHANVIEN (HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG)
	VALUES (N'Nguyễn', N'Thanh', N'Tùng', '005', '08/20/1962', N'222, Nguyễn Văn Cừ, TP.HCM', N'Nam', 40000, '006', 5)
	INSERT INTO NHANVIEN (HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG)
	VALUES (N'Bùi', N'Ngọc', N'Hằng', '007', '03/11/1954', N'332, Nguyễn Thái Học, TP.HCM', N'Nam', 25000, '001', 4)
	INSERT INTO NHANVIEN (HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG)
	VALUES (N'Lê', N'Quỳnh', N'Như', '001', '02/01/1967', N'291, Hồ Văn Huê, TP.HCM', N'Nữ', 43000, '006', 4)
	INSERT INTO NHANVIEN (HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG)
	VALUES (N'Nguyễn', N'Mạnh', N'Hùng', '004', '03/04/1967', N'95, Bà Rịa - Vũng Tàu', N'Nam', 38000, '005', 5)
	INSERT INTO NHANVIEN (HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG)
	VALUES (N'Trần', N'Thanh', N'Tâm', '003', '05/04/1957', N'34, Mai Thị Lự, TP.HCM', N'Nam', 25000, '005', 5)
	INSERT INTO NHANVIEN (HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG)
	VALUES (N'Trần', N'Hồng', N'Quang', '008', '09/01/1967', N'45, Lê Hồng Phong, TP.HCM', N'Nam', 25000, '001', 4)
	INSERT INTO NHANVIEN (HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, PHG)
	VALUES (N'Phạm', N'Văn', N'Vinh', '006', '01/01/1965', N'45, Trưng Vương', N'Nữ', 55000, 1)
	INSERT INTO NHANVIEN (HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, PHG)
	VALUES (N'Bùi', N'Đức', N'Danh', '012', '09/01/1955', N'78, Quảng Ngãi', N'Nam', 57000, 5)
	ALTER TABLE NHANVIEN
	CHECK CONSTRAINT ALL
END

BEGIN /** PHONGBAN **/
	ALTER TABLE PHONGBAN
	NOCHECK CONSTRAINT ALL
	INSERT INTO PHONGBAN (TENPHG, MAPHG, TRPHG, NG_NHANCHUC)
	VALUES (N'Nghiên cứu', 5, '005', '05/22/1978')
	INSERT INTO PHONGBAN (TENPHG, MAPHG, TRPHG, NG_NHANCHUC)
	VALUES (N'Điều hành', 4, '008', '01/01/1985')
	INSERT INTO PHONGBAN (TENPHG, MAPHG, TRPHG, NG_NHANCHUC)
	VALUES (N'Quản lý', 1, '006', '06/19/1971')
	ALTER TABLE PHONGBAN
	CHECK CONSTRAINT ALL
END

BEGIN /** DEAN **/
	ALTER TABLE DEAN
	NOCHECK CONSTRAINT ALL
	INSERT INTO DEAN (TENDA, MADA, DDIEM_DA, PHONG)
	VALUES (N'Sản phẩm X', 1, N'Vũng Tàu', 5)
	INSERT INTO DEAN (TENDA, MADA, DDIEM_DA, PHONG)
	VALUES (N'Sản phẩm Y', 2, N'Nha Trang', 5)
	INSERT INTO DEAN (TENDA, MADA, DDIEM_DA, PHONG)
	VALUES (N'Sản phẩm Z', 3, N'TP.HCM', 5)
	INSERT INTO DEAN (TENDA, MADA, DDIEM_DA, PHONG)
	VALUES (N'Tin học hóa', 10, N'Hà Nội', 4)
	INSERT INTO DEAN (TENDA, MADA, DDIEM_DA, PHONG)
	VALUES (N'Cáp quang', 20, N'TP.HCM', 1)
	INSERT INTO DEAN (TENDA, MADA, DDIEM_DA, PHONG)
	VALUES (N'Đào tạo', 30, N'Hà Nội', 4)
	ALTER TABLE DEAN
	CHECK CONSTRAINT ALL
END

BEGIN /** THANNHAN **/
	ALTER TABLE THANNHAN
	NOCHECK CONSTRAINT ALL
	INSERT INTO THANNHAN (MA_NVIEN, TENTN, PHAI, NGSINH, QUANHE)
	VALUES ('005', N'Trinh', N'Nữ', '04/05/1976', N'Con gái')
	INSERT INTO THANNHAN (MA_NVIEN, TENTN, PHAI, NGSINH, QUANHE)
	VALUES ('005', N'Khang', N'Nam', '10/25/1973', N'Con trai')
	INSERT INTO THANNHAN (MA_NVIEN, TENTN, PHAI, NGSINH, QUANHE)
	VALUES ('005', N'Phương', N'Nữ', '05/03/1948', N'Vợ chồng')
	INSERT INTO THANNHAN (MA_NVIEN, TENTN, PHAI, NGSINH, QUANHE)
	VALUES ('001', N'Minh', N'Nam', '02/29/1932', N'Vợ chồng')
	INSERT INTO THANNHAN (MA_NVIEN, TENTN, PHAI, NGSINH, QUANHE)
	VALUES ('009', N'Tiến', N'Nam', '01/01/1978', N'Con trai')
	INSERT INTO THANNHAN (MA_NVIEN, TENTN, PHAI, NGSINH, QUANHE)
	VALUES ('009', N'Châu', N'Nữ', '12/30/1978', N'Con gái')
	INSERT INTO THANNHAN (MA_NVIEN, TENTN, PHAI, NGSINH, QUANHE)
	VALUES ('009', N'Phương', N'Nữ', '05/05/1957', N'Vợ chồng')
	ALTER TABLE THANNHAN
	CHECK CONSTRAINT ALL
END

BEGIN /** DIADIEM_PHG **/
	ALTER TABLE DIADIEM_PHG
	NOCHECK CONSTRAINT ALL
	INSERT INTO DIADIEM_PHG (MAPHG, DIADIEM)
	VALUES (1, N'TP.HCM')
	INSERT INTO DIADIEM_PHG (MAPHG, DIADIEM)
	VALUES (4, N'Hà Nội')
	INSERT INTO DIADIEM_PHG (MAPHG, DIADIEM)
	VALUES (5, N'Vũng Tàu')
	INSERT INTO DIADIEM_PHG (MAPHG, DIADIEM)
	VALUES (5, N'Nha Trang')
	INSERT INTO DIADIEM_PHG (MAPHG, DIADIEM)
	VALUES (5, N'TP.HCM')
	INSERT INTO DIADIEM_PHG (MAPHG, DIADIEM)
	VALUES (5, N'Quảng Ngãi')
	ALTER TABLE DIADIEM_PHG
	CHECK CONSTRAINT ALL
END

BEGIN /** PHANCONG **/
	ALTER TABLE PHANCONG
	NOCHECK CONSTRAINT ALL
	INSERT INTO PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
	VALUES ('009', 1, 1, 32)
	INSERT INTO PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
	VALUES ('009', 2, 2, 8)
	INSERT INTO PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
	VALUES ('004', 3, 1, 40)
	INSERT INTO PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
	VALUES ('003', 1, 2, 20.0)
	INSERT INTO PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
	VALUES ('003', 2, 1, 20.0)
	INSERT INTO PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
	VALUES ('008', 10, 1, 35)
	INSERT INTO PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
	VALUES ('008', 30, 2, 5)
	INSERT INTO PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
	VALUES ('001', 30, 1, 20)
	INSERT INTO PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
	VALUES ('001', 20, 1, 15)
	INSERT INTO PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
	VALUES ('006', 20, 1, 30)
	INSERT INTO PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
	VALUES ('005', 3, 1, 10)
	INSERT INTO PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
	VALUES ('005', 10, 2, 10)
	INSERT INTO PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
	VALUES ('005', 20, 1, 10)
	INSERT INTO PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
	VALUES ('007', 30, 2, 30)
	INSERT INTO PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
	VALUES ('007', 10, 2, 10)
	ALTER TABLE PHANCONG
	CHECK CONSTRAINT ALL
END

BEGIN /** CONGVIEC **/
	ALTER TABLE CONGVIEC
	NOCHECK CONSTRAINT ALL
	INSERT INTO CONGVIEC (MADA, STT, TEN_CONG_VIEC)
	VALUES (1, 1, N'Thiết kế sản phẩm X')
	INSERT INTO CONGVIEC (MADA, STT, TEN_CONG_VIEC)
	VALUES (1, 2, N'Thử nghiệm sản phẩm X')
	INSERT INTO CONGVIEC (MADA, STT, TEN_CONG_VIEC)
	VALUES (2, 1, N'Sản xuất sản phẩm Y')
	INSERT INTO CONGVIEC (MADA, STT, TEN_CONG_VIEC)
	VALUES (2, 2, N'Quảng cáo sản phẩm Y')
	INSERT INTO CONGVIEC (MADA, STT, TEN_CONG_VIEC)
	VALUES (3, 1, N'Khuyến mãi sản phẩm Z')
	INSERT INTO CONGVIEC (MADA, STT, TEN_CONG_VIEC)
	VALUES (10, 1, N'Tin học hóa phòng nhân sự')
	INSERT INTO CONGVIEC (MADA, STT, TEN_CONG_VIEC)
	VALUES (10, 2, N'Tin học hóa phòng kinh doanh')
	INSERT INTO CONGVIEC (MADA, STT, TEN_CONG_VIEC)
	VALUES (20, 1, N'Lắp đặt cáp quang')
	INSERT INTO CONGVIEC (MADA, STT, TEN_CONG_VIEC)
	VALUES (30, 1, N'Đào tạo nhân viên Marketing')
	INSERT INTO CONGVIEC (MADA, STT, TEN_CONG_VIEC)
	VALUES (30, 2, N'Đào tạo chuyên viên thiết kế')
	ALTER TABLE CONGVIEC
	CHECK CONSTRAINT ALL
END
GO

--1. Liệt kê danh sách tất cả các nhân viên
SELECT * FROM NHANVIEN

--2. Tìm các nhân viên làm việc ở phòng số 5
SELECT NHANVIEN.HONV + NHANVIEN.TENLOT + NHANVIEN.TENNV AS N'Nhân viên phòng 5'
FROM NHANVIEN
WHERE NHANVIEN.PHG = 5

--3. Liệt kê họ tên và phòng làm việc các nhân viên có mức lương trên 6.000.000 đồng
SELECT HONV+ '' +TENLOT+ ' ' +TENNV AS 'HOTEN' , PHG
FROM NHANVIEN
WHERE LUONG > 6000000

--4. Tìm các nhân viên có mức lương trên 6.500.000 ở phòng 1 hoặc các nhân viên có mức lương trên 5.000.000 ở phòng 
SELECT * FROM NHANVIEN 
WHERE LUONG > 650000 AND PHG = 1 OR LUONG > 5000000 AND PHG = 4

--5. Cho biết họ tên đầy đủ của các nhân viên ở TP Quảng Ngãi
SELECT HONV+ ' ' +TENLOT+ ' ' +TENNV AS 'HOTEN' 
FROM NHANVIEN
WHERE DCHI LIKE '78, Quảng Ngãi'

--6. Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự 'N'
SELECT HONV+ ' ' +TENLOT+ ' ' +TENNV as 'HOTEN' 
FROM NHANVIEN  
WHERE HONV LIKE 'N%'

--7. Cho biết ngày sinh và địa chỉ của nhân viên Cao Thanh Huyền
SELECT NGSINH, DCHI 
FROM NHANVIEN 
WHERE HONV LIKE 'Cao' AND TENLOT LIKE 'Thanh' AND TENNV LIKE 'Huyền'

--8. Cho biết các nhân viên có năm sinh trong khoảng 1955 đến 1975
SELECT * FROM NHANVIEN 
WHERE YEAR(NGSINH) BETWEEN 1955 AND 1975

--9. Cho biết các nhân viên và năm sinh của nhân viên
SELECT HONV+ ' ' +TENLOT+ ' ' +TENNV AS 'Họ và tên', YEAR(NGSINH) AS 'Năm sinh' 
FROM NHANVIEN

-- 10. Cho biết họ tên và tuổi của tất cả các nhân viên
SELECT HONV+ ' ' +TENLOT+ ' ' +TENNV AS 'Họ và tên', (2023 - YEAR(NGSINH)) AS 'Tuổi' 
FROM NHANVIEN

--11. Tìm tên những người trưởng phòng của từng phòng ban
SELECT HONV+ ' ' +TENLOT+ ' ' +TENNV AS 'Họ và tên Trưởng Phòng' 
FROM PHONGBAN,NHANVIEN
WHERE PHONGBAN.TRPHG = NHANVIEN.MANV

--12.Tìm tên và địa chỉ của tất cả các nhân viên của phòng 'Điều hành'
SELECT HONV+ ' ' +TENLOT+ ' ' +TENNV AS 'Họ và tên', DCHI 
FROM NHANVIEN INNER JOIN PHONGBAN ON NHANVIEN.PHG = PHONGBAN.MAPHG
WHERE PHONGBAN.MAPHG = 4

--13. Với mỗi đề án ở Tp Quảng Ngãi, cho biết tên đề án, tên phòng ban, họ tên và ngày nhận chức của trưởng phòng của phòng ban chủ trì đề án đó.
SELECT TENDA, TENPHG, HONV+ ' ' +TENLOT+ ' ' +TENNV AS 'Họ và tên', NG_NHANCHUC 
FROM NHANVIEN INNER JOIN PHONGBAN 
ON NHANVIEN.PHG = PHONGBAN.MAPHG 
INNER JOIN DEAN ON DEAN.PHONG = PHONGBAN.MAPHG
WHERE PHONGBAN.TRPHG = NHANVIEN.MANV AND DCHI like 'Quảng Ngãi'

--14. Tìm tên những nữ nhân viên và tên người thân của họ
SELECT HONV+ ' ' +TENLOT+ ' ' +TENNV AS 'Họ và tên', TENTN AS 'Tên người thân' 
FROM NHANVIEN inner join THANNHAN ON NHANVIEN.MANV = THANNHAN.MA_NVIEN
WHERE NHANVIEN.PHAI = N'Nữ'

--15. Với mỗi nhân viên, cho biết họ tên của nhân viên, họ tên trưởng phòng của phòng ban mà nhân viên đó đang làm việc.
SELECT NV.HONV + ' ' + NV.TENLOT + ' ' + NV.TENNV AS 'HOTEN', QL.HONV+ ' ' + QL.TENLOT + ' ' + QL.TENNV as 'HOTENQUANLI'
FROM NHANVIEN NV,NHANVIEN QL
WHERE NV.MA_NQL = QL.MANV

--16. Tên những nhân viên phòng Nghiên cứu có tham gia vào đề án "Xây dựng nhà máy chế biến thủy sản"
SELECT HONV+ ' ' + TENLOT + ' ' + TENNV AS 'HOTEN' 
FROM NHANVIEN INNER JOIN DEAN ON NHANVIEN.PHG = DEAN.PHONG
WHERE DEAN.TENDA = 'Xây dựng nhà máy chế biến thủy sản'

--17. Cho biết tên các đề án mà nhân viên Trần Thanh Tâm đã tham gia.
SELECT TENDA AS 'Tên đề án'
FROM NHANVIEN INNER JOIN DEAN ON NHANVIEN.PHG = DEAN.PHONG
WHERE NHANVIEN.HONV = N'Trần' AND NHANVIEN.TENLOT = N'Thanh' AND NHANVIEN.TENNV = N'Tâm'

--18. Cho biết số lượng đề án của công ty
SELECT COUNT(DEAN.MADA)
FROM DEAN

--19. Liệt kê danh sách các phòng ban có tham gia chủ trì các đề án
SELECT * FROM DEAN,PHONGBAN 
WHERE DEAN.PHONG = PHONGBAN.MAPHG

--20. Cho biết số lượng các phòng ban có tham gia chủ trì các đề án
SELECT COUNT(*) AS 'Số lượng các phòng ban tham gia chủ trì đề án' 
FROM DEAN,PHONGBAN 
WHERE DEAN.PHONG = PHONGBAN.MAPHG

--21. Cho biết số lượng đề án do phòng 'Nghiên Cứu' chủ trì.
SELECT COUNT(DEAN.MADA)
FROM DEAN, PHONGBAN
WHERE DEAN.PHONG = PHONGBAN.MAPHG AND
PHONGBAN.TENPHG = N'Nghiên cứu'

--22. Cho biết lương trung bình của các nữ nhân viên.
SELECT AVG(NHANVIEN.LUONG)
FROM NHANVIEN
WHERE NHANVIEN.PHAI = N'Nữ'

--23. Cho biết số thân nhân của nhân viên 'Đinh Bá Tiến'.
SELECT COUNT(THANNHAN.MA_NVIEN)
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MANV = THANNHAN.MA_NVIEN AND NHANVIEN.HONV = N'Đinh' AND NHANVIEN.TENLOT = N'Bá' AND NHANVIEN.TENNV = N'Tiến'

--24. Liệt kê danh sách 3 nhân viên lớn tuổi nhất, danh sách bao gồm họ tên và năm sinh.
SELECT TOP 3 HONV + ' ' + TENLOT + ' ' + TENNV + ' ' AS 'Họ và tên',year(NGSINH) AS 'Năm sinh' 
FROM NHANVIEN
ORDER BY year(NGSINH)

--25. Với mỗi đề án, liệt kê mã đề án và tổng số giờ làm việc của tất cả các nhân viên tham gia đề án đó.
SELECT DEAN.MADA, COUNT(DEAN.MADA) AS 'Số lượng công việc'
FROM DEAN, CONGVIEC
WHERE DEAN.MADA = CONGVIEC.MADA
GROUP BY DEAN.MADA, DEAN.TENDA

--26. Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc của tất cả các nhân viên tham gia đề án đó.
SELECT DEAN.TENDA, COUNT(DEAN.MADA) AS 'Số lượng công việc'
FROM DEAN, CONGVIEC
WHERE DEAN.MADA = CONGVIEC.MADA
GROUP BY DEAN.MADA, DEAN.TENDA

--27. Với mỗi đề án, cho biết có bao nhiêu nhân viên tham gia đề án đó, thông tin bao gồm tên đề án và số lượng nhân viên.
SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên nhân viên', COUNT(THANNHAN.MA_NVIEN) AS 'Số lượng thân nhân'
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MANV = THANNHAN.MA_NVIEN
GROUP BY (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV)

--28. Với mỗi nhân viên, cho biết họ và tên nhân viên và số lượng thân nhân của nhân viên đó.
SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên nhân viên', COUNT(THANNHAN.MA_NVIEN) AS 'Số lượng thân nhân'
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MANV = THANNHAN.MA_NVIEN
GROUP BY (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV)

--29. Với mỗi nhân viên, cho biết họ tên của nhân viên và số lượng đề án mà nhân viên đó đã tham gia.
SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên nhân viên', COUNT(PHANCONG.MA_NVIEN) AS'Số lượng đề án tham gia'
FROM NHANVIEN, DEAN, PHANCONG
WHERE NHANVIEN.MANV = PHANCONG.MA_NVIEN AND DEAN.MADA = PHANCONG.MADA
GROUP BY (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV)

--30. Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc cho phòng ban đó.
SELECT PHONGBAN.MAPHG, PHONGBAN.TENPHG, AVG(NHANVIEN.LUONG) AS 'Lương trung bình'
FROM NHANVIEN, PHONGBAN
WHERE NHANVIEN.PHG = PHONGBAN.MAPHG
GROUP BY PHONGBAN.MAPHG, PHONGBAN.TENPHG

--31.Với các phòng ban có mức lương trung bình trên 5.200.000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó.
SELECT PHONGBAN.TENPHG, COUNT(NHANVIEN.MANV) AS N'Số lượng nhân viên'
FROM NHANVIEN, PHONGBAN
WHERE NHANVIEN.PHG = PHONGBAN.MAPHG
GROUP BY PHONGBAN.TENPHG
HAVING AVG(NHANVIEN.LUONG)>5200000

--32. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì.
SELECT PHONGBAN.TENPHG, COUNT(DEAN.PHONG) AS 'Số lượng đề án'
FROM PHONGBAN, DEAN
WHERE PHONGBAN.MAPHG = DEAN.PHONG
GROUP BY PHONGBAN.TENPHG

--33. Với mỗi phòng ban, cho biết tên phòng ban, họ tên người trưởng phòng và số lượng đề án mà phòng ban đó chủ trì.
SELECT PHONGBAN.TENPHG, (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên trưởng phòng', COUNT(DEAN.PHONG) AS 'Số lượng đề án'
FROM NHANVIEN, PHONGBAN, DEAN
WHERE NHANVIEN.MANV = PHONGBAN.TRPHG AND PHONGBAN.MAPHG = DEAN.PHONG
GROUP BY PHONGBAN.TENPHG, (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV)

--34. Với mỗi đề án, cho biết tên đề án và số lượng nhân viên tham gia đề án
SELECT DEAN.MADA, DEAN.TENDA, COUNT(DEAN.MADA) AS 'Số lượng công việc'
FROM DEAN, CONGVIEC
WHERE DEAN.MADA = CONGVIEC.MADA
GROUP BY DEAN.MADA, DEAN.TENDA