--procedure 2

CREATE OR REPLACE PROCEDURE approve_loan(
  p_loan_id  IN  NUMBER,
  p_result   OUT VARCHAR2
)
AS
  v_status     VARCHAR2(20);
  v_exists     NUMBER;
  v_errcode    NUMBER;
  v_errmsg     VARCHAR2(4000);
  v_errstack   VARCHAR2(4000);
BEGIN
  -- Check if loan exists
  SELECT COUNT(*)
  INTO v_exists
  FROM loans
  WHERE loan_id = p_loan_id;

  IF v_exists = 0 THEN
    p_result := 'ERROR: Loan ID not found';
    RETURN;
  END IF;

  -- Get current status
  SELECT loan_status
  INTO v_status
  FROM loans
  WHERE loan_id = p_loan_id;

  -- Validate status
  IF v_status <> 'Pending' THEN
    p_result := 'ERROR: Only Pending loans can be approved';
    RETURN;
  END IF;

  -- Approve loan
  UPDATE loans
  SET loan_status = 'Approved'
  WHERE loan_id = p_loan_id;

  COMMIT;

  p_result := 'OK: Loan approved successfully';

EXCEPTION
  WHEN OTHERS THEN
    -- Capture error values
    v_errcode  := SQLCODE;
    v_errmsg   := SQLERRM;
    v_errstack := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE();

    -- Insert into error_log using variables (safe)
    INSERT INTO error_log (routine_name, error_code, error_msg, error_stack)
    VALUES ('approve_loan', v_errcode, v_errmsg, v_errstack);

    ROLLBACK;
    p_result := 'ERROR: ' || v_errmsg;
END approve_loan;
/

SET SERVEROUTPUT ON;
DECLARE
  v_msg VARCHAR2(200);
BEGIN
  approve_loan(1, v_msg);  -- example loan_id
  DBMS_OUTPUT.PUT_LINE('Result: ' || v_msg);
END;
/