SET SERVEROUTPUT ON;

DECLARE
  -- Explicit cursor to fetch borrower info
  CURSOR c_borrowers IS
    SELECT borrower_id, first_name, last_name, income
    FROM borrowers
    ORDER BY borrower_id;

  v_id      borrowers.borrower_id%TYPE;
  v_fname   borrowers.first_name%TYPE;
  v_lname   borrowers.last_name%TYPE;
  v_income  borrowers.income%TYPE;
BEGIN
  OPEN c_borrowers;

  LOOP
    FETCH c_borrowers INTO v_id, v_fname, v_lname, v_income;
    EXIT WHEN c_borrowers%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE(
      'Borrower: ' || v_id || ' - ' || v_fname || ' ' || v_lname ||
      ' | Income: ' || NVL(TO_CHAR(v_income), 'Unknown')
    );
  END LOOP;

  CLOSE c_borrowers;
END;
/
