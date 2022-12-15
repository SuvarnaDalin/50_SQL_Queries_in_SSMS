-- 1. From the following table write a query in SQL to retrieve all rows and columns from the employee table in the Adventureworks 
-- database. Sort the result set in ascending order on jobtitle.
-- Sample table: HumanResources.Employee

select * from HumanResources.Employee
order by JobTitle;

-- 2. From the following table write a query in SQL to retrieve all rows and columns from the employee table using table aliasing 
-- in the Adventureworks database. Sort the output in ascending order on lastname.
-- Sample table: Person.Person
select e.* 
from Person.Person as e
order by LastName;

-- 3. From the following table write a query in SQL to return all rows and a subset of the columns (FirstName, LastName, 
-- businessentityid) from the person table in the AdventureWorks database. The third column heading is renamed to Employee_id. 
-- Arrange the output in ascending order by lastname.
-- Sample table: Person.Person
select e.FirstName, e.LastName, e.BusinessEntityID as Employee_id
from Person.Person as e
order by LastName;


-- 4. From the following table write a query in SQL to return only the rows for product that have a sellstartdate that is not 
-- NULL and a productline of 'T'. Return productid, productnumber, and name. Arranged the output in ascending order on name.
-- Sample table: production.Product
select pr.ProductID, pr.ProductNumber, pr.Name
from Production.Product as pr
where pr.SellStartDate is not null and pr.ProductLine = 'T'
order by Name;

-- 5. From the following table write a query in SQL to return all rows from the salesorderheader table in Adventureworks database 
-- and calculate the percentage of tax on the subtotal have decided. Return salesorderid, customerid, orderdate, subtotal, 
-- percentage of tax column. Arranged the result set in descending order on subtotal.
-- Sample table: sales.salesorderheader
select so.SalesOrderID, so.CustomerID, so.OrderDate, so.SubTotal, so.TaxAmt/so.SubTotal*100 as tax_percentage
from Sales.SalesOrderHeader as so
order by SubTotal desc;


-- 6. From the following table write a query in SQL to create a list of unique jobtitles in the employee table in Adventureworks 
-- database. Return jobtitle column and arranged the resultset in ascending order.
-- Sample table: HumanResources.Employee
select JobTitle from HumanResources.Employee
group by JobTitle
order by JobTitle;

-- OR --

select distinct JobTitle from HumanResources.Employee
order by JobTitle;

-- 7. From the following table write a query in SQL to calculate the total freight paid by each customer. 
-- Return customerid and total freight. Sort the output in ascending order on customerid.
-- Sample table: sales.salesorderheader
select CustomerID, sum(Freight) as Total_Freight
from Sales.SalesOrderHeader
group by CustomerID
order by CustomerID;

-- 8. From the following table write a query in SQL to find the average and the sum of the subtotal for every customer. 
-- Return customerid, average and sum of the subtotal. Grouped the result on customerid and salespersonid. 
-- Sort the result on customerid column in descending order.
-- Sample table: sales.salesorderheader
select CustomerID, SalesPersonID, AVG(SubTotal) as Avg_SubTotal, SUM(SubTotal) as Total_Subtotal
from Sales.SalesOrderHeader
group by CustomerID, SalesPersonID
order by CustomerID desc;

-- 9. From the following table write a query in SQL to retrieve total quantity of each productid which are in shelf of 'A' or 'C' 
-- or 'H'. Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. Sort the results 
-- according to the productid in ascending order.
-- Sample table: production.productinventory
select ProductID, sum(Quantity) as Total_Quantity
from Production.ProductInventory
where(Shelf = 'A' or Shelf = 'C' or Shelf = 'H')
group by ProductID
having sum(Quantity) > 500
order by ProductID;


-- 10. From the following table write a query in SQL to find the total quantity for a group of locationid multiplied by 10.  
-- Sample table: production.productinventory
select sum(Quantity) as Total_Quantity
from Production.ProductInventory
group by (LocationID*10);


