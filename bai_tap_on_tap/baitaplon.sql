use study_sql;
create table users(
user_id int primary key auto_increment,
user_name varchar(50) not null unique,
user_fullname varchar(100) not null,
email varchar(100) not null unique,
address varchar(255),
user_phone varchar(20) not null unique
);
create table employee(
emp_id varchar(5) primary key,
user_id int not null,
emp_position varchar(50),
emp_hire_date date not null,
salary int not null check(salary>0),
emp_status bit default 1,
foreign key (user_id) references users(user_id)
);
create table orders(
order_id int primary key auto_increment,
user_id int not null,
order_date date not null default (curdate()),
order_total_amount float not null,
foreign key(user_id) references users(user_id)
);
CREATE TABLE products (
    pro_id VARCHAR(5) PRIMARY KEY, 
    pro_name VARCHAR(100) NOT NULL UNIQUE, -- Không trùng lặp, không null
    pro_price DECIMAL(10,2) NOT NULL CHECK(pro_price > 0), 
    pro_quantity INT NOT NULL CHECK(pro_quantity >= 0),
    pro_status bit(1) DEFAULT 1
);
CREATE TABLE tbl_order_detail (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT, 
    order_id INT NOT NULL,
    pro_id VARCHAR(5) NOT NULL,
    order_detail_quantity INT NOT NULL CHECK(order_detail_quantity > 0), 
    order_detail_price DECIMAL(10,2) NOT NULL CHECK(order_detail_price > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ,
    FOREIGN KEY (pro_id) REFERENCES products(pro_id) 
);
alter table orders add order_status enum( 'Pending','Processing', 'Completed', 'Cancelled');
alter table users modify column user_phone  varchar(11);
alter table users drop column email;
-- Thêm dữ liệu vào bảng users (bao gồm cả khách hàng và nhân viên)
INSERT INTO users (user_name, user_fullname, address, user_phone) 
VALUES 
('john_doe', 'John Doe', '123 Main St, NY', '0123456789'),
('alice_smith', 'Alice Smith', '456 Oak St, CA', '0987654321'),
('bob_jones', 'Bob Jones', '789 Pine St, TX', '0112233445');
-- Thêm dữ liệu vào bảng employee (chỉ dành cho nhân viên)
INSERT INTO employee (emp_id, user_id, emp_position, emp_hire_date, salary, emp_status) 
VALUES 
('E001', 1, 'Manager', '2023-01-15', 5000, 1),
('E002', 2, 'Salesperson', '2023-05-20', 3000, 1);

-- Thêm dữ liệu vào bảng products
INSERT INTO products (pro_id, pro_name, pro_price, pro_quantity, pro_status) 
VALUES 
('P001', 'Laptop Dell XPS 13', 1200.00, 10, 1),
('P002', 'iPhone 14 Pro', 999.99, 20, 1),
('P003', 'Samsung Galaxy S23', 899.99, 15, 1);

-- Thêm dữ liệu vào bảng orders
INSERT INTO orders (user_id, order_total_amount, order_status) 
VALUES 
(1, 2199.99, 'Pending'),
(2, 1200.00, 'Processing'),
(3, 899.99, 'Completed');

-- Thêm dữ liệu vào bảng tbl_order_detail
INSERT INTO tbl_order_detail (order_id, pro_id, order_detail_quantity, order_detail_price) 
VALUES 
(1, 'P001', 1, 1200.00),
(1, 'P002', 1, 999.99),
(2, 'P001', 1, 1200.00),
(3, 'P003', 1, 899.99);
-- them 
INSERT INTO users (user_name, user_fullname, address,user_phone) 
VALUES ('johndoe1', 'John Doe1', '123 Main Ste3', '0123456781');
INSERT INTO employee (emp_id, user_id, emp_position, emp_hire_date, salary, emp_status)  
VALUES ('E005', 5, 'Developer', '2024-02-10', 4000, 1);
-- cau 4
select * from orders;
select distinct(us.user_name) from users us  join orders od on od.user_id=us.user_id;
-- cau 5
select p.pro_name,count(*) as tong_san_pham_da_ban from products p join tbl_order_detail o on p.pro_id=o.pro_id group by o.pro_id;
select p.pro_name,sum(o.order_detail_price*o.order_detail_quantity) as tong_doanh_thu from products p 
join tbl_order_detail o on p.pro_id=o.pro_id group by p.pro_id,p.pro_name 
order by tong_doanh_thu desc;
-- cau6
select us.user_fullname, count(od.order_id) as so_don_hang from users us  join orders od on od.user_id=us.user_id group by us.user_id,us.user_fullname;
select us.user_fullname, count(od.order_id) as so_don_hang from users us  join orders od on od.user_id=us.user_id group by us.user_id,us.user_fullname having so_don_hang>2;
-- cau7
select us.user_fullname, sum(od.order_total_amount) as tong_tien from users us join orders od on od.user_id=us.user_id group by us.user_id order by tong_tien desc limit 3;
-- cau 8
select ep.emp_position,us.user_fullname,count(od.order_id) as sodonhang from employee ep 
join users us on ep.user_id=us.user_id  
left join orders od on od.user_id=ep.user_id
group by ep.user_id,ep.emp_position;
-- cau9
select  us.user_fullname, od.order_total_amount from users us  join orders od on od.user_id=us.user_id 
where od.order_total_amount=(select max(order_total_amount) from orders);
-- cau10
select pd1.pro_id,pd1.pro_name,pd1.pro_quantity from products pd1
left join (select pd.pro_id from products pd inner join  tbl_order_detail od on pd.pro_id=od.pro_id) as subquery on subquery.pro_id=pd1.pro_id where subquery.pro_id is null;



