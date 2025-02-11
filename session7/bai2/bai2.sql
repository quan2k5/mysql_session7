create database session7;
use session7;
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(255),
    location VARCHAR(255)
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(255),
    dob DATE,
    department_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(255),
    start_date DATE,
    end_date DATE
);

CREATE TABLE Timesheets (
    timesheet_id INT PRIMARY KEY,
    employee_id INT,
    project_id INT,
    work_date DATE,
    hours_worked DECIMAL(5, 2),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

CREATE TABLE Reports (
    report_id INT PRIMARY KEY,
    employee_id INT,
    report_date DATE,
    report_content TEXT,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);
-- 3
-- Thêm dữ liệu vào bảng Departments
INSERT INTO Departments (department_id, department_name, location)
VALUES
    (1, 'Phòng Kế Toán', 'Tầng 2'),
    (2, 'Phòng IT', 'Tầng 5');

-- Thêm dữ liệu vào bảng Employees
INSERT INTO Employees (employee_id, name, dob, department_id, salary)
VALUES
    (1, 'Nguyễn Văn A', '1990-05-15', 1, 15000000),
    (2, 'Trần Thị B', '1985-09-20', 2, 25000000);

-- Thêm dữ liệu vào bảng Projects
INSERT INTO Projects (project_id, project_name, start_date, end_date)
VALUES
    (1, 'Dự án ERP', '2024-01-01', '2024-12-31'),
    (2, 'Dự án AI Chatbot', '2024-03-01', '2024-09-30');

-- Thêm dữ liệu vào bảng Timesheets
INSERT INTO Timesheets (timesheet_id, employee_id, project_id, work_date, hours_worked)
VALUES
    (1, 1, 1, '2024-06-10', 8.0),
    (2, 2, 2, '2024-06-11', 7.5);

-- Thêm dữ liệu vào bảng Reports
INSERT INTO Reports (report_id, employee_id, report_date, report_content)
VALUES
    (1, 1, '2024-06-12', 'Báo cáo tiến độ dự án ERP.'),
    (2, 2, '2024-06-13', 'Báo cáo tiến độ dự án AI Chatbot.');

-- 3
UPDATE Projects
SET project_name = 'Dự án nhà xanh', end_date = '2022-12-31'
WHERE project_id = 1;
-- 4
DELETE FROM Employees WHERE employee_id = 2;



