-- Query to join all three tables( Orders, Returns and People) to get the data in a single table for reporting.
Use [Online Store]
SELECT * INTO tbl_StoreOrderMaster from (SELECT        Orders.Category, Orders.City, Orders.Country, Orders.Customer_ID, Orders.Customer_Name, Orders.Discount, Orders.Number_of_Records, Orders.Order_Date, Orders.Order_ID, Orders.Postal_Code, Orders.Product_ID, 
                         Orders.Product_Name, Orders.Profit, Orders.Quantity, Orders.Region, Orders.Row_ID, Orders.Sales, Orders.Segment, Orders.Ship_Date, Orders.Ship_Mode, Orders.State, Orders.Sub_Category, 
                         [Returns].Returned AS [Returned Status], People.Person AS [Area Manager]
FROM            Orders LEFT OUTER JOIN
                         [Returns] ON Orders.Order_ID = [Returns].[Order ID] LEFT OUTER JOIN
                         People ON Orders.Region = People.Region) Final

--Flag to get the Orders Above $2000. Around the Test Case 1
Alter Table tbl_StoreOrderMaster
Add [Order Above $2000] varchar(10)
Update tbl_StoreOrderMaster
SET [Order Above $2000]='Yes'
WHERE [Sales]>2000

-- Customers with total Purchase value more than $2000. Around the Test Case 1
Alter Table tbl_StoreOrderMaster
Add [Customer with Total Purchase >2000] varchar(10)

Update tbl_StoreOrderMaster
SET [Customer with Total Purchase >2000]='Yes'
WHERE [Customer_Name] IN ( Select [Customer_Name] 
	from 
		tbl_StoreOrderMaster group by  [Customer_Name] having SUM(Sales)>2000)

--Returning Customers and One time customers (Customer who have placed multiple orders and only one order)
Alter Table tbl_StoreOrderMaster
ADD [Valued Customers] int

Update tbl_StoreOrderMaster
SET [Valued Customers]=1
WHERE [Customer_name] IN ( SELECT [Customer_name] 
	from 
		(SELECT [Customer_name], Customer_ID, ROW_NUMBER() OVER (PARTITION BY [Customer_ID] Order by [Customer_ID]) AS RN  
			from 
				tbl_StoreOrderMaster) Customer where Customer.RN>1)

--One Time customer 
Update tbl_StoreOrderMaster
SET [Valued Customers]=0
WHERE [Customer_name] NOT IN (  SELECT  distinct [Customer_name] 
	from 
		(SELECT [Customer_name], Customer_ID, ROW_NUMBER() OVER (PARTITION BY [Customer_ID] Order by [Customer_ID]) AS RN  
			from tbl_StoreOrderMaster) Customer where Customer.RN>1)

--Returning customers for same product ordered before
Alter Table tbl_StoreOrderMaster
ADD [Product purchased more than once by a customer] int

Update tbl_StoreOrderMaster
SET [Product purchased more than once by a customer]=1
WHERE [Customer_name] IN 
(SELECT [Customer_name] 
	from 
	(SELECT [Customer_name], Customer_ID,[Product_name], ROW_NUMBER() OVER (PARTITION BY [Customer_ID], [Product_ID] Order by [Customer_ID]) AS RN  
		from 
			tbl_StoreOrderMaster) Customer where Customer.RN>1)
AND
 [Product_Name] IN 
 (SELECT [Product_Name] 
	from 
	(SELECT [Customer_name], Customer_ID,[Product_name], ROW_NUMBER() OVER (PARTITION BY [Customer_ID], [Product_ID] Order by [Customer_ID]) AS RN 
		from 
			tbl_StoreOrderMaster) Customer where Customer.RN>1)



--Cutomer with max orders returned.

--Aeging from Order Date to Ship Date
Alter Table tbl_StoreOrderMaster
ADD [Days to Ship] int

Update tbl_StoreOrderMaster
SET [Days to Ship] = DATEDIFF(d,[Order_Date],[Ship_Date])
	from 
		tbl_StoreOrderMaster

--Final table
SELECT * from tbl_StoreOrderMaster
