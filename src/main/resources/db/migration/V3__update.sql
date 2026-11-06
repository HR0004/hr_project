-- 9. Account roles (2): ROLE_EMPLOYEE and ROLE_TEAM_APPROVER.
INSERT INTO account_role (account_id, hr_role_id)
SELECT a.account_id, r.hr_role_id
FROM `account` AS a
CROSS JOIN hr_role AS r
WHERE a.login_id = 'hexagon'
  AND r.role_code IN ('ROLE_EMPLOYEE', 'ROLE_TEAM_APPROVER', 'ROLE_HR_ADMIN');