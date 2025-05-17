USE adashi_staging;

SELECT
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_fixed_investment = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days
FROM 
	plans_plan p
LEFT JOIN 
	savings_savingsaccount s 
	ON p.id = s.plan_id 
	AND s.transaction_status = 'success'
WHERE
    p.is_deleted = 0
    AND p.is_archived = 0
    AND (p.is_regular_savings = 1 OR p.is_fixed_investment = 1)
GROUP BY 
	p.id,
    p.owner_id
HAVING 
	last_transaction_date IS NULL OR DATEDIFF(CURDATE(), last_transaction_date) > 365
ORDER BY 
	inactivity_days DESC;




