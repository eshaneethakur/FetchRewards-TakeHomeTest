/** DATA INTEGRITY ISSUES **/

--1. Duplicate user data
SELECT userId, COUNT(*)
FROM tblUserStaging 
GROUP BY userId
HAVING COUNT(*) > 1

--2. Barcode values in Receipts data don't exist in the Brands data.
SELECT COUNT(DISTINCT barcode) FROM tblReceiptBarcodeData --568

SELECT COUNT(DISTINCT barcode) FROM tblBrands --1160

SELECT DISTINCT r.barcode
FROM tblReceiptBarcodeData r
LEFT JOIN tblBrands b ON r.barcode = b.barcode
WHERE b.barcode IS NULL


--3. Some userIds do not exist in UserData
SELECT DISTINCT r.userId
FROM tblReceiptsStaging r
LEFT JOIN tblUsers u ON r.userId = u.userIdOriginal
WHERE u.userIdOriginal IS NULL



--4. Inconsistent values for Category and categoryCode
SELECT DISTINCT category, categoryCode
FROM tblBrandsStaging