-- 11. From the following tables write a query in SQL to find the persons whose last name starts with letter 'L'. 
-- Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname.  
-- Sample table: Person.PersonPhone, Person.Person
select ph.BusinessEntityID, p.FirstName, p.LastName, ph.PhoneNumber
from Person.Person as p join Person.PersonPhone as ph
on (p.BusinessEntityID = ph.BusinessEntityID)
where LastName like 'L%'
order by Lastname, FirstName;


-- 12. From the following table write a query in SQL to find the sum of subtotal column. Group the sum on distinct salespersonid 
-- and customerid. Rolls up the results into subtotal and running total. Return salespersonid, customerid and sum of subtotal 
-- column i.e. sum_subtotal.
-- Sample table: sales.salesorderheader
select SalesPersonID, CustomerID, sum(SubTotal) as sum_subtotal
from Sales.SalesOrderHeader
group by rollup (SalesPersonID, CustomerID);

-- 13. From the following table write a query in SQL to find the sum of the quantity of all combination of group of distinct 
-- locationid and shelf column. Return locationid, shelf and sum of quantity as TotalQuantity.
-- Sample table: production.productinventory  ***** CUBE - GROUP OF DISTINCT COMBINATIONS
select LocationID, Shelf, sum(Quantity) as TotalQuantity
from Production.ProductInventory
group by cube (LocationID, Shelf);

-- 14. From the following table write a query in SQL to find the sum of the quantity with subtotal for each locationid. 
-- Group the results for all combination of distinct locationid and shelf column. Rolls up the results into subtotal and 
-- running total. Return locationid, shelf and sum of quantity as TotalQuantity.  
-- Sample table: production.productinventory
select LocationID, Shelf, sum(Quantity) as TotalQuantity
from Production.ProductInventory
group by grouping sets (rollup(LocationID, Shelf), cube (LocationID, Shelf));

-- 15. From the following table write a query in SQL to find the total quantity for each locationid and calculate the grand-total 
-- for all locations. Return locationid and total quantity. Group the results on locationid.  
-- Sample table: production.productinventory
select LocationID, sum(Quantity) as TotalQuantity
from Production.ProductInventory
group by grouping sets (LocationID, ());

-- 16. From the following table write a query in SQL to retrieve the number of employees for each City. Return city and number of employees. 
-- Sort the result in ascending order on city.
-- Sample table: Person.BusinessEntityAddress
select pa.City, count(pb.BusinessEntityID) as Emp_Count
from Person.BusinessEntityAddress as pb join Person.Address as pa
on (pa.AddressID = pb.AddressID)
group by pa.City
order by pa.City;

-- 17. From the following table write a query in SQL to retrieve the total sales for each year. Return the year part of order date and total 
-- due amount. Sort the result in ascending order on year part of order date.  
-- Sample table: Sales.SalesOrderHeader
select year(OrderDate) as Ordered_Year, sum(TotalDue) as Total_Dues
from Sales.SalesOrderHeader
group by year(OrderDate)
order by year(OrderDate);


-- 18. From the following table write a query in SQL to retrieve the total sales for each year. Filter the result set for those orders 
-- where order year is on or before 2016. Return the year part of orderdate and total due amount. 
-- Sort the result in ascending order on year part of order date.  
-- Sample table: Sales.SalesOrderHeader
select year(OrderDate) as Ordered_Year, sum(TotalDue) as Total_Due_Amt
from Sales.SalesOrderHeader
where year(OrderDate) <= 2016
group by year(OrderDate)
order by year(OrderDate);

-- 19. From the following table write a query in SQL to find the contacts who are designated as a manager in various departments. 
-- Returns ContactTypeID, name. Sort the result set in descending order. 
-- Sample table: Person.ContactType
select ContactTypeID, Name
from Person.ContactType
where Name like '%Manager'
order by ContactTypeID desc;


