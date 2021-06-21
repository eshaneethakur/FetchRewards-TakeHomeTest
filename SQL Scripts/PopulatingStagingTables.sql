/*** SCRIPT TO IMPORT DATA FROM JSON FILES AND DUMPING IT IN STAGING DATA***/

--importing user data into a staging table
INSERT INTO tblUserStaging
SELECT 
	 users.userId
	,users.isActive
	,DATEADD(s, CONVERT(INT, LEFT(users.createdDate,10)),'1970-01-01') AS createdDate
	,DATEADD(s, CONVERT(INT, LEFT(users.lastLogin,10)),'1970-01-01') AS lastLogin
	,users.[role]
	,users.signUpSource
	,users.[state]
FROM OPENROWSET (BULK 'C:\Eshanee Data\Full time search\Assessment\FetchRewards\users.json', SINGLE_CLOB) as j
CROSS APPLY OPENJSON(BulkColumn)
WITH 
(
    userId NVARCHAR(MAX) '$._id."$oid"', 
	isActive BIT '$.active', 
    createdDate VARCHAR(MAX) '$.createdDate."$date"', 
    lastLogin VARCHAR(MAX) '$.lastLogin."$date"', 
    [role] VARCHAR(15) '$.role', 
	signUpSource VARCHAR(100) '$.signUpSource', 
	[state] VARCHAR(5) '$.state'
) AS users


--importing brands data into a staging table
INSERT INTO tblBrandsStaging
SELECT brands.*
FROM OPENROWSET (BULK 'C:\Eshanee Data\Full time search\Assessment\FetchRewards\brands.json', SINGLE_CLOB) as j
CROSS APPLY OPENJSON(BulkColumn)
WITH 
(
    brandId NVARCHAR(MAX) '$._id."$oid"', 
	brandName VARCHAR(100) '$.name', 
    brandCode VARCHAR(100) '$.brandCode', 
    barcode BIGINT '$.barcode', 
    category VARCHAR(100) '$.category', 
	categoryCode VARCHAR(100) '$.categoryCode', 
	topBrand BIT '$.topBrand',
	cpgCollectionId NVARCHAR(MAX) '$.cpg."$id"."$oid"',
	cpgCollectionRef VARCHAR(10) '$.cpg."$ref"'
) AS brands


--importing receipts data into a staging table
INSERT INTO tblReceiptsStaging
SELECT 
	receipts.receiptId
	,receipts.userId
	,receipts.totalSpent
	,receipts.purchasedItemCount
	,receipts.pointsEarned
	,receipts.bonusPointsEarned
	,receipts.bonusPointsEarnedReason
	,receipts.rewardsReceiptStatus
	,DATEADD(s, CONVERT(INT, LEFT(receipts.createDate,10)),'1970-01-01') AS createDate
	,DATEADD(s, CONVERT(INT, LEFT(receipts.scannedDate,10)),'1970-01-01') AS scannedDate
	,DATEADD(s, CONVERT(INT, LEFT(receipts.finishedDate,10)),'1970-01-01') AS finishedDate
	,DATEADD(s, CONVERT(INT, LEFT(receipts.modifyDate,10)),'1970-01-01') AS modifyDate
	,DATEADD(s, CONVERT(INT, LEFT(receipts.pointsAwardedDate,10)),'1970-01-01') AS pointsAwardedDate
	,DATEADD(s, CONVERT(INT, LEFT(receipts.purchaseDate,10)),'1970-01-01') AS purchaseDate
	,receipts.rewardsReceiptItemList
FROM OPENROWSET (BULK 'C:\Eshanee Data\Full time search\Assessment\FetchRewards\receipts.json', SINGLE_CLOB) as j
CROSS APPLY OPENJSON(BulkColumn)
WITH 
(
    receiptId NVARCHAR(MAX) '$._id."$oid"', 
	userId NVARCHAR(MAX) '$.userId', 
	totalSpent VARCHAR(10) '$.totalSpent',
	purchasedItemCount INT '$.purchasedItemCount',
	pointsEarned VARCHAR(10) '$.pointsEarned',
	bonusPointsEarned VARCHAR(10) '$.bonusPointsEarned',
	bonusPointsEarnedReason VARCHAR(100) '$.bonusPointsEarnedReason',
	rewardsReceiptStatus VARCHAR(100) '$.rewardsReceiptStatus',
	createDate VARCHAR(MAX) '$.createDate."$date"', 
	scannedDate VARCHAR(MAX) '$.dateScanned."$date"', 
	finishedDate VARCHAR(MAX) '$.finishedDate."$date"', 
	modifyDate VARCHAR(MAX) '$.modifyDate."$date"', 
	pointsAwardedDate VARCHAR(MAX) '$.pointsAwardedDate."$date"', 
	purchaseDate VARCHAR(MAX) '$.purchaseDate."$date"', 
	rewardsReceiptItemList NVARCHAR(MAX) '$.rewardsReceiptItemList' AS JSON
) AS receipts



INSERT INTO tblReceiptBarcodeStaging
SELECT DISTINCT itemsList.receiptId , barcodeData.*
FROM OPENROWSET (BULK 'C:\Eshanee Data\Full time search\Assessment\FetchRewards\receipts.json', SINGLE_CLOB) as j
CROSS APPLY OPENJSON(BulkColumn)
WITH (
	receiptId NVARCHAR(MAX) '$._id."$oid"' 
	,rewardsReceiptItemList NVARCHAR(MAX) '$.rewardsReceiptItemList' AS JSON
) AS itemsList
CROSS APPLY (
	SELECT *
	FROM OPENJSON(itemsList.rewardsReceiptItemList)
	WITH (
		barcode NVARCHAR(100) '$.barcode'
	)
) barcodeData

