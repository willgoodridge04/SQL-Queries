-- Cleansed Dim_Customer Table -- 
SELECT 
  c.[CustomerKey] as CustomerKey, 
  --[GeographyKey]
  --[CustomerAlternateKey]
  --[Title]
  c.[FirstName] as [First Name], 
  --,[MiddleName]
  c.[LastName] as [Last Name], 
  c.FirstName + ' ' + c.LastName as [Full Name], 
  --,[NameStyle]
  --,[BirthDate]
  --,[MaritalStatus]
  --,[Suffix]
  Case c.Gender when 'M' then 'Male' when 'F' then 'Female' end as Gender, -- created case statement to concatenate first and last name
  --,[EmailAddress]
  --,[YearlyIncome]
  --,[TotalChildren]
  --,[NumberChildrenAtHome]
  --,[EnglishEducation]
  --,[SpanishEducation]
  --,[FrenchEducation]
  --,[EnglishOccupation]
  --,[SpanishOccupation]
  --,[FrenchOccupation]
  --,[HouseOwnerFlag]
  --,[NumberCarsOwned]
  --,[AddressLine1]
  --,[AddressLine2]
  --,[Phone]
  c.[DateFirstPurchase] as DateFirstPurchase, 
  g.City as [Customer City] 
  --,[CommuteDistance]
FROM 
  [dbo].[DimCustomer] as c  -- Joined in the Customer City from the Geography Table
  Left Join dbo.DimGeography as g on g.GeographyKey = c.GeographyKey 
order by 
  CustomerKey ASC  -- ordered list by acsending CustomerKey

---------------------------------------------------------------------------------------------

  
-- Cleansed DIM_Date Table --
SELECT 
  [DateKey], 
  [FullDateAlternateKey] as Date, 
  --[DayNumberOfWeek],
  [EnglishDayNameOfWeek] as Day, 
  --[SpanishDayNameOfWeek]
  --[FrenchDayNameOfWeek]
  --[DayNumberOfMonth]
  --[DayNumberOfYear]
  --[WeekNumberOfYear]
  [EnglishMonthName] as Month, 
  Left([EnglishMonthName], 3) as MonthShort, 
  --[SpanishMonthName]
  --[FrenchMonthName]
  [MonthNumberOfYear] as MonthNo, 
  [CalendarQuarter] as Quarter, 
  [CalendarYear] as Year --[CalendarSemester]
  --[FiscalQuarter]
  --[FiscalYear]
  --[FiscalSemester]
FROM 
  [AdventureWorksDW2019].[dbo].[DimDate] 
where 
  CalendarYear >= 2019

---------------------------------------------------------------------------------------------

-- Cleansed Dim_Product Table --
SELECT 
  p.[ProductKey], 
  p.[ProductAlternateKey] as ProductItemCode, 
  --,[ProductSubcategoryKey]
  --,[WeightUnitMeasureCode]
  --,[SizeUnitMeasureCode]
  p.[EnglishProductName] as [Product Name], 
  ps.EnglishProductSubcategoryName as [Sub Category],  -- Joined in from Sub Category Table
  pc.EnglishProductCategoryName as [Product Category], -- Joined in from Category Table
  --,[SpanishProductName]
  --,[FrenchProductName]
  --,[StandardCost]
  --,[FinishedGoodsFlag]
  p.[Color] as [Product Color], 
  --,[SafetyStockLevel]
  --,[ReorderPoint]
  --,[ListPrice]
  p.[Size] as [Product Size], 
  --,[SizeRange]
  --,[Weight]
  --,[DaysToManufacture]
  p.[ProductLine] as [Product Line], 
  --,[DealerPrice]
  --,[Class]
  --,[Style]
  p.[ModelName] as [Product Model Name], 
  --,[LargePhoto]
  p.[EnglishDescription] as [Product Description], 
  --,[FrenchDescription]
  --,[ChineseDescription]
  --,[ArabicDescription]
  --,[HebrewDescription]
  --,[ThaiDescription]
  --,[GermanDescription]
  --,[JapaneseDescription]
  --,[TurkishDescription]
  --,[StartDate]
  --,[EndDate]
  ISNULL (p.Status, 'Outdated') as [Product Status] 
FROM 
  [dbo].[DimProduct] as p 
  Left Join dbo.DimProductSubcategory as ps on ps.ProductSubcategoryKey = p.ProductSubcategoryKey 
  Left Join dbo.DimProductCategory as pc on ps.ProductCategoryKey = pc.ProductCategoryKey 
order by 
  p.ProductKey asc
  
  --------------------------------------------------------------------------------------------------------
  
  -- Cleansed FACT_InternetSales Table -- 
SELECT 
[ProductKey],
[OrderDateKey],
[DueDateKey],
[ShipDateKey],
[CustomerKey],
      --,[PromotionKey]
      --,[CurrencyKey]
      --,[SalesTerritoryKey]
[SalesOrderNumber],
      --,[SalesOrderLineNumber]
      --,[RevisionNumber]
      --,[OrderQuantity]
      --,[UnitPrice]
      --,[ExtendedAmount]
      --,[UnitPriceDiscountPct]
      --,[DiscountAmount]
      --,[ProductStandardCost]
      --,[TotalProductCost]
[SalesAmount]
      --,[TaxAmt]
      --,[Freight]
      --,[CarrierTrackingNumber]
      --,[CustomerPONumber]
      --,[OrderDate]
      --,[DueDate]
      --,[ShipDate]
 FROM 
  [dbo].[FactInternetSales]
WHERE
	LEFT (OrderDateKey, 4) >= YEAR(GETDATE()) - 2 -- Ensures we always only bring two years of date from extraction
ORDER BY
	OrderDateKey ASC
