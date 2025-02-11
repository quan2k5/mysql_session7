CREATE DATABASE MovieTicket;
USE MovieTicket;
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY AUTO_INCREMENT,
    MovieName NVARCHAR(30),
    MovieType NVARCHAR(25),
    Duration INT
);

CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY AUTO_INCREMENT,
    RoomName NVARCHAR(20),
    Status TINYINT
);

CREATE TABLE Seats (
    SeatID INT PRIMARY KEY AUTO_INCREMENT,
    RoomID INT,
    SeatNumber VARCHAR(10),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID) ON DELETE CASCADE
);

CREATE TABLE Tickets (
    MovieID INT,
    SeatID INT,
    ShowDate DATETIME,
    TicketStatus NVARCHAR(20),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) ON DELETE CASCADE,
    FOREIGN KEY (SeatID) REFERENCES Seats(SeatID) ON DELETE CASCADE
);
INSERT INTO movies (MovieName, MovieType, Duration) VALUES
('Em bé Hà Nội', 'Tâm lý', 90),
('Nhiệm vụ bất khả thi', 'Hành động', 100),
('Dị nhân', 'Viễn tưởng', 90),
('Cuốn theo chiều gió', 'Tình cảm', 120);

INSERT INTO rooms (RoomName, Status) VALUES
('Phòng chiếu 1', 1),
('Phòng chiếu 2', 1),
('Phòng chiếu 3', 0);

INSERT INTO seats (RoomID, SeatNumber) VALUES
(1, 'A3'),
(1, 'B5'),
(2, 'A7'),
(2, 'D1'),
(3, 'T2');

INSERT INTO tickets (MovieID, SeatID, ShowDate, TicketStatus) VALUES
(1, 1, '2008-10-20', 'Đã bán'),
(1, 3, '2008-11-20', 'Đã bán'),
(1, 4, '2008-12-23', 'Đã bán'),
(2, 1, '2009-02-14', 'Đã bán'),
(3, 1, '2009-02-14', 'Đã bán'),
(2, 5, '2009-03-08', 'Chưa bán'),
(2, 3, '2009-03-08', 'Chưa bán');
-- 1
SELECT *
FROM movies
ORDER BY duration;
-- 2
SELECT moviename
FROM movies
WHERE duration = (SELECT MAX(duration) FROM movies);
-- 3
SELECT moviename
FROM movies
WHERE duration = (SELECT MIN(duration) FROM movies);
-- 4
SELECT seatnumber
FROM seats
WHERE seatnumber LIKE 'A%';
-- 5
ALTER TABLE rooms
modify COLUMN `status` VARCHAR(25);
-- 6
DELIMITER //
CREATE PROCEDURE UpdateAndShowRoom()
BEGIN
    UPDATE rooms 
    SET `status` = CASE 
        WHEN `status` = '0' THEN 'Đang sửa'
        WHEN `status` = '1' THEN 'Đang sử dụng'
        ELSE 'Unknown'
    END;
    
    SELECT * FROM rooms;
END //
DELIMITER ;
CALL UpdateAndShowRoom();
-- DROP PROCEDURE IF EXISTS UpdateAndShowRoom;
-- 7
SELECT moviename
FROM movies
WHERE length(moviename) > 15 AND length(moviename) < 25;
-- 8
SELECT roomname + ' - ' + status AS 'Trạng thái phòng chiếu'
FROM rooms;
-- 9
CREATE VIEW `Rank` AS
SELECT
    RANK() OVER (ORDER BY moviename) AS STT,  -- Thứ hạng theo Ten_phim
    moviename,
    duration
FROM movies;
-- 10
ALTER TABLE movies
ADD  `description` NVARCHAR(255);

UPDATE movies
SET description = 'Đây là bộ phim thể loại ' + movietype;
SELECT * FROM tblPhim;
UPDATE movies
SET `description`  = REPLACE(`description`, 'bộ phim', 'film');
-- 11
ALTER TABLE tblGhe DROP FOREIGN KEY tblGhe_ibfk_1;
ALTER TABLE tblVe DROP FOREIGN KEY tblVe_ibfk_1;
ALTER TABLE tblVe DROP FOREIGN KEY tblVe_ibfk_2;
-- 12
DELETE FROM tblGhe;
-- 13
SELECT showdate, DATE_ADD(showdate,  INTERVAL 5000 MINUTE) AS Ngay_chieu_cong_5000_phut
FROM tickets;