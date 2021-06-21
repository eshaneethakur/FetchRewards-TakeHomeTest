# FetchRewards-TakeHomeTest
Modelling and analyzing specific dataset to gain insights

### Tasks Overview:-
- Task 1 : 
    ER Model for the given dataset can be viewed in [1_ER_Model.png](https://github.com/eshaneethakur/FetchRewards-TakeHomeTest/blob/main/1_ER_Model.PNG)
    
- Task 2 :
    1. SQL Query for answering a predetermined question from stakeholder can be viewed in [2_PrederterminedQuestion.sql](https://github.com/eshaneethakur/FetchRewards-TakeHomeTest/blob/main/2_PredeterminedQuestion.sql)
    2. Few assumptions were made while writing the SQL queries, they are mentioned in the "Task Assumptions" section.
    
- Task 3 : 
    1. Data Integrity issues and their corresponding SQL script can be found under [3_DataQualityIssue.sql](https://github.com/eshaneethakur/FetchRewards-TakeHomeTest/blob/main/3_DataQualityIssue.sql)
    2. Data quality issues are listed under the "Data Quality Issues" section.
    
- Task 4 : Email/Slack message to the business can be found in ReadME file under the "Task 4" section.
    

### Task Assumptions:
- Assumption 1: I used "barcode" column to create a mapping between Brands and Receipts data. Looking at the data, "Barcode" has 1:1 mapping to Brand, hence this assumption.

- Assumption 2: For one of the business questions, "Accepted" was required to be one of the "rewardsReceiptStatus", however, the given dataset doesn't have "Accepted" status. Hence, have considered "Submitted" and "Finished" completing the "Accepted" criteria.


### Data Quality Issues:
- Issue 1: Duplicate data - User data had duplicate entries
    1. When piping the data from the JSON files to staging tables, came across this issue.
    2. Investigated further by writing SQL query to find out how many duplicate entries exist. 
  
- Issue 2: Missing data - Some UserIds mentioned in the Receipts data do not exist in the Users data.
 
- Issue 3: Missing data/ Different formats - Some of Barcode values in receipts data do not exist in Brand data. Additionally, there is a data format mismatch between "barcode" values in receipt data and brands data

- Issue 4: Inconsistent data - Few records in Brands data have CategoryCode equal to blank/null values even though a code exists for the same category.


### Task 4:
