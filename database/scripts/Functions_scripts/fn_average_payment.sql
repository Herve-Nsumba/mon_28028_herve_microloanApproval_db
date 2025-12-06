CREATE OR REPLACE FUNCTION average_payment(
  p_loan_id IN NUMBER
)
RETURN NUMBER
AS
  v_avg NUMBER;
BEGIN
  SELECT AVG(amount_paid)
  INTO v_avg
  FROM payments
  WHERE loan_id = p_loan_id;

  RETURN v_avg;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
  WHEN OTHERS THEN
    RETURN NULL;
END average_payment;
/

SET SERVEROUTPUT ON;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Average = ' || average_payment(1));
END;
/
