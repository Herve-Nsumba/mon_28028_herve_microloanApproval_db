-- Borrowers
SELECT * FROM borrowers WHERE ROWNUM <= 5; -- first 5 rows
SELECT borrower_id, first_name, last_name, income FROM borrowers WHERE income > 100000;

-- Loans
SELECT * FROM loans WHERE ROWNUM <= 5;
SELECT loan_id, borrower_id, loan_amount, loan_status FROM loans WHERE loan_status='Approved';

-- Risk Evaluations
SELECT * FROM risk_evaluations WHERE ROWNUM <= 5;
SELECT risk_id, loan_id, credit_score, risk_level FROM risk_evaluations WHERE risk_level='High';

-- Payments
SELECT * FROM payments WHERE ROWNUM <= 5;
SELECT payment_id, loan_id, amount_paid, payment_method FROM payments WHERE amount_paid > 20000;

--JOINS
-- Borrowers + Loans
SELECT b.first_name, b.last_name, l.loan_id, l.loan_amount, l.loan_status
FROM borrowers b
JOIN loans l ON b.borrower_id = l.borrower_id
WHERE ROWNUM <= 5;

-- Loans + Risk Evaluations
SELECT l.loan_id, l.loan_amount, r.credit_score, r.risk_level
FROM loans l
JOIN risk_evaluations r ON l.loan_id = r.loan_id
WHERE r.risk_level='High';

-- Loans + Payments
SELECT l.loan_id, l.loan_amount, p.payment_id, p.amount_paid
FROM loans l
JOIN payments p ON l.loan_id = p.loan_id
WHERE ROWNUM <= 5;


--GROUP BY 
-- Total loan amount per borrower
SELECT borrower_id, SUM(loan_amount) AS total_loans
FROM loans
GROUP BY borrower_id
HAVING SUM(loan_amount) > 500000;

-- Average payment amount per loan
SELECT loan_id, AVG(amount_paid) AS avg_payment
FROM payments
GROUP BY loan_id
HAVING AVG(amount_paid) > 15000;

-- Count of risk evaluations by risk_level
SELECT risk_level, COUNT(*) AS num_loans
FROM risk_evaluations
GROUP BY risk_level;

--SUBQUERIES
-- Borrowers who have loans over 300000
SELECT first_name, last_name
FROM borrowers
WHERE borrower_id IN (
    SELECT borrower_id FROM loans WHERE loan_amount > 300000
);

-- Loans with high-risk evaluation
SELECT loan_id, loan_amount
FROM loans
WHERE loan_id IN (
    SELECT loan_id FROM risk_evaluations WHERE risk_level='High'
);

-- Payments greater than average payment
SELECT payment_id, amount_paid
FROM payments
WHERE amount_paid > (
    SELECT AVG(amount_paid) FROM payments
);