-- 20. From the following tables write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. 
-- Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName.  
-- Sample table: Person.BusinessEntityContact
select pbe.BusinessEntityID, pp.LastName, pp.FirstName
from Person.Person as pp join Person.BusinessEntityContact as pbe on (pp.BusinessEntityID = pbe.PersonID)
						 join Person.ContactType as pct on (pbe.ContactTypeID = pct.ContactTypeID)
where pct.Name = 'Purchasing Manager'
order by pp.LastName, pp.FirstName;

-- 21. From the following tables write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and 
-- SalesYTD is not zero. Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. 
-- Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.  
-- Sample table: Sales.SalesPerson, Person.Person, Person.Address
select row_number() over (partition by pa.PostalCode order by sp.SalesYTD desc) as row_no, 
LastName, SalesYTD, PostalCode
from Sales.SalesPerson as sp 
	inner join Person.Person as pp
		on sp.BusinessEntityID = pp.BusinessEntityID
	inner join Person.Address as pa
		on pp.BusinessEntityID = pa.AddressID
where sp.TerritoryID is not null and sp.SalesYTD <> 0
order by PostalCode;

-- 22. From the following table write a query in SQL to count the number of contacts for combination of each type and name. 
-- Filter the output for those who have 100 or more contacts. Return ContactTypeID and ContactTypeName and BusinessEntityContact. 
-- Sort the result set in descending order on number of contacts.  
-- Sample table: Person.BusinessEntityContact, Person.ContactType
select pct.ContactTypeID, pct.Name, count(*) as no_of_contacts
from Person.BusinessEntityContact as pbc
	inner join Person.ContactType as pct
		on (pbc.ContactTypeID = pct.ContactTypeID)
group by pct.ContactTypeID, pct.Name
having count(*) > 100
order by count(*) desc;

-- 23. From the following table write a query in SQL to retrieve the RateChangeDate, full name (first name, middle name and last name) 
-- and weekly salary (40 hours in a week) of employees. In the output the RateChangeDate should appears in date format. 
-- Sort the output in ascending order on NameInFull.  
-- Sample table: HumanResources.EmployeePayHistory, Person.Person
select convert(date, hre.RateChangeDate) as RateChangeDate, 
CONCAT(pp.FirstName, ' ', pp.MiddleName, ' ', pp.LastName) as Full_Name, 
hre.Rate*40 as Weekly_salary
from Person.Person as pp
	inner join HumanResources.EmployeePayHistory as hre
		on (hre.BusinessEntityID = pp.BusinessEntityID)
order by Full_Name;

-- 24. From the following tables write a query in SQL to calculate and display the latest weekly salary of each employee. 
-- Return RateChangeDate, full name (last name, middle name, first name) and weekly salary (40 hours in a week) of employees 
-- Sort the output in ascending order on NameInFull.  
-- Sample table: Person.Person, HumanResources.EmployeePayHistory
select convert(date, hre.RateChangeDate) as RateChangeDate, 
CONCAT(pp.LastName, ' ', pp.MiddleName, ' ', pp.FirstName) as Full_Name, 
hre.Rate*40 as Weekly_salary
from Person.Person as pp
	inner join HumanResources.EmployeePayHistory as hre
		on (hre.BusinessEntityID = pp.BusinessEntityID)
order by Full_Name;

-- 25. From the following table write a query in SQL to find the sum, average, count, minimum, and maximum order quantity for those orders 
-- whose id are 43659 and 43664. Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity.  
-- Sample table: Sales.SalesOrderDetail

select SalesOrderID, ProductID, OrderQty, 
sum(OrderQty) over (partition by SalesOrderID) as Tot_Qty, 
avg(OrderQty) over (partition by SalesOrderID) as Avg_Qty, 
count(OrderQty) over (partition by SalesOrderID) as Count_Qty, 
min(OrderQty) over (partition by SalesOrderID) as Min_Qty, 
max(OrderQty) over (partition by SalesOrderID) as Max_Qty
from Sales.SalesOrderDetail
where SalesOrderID in (43659,43664);

