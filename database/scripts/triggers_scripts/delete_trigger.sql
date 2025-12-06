CREATE OR REPLACE TRIGGER trg_restrict_delete
BEFORE DELETE ON borrowers
FOR EACH ROW
DECLARE
    v_result VARCHAR2(200);
BEGIN
    v_result := check_restriction();

    IF v_result LIKE 'BLOCKED%' THEN
        log_audit('DELETE', 'BORROWERS', 'BLOCKED', v_result);
        RAISE_APPLICATION_ERROR(-20003, v_result);
    ELSE
        log_audit('DELETE', 'BORROWERS', 'ALLOWED', 'Delete permitted');
    END IF;
END;
/
