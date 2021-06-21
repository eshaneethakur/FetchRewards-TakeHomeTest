 --Question: When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
 --Assumption: Could not find any status as "Accepted", considering Finished/Submitted as Accepted cases
WITH acceptedAvgSpend AS (
	SELECT AVG(totalSpent) AS accepted_avg_spend
	FROM tblReceipt
	WHERE rewardsReceiptStatus IN ('FINISHED','SUBMITTED')
)
, rejectedAvgSpend AS (
	SELECT AVG(totalSpent) AS rejected_avg_spend
	FROM tblReceipt
	WHERE rewardsReceiptStatus IN ('REJECTED')
)
SELECT 
	CASE 
		WHEN accepted_avg_spend > rejected_avg_spend THEN 'Accepted Reward receipt average spend is greater'
		WHEN accepted_avg_spend < rejected_avg_spend THEN 'Rejected Reward receipt average spend is greater'
		ELSE 'Both are equal'
	END
FROM acceptedAvgSpend,rejectedAvgSpend
GO

 --Question: When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
 --Assumption: Could not find any status as "Accepted", considering Finished/Submitted as Accepted cases
 WITH acceptedTotalItems AS (
	SELECT SUM(purchasedItemCount) AS accepted_total_items
	FROM tblReceipt
	WHERE rewardsReceiptStatus IN ('FINISHED','SUBMITTED')
)
,rejectedTotalItems AS (
	SELECT SUM(purchasedItemCount) AS rejected_total_items
	FROM tblReceipt
	WHERE rewardsReceiptStatus IN ('REJECTED')
)
SELECT 
	CASE 
		WHEN accepted_total_items > rejected_total_items THEN 'Accepted Reward receipt total purchased items is greater'
		WHEN accepted_total_items < rejected_total_items THEN 'Rejected Reward receipt total purchased items is greater'
		ELSE 'Both are equal'
	END
FROM acceptedTotalItems,rejectedTotalItems


 --Question: What are the top 5 brands by receipts scanned for most recent month?
 --Assumption: Barcode has 1:1 relation with Brand.
SELECT TOP 5 
	b.brandId, b.brandName, COUNT(bar.receiptId) AS totalReceipts
FROM tblReceiptBarcodeData bar
INNER JOIN tblReceipt r ON r.receiptId = bar.receiptId
INNER JOIN tblBrands b ON b.barcode = bar.barcode
WHERE YEAR(r.createDate) = 2021 AND MONTH(r.createDate) = 3
GROUP BY b.brandId, b.brandName
ORDER BY totalReceipts DESC