-- 26. From the following table write a query in SQL to find the sum, average, and number of order quantity for those orders whose ids are 
-- 43659 and 43664 and product id starting with '71'. Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order 
-- quantity.
-- Sample table: Sales.SalesOrderDetail
select SalesOrderID, ProductID, OrderQty, 
sum(OrderQty) over (partition by SalesOrderID) as Tot_Qty, 
avg(OrderQty) over (partition by SalesOrderID) as Avg_Qty, 
count(OrderQty) over (partition by SalesOrderID) as Count_Qty
from Sales.SalesOrderDetail
where SalesOrderID in (43659,43664) and cast(ProductID as varchar) like '71%';

-- 27. From the following table write a query in SQL to retrieve the total cost of each salesorderID that exceeds 100000. Return SalesOrderID, 
-- total cost.
-- Sample table: Sales.SalesOrderDetail
select SalesOrderID, sum(UnitPrice*OrderQty) as Total_Cost
from Sales.SalesOrderDetail
group by SalesOrderID
having sum(UnitPrice*OrderQty) > 100000;

-- 28. From the following table write a query in SQL to retrieve products whose names start with 'Lock Washer'. Return product ID, and name and 
-- order the result set in ascending order on product ID column.  
-- Sample table: Production.Product
select ProductID, Name
from Production.Product
where Name like 'Lock Washer%'
order by ProductID;

-- 29. Write a query in SQL to fetch rows from product table and order the result set on an unspecified column listprice. Return product ID, 
-- name, and color of the product.
-- Sample table: Production.Product
select ProductID, Name, Color
from Production.Product
order by ListPrice;

-- 30. From the following table write a query in SQL to retrieve records of employees. Order the output on year (default ascending order) of 
-- hiredate. Return BusinessEntityID, JobTitle, and HireDate. 
-- Sample table: HumanResources.Employee
select BusinessEntityID, JobTitle, HireDate
from HumanResources.Employee
order by HireDate;

-- 31. From the following table write a query in SQL to retrieve those persons whose last name begins with letter 'R'. Return lastname, and 
-- firstname and display the result in ascending order on firstname and descending order on lastname columns.  
-- Sample table: Person.Person
select LastName, FirstName
from Person.Person
where LastName like 'R%'
order by FirstName, LastName desc;

-- 32. From the following table write a query in SQL to ordered the BusinessEntityID column descendingly when SalariedFlag set to 'true' and 
-- BusinessEntityID in ascending order when SalariedFlag set to 'false'. Return BusinessEntityID, SalariedFlag columns.
-- Sample table: HumanResources.Employee
select BusinessEntityID, 
case when SalariedFlag = 1 then 'True' else 'False' end as SalaryFlag
from HumanResources.Employee
order by case when SalariedFlag = 'True' then BusinessEntityID end desc,
		 case when SalariedFlag = 'False' then BusinessEntityID end;

-- 33. From the following table write a query in SQL to set the result in order by the column TerritoryName when the column CountryRegionName 
-- is equal to 'United States' and by CountryRegionName for all other rows.
-- Sample table: Sales.SalesTerritory, Person.CountryRegion
select cr.Name as Country_RegionName, st.Name as TerritoryName
from Sales.SalesTerritory as st
	inner join Person.CountryRegion as cr
		on (st.CountryRegionCode = cr.CountryRegionCode)
order by case when cr.Name = 'United States' then st.Name end,
		 case when cr.Name <> 'United States' then cr.Name end;

-- 34. From the following table write a query in SQL to find those persons who lives in a territory and the value of salesytd except 0. 
-- Return first name, last name,row number as 'Row Number', 'Rank', 'Dense Rank' and NTILE as 'Quartile', salesytd and postalcode. 
-- Order the output on postalcode column. 
-- Sample table: Sales.SalesPerson, Person.Person, Person.Address

