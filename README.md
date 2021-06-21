# FetchRewards-TakeHomeTest
Modelling and analyzing specific dataset to gain insights

### Tasks Overview:-
- Task 1 : 
    ER Model for the given dataset can be viewed in [1_ER_Model.png](https://github.com/eshaneethakur/FetchRewards-TakeHomeTest/blob/main/1_ER_Model.PNG)
    
- Task 2 :
    1. SQL Query for answering a predetermined question from stakeholder can be viewed in [2_PrederterminedQuestion.sql](https://github.com/eshaneethakur/FetchRewards-TakeHomeTest/blob/main/2_PredeterminedQuestion.sql)
    2. Few assumptions were made while writing the SQL queries, they are mentioned in the "Task Assumptions" section.
    
- Task 3 : 
    Data Integrity issues can be found under [3_DataQualityIssue.sql](https://github.com/eshaneethakur/FetchRewards-TakeHomeTest/blob/main/3_DataQualityIssue.sql)
    
- Task 4 : 
    Email/Slack message to the business can be found under []()
    

### Task Assumptions:
- Assumption 1: I used "barcode" column to create a mapping between Brands and Receipts data. Looking at the data, "Barcode" has 1:1 mapping to Brand, hence this assumption.
- Assumption 2: For one of the business questions, "Accepted" was required to be one of the "rewardsReceiptStatus", however, the given dataset doesn't have "Accepted" status. Hence, have considered "Submitted" and "Finished" completing the "Accepted" criteria.
