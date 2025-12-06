CREATE OR REPLACE TRIGGER trg_payments_compound
FOR INSERT OR UPDATE OR DELETE ON payments
COMPOUND TRIGGER

    v_result VARCHAR2(200);

BEFORE STATEMENT IS
BEGIN
    v_result := check_restriction();

    IF v_result LIKE 'BLOCKED%' THEN
        log_audit('DML', 'PAYMENTS', 'BLOCKED', v_result);
        RAISE_APPLICATION_ERROR(-20010, v_result);
    ELSE
        log_audit('DML', 'PAYMENTS', 'ALLOWED', 'Payments modification permitted');
    END IF;
END BEFORE STATEMENT;

END trg_payments_compound;
/
