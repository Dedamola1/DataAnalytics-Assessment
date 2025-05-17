USE adashi_staging;

SELECT
    CASE
        WHEN avg_txn_per_month >= 10 THEN 'High Frequency'
        WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        WHEN avg_txn_per_month <= 2 THEN 'Low Frequency'
        -- 'Other' to categorize customers with an average of 2-3 transactions per month since this was not taken into consideration in any frequency
        ELSE 'Other'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txn_per_month), 1) AS avg_transactions_per_month
FROM (
    SELECT
        txn.owner_id,
        AVG(txn.monthly_txn_count) AS avg_txn_per_month
    FROM (
        SELECT
            owner_id,
            DATE_FORMAT(transaction_date, '%Y-%m') AS txn_month,
            COUNT(*) AS monthly_txn_count
        FROM
            savings_savingsaccount
        WHERE
            confirmed_amount > 0
        GROUP BY
            owner_id,
            txn_month
    ) AS txn
    GROUP BY
        txn.owner_id
) AS user_avg_txns
GROUP BY
    frequency_category
ORDER BY 
	frequency_category;

     
     
     