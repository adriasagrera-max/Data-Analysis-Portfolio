
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