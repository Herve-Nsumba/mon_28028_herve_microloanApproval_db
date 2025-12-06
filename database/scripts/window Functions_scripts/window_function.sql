-- 1) Rank borrowers by total loan amount (highest first)
SELECT borrower_id, total_loan, RANK() OVER (ORDER BY total_loan DESC) AS loan_rank
FROM (
  SELECT borrower_id, SUM(loan_amount) AS total_loan FROM loans GROUP BY borrower_id
) t
WHERE ROWNUM <= 20;

-- 2) ROW_NUMBER to list payments per loan ordered by date
SELECT loan_id, payment_id, amount_paid, payment_date,
  ROW_NUMBER() OVER (PARTITION BY loan_id ORDER BY payment_date DESC) rn
FROM payments
WHERE loan_id <= 30
ORDER BY loan_id, rn;

-- 3) LAG to find previous payment amount per loan
SELECT payment_id, loan_id, amount_paid,
  LAG(amount_paid) OVER (PARTITION BY loan_id ORDER BY payment_date) prev_amount
FROM payments
WHERE loan_id <= 30;

-- 4) Aggregates with OVER clause: running total per loan
SELECT payment_id, loan_id, amount_paid,
  SUM(amount_paid) OVER (PARTITION BY loan_id ORDER BY payment_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) running_total
FROM payments
WHERE loan_id <= 20;
