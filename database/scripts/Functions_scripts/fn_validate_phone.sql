CREATE OR REPLACE FUNCTION validate_phone(
  p_phone IN VARCHAR2
)
RETURN VARCHAR2
AS
BEGIN
  -- Accept numbers 10–12 digits (common African telecom ranges)
  IF REGEXP_LIKE(p_phone, '^[0-9]{10,12}$') THEN
    RETURN 'VALID';
  ELSE
    RETURN 'INVALID';
  END IF;
END validate_phone;
/

SET SERVEROUTPUT ON;
BEGIN
  DBMS_OUTPUT.PUT_LINE(validate_phone('0789123456'));
  DBMS_OUTPUT.PUT_LINE(validate_phone('ABC123'));
END;
/
