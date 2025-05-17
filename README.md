# DataAnalytics-Assessment

This repository contains solutions to SQL-based data analysis tasks performed on the adashi_staging database provided by Cowrywise. Each task targets a specific business objective using structured queries. Below is a detailed explanation of the approach taken to solve each assessment question.

Assessment Question 1: High-Value Customers with Multiple Products
Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

Approach:
1. Joined users_customuser, plans_plan, and savings_savingsaccount tables using owner_id and plan_id to gather user and plan data.
2. Filtered out deleted or archived plans.
3. Filtered transactions with confirmed_amount > 0 and excluded accounts labeled as testing (by checking for 'test' in names).
4. Counted the number of distinct savings and investment plans using conditional aggregation.
5. Summed up all confirmed deposits and grouped the results by user.
6. Applied a HAVING clause to include only customers with both savings and investment plans.
7. Ordered the result by total_deposits in descending order.


Assessment Question 2: Transaction Frequency Analysis
Task: Calculate the average number of transactions per customer per month and categorize them by High Frequency (≥10 transactions/month), Medium Frequency (3-9 transactions/month), and Low Frequency (≤2 transactions/month)

Approach:
1. Using two subqueries;
    a. The first subquery calculated the monthly transaction count per customer by grouping on owner_id, and month (DATE_FORMAT(transaction_date, '%Y-%m')).
    b. The second subquery averaged the monthly transaction count per customer in the first subquery to determine each customer’s transaction frequency. 
2. Classified each user into the frequency categories using CASE STATEMENTS:
3. Counted customers and averaged their monthly transaction rates within each category.
4. Ordered the results by frequency category.

