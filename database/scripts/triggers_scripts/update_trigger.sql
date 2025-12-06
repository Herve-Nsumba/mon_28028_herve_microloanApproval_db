CREATE OR REPLACE TRIGGER trg_restrict_update
BEFORE UPDATE ON borrowers
FOR EACH ROW
DECLARE
    v_result VARCHAR2(200);
BEGIN
    v_result := check_restriction();

    IF v_result LIKE 'BLOCKED%' THEN
        log_audit('UPDATE', 'BORROWERS', 'BLOCKED', v_result);
        RAISE_APPLICATION_ERROR(-20002, v_result);
    ELSE
        log_audit('UPDATE', 'BORROWERS', 'ALLOWED', 'Update permitted');
    END IF;
END;
/
