-- Loan status distribution
SELECT loan_status, COUNT(*) AS total
FROM loans
GROUP BY loan_status;

-- Average loan amount per borrower
SELECT borrower_id, AVG(loan_amount) AS avg_amount
FROM loans
GROUP BY borrower_id;

-- Risk level distribution
SELECT risk_level, COUNT(*) AS total
FROM risk_evaluations
GROUP BY risk_level;

-- Total payments collected per month
SELECT TO_CHAR(payment_date, 'YYYY-MM') AS month, SUM(amount_paid) AS total_collected
FROM payments
GROUP BY TO_CHAR(payment_date, 'YYYY-MM')
ORDER BY month;

-- Delinquency indicator (late payments)
SELECT loan_id,
       COUNT(*) FILTER (WHERE amount_paid < 0) AS late_payments
FROM payments
GROUP BY loan_id;

-- Average credit score per month
SELECT TO_CHAR(evaluation_date, 'YYYY-MM') AS month,
       AVG(credit_score) AS avg_score
FROM risk_evaluations
GROUP BY TO_CHAR(evaluation_date, 'YYYY-MM');
