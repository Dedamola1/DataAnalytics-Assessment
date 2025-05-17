USE adashi_staging;

SELECT 
    u.id AS customer_id,
    CONCAT(u.first_name, " ", u.last_name) AS full_name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
    COUNT(s.id) AS total_transactions,
    ROUND(
        (
            COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0) -- NULLIF(..., 0) prevents division by zero for users with 0 months of tenure.
        ) * 12 * (0.001 * IFNULL(AVG(s.amount), 0)), -- IFNULL(..., 0) ensures that the profit estimate doesn’t break or end when no transactions exists.
        2
    ) AS estimated_clv
FROM 
    users_customuser u
LEFT JOIN 
    savings_savingsaccount s 
    ON u.id = s.owner_id 
    AND s.transaction_status = 'success'
GROUP BY 
    u.id, 
    u.name
ORDER BY 
	estimated_clv DESC;
