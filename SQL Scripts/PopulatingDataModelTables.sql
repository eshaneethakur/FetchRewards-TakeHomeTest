/*** SCRIPT FOR PROCESSING AND POPULATING DATA MODEL TABLES***/

INSERT INTO tblDateDimension
SELECT DISTINCT 
	CHECKSUM(createdDate)
	,YEAR(createdDate)
	,DATEPART(QUARTER, createdDate)
	,MONTH(createdDate)
	,DATEPART(WEEK, createdDate)
	,DAY(createdDate)
	,DATEPART(HOUR, createdDate)
	,createdDate
FROM tblUserStaging


INSERT INTO tblDateDimension
SELECT DISTINCT 
	CHECKSUM(lastLogin)
	,YEAR(lastLogin)
	,DATEPART(QUARTER, lastLogin)
	,MONTH(lastLogin)
	,DATEPART(WEEK, lastLogin)
	,DAY(lastLogin)
	,DATEPART(HOUR, lastLogin)
	,lastLogin
FROM tblUserStaging stg
LEFT JOIN tblDateDimension dd ON dd.OriginalDate = stg.lastLogin
WHERE dd.DateId IS NULL AND lastLogin IS NOT NULL


INSERT INTO tblDateDimension
SELECT DISTINCT
	CHECKSUM(purchaseDate)
	,YEAR(purchaseDate)
	,DATEPART(QUARTER, purchaseDate)
	,MONTH(purchaseDate)
	,DATEPART(WEEK, purchaseDate)
	,DAY(purchaseDate)
	,DATEPART(HOUR, purchaseDate)
	,purchaseDate
FROM tblReceiptsStaging stg
LEFT JOIN tblDateDimension dd ON dd.OriginalDate = stg.purchaseDate
WHERE dd.DateId IS NULL AND purchaseDate IS NOT NULL


INSERT INTO tblDateDimension
SELECT DISTINCT
	CHECKSUM(createDate)
	,YEAR(createDate)
	,DATEPART(QUARTER, createDate)
	,MONTH(createDate)
	,DATEPART(WEEK, createDate)
	,DAY(createDate)
	,DATEPART(HOUR, createDate)
	,createDate
FROM tblReceiptsStaging stg
LEFT JOIN tblDateDimension dd ON dd.OriginalDate = stg.createDate
WHERE dd.DateId IS NULL AND createDate IS NOT NULL
GO

INSERT INTO tblUsers
SELECT
	 us.userId
	,us.createdDate
	,dd.DateId AS createdDateId
	,us.lastLogin
	,dd_ll.DateId AS lastLoginDateId
	,us.isActive
	,us.[role]
	,us.signUpSource
	,us.[state]
FROM tblUserStaging us
INNER JOIN tblDateDimension dd ON dd.OriginalDate = us.createdDate
LEFT JOIN tblDateDimension dd_ll ON dd_ll.OriginalDate = us.lastLogin --some null values
GROUP BY 	 
	 us.userId
	,us.createdDate
	,dd.DateId
	,us.lastLogin
	,dd_ll.DateId
	,us.isActive
	,us.[role]
	,us.signUpSource
	,us.[state]
	
GO	

WITH category_data AS
(
	SELECT ROW_NUMBER() OVER(PARTITION BY category ORDER BY categoryCode DESC) row_num
		,category
		,categoryCode
	FROM tblBrandsStaging
	WHERE category IS NOT NULL
	GROUP BY category
		,categoryCode
)
INSERT INTO tblCategory
SELECT 
	category, categoryCode
FROM category_data
WHERE row_num = 1

GO


INSERT INTO tblBrands
SELECT
	 bs.brandId
	,bs.brandName
	,bs.brandCode
	,bs.barcode
	,c.categoryId
	,bs.topBrand
	,bs.cpgCollectionId
	,bs.cpgCollectionRef
FROM tblBrandsStaging bs
LEFT JOIN tblCategory c ON c.category = bs.category



INSERT INTO tblReceipt
SELECT 
	 rs.receiptId
	,u.userId
	,TRY_CAST(rs.totalSpent AS DECIMAL(5,2)) AS totalSpent
	,rs.purchasedItemCount
	,TRY_CAST(rs.pointsEarned AS DECIMAL(5,2)) AS pointsEarned
	,TRY_CAST(rs.bonusPointsEarned AS DECIMAL(5,2)) AS bonusPointsEarned
	,rs.bonusPointsEarnedReason
	,rs.rewardsReceiptStatus
	,rs.createDate
	,rs.scannedDate
	,rs.finishedDate
	,rs.modifyDate
	,rs.pointsAwardedDate
	,rs.purchaseDate
	,dd_c.DateId AS createDateId
	,dd_p.DateId AS purchaseDateId
FROM tblReceiptsStaging rs
LEFT JOIN tblUsers u ON u.userIdOriginal = rs.userId
LEFT JOIN tblDateDimension dd_p ON dd_p.OriginalDate = rs.purchaseDate
LEFT JOIN tblDateDimension dd_c ON dd_c.OriginalDate = rs.createDate


INSERT INTO tblReceiptItemsMapping_raw
SELECT 
	r.receiptId
	,rs.rewardsReceiptItemList
FROM tblReceiptsStaging rs
INNER JOIN tblReceipt r ON r.receiptIdOriginal = rs.receiptId


INSERT INTO tblReceiptBarcodeData
SELECT 
	r.receiptId
	,rs.barcode
FROM tblReceiptBarcodeStaging rs
INNER JOIN tblReceipt r ON r.receiptIdOriginal = rs.receiptId
WHERE barcode IS NOT NULL

GO