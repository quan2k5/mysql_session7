use session7;
create table Categories (
category_id int primary key,
category_name varchar(255) 
);

create table Books (
book_id int primary key,
title varchar(255),
author varchar (225),
publication_year int,
available_quality int,
category_id int,
foreign key (category_id) references Categories(category_id) on delete cascade
);
create table Readers (
reader_id int primary key ,
name varchar(255),
phone_number varchar(15),
email varchar(255)
);

create table Borrowing (
borrow_id int primary key,
reader_id int,
book_id int,
foreign key ( reader_id) references Readers(reader_id),
foreign key ( book_id) references Books(book_id)  on delete cascade,
borrow_date date ,
due_date date 
);

create table Returning (
return_id int primary key,
borrow_id int,
foreign key (borrow_id) references Borrowing(borrow_id)  on delete cascade,
return_date date
);

create table Fines  (
fine_id int primary key,
return_id int,
foreign key (return_id) references Returning(return_id)  on delete cascade,
fine_amount decimal(10,2)
);
-- 3
-- Thêm dữ liệu vào bảng Categories
INSERT INTO Categories (category_id, category_name) 
VALUES (1, 'Science Fiction'), (2, 'History');

-- Thêm dữ liệu vào bảng Books
INSERT INTO Books (book_id, title, author, publication_year, available_quality, category_id) 
VALUES (1, 'Dune', 'Frank Herbert', 1965, 5, 1),
       (2, 'Sapiens', 'Yuval Noah Harari', 2011, 3, 2);

-- Thêm dữ liệu vào bảng Readers
INSERT INTO Readers (reader_id, name, phone_number, email) 
VALUES (1, 'Nguyen Van A', '0123456789', 'vana@example.com'),
       (2, 'Tran Thi B', '0987654321', 'thib@example.com');

-- Thêm dữ liệu vào bảng Borrowing
INSERT INTO Borrowing (borrow_id, reader_id, book_id, borrow_date, due_date) 
VALUES (1, 1, 1, '2024-02-01', '2024-02-15'),
       (2, 2, 2, '2024-02-03', '2024-02-17');

-- Thêm dữ liệu vào bảng Returning
INSERT INTO Returning (return_id, borrow_id, return_date) 
VALUES (1, 1, '2024-02-16'),
       (2, 2, '2024-02-18');

-- Thêm dữ liệu vào bảng Fines
INSERT INTO Fines (fine_id, return_id, fine_amount) 
VALUES (1, 1, 5000.00),
       (2, 2, 10000.00);

-- 4
UPDATE Readers 
SET phone_number = '0909090909' 
WHERE reader_id = 1;

-- 5
DELETE FROM Books WHERE book_id = 1;
