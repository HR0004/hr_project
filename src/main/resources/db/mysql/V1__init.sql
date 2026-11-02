-- Role
CREATE TABLE hr_role (
    hr_role_id INT NOT NULL AUTO_INCREMENT,
    role_code VARCHAR(30),
    role_name VARCHAR(30),
    is_active TINYINT(1) DEFAULT 1,
    CONSTRAINT pk_hr_role PRIMARY KEY (hr_role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Permission
CREATE TABLE permission (
    permission_id INT NOT NULL AUTO_INCREMENT,
    permission_code VARCHAR(40),
    permission_name VARCHAR(30),
    CONSTRAINT pk_permission PRIMARY KEY (permission_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Role to permission mapping
CREATE TABLE hr_role_permission (
    hr_role_permission_id INT NOT NULL AUTO_INCREMENT,
    hr_role_id INT,
    permission_id INT,
    CONSTRAINT pk_hr_role_permission PRIMARY KEY (hr_role_permission_id),
    CONSTRAINT fk_hr_role_permission_hr_role FOREIGN KEY (hr_role_id) REFERENCES hr_role(hr_role_id),
    CONSTRAINT fk_hr_role_permission_permission FOREIGN KEY (permission_id) REFERENCES permission(permission_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Department
CREATE TABLE department (
    department_id INT NOT NULL AUTO_INCREMENT,
    department_code VARCHAR(20),
    department_name VARCHAR(20),
    is_active TINYINT(1) DEFAULT 1,
    CONSTRAINT pk_department PRIMARY KEY (department_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Job grade
CREATE TABLE job (
    job_id INT NOT NULL AUTO_INCREMENT,
    job_code VARCHAR(30),
    job_name VARCHAR(15),
    is_active TINYINT(1) DEFAULT 1,
    CONSTRAINT pk_job PRIMARY KEY (job_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Position
CREATE TABLE hr_position (
    hr_position_id INT NOT NULL AUTO_INCREMENT,
    position_code VARCHAR(50) NOT NULL,
    position_name VARCHAR(100) NOT NULL,
    is_active TINYINT(1) DEFAULT 1,
    CONSTRAINT pk_hr_position PRIMARY KEY (hr_position_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Employee
CREATE TABLE emp (
    emp_id INT NOT NULL AUTO_INCREMENT,
    ename VARCHAR(30),
    email VARCHAR(40),
    phone VARCHAR(13),
    hiredate DATE,
    department_id INT,
    job_id INT,
    hr_position_id INT,
    status VARCHAR(15) DEFAULT 'ACTIVE',
    annual_leave_days DECIMAL(7,2),
    CONSTRAINT pk_emp PRIMARY KEY (emp_id),
    CONSTRAINT fk_emp_department FOREIGN KEY (department_id) REFERENCES department(department_id),
    CONSTRAINT fk_emp_job FOREIGN KEY (job_id) REFERENCES job(job_id),
    CONSTRAINT fk_emp_hr_position FOREIGN KEY (hr_position_id) REFERENCES hr_position(hr_position_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Employee account
CREATE TABLE account (
    account_id INT NOT NULL AUTO_INCREMENT,
    emp_id INT,
    login_id VARCHAR(25),
    password VARCHAR(255),
    enabled TINYINT(1) DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_login_at DATETIME,
    CONSTRAINT pk_account PRIMARY KEY (account_id),
    CONSTRAINT fk_account_emp FOREIGN KEY (emp_id) REFERENCES emp(emp_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Account role
CREATE TABLE account_role (
    account_role_id INT NOT NULL AUTO_INCREMENT,
    account_id INT,
    hr_role_id INT,
    CONSTRAINT pk_account_role PRIMARY KEY (account_role_id),
    CONSTRAINT fk_account_role_account FOREIGN KEY (account_id) REFERENCES account(account_id),
    CONSTRAINT fk_account_role_hr_role FOREIGN KEY (hr_role_id) REFERENCES hr_role(hr_role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Leave request
CREATE TABLE leave_request (
    leave_request_id INT NOT NULL AUTO_INCREMENT,
    emp_id INT,
    start_date DATE,
    end_date DATE,
    days DECIMAL(7,2),
    reason VARCHAR(50),
    status VARCHAR(15),
    request_date DATETIME,
    approver_id INT,
    approved_at DATETIME,
    CONSTRAINT pk_leave_request PRIMARY KEY (leave_request_id),
    CONSTRAINT fk_leave_request_emp FOREIGN KEY (emp_id) REFERENCES emp(emp_id),
    CONSTRAINT fk_leave_request_approver FOREIGN KEY (approver_id) REFERENCES emp(emp_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Attendance
CREATE TABLE tb_attendance (
    attendance_id INT NOT NULL AUTO_INCREMENT,
    emp_id INT NOT NULL,
    work_date DATE NOT NULL,
    clock_in DATETIME,
    clock_out DATETIME,
    status VARCHAR(30) NOT NULL,
    CONSTRAINT pk_tb_attendance PRIMARY KEY (attendance_id),
    CONSTRAINT fk_attendance_emp FOREIGN KEY (emp_id) REFERENCES emp(emp_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Leave balance
CREATE TABLE tb_leave_balance (
    balance_id INT NOT NULL AUTO_INCREMENT,
    emp_id INT NOT NULL,
    fiscal_year VARCHAR(4) NOT NULL,
    total_days DECIMAL(7,2) NOT NULL DEFAULT 15,
    used_days DECIMAL(7,2) NOT NULL DEFAULT 0,
    remaining_days DECIMAL(7,2) GENERATED ALWAYS AS (total_days - used_days) STORED,
    CONSTRAINT pk_tb_leave_balance PRIMARY KEY (balance_id),
    CONSTRAINT fk_leave_balance_emp FOREIGN KEY (emp_id) REFERENCES emp(emp_id),
    CONSTRAINT uk_emp_year UNIQUE (emp_id, fiscal_year)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Salary
CREATE TABLE salary (
    salary_id INT NOT NULL AUTO_INCREMENT,
    emp_id INT NOT NULL,
    salary_year_month VARCHAR(7) NOT NULL,
    base_salary DECIMAL(15,0) NOT NULL,
    bonus DECIMAL(15,0) NOT NULL DEFAULT 0,
    deduction DECIMAL(15,0) NOT NULL DEFAULT 0,
    net_salary DECIMAL(15,0) NOT NULL,
    payment_date DATE,
    CONSTRAINT pk_salary PRIMARY KEY (salary_id),
    CONSTRAINT fk_salary_emp FOREIGN KEY (emp_id) REFERENCES emp(emp_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
