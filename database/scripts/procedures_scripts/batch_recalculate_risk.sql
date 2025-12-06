CREATE OR REPLACE PROCEDURE batch_recalculate_risk(
  p_result OUT VARCHAR2
)
AS
  -- Cursor to fetch all approved loans
  CURSOR c_loans IS
    SELECT loan_id, loan_amount, loan_term
    FROM loans
    WHERE loan_status = 'Approved';

  v_loan_id     loans.loan_id%TYPE;
  v_amount      loans.loan_amount%TYPE;
  v_term        loans.loan_term%TYPE;
  v_score       NUMBER;
  v_risk        VARCHAR2(20);

  -- error logging vars
  v_errcode     NUMBER;
  v_errmsg      VARCHAR2(4000);
  v_errstack    VARCHAR2(4000);

BEGIN
  -- Open cursor
  OPEN c_loans;

  LOOP
    FETCH c_loans INTO v_loan_id, v_amount, v_term;
    EXIT WHEN c_loans%NOTFOUND;

    -- Simplified dummy credit score calculation (you can replace later)
    v_score := LEAST(850, GREATEST(300, (1000 - (v_amount / 1000) - v_term)));

    -- Determine risk level
    IF v_score >= 700 THEN
      v_risk := 'Low';
    ELSIF v_score >= 500 THEN
      v_risk := 'Medium';
    ELSE
      v_risk := 'High';
    END IF;

    -- Upsert into risk_evaluations
    MERGE INTO risk_evaluations r
    USING (SELECT v_loan_id AS loan_id FROM dual) src
    ON (r.loan_id = src.loan_id)
    WHEN MATCHED THEN 
      UPDATE SET credit_score = v_score,
                 risk_level  = v_risk,
                 evaluation_date = SYSDATE
    WHEN NOT MATCHED THEN
      INSERT (loan_id, credit_score, risk_level, evaluation_date)
      VALUES (v_loan_id, v_score, v_risk, SYSDATE);

  END LOOP;

  CLOSE c_loans;

  COMMIT;
  p_result := 'OK: Risk recalculation completed';

EXCEPTION
  WHEN OTHERS THEN
    v_errcode  := SQLCODE;
    v_errmsg   := SQLERRM;
    v_errstack := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE();

    INSERT INTO error_log (routine_name, error_code, error_msg, error_stack)
    VALUES ('batch_recalculate_risk', v_errcode, v_errmsg, v_errstack);

    ROLLBACK;
    p_result := 'ERROR: ' || v_errmsg;
END batch_recalculate_risk;
/


SET SERVEROUTPUT ON;
DECLARE
  v_msg VARCHAR2(200);
BEGIN
  batch_recalculate_risk(v_msg);
  DBMS_OUTPUT.PUT_LINE('Result: ' || v_msg);
END;
/
