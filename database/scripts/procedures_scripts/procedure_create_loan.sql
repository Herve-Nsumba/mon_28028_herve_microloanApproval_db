CREATE OR REPLACE PROCEDURE create_loan(
  p_borrower_id   IN  NUMBER,
  p_loan_amount   IN  NUMBER,
  p_loan_term     IN  NUMBER,
  p_interest_rate IN  NUMBER DEFAULT 5,
  p_new_loan_id   OUT NUMBER,
  p_result        OUT VARCHAR2
)
AS
  v_count       NUMBER;
  v_errcode     NUMBER;
  v_errmsg      VARCHAR2(4000);
  v_errstack    VARCHAR2(4000);
BEGIN
  -- Validate borrower exists
  SELECT COUNT(*) INTO v_count
  FROM borrowers
  WHERE borrower_id = p_borrower_id;

  IF v_count = 0 THEN
    p_result := 'ERROR: Borrower not found';
    p_new_loan_id := NULL;
    RETURN;
  END IF;

  -- Validate amount/term
  IF p_loan_amount <= 0 OR p_loan_term <= 0 THEN
    p_result := 'ERROR: Invalid loan amount or term';
    p_new_loan_id := NULL;
    RETURN;
  END IF;

  -- Insert loan
  INSERT INTO loans (
    borrower_id, loan_amount, loan_term, interest_rate, loan_status, application_date
  )
  VALUES (
    p_borrower_id, p_loan_amount, p_loan_term, p_interest_rate, 'Pending', SYSDATE
  )
  RETURNING loan_id INTO p_new_loan_id;

  COMMIT;
  p_result := 'OK: Loan created';

EXCEPTION
  WHEN OTHERS THEN
    -- Capture error values into variables
    v_errcode  := SQLCODE;
    v_errmsg   := SQLERRM;
    v_errstack := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE();

    -- Insert using variables (100% ORA-00984 proof)
    INSERT INTO error_log (routine_name, error_code, error_msg, error_stack)
    VALUES ('create_loan', v_errcode, v_errmsg, v_errstack);

    ROLLBACK;
    p_new_loan_id := NULL;
    p_result := 'ERROR: ' || v_errmsg;
END create_loan;
/


SET SERVEROUTPUT ON;
DECLARE
  v_loan_id NUMBER;
  v_msg     VARCHAR2(200);
BEGIN
  create_loan(1, 250000, 12, 5.5, v_loan_id, v_msg);

  DBMS_OUTPUT.PUT_LINE('Result: ' || v_msg);
  DBMS_OUTPUT.PUT_LINE('Generated Loan ID: ' || NVL(TO_CHAR(v_loan_id), 'NULL'));
END;
/

