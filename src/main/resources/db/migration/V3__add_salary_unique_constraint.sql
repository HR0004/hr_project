ALTER TABLE salary
    ADD CONSTRAINT uk_salary_emp_year_month
    UNIQUE (emp_id, salary_year_month);