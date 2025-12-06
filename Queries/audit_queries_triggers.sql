SELECT *
FROM audit_log
WHERE status = 'BLOCKED'
ORDER BY audit_id DESC;

SELECT *
FROM audit_log
WHERE status = 'ALLOWED'
ORDER BY audit_id DESC;
SELECT username, action_type, table_name, status, action_date
FROM audit_log
ORDER BY action_date DESC;

SELECT *
FROM audit_log
WHERE status = 'ALLOWED'
ORDER BY audit_id DESC;


SELECT reason, action_type, table_name, action_date
FROM audit_log
WHERE status = 'BLOCKED'
ORDER BY audit_id DESC;
