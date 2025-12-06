-- Retrieve all borrowers
SELECT * FROM borrowers;

-- Retrieve all loans
SELECT * FROM loans;

-- Retrieve loans for a specific borrower
SELECT * FROM loans WHERE borrower_id = 5;

-- Retrieve payments for a loan
SELECT * FROM payments WHERE loan_id = 10;

-- Retrieve risk evaluations
SELECT * FROM risk_evaluations;

-- Join: Borrower + Loan summary
SELECT b.first_name, b.last_name, l.loan_id, l.loan_amount, l.loan_status
FROM borrowers b
JOIN loans l ON b.borrower_id = l.borrower_id;

-- Join: Loan + Risk
SELECT l.loan_id, l.loan_amount, r.credit_score, r.risk_level
FROM loans l
LEFT JOIN risk_evaluations r ON l.loan_id = r.loan_id;
