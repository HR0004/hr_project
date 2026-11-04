-- 1. Roles (3)
INSERT INTO hr_role (role_code, role_name) VALUES
    ('ROLE_EMPLOYEE', '일반 사원'),
    ('ROLE_TEAM_APPROVER', '팀 업무 승인자'),
    ('ROLE_HR_ADMIN', '인사 관리자');

-- 2. Permissions (15)
INSERT INTO permission (permission_code, permission_name) VALUES
    ('PERMISSION_MY_INFO_READ', '내 정보 조회'),
    ('PERMISSION_LEAVE_REQUEST', '내 휴가 신청'),
    ('PERMISSION_MY_LEAVE_READ', '내 휴가 조회'),
    ('PERMISSION_TEAM_MEMBER_READ', '내 팀원 조회'),
    ('PERMISSION_TEAM_LEAVE_APPROVE', '팀원 휴가 승인/반려'),
    ('PERMISSION_EMPLOYEE_READ', '전체 사원 조회'),
    ('PERMISSION_EMPLOYEE_CREATE', '신규 사원 등록'),
    ('PERMISSION_EMPLOYEE_UPDATE', '사원 정보 수정'),
    ('PERMISSION_EMPLOYEE_RESIGN', '퇴직 처리'),
    ('PERMISSION_DEPARTMENT_MANAGE', '부서 관리'),
    ('PERMISSION_JOB_MANAGE', '직급 관리'),
    ('PERMISSION_LEAVE_ALL_READ', '전체 휴가 현황 조회'),
    ('PERMISSION_ACCOUNT_MANAGE', '계정 발급/상태 관리'),
    ('PERMISSION_ROLE_ASSIGN', '계정 역할 부여'),
    ('PERMISSION_ROLE_MANAGE', '역할별 권한 설정');

-- 3. Role permissions (23)
-- Employee: permissions 1-3 from the original Oracle seed data.
INSERT INTO hr_role_permission (hr_role_id, permission_id)
SELECT r.hr_role_id, p.permission_id
FROM hr_role AS r
CROSS JOIN permission AS p
WHERE r.role_code = 'ROLE_EMPLOYEE'
  AND p.permission_code IN (
      'PERMISSION_MY_INFO_READ',
      'PERMISSION_LEAVE_REQUEST',
      'PERMISSION_MY_LEAVE_READ'
  );

-- Team approver: permissions 1-5.
INSERT INTO hr_role_permission (hr_role_id, permission_id)
SELECT r.hr_role_id, p.permission_id
FROM hr_role AS r
CROSS JOIN permission AS p
WHERE r.role_code = 'ROLE_TEAM_APPROVER'
  AND p.permission_code IN (
      'PERMISSION_MY_INFO_READ',
      'PERMISSION_LEAVE_REQUEST',
      'PERMISSION_MY_LEAVE_READ',
      'PERMISSION_TEAM_MEMBER_READ',
      'PERMISSION_TEAM_LEAVE_APPROVE'
  );

-- HR admin: permissions 1-15 from the original Oracle seed data.
INSERT INTO hr_role_permission (hr_role_id, permission_id)
SELECT r.hr_role_id, p.permission_id
FROM hr_role AS r
CROSS JOIN permission AS p
WHERE r.role_code = 'ROLE_HR_ADMIN'
  AND p.permission_code IN (
      'PERMISSION_MY_INFO_READ',
      'PERMISSION_LEAVE_REQUEST',
      'PERMISSION_MY_LEAVE_READ',
      'PERMISSION_TEAM_MEMBER_READ',
      'PERMISSION_TEAM_LEAVE_APPROVE',
      'PERMISSION_EMPLOYEE_READ',
      'PERMISSION_EMPLOYEE_CREATE',
      'PERMISSION_EMPLOYEE_UPDATE',
      'PERMISSION_EMPLOYEE_RESIGN',
      'PERMISSION_DEPARTMENT_MANAGE',
      'PERMISSION_JOB_MANAGE',
      'PERMISSION_LEAVE_ALL_READ',
      'PERMISSION_ACCOUNT_MANAGE',
      'PERMISSION_ROLE_ASSIGN',
      'PERMISSION_ROLE_MANAGE'
  );

-- 4. Departments (3)
INSERT INTO department (department_code, department_name) VALUES
    ('HR', '경영지원팀'),
    ('DEV', '개발팀'),
    ('SALES', '영업팀');

-- 5. Job grades (5)
INSERT INTO job (job_code, job_name) VALUES
    ('STAFF', '사원'),
    ('ASSOCIATE', '대리'),
    ('MANAGER', '과장'),
    ('SENIOR_MANAGER', '차장'),
    ('DEPARTMENT_MANAGER', '부장');

-- 6. Positions (5)
INSERT INTO hr_position (position_code, position_name) VALUES
    ('TEAM_LEADER', '팀장'),
    ('DEPT_HEAD', '부서장'),
    ('DIVISION_HEAD', '본부장'),
    ('CENTER_HEAD', '센터장'),
    ('PART_LEADER', '파트장');

-- 7. Employee (1)
-- Associate employee with DEV department and MANAGER grade by code, not by numeric ID.
INSERT INTO emp (
    ename, email, phone, hiredate,
    department_id, job_id, status, annual_leave_days
)
SELECT '사고니', 'hexa@naver.com', '010-2222-9999', '2026-10-25',
       d.department_id, j.job_id, 'ACTIVE', 10
FROM department AS d
CROSS JOIN job AS j
WHERE d.department_code = 'DEV'
  AND j.job_code = 'MANAGER';

-- 8. Account (1)
-- Preserve the bcrypt hash exactly as supplied; replace test credentials before real use.
INSERT INTO `account` (emp_id, login_id, `password`)
SELECT e.emp_id,
       'hexagon',
       '$2a$10$spvniMWIKiRCH9Qh.hdAVejVMTA6NkYjwdUy1JmeQS2hthQM9tv4W'
FROM emp AS e
WHERE e.email = 'hexa@naver.com'
  AND e.ename = '사고니';

-- 9. Account roles (2): ROLE_EMPLOYEE and ROLE_TEAM_APPROVER.
INSERT INTO account_role (account_id, hr_role_id)
SELECT a.account_id, r.hr_role_id
FROM `account` AS a
CROSS JOIN hr_role AS r
WHERE a.login_id = 'hexagon'
  AND r.role_code IN ('ROLE_EMPLOYEE', 'ROLE_TEAM_APPROVER');

-- No explicit COMMIT: Flyway controls migration execution.
