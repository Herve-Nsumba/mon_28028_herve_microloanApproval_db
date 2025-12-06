CREATE OR REPLACE TRIGGER trg_restrict_insert
BEFORE INSERT ON borrowers
FOR EACH ROW
DECLARE
    v_result VARCHAR2(200);
BEGIN
    v_result := check_restriction();

    IF v_result LIKE 'BLOCKED%' THEN
        log_audit('INSERT', 'BORROWERS', 'BLOCKED', v_result);
        RAISE_APPLICATION_ERROR(-20001, v_result);
    ELSE
        log_audit('INSERT', 'BORROWERS', 'ALLOWED', 'Insert permitted');
    END IF;
END;
/
