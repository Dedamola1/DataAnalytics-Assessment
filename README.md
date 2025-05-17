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
6. Used CONCAT function for the first_name and last_name to identify user’s full name.
7. Applied a HAVING clause to include only customers with both savings and investment plans.
8. Ordered the result by total_deposits in descending order.


Assessment Question 2: Transaction Frequency Analysis

Task: Calculate the average number of transactions per customer per month and categorize them by High Frequency (≥10 transactions/month), Medium Frequency (3-9 transactions/month), and Low Frequency (≤2 transactions/month)

Approach:
1. Using two subqueries;
   The first subquery calculated the monthly transaction count per customer by grouping on owner_id, and month (DATE_FORMAT(transaction_date, '%Y-%m')), then
   the second subquery averaged the monthly transaction count per customer in the first subquery to determine each customer’s transaction frequency.
2. Classified each user into the frequency categories using CASE statements.
3. Counted customers and averaged their monthly transaction rates within each category.
4. Ordered the results by frequency category.


Assessment Question 3: Account Inactivity Alert

Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days).

Approach:
1. Used a LEFT JOIN between plans_plan and savings_savingsaccount tables to retain accounts with no transactions. Joined both tables using id and plan_id and ensured transaction_status was filtered to only “success”.
2. Included only active plans (is_deleted = 0 and is_archived = 0) and filtered for savings or investment types.
3. Calculated the last transaction date (which was the MAX transaction_date) and the number of days since the last transaction using DATEDIFF.
4. Applied a HAVING clause to include only accounts with no transactions or transactions older than 365 days.
5. Used CASE Statements to classify each plan as "Savings", "Investment", or "Other" based on flags.
6. Ordered the results by days of inactivity in descending order.


Assessment Question 4: Customer Lifetime Value (CLV) Estimation

Task: Estimate the Customer Lifetime Value based on account tenure and transaction volume, assuming the profit_per_transaction is 0.1% of the transaction value.

Approach:
1. Joined users_customuser with savings_savingsaccount using id and owner_id  to collect transaction history. Also ensured transaction_status was filtered to only “success”.
2. Used CONCAT function for the first_name and last_name to identify the user’s full name.
3. Calculated tenure in months using TIMESTAMPDIFF between signup date and current date.
4. Counted total successful transactions using COUNT function.
5. Used a simplified CLV model: Calculated CLV = (total_transactions / tenure_months) * 12 * average_profit_per_transaction, where average_profit_per_transaction = 0.1% (0.001) of average transaction amount
6. Used NULLIF to prevent division by zero and IFNULL to handle users with no transactions.
7. Grouped the result by user id and name, then sorted it by estimated CLV in descending order.


Notes
- All queries were written and tested in MySQL.
- Queries are optimized for clarity and maintainability with proper aliasing and conditional logic.


Challenges Faced
- 