select pp.FirstName, pp.LastName,
row_number() over (order by pa.PostalCode) as 'Row Number',
rank() over (order by pa.PostalCode) as 'Rank',
dense_rank() over (order by pa.PostalCode) as 'Dense Rank',
ntile(4) over (order by pa.PostalCode)  as 'Quartile',
sp.SalesYTD, pa.PostalCode
from Sales.SalesPerson as sp
	inner join Person.Person as pp
		on(sp.BusinessEntityID = pp.BusinessEntityID)
	inner join Person.Address as pa
		on(pp.BusinessEntityID = pa.AddressID)
where TerritoryID is not null and SalesYTD <> 0;

-- 35. From the following table write a query in SQL to skip the first 10 rows from the sorted result set and return all remaining rows.  
-- Sample table: HumanResources.Department
select * 
from HumanResources.Department
where DepartmentID > 10;

-- 36. From the following table write a query in SQL to skip the first 5 rows and return the next 5 rows from the sorted result set.  
-- Sample table: HumanResources.Department
select * 
from HumanResources.Department
where DepartmentID > 5 and DepartmentID < 11;

-- 37. From the following table write a query in SQL to list all the products that are Red or Blue in color. Return name, color and listprice.
-- Sorts this result by the column listprice.
-- Sample table: Production.Product
select Name, Color, ListPrice
from Production.Product
where Color in ('Red', 'Blue')
order by ListPrice;

-- 38. Create a SQL query from the SalesOrderDetail table to retrieve the product name and any associated sales orders. 
-- Additionally, it returns any sales orders that don't have any items mentioned in the Product table as well as any products that have sales 
-- orders other than those that are listed there. Return product name, salesorderid. Sort the result set on product name column.  
-- Sample table: Production.Product, Sales.SalesOrderDetail
select p.Name as Product_Name, s.SalesOrderID
from Production.Product as p
	full outer join Sales.SalesOrderDetail as s
		on (p.ProductID = s.ProductID)
order by Product_Name;

-- 39. From the following table write a SQL query to retrieve the product name and salesorderid. Both ordered and unordered products are 
-- included in the result set.  
-- Sample table: Production.Product, Sales.SalesOrderDetail
select p.Name as Product_Name, s.SalesOrderID
from Production.Product as p
	left outer join Sales.SalesOrderDetail as s
		on (p.ProductID = s.ProductID)
order by Product_Name;

-- 40. From the following tables write a SQL query to get all product names and sales order IDs. Order the result set on product name column.  
-- Sample table: Production.Product, Sales.SalesOrderDetail
select p.Name as Product_Name, s.SalesOrderID
from Production.Product as p
	inner join Sales.SalesOrderDetail as s
		on (p.ProductID = s.ProductID)
order by Product_Name;

-- 41. From the following tables write a SQL query to retrieve the territory name and BusinessEntityID. The result set includes all salespeople,
-- regardless of whether or not they are assigned a territory.  
-- Sample table: Sales.SalesTerritory, Sales.SalesPerson
select st.Name, sp.BusinessEntityID
from Sales.SalesTerritory as st
	right outer join Sales.SalesPerson as sp
		on (st.TerritoryID = sp.TerritoryID);

-- 42. Write a query in SQL to find the employee's full name (firstname and lastname) and city from the following tables. Order the result set 
-- on lastname then by firstname.  
-- Sample table: Person.Person, HumanResources.Employee, Person.Address, Person.BusinessEntityAddress
select concat(FirstName, ' ', LastName) as Full_Name, City
from Person.Person as pp
	inner join Person.BusinessEntityAddress as pba
		on (pp.BusinessEntityID = pba.BusinessEntityID)
	inner join Person.Address as pa
		on (pba.AddressID = pa.AddressID)
order by LastName, FirstName;

-- 43. Write a SQL query to return the businessentityid, firstname and lastname columns of all persons in the person table (derived table) 
-- with persontype is 'IN' and the last name is 'Adams'. Sort the result set in ascending order on firstname. 
-- A SELECT statement after the FROM clause is a derived table. 
-- Sample table: Person.Person
select BusinessEntityID, PersonType, FirstName, LastName
from Person.Person
where PersonType = 'IN' and LastName = 'Adams'
order by FirstName;

