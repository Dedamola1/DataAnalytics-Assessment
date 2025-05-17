USE adashi_staging;

SELECT 
    u.id AS owner_id,
    CONCAT(first_name, " ", last_name) AS full_name,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 0 THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,
    ROUND(SUM(s.confirmed_amount),2) AS total_deposits
FROM 
	users_customuser u
JOIN 
	plans_plan p 
	ON p.owner_id = u.id
JOIN 
	savings_savingsaccount s 
	ON s.plan_id = p.id 
	AND s.owner_id = u.id
WHERE 
    p.is_deleted = 0 
    AND p.is_archived = 0
    AND s.confirmed_amount > 0
    -- Syntax below is to remove customers with "testing" in their name which may indicate company testing accounts (not actual customers) in the final query 
    AND NOT u.first_name = "test"
    AND NOT last_name = "test"
GROUP BY 
	u.id
HAVING 
	savings_count >= 1 AND investment_count >= 1
ORDER BY 
	total_deposits DESC;

