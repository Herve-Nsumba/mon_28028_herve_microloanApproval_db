CREATE OR REPLACE FUNCTION calculate_risk_score(
  p_loan_amount IN NUMBER,
  p_loan_term   IN NUMBER
)
RETURN NUMBER
AS
  v_score NUMBER;
BEGIN
  -- Simple risk model
  v_score := LEAST(850, GREATEST(300, (1000 - (p_loan_amount / 1000) - p_loan_term)));

  RETURN v_score;
EXCEPTION
  WHEN OTHERS THEN
    RETURN NULL; -- return NULL on failure
END calculate_risk_score;
/

SET SERVEROUTPUT ON;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Score = ' || calculate_risk_score(300000, 12));
END;
/
