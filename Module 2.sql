--1. Liệt kê danh sách các hóa đơn (SalesOrderID) lặp trong tháng 6 năm 2008 có tổng tiền >70000, thông tin gồm SalesOrderID, Orderdate, SubTotal, trong đó SubTotal=sum(OrderQty*UnitPrice).
SELECT d.SalesOrderID, OrderDate, SubTotal=sum(OrderQty * UnitPrice)
FROM sales.SalesOrderDetail d join Sales.SalesOrderHeader h ON d.SalesOrderID = h.SalesOrderID
WHERE  MONTH(OrderDate) = 6 and YEAR(OrderDate) = 2008  
GROUP BY d.SalesOrderID, OrderDate
HAVING SUM(OrderQty * UnitPrice) > 70000

--2. Đếm tổng số khách hàng và tổng tiền của những khách hàng thuộc các quốc gia có mã vùng là US (lấy thông tin từ các bảng SalesTerritory, Sales.Customer, Sales.SalesOrderHeader, Sales.SalesOrderDetail). Thông tin bao gồm TerritoryID, tổng số khách hàng (countofCus), tổng tiền (Subtotal) với Subtotal = SUM(OrderQty*UnitPrice)
SELECT sst.TerritoryID, count(sc.CustomerID) as 'CountOfCust', sum(ssod.OrderQty * ssod.UnitPrice) as 'Subtotal'
FROM Sales.SalesTerritory as sst join sales.Customer as sc
   ON sst.TerritoryID = sc.TerritoryID
   JOIN Sales.SalesOrderHeader as ssoh
   ON ssoh.TerritoryID = sc.TerritoryID
   JOIN sales.SalesOrderDetail as ssod
   ON SSOD.SalesOrderID = SSOH.SalesOrderID
WHERE SST.CountryRegionCode = 'US'
GROUP BY SST.TerritoryID

--3)Tính tổng trị giá của những hóa đơn với Mã theo dõi giao hàng (CarrierTrackingNumber) có 3 ký tự đầu là 4BD, thông tin bao gồm SalesOrderID, CarrierTrackingNumber, SubTotal=sum(OrderQty*UnitPrice)  
SELECT SalesOrderID, CarrierTrackingNumber, Subtotal=SUM(OrderQty * UnitPrice) 
FROM Sales.SalesOrderDetail
WHERE CarrierTrackingNumber like '4BD%'
GROUP BY SalesOrderID, CarrierTrackingNumber

--4) Liệt kê các sản phẩm (product)có đơn giá (unitPrice)<25 và số lượng bán trung bình >5, thông tin gồm ProductID, name, AverageofQty
SELECT pro.ProductID, pro.Name, AverageofQty=AVG(det.OrderQty) 
FROM Sales.SalesOrderDetail det join Production.Product pro on det.ProductID = pro.ProductID
WHERE det.UnitPrice < 25
GROUP BY pro.ProductID, pro.Name
HAVING AVG(det.OrderQty) > 5

--5) Liệt kê các công việc (JobTitle) có tổng số nhân viên >20 người, thông tin gồm JobTitle, countofPerson=count(*) 
SELECT JobTitle, CountofEmployee=count(BusinessEntityID) 
FROM HumanResources.Employee 
GROUP BY JobTitle
HAVING COUNT(BusinessEntityID) > 20

--6) Tính tổng số lượng và tổng trị giá của các sản phẩm do các nhà cung cấp có tên kết thúc bằng ‘Bicycles’ và tổng trị giá >800000, thông tin gồm BusinessEntityID, Vendor_name, ProductID, sumofQty, SubTotal (sử dụng các bảng [Purchasing].[Vendor] [Purchasing].[PurchaseOrderHeader] và [Purchasing].[PurchaseOrderDetail])
SELECT v.BusinessEntityID, v.Name, ProductID, sumofQty = SUM(OrderQty), SubTotal = SUM(OrderQty * UnitPrice)
FROM Purchasing.Vendor v join Purchasing.PurchaseOrderHeader h on h.VendorID = v.BusinessEntityID
							 join Purchasing.PurchaseOrderDetail d on h.PurchaseOrderID = d.PurchaseOrderID
WHERE v.Name like '%Bicycles'
GROUP BY v.BusinessEntityID, v.Name, ProductID
HAVING SUM(OrderQty * UnitPrice) > 800000

--7) Liệt kê các sản phẩm có trên 500 đơn đặt hàng trong quí 1 năm 2008 và có tổng trị giá >10000, thông tin gồm ProductID, Product_name, countofOrderID và Subtotal
SELECT p.ProductID, p.Name, countofOrderID = COUNT(o.SalesOrderID), Subtotal = sum(OrderQty * UnitPrice) 
FROM Production.Product p join Sales.SalesOrderDetail o on p.ProductID = o.ProductID
								  join sales.SalesOrderHeader h on h.SalesOrderID = o.SalesOrderID
WHERE Datepart(q, OrderDate) =1 and YEAR(OrderDate) = 2008
GROUP BY p.ProductID, p.Name
HAVING sum(OrderQty * UnitPrice) > 10000 and COUNT(o.SalesOrderID) > 500

--8) Liệt kê danh sách các khách hàng có trên 25 hóa đơn đặt hàng từ năm 2007 đến 2008, thông tin gồm mã khách (PersonID) , họ tên (FirstName +' '+ LastName as fullname), Số hóa đơn (CountOfOrders). 
SELECT PersonID, FirstName +' '+ LastName as fullname, CountOfOrders=count(*)
FROM [Person].[Person] p join [Sales].[Customer] c on p.BusinessEntityID=c.CustomerID
						 join [Sales].[SalesOrderHeader] h on h.CustomerID= c.CustomerID
WHERE YEAR([OrderDate])>=2007 and YEAR([OrderDate])<=2008
GROUP BY PersonID, FirstName +' '+ LastName
HAVING count(*)>25

--9) Liệt kê những sản phẩm có tên bắt đầu với ‘Bike’ và ‘Sport’ có tổng số lượng bán trong mỗi mỗi năm trên 500 sản phẩm, thông tin gồm ProductID, Name, CountofOrderQty, year. (dữ liệu lấy từ các bảng  Sales.SalesOrderHeader, Sales.SalesOrderDetail and Production.Product) 
SELECT p.ProductID, Name, CountofOrderQty=sum([OrderQty]), yearofSale=year([OrderDate])
FROM [Production].[Product] p join [Sales].[SalesOrderDetail] d on p.ProductID=d.ProductID
							  join [Sales].[SalesOrderHeader] h on d.SalesOrderID=d.SalesOrderID
WHERE NAME like 'Bike%' or name like 'Sport%'
GROUP BY p.ProductID, Name, year([OrderDate])
HAVING sum([OrderQty])>500

--10) Liệt kê những phòng ban có lương (Rate: lương theo giờ) trung bình >30, thông tin gồm Mã phòng ban (DepartmentID), tên phòng ban (name), Lương trung bình (AvgofRate). Dữ liệu từ các bảng [HumanResources].[Department], [HumanResources].[EmployeeDepartmentHistory], [HumanResources].[EmployeePayHistory]
SELECT d.DepartmentID, d.name, AvgofRate=avg([Rate])
FROM [HumanResources].[Department] d join [HumanResources].[EmployeeDepartmentHistory] h on d.DepartmentID=h.DepartmentID
									 join [HumanResources].[EmployeePayHistory] e on h.BusinessEntityID=e.BusinessEntityID
GROUP BY d.DepartmentID, d.name
HAVING avg([Rate])>30















