-- Data Cleaning

--DimCustomer
select * from DimCustomer;

select distinct gender from DimCustomer;

alter table dimcustomer
drop column namestyle;

UPDATE DimCustomer
SET Title = 
CASE 
    WHEN Gender IS NULL OR MaritalStatus IS NULL THEN 'Unknown'
    WHEN Gender = 'M' THEN 'Mr'
    WHEN Gender = 'F' AND MaritalStatus = 'M' THEN 'Mrs'
    WHEN Gender = 'F' AND MaritalStatus = 'S' THEN 'Ms'
    ELSE NULL
END;

UPDATE DimCustomer
SET LastName = 
    CASE 
        WHEN Suffix IS NOT NULL THEN COALESCE(LastName, '') + ' ' + Suffix
        ELSE LastName
    END;

ALTER TABLE DimCustomer DROP COLUMN Suffix;

alter table dimcustomer
alter column gender varchar(10);

UPDATE DimCustomer
SET gender = CASE
    WHEN gender = 'M' THEN 'Male'
    WHEN gender = 'F' THEN 'Female'
    ELSE NULL
END;

alter table dimcustomer
alter column MaritalStatus varchar(10);

update DimCustomer
set MaritalStatus = case
when MaritalStatus = 'M' then 'Married'
When MaritalStatus = 'S' Then 'Single'
else null
end;

alter table dimcustomer
alter column HouseOwnerFlag int;


-- DimEmployee
select * from DimEmployee;

alter table DimEmployee
drop column ParentEmployeeNationalIdAlternateKey;

update DimEmployee
Set Status = 'Left' where Status is null;  

alter table DimEmployee
drop column NameStyle;

-- DimGeography
select * from DimGeography;
-- Everything looks fine


-- DimOrganization
select * from DimOrganization;
-- Everything looks fine

--DimProduct
select * from DimProduct;
-- Everything looks fine

--DimProductCategory
Select * from DimProductCategory;
-- Everything looks fine

--DimProductSubCategory
select * from DimProductSubcategory;
-- Everything looks fine


-- DimReseller
select * from DimReseller;

update DimReseller
set OrderFrequency = 
case
when OrderFrequency = 'S' then 'Seasonal'
when OrderFrequency = 'Q' then 'Quarterly'
when OrderFrequency = 'A' then 'Annual'
else OrderFrequency
end;

Alter table dimreseller
Alter column orderfrequency varchar(20);

--DimSalesReason
select * from DimSalesReason;
-- everything looks fine

--DimSalesTerritory
select * from DimSalesTerritory;
-- everything looks fine

--DimScenario
select * from DimScenario;
-- everything looks fine

select * from DimCustomer;
update dimcustomer
set middlename = 'A' where CustomerKey = 11000;


select * from FactInternetSales;

ALTER TABLE FactInternetSales 
ADD ProductPrice DECIMAL(18,2);

ALTER TABLE FactInternetSales 
ADD ProductPrice DECIMAL(18,2);

UPDATE FactInternetSales 
SET ProductPrice = fs.SalesAmount * fc.AverageRate
FROM FactInternetSales fs
JOIN FactCurrencyRate fc 
    ON fs.OrderDateKey = fc.DateKey 
    AND fs.CurrencyKey = fc.CurrencyKey;

select top 10 a.ProductKey, a.OrderDateKey, a.CurrencyKey, b.averagerate, a.SalesOrderNumber, a.SalesAmount,a.productPrice
from FactInternetSales a inner join FactCurrencyRate b on a.CurrencyKey = b.CurrencyKey order by a.SalesAmount ;

select * from DimCurrency;

select * from FactCurrencyRate where DateKey = 20121230;

select * from DimDate where EnglishMonthName = 'April';

-- Previous Year Sales
select year(orderdate), sum(salesamount) from FactResellerSales group by year(orderdate);

select * from DimEmployee;

select distinct baserate from DimEmployee ;

select EmployeeKey from DimEmployee where SalesPersonFlag = 1;
select * from FactSalesQuota;
select distinct EmployeeKey from FactResellerSales;
select employeekey, sum(salesamountquota) from FactSalesQuota group by employeekey order by sum(salesamountquota) desc;

select * from FactInternetSales;


ALTER TABLE FactInternetSales 
add productprice decimal(14,4);

UPDATE FactInternetSales 
SET ProductPrice = fs.SalesAmount / fc.AverageRate
FROM FactInternetSales fs
JOIN FactCurrencyRate fc 
    ON fs.OrderDateKey = fc.DateKey 
    AND fs.CurrencyKey = fc.CurrencyKey;

select SalesOrderNumber, ProductStandardCost, SalesAmount, ProductPrice from FactInternetSales;

select year(orderdate) as year, sum(productprice) as CurrentYearSales, LAG(sum(productprice),1) over(order by year(OrderDate)) as PreviousYearSales
from FactInternetSales 
group by year(orderdate) order by year;

SELECT * INTO PreviousYearSales 
FROM (
    SELECT 
        YEAR(OrderDate) AS Year, 
        SUM(ProductPrice) AS CurrentYearSales, 
        LAG(SUM(ProductPrice), 1) OVER (ORDER BY YEAR(OrderDate)) AS PreviousYearSales
    FROM FactInternetSales 
    GROUP BY YEAR(OrderDate)
) AS SalesData;

drop table PreviousYearSales;

select * from PreviousYearSales;

select orderdate, sum(productprice) from FactInternetSales group by orderdate;

select * into PreviousYearSales from(
select orderdate, sum(productprice) as Sales from FactInternetSales group by orderdate) as a;


create table months(MonthName varchar(20));
select * from months;
insert into months(MonthName) values('January'),('February'),('March'),('April'),('May'),('June'),('July'),('August'),('September'),('October'),
('November'),('December');