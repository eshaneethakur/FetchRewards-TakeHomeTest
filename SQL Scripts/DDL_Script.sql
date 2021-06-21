/*** CREATION OF STAGING TABLES TO DUMP THE UNSTRUCTURED JSON DATA INTO A DB SCHEMA ***/

--table creation for user data
CREATE TABLE tblUserStaging
(
	userId VARCHAR(MAX)
	,isActive BIT
    ,createdDate DATETIME
    ,lastLogin DATETIME
    ,[role] VARCHAR(15)
	,signUpSource VARCHAR(100)
	,[state] VARCHAR(5)
)

--table creation for brands data
CREATE TABLE tblBrandsStaging
(
	brandId VARCHAR(MAX)
	,brandName VARCHAR(100)
    ,brandCode VARCHAR(100)
    ,barcode VARCHAR(100)
    ,category VARCHAR(100)
	,categoryCode VARCHAR(100)
	,topBrand BIT
	,cpgCollectionId NVARCHAR(MAX) 
	,cpgCollectionRef VARCHAR(10)
)


--table creation  for receipts data
CREATE TABLE tblReceiptsStaging
(
	receiptId VARCHAR(MAX)
	,userId VARCHAR(MAX)
	,totalSpent  VARCHAR(10)
	,purchasedItemCount INT
	,pointsEarned  VARCHAR(10)
	,bonusPointsEarned VARCHAR(10)
	,bonusPointsEarnedReason VARCHAR(100)
	,rewardsReceiptStatus VARCHAR(100)
	,createDate DATETIME
	,scannedDate DATETIME
	,finishedDate DATETIME
	,modifyDate DATETIME
	,pointsAwardedDate DATETIME
	,purchaseDate DATETIME
	,rewardsReceiptItemList NVARCHAR(MAX)
)

CREATE TABLE tblReceiptBarcodeStaging
(
	receiptId VARCHAR(100)
	,barcode VARCHAR(100)
)
GO


/*** CREATION OF DATA MODEL TABLES ***/

CREATE TABLE tblDateDimension
(
	 DateId BIGINT
	,[Year] INT
	,[Quarter] INT
	,[Month] INT
	,[Week] INT
	,[Day] INT
	,[Hour] INT
	,OriginalDate DATETIME
	,CONSTRAINT PK_DateId PRIMARY KEY (DateId)
)

CREATE TABLE tblUsers
(
	userId BIGINT IDENTITY(1,1)
	,userIdOriginal VARCHAR(100)
	,createdDate DATETIME
	,createdDateId BIGINT
	,lastLogin DATETIME
	,lastLoginDateId BIGINT
	,isActive BIT
	,[role] VARCHAR(15)
	,signUpSource VARCHAR(100)
	,[state] VARCHAR(5)
	,CONSTRAINT PK_User PRIMARY KEY (userId)
)


CREATE TABLE tblCategory
(
	categoryId INT IDENTITY(1,1)
	,category VARCHAR(100)
	,categoryCode VARCHAR(100)
	,CONSTRAINT PK_Category PRIMARY KEY (categoryId)
)

CREATE TABLE tblBrands
(
	 brandId BIGINT IDENTITY(1,1)
	,brandIdOriginal VARCHAR(100)
	,brandName VARCHAR(100)
    ,brandCode VARCHAR(100)
    ,barcode BIGINT
	,categoryId INT
	,topBrand BIT
	,cpgCollectionId VARCHAR(100)
	,cpgCollectionRef VARCHAR(10)
	,CONSTRAINT PK_Brand PRIMARY KEY (brandId)
)

CREATE TABLE tblReceipt
(
	receiptId BIGINT IDENTITY(1,1)
	,receiptIdOriginal VARCHAR(MAX)
	,userId BIGINT
	,totalSpent  DECIMAL(5,2)
	,purchasedItemCount INT
	,pointsEarned  DECIMAL(5,2)
	,bonusPointsEarned DECIMAL(5,2)
	,bonusPointsEarnedReason VARCHAR(100)
	,rewardsReceiptStatus VARCHAR(100)
	,createDate DATETIME
	,scannedDate DATETIME 
	,finishedDate DATETIME
	,modifyDate DATETIME
	,pointsAwardedDate DATETIME
	,purchaseDate DATETIME
	,createDateId BIGINT
	,purchaseDateId BIGINT
	,CONSTRAINT PK_Receipt PRIMARY KEY (receiptId)
)

CREATE TABLE tblReceiptItemsMapping_raw
(
	 receiptId BIGINT
	,rewardsReceiptItemList NVARCHAR(MAX)
)

CREATE TABLE tblReceiptBarcodeData
(
	 receiptId BIGINT
	,barcode VARCHAR(100) 
)