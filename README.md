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


### Task 4: Email/Slack message to the business/product leader- (the initial greetings are not included in this message)
Hello, 

I've been doing some preliminary analysis of our receipts data and its correlation with our user data and brands data. I would like to share a few pointers I came across while working on this task.
- The first one is the data quality issue. While trying to understand and tie back user data and brand data to the receipts data we have collected, I came across a few data quality issues like duplicate userIds, missing barcode information. I feel one of the priority tasks would be handling these issues as it will help us increase our accuracy of results while performing analysis of our KPIs. I would like to dive deeper into the data quality issue to understand how the data flows and how do we capture this data. It would go a long way in determining a solution for handling these data quality issues.
- Additionally, we do have a preliminary data model developed based on the data and my understanding of the business context. However, I would love to know more about any specific key metrics we are looking at, it would help me gain an overall business perpective and I can try to incorporate these requirements and optimize the data modeling based on this information.
- I would also like to highlight one more thing, which I feel needs to be given some thought and attention. We are growing as a company, and with that our data influx would also grow exponentially. In order to manage the performance and scalibility risks, I feel we should consider moving to cloud platforms. I would be conducting a meeting to explain more about how the cloud platform approach may be better than the current approach some time this week.

Please feel free to drop me a message on slack or schedule a meeting if you would like to further discuss these points. I would love to hop on a quick call to discuss each point in detail.

Thank you.
