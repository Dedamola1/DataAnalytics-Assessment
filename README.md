# DataAnalytics-Assessment

This repository contains solutions to SQL-based data analysis tasks performed on the adashi_staging database provided by Cowrywise. Each task targets a specific business objective using structured queries. Below is a detailed explanation of the approach taken to solve each assessment question.

Assessment Question 1: High-Value Customers with Multiple Products

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

Approach:
1. Using two subqueries;
   The first subquery calculated the monthly transaction count per customer by grouping on owner_id, and month (DATE_FORMAT(transaction_date, '%Y-%m')), then
   the second subquery averaged the monthly transaction count per customer in the first subquery to determine each customer’s transaction frequency.
2. Classified each user into the frequency categories using CASE statements.
3. Counted customers and averaged their monthly transaction rates within each category.
4. Ordered the results by frequency category.


Assessment Question 3: Account Inactivity Alert

Approach:
1. Used a LEFT JOIN between plans_plan and savings_savingsaccount tables to retain accounts with no transactions. Joined both tables using id and plan_id and ensured transaction_status was filtered to only “success”.
2. Included only active plans (is_deleted = 0 and is_archived = 0) and filtered for savings or investment types.
3. Calculated the last transaction date (which was the MAX transaction_date) and the number of days since the last transaction using DATEDIFF.
4. Applied a HAVING clause to include only accounts with no transactions or transactions older than 365 days.
5. Used CASE Statements to classify each plan as "Savings", "Investment", or "Other" based on flags.
6. Ordered the results by days of inactivity in descending order.


Assessment Question 4: Customer Lifetime Value (CLV) Estimation

Approach:
1. Joined users_customuser with savings_savingsaccount using id and owner_id  to collect transaction history. Also ensured transaction_status was filtered to only “success”.
2. Used CONCAT function for the first_name and last_name to identify the user’s full name.
3. Calculated tenure in months using TIMESTAMPDIFF between signup date and current date.
4. Counted total successful transactions using COUNT function.
5. Used a simplified CLV model: Calculated CLV = (total_transactions / tenure_months) * 12 * average_profit_per_transaction, where average_profit_per_transaction = 0.1% (0.001) of average transaction amount
6. Used NULLIF to prevent division by zero and IFNULL to handle users with no transactions.
7. Grouped the result by user id and name, then sorted it by estimated CLV in descending order.




Note
- All queries were written and tested in MySQL.
- Queries are optimized for clarity and maintainability with proper aliasing and conditional logic.




Challenges Faced:

While working through this assessment, I encountered a few notable challenges, particularly during the setup phase and data import process. Below are the key issues:

1. While importing the schema and initializing the tables, I encountered errors due to missing referenced tables. The plans_plan, user_customuser, and withdrawals_withdrawal tables included foreign key constraints referencing other tables (plans_currency, managed_portfolio_portfolioholdings, plans_planpreset, funds_usdindex, withdrawals_withdrawalintent, ) that were not yet created or not available in the provided schema.
These constraints were causing MySQL to block the table creation, because it requires referenced tables to exist before the constraints are applied. Since these related tables weren't needed for the assessment and were not available in the dataset, I decided to remove the constraints temporarily to allow the tables to be created and populated successfully.

2. I had to clean the data to ensure default values or NULL were used where appropriate, and date formats were correctly parsed to avoid discrepancies and erros when querying the tables.

3. Due to the removal of foreign key constraints, I had to be extra cautious while writing JOIN queries to ensure data integrity and relationship accuracy. 

 