---- USING SUB QUERY/ DERIVED TABLE
select BusinessEntityID, PersonType, FirstName, LastName 
from 
	(select * 
	from Person.Person 
	where PersonType = 'IN') as derived_PersonTable
where LastName = 'Adams'
order by FirstName;

-- 44. Create a SQL query to retrieve individuals from the following table with a businessentityid inside 1500, a lastname starting with 'Al', 
-- and a firstname starting with 'M'.  
-- Sample table: Person.Person
select BusinessEntityID, FirstName, LastName
from Person.Person
where BusinessEntityID < 1500 and LastName like 'Al%' and FirstName like 'M%'
order by BusinessEntityID;

-- 45. Write a SQL query to find the productid, name, and colour of the items 'Blade', 'Crown Race' and 'AWC Logo Cap' using a derived table 
--with multiple values.  
--Sample table: Production.Product
select ProductID, Name, Color
from
	(select *
	from Production.Product) as derived_ProductTable
where Name in ('Blade', 'Crown Race', 'AWC Logo Cap');

-- OR using an inner join with the Name column and the 3 values, 'Blade', 'Crown Race', 'AWC Logo Cap' 
select ProductID, n1.Name, Color
from Production.Product as n1
	inner join (Values ('Blade'), ('Crown Race'), ('AWC Logo Cap')) as n2(Name)
		on (n1.Name = n2.Name);

--46. Create a SQL query to display the total number of sales orders each sales representative receives annually. Sort the result set by 
--SalesPersonID and then by the date component of the orderdate in ascending order. Return the year component of the OrderDate, SalesPersonID, 
--and SalesOrderID. 
--Sample table: Sales.SalesOrderHeader
with SalesCTE (SalesPersonID, SalesOrderID, SalesYear)
as
	(select SalesPersonID, SalesOrderID, year(convert(date, OrderDate)) as SalesYear
	from Sales.SalesOrderHeader
	where SalesPersonID is not null)
select SalesPersonID, count(SalesOrderID) as Total_Sales, SalesYear
from SalesCTE
group by SalesYear, SalesPersonID
order by SalesPersonID, SalesYear;

-- 47. From the following table write a query in SQL to find the average number of sales orders for all the years of the sales representatives. 
-- Sample table: Sales.SalesOrderHeader
with TotSales_CTE (Total_Sales)
as
	(select count(SalesOrderID) as Total_Sales
	from Sales.SalesOrderHeader
	where SalesPersonID is not null
	group by SalesPersonID)
select avg(Total_Sales) as Avg_Sales
from TotSales_CTE;

-- 48. Write a SQL query on the following table to retrieve records with the characters green_ in the LargePhotoFileName field. 
--The following table's columns must all be returned.  
--Sample table: Production.ProductPhoto
select *
from Production.ProductPhoto
where LargePhotoFileName like '%green_%';

-- 49. Write a SQL query to retrieve the mailing address for any company that is outside the United States (US) and in a city whose name starts 
-- with Pa. Return Addressline1, Addressline2, city, postalcode, countryregioncode columns.  
-- Sample table: Person.Address, Person.StateProvince
select pa.Addressline1, pa.Addressline2, pa.city, pa.postalcode, ps.countryregioncode
from Person.Address as pa
	inner join Person.StateProvince as ps
		on (pa.StateProvinceID = ps.StateProvinceID)
where CountryRegionCode <> 'US' and City like 'Pa%';

-- 50. From the following table write a query in SQL to fetch first twenty rows. Return jobtitle, hiredate. Order the result set on hiredate 
-- column in descending order. 
-- Sample table: HumanResources.Employee
select top 20 JobTitle, HireDate
from HumanResources.Employee
order by HireDate desc;








