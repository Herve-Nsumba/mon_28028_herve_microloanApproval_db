CREATE OR REPLACE PROCEDURE record_payment(
  p_loan_id       IN  NUMBER,
  p_amount_paid   IN  NUMBER,
  p_method        IN  VARCHAR2,
  p_result        OUT VARCHAR2
)
AS
  v_exists     NUMBER;
  v_errcode    NUMBER;
  v_errmsg     VARCHAR2(4000);
  v_errstack   VARCHAR2(4000);
BEGIN
  -- Validate loan exists
  SELECT COUNT(*)
  INTO v_exists
  FROM loans
  WHERE loan_id = p_loan_id;

  IF v_exists = 0 THEN
    p_result := 'ERROR: Loan ID not found';
    RETURN;
  END IF;

  -- Validate payment amount
  IF p_amount_paid <= 0 THEN
    p_result := 'ERROR: Payment amount must be greater than zero';
    RETURN;
  END IF;

  -- Insert payment
  INSERT INTO payments (
    loan_id, amount_paid, payment_method, payment_date
  )
  VALUES (
    p_loan_id, p_amount_paid, p_method, SYSDATE
  );

  COMMIT;

  p_result := 'OK: Payment recorded successfully';

EXCEPTION
  WHEN OTHERS THEN
    -- Capture error values into variables
    v_errcode  := SQLCODE;
    v_errmsg   := SQLERRM;
    v_errstack := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE();

    INSERT INTO error_log (routine_name, error_code, error_msg, error_stack)
    VALUES ('record_payment', v_errcode, v_errmsg, v_errstack);

    ROLLBACK;
    p_result := 'ERROR: ' || v_errmsg;
END record_payment;
/

SET SERVEROUTPUT ON;
DECLARE
  v_msg VARCHAR2(200);
BEGIN
  record_payment(1, 50000, 'Mobile Money', v_msg);  -- adjust loan_id if needed
  DBMS_OUTPUT.PUT_LINE('Result: ' || v_msg);
END;
/