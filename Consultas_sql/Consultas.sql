
USE AdventureWorksS2017;

-- CONSULTA NÚMERO 1 

WITH SalesUSA AS (
    SELECT 
        SOH.OrderDate,
        SUM(SOD.LineTotal) AS SalesUSA
    FROM SalesOrderHeader AS SOH
    INNER JOIN SalesOrderDetail AS SOD
        ON SOH.SalesOrderID = SOD.SalesOrderID
    INNER JOIN SalesTerritory AS ST
        ON SOH.TerritoryID = ST.TerritoryID
    WHERE ST.`Group` = 'North America'
    GROUP BY OrderDate
),
SalesEU AS (
    SELECT 
        SOH.OrderDate,
        SUM(SOD.LineTotal) AS SalesEU   
    FROM SalesOrderHeader AS SOH
    INNER JOIN SalesOrderDetail AS SOD
        ON SOH.SalesOrderID = SOD.SalesOrderID
    INNER JOIN SalesTerritory AS ST
        ON SOH.TerritoryID = ST.TerritoryID
    WHERE ST.`Group` = 'Europe'
    GROUP BY OrderDate
),
SalesPac AS (
    SELECT 
        SOH.OrderDate,
        SUM(SOD.LineTotal) AS SalesPac   
    FROM SalesOrderHeader AS SOH
    INNER JOIN SalesOrderDetail AS SOD
        ON SOH.SalesOrderID = SOD.SalesOrderID
    INNER JOIN SalesTerritory AS ST
        ON SOH.TerritoryID = ST.TerritoryID
    WHERE ST.`Group` = 'Pacific'
    GROUP BY OrderDate
),
TotalSales AS ( 
    SELECT 
        SOH.OrderDate,
        SUM(SOD.LineTotal) AS TotalSales
    FROM SalesOrderHeader AS SOH
    INNER JOIN SalesOrderDetail AS SOD
        ON SOH.SalesOrderID = SOD.SalesOrderID
    GROUP BY OrderDate
)

SELECT 
    TS.OrderDate,
    TS.TotalSales,
    USA.SalesUSA,
    EU.SalesEU,
    Pac.SalesPac
FROM 
    TotalSales AS TS
    LEFT JOIN SalesUSA AS USA 
        ON TS.OrderDate = USA.OrderDate
    LEFT JOIN SalesEU AS EU 
        ON TS.OrderDate = EU.OrderDate
    LEFT JOIN SalesPac AS Pac 
        ON TS.OrderDate = Pac.OrderDate
	WHERE YEAR(TS.OrderDate) BETWEEN 2011 AND 2014
ORDER BY 
    TS.OrderDate;


-- CONSULTA NÚMERO 2

SELECT 
    SUM(SOD.LineTotal) AS TotalAmount,
    SOH.CustomerID,
    ST.Name AS Country,
    ST.CountryRegionCode,
    ST.`Group`,
    C.PersonID,
    PS.PersonType,
    PD.DateFirstPurchase,
    PD.BirthDate,
	TIMESTAMPDIFF(YEAR, PD.BirthDate, CURDATE()) AS AGE,
    PD.MaritalStatus,
    PD.YearlyIncome,
    PD.Gender,
    PD.TotalChildren,
    PD.Education,
    PD.Occupation,
    PD.HomeOwnerFlag,
    PD.NumberCarsOwned
FROM Customer AS C
LEFT JOIN Person AS PS
	ON C.PersonID = PS.BusinessEntityID
LEFT JOIN SalesOrderHeader AS SOH
	ON C.CustomerID = SOH.CustomerID
LEFT JOIN SalesOrderDetail AS SOD
	ON SOH.SalesOrderID = SOD.SalesOrderID
LEFT JOIN SalesTerritory AS ST
	ON ST.TerritoryID = C.TerritoryID
LEFT JOIN vpersondemopgraphics AS PD
    ON PD.BusinessEntityID = C.PersonID
WHERE PS.PersonType = 'IN' 
GROUP BY 
    SOH.CustomerID,
    ST.Name,
    ST.CountryRegionCode,
    ST.`Group`,
    C.PersonID,
    PS.PersonType,
	PD.DateFirstPurchase,
    PD.BirthDate,
	PD.MaritalStatus,
    PD.YearlyIncome,
    PD.Gender,
    PD.TotalChildren,
    PD.Education,
    PD.Occupation,
    PD.HomeOwnerFlag,
    PD.NumberCarsOwned
    ORDER BY CustomerID
    
    
    
    
    -- CONSULTA NÚMERO 3
    
    SELECT 
	SUM(sog.SubTotal) AS TotalAmount,
	IFNULL(BikePurchase.BikePurchase, 0) AS BikePurchase,
	sog.CustomerID, 
	sst.Name AS Country,
	sst.CountryRegionCode,
	sst.Group,
	sc.PersonID,
	pp.PersonType,
	vpd.DateFirstPurchase,
	vpd.BirthDate, 
	TIMESTAMPDIFF(year,vpd.BirthDate, NOW()) AS Age,
	vpd.MaritalStatus, 
	vpd.YearlyIncome, 
	vpd.Gender, 
	vpd.TotalChildren, 
	vpd.Education, 
	vpd.Occupation, 
	vpd.HomeOwnerFlag, 
	vpd.NumberCarsOwned
FROM SalesOrderHeader AS sog
	LEFT JOIN Customer AS sc 
		ON sc.CustomerID = sog.CustomerID 
	INNER JOIN Person AS pp 
		ON pp.BusinessEntityID=sc.PersonID
	LEFT JOIN SalesTerritory AS sst 
		ON sst.TerritoryID = sOG.TerritoryID
	LEFT JOIN  vpersondemopgraphics AS vpd 
		ON vpd.BusinessEntityID = sc.PersonID 
	LEFT JOIN (			
				SELECT DISTINCT soh.CustomerID,
								1 AS BikePurchase
				FROM SalesOrderDetail AS sod
					INNER JOIN SalesOrderHeader AS SOh 
						ON soH.SalesOrderID = sod.SalesOrderID
					INNER JOIN Customer AS sc 
						ON sc.CustomerID = soh.CustomerID 
					INNER JOIN Product AS pp 
						ON pp.ProductID = sod.ProductID
					INNER JOIN ProductSubcategory AS pps 
						ON pps.ProductSubCategoryID = pp.ProductSubcategoryID
				WHERE pps.ProductSubcategoryID IN (1,2,3)
				) AS BikePurchase ON BikePurchase.CustomerID = sog.CustomerID
WHERE pp.PersonType = 'IN'
GROUP BY BikePurchase.BikePurchase, 
		sog.CustomerID, 
		sst.Name,
		sst.CountryRegionCode,
		sst.Group,
		sc.PersonID,
		pp.PersonType,
		vpd.DateFirstPurchase,
		vpd.BirthDate, 
		vpd.MaritalStatus, 
		vpd.YearlyIncome, 
		vpd.Gender, 
		vpd.TotalChildren, 
		vpd.Education, 
		vpd.Occupation, 
		vpd.HomeOwnerFlag, 
		vpd.NumberCarsOwned
ORDER BY vpd.DateFirstPurchase ASC;