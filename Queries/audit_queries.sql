-- View full audit log
SELECT *
FROM audit_log
ORDER BY audit_id DESC;

-- View blocked actions only
SELECT *
FROM audit_log
WHERE status = 'BLOCKED'
ORDER BY audit_id DESC;

-- View allowed actions only
SELECT *
FROM audit_log
WHERE status = 'ALLOWED'
ORDER BY audit_id DESC;

-- Count violations
SELECT status, COUNT(*) AS total
FROM audit_log
GROUP BY status;

-- Violations per user
SELECT username, COUNT(*) AS total
FROM audit_log
WHERE status = 'BLOCKED'
GROUP BY username;

-- Violations by table
SELECT table_name, COUNT(*) AS total
FROM audit_log
GROUP BY table_name;
