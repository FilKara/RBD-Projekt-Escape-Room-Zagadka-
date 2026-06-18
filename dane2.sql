use EscapeRoomZagadka;

-- 1) Make an existing employee work at one more existing location (showcases query 4)
-- (uses EmployeeID = 1 and LocationID = 2 which already exist in dane.sql)
INSERT INTO Employees_Locations (EmployeeID, LocationID)
VALUES (1, 2);

-- 2) Upcoming reservation within next 30 days (showcases query 1)
INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (2, 2, 1, NOW() + INTERVAL 7 DAY, 4, 1, 'Pending');
-- no score yet (pending)

-- 3) Capacity violations (showcases query 6)
-- RoomID 3 (Bunker 13) MaxPlayers = 4 -> create a booking with 5 players (too many)
INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (3, 5, 2, NOW() + INTERVAL 3 DAY, 5, 0, 'Pending');

-- RoomID 11 (Sherlock's Study) MaxPlayers = 2 -> create a booking with 1 player (too few)
INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (11, 6, 3, NOW() + INTERVAL 4 DAY, 2, 0, 'Pending');

-- 4) Recent No-Show without a Score (showcases query 7)
INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (9, 7, 4, NOW() - INTERVAL 10 DAY, 4, 1, 'No-Show');
-- intentionally do NOT insert a Scores row for this reservation

-- 5) Build many completed runs with mostly failures and high clue counts for RoomID = 3 (Bunker 13)
-- This will create a low escape rate and a high avg clues used (showcases queries 2 and 9).
-- Insert them one-by-one and immediately create Scores using LAST_INSERT_ID().

INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (3, 8, 5, NOW() - INTERVAL 10 DAY, 4, 1, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 0, 3600, 7);

INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (3, 9, 6, NOW() - INTERVAL 20 DAY, 4, 1, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 0, 3500, 8);

INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (3, 10, 7, NOW() - INTERVAL 30 DAY, 3, 1, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 0, 3600, 6);

INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (3, 11, 8, NOW() - INTERVAL 40 DAY, 4, 1, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 1, 3200, 4);

INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (3, 12, 9, NOW() - INTERVAL 50 DAY, 4, 1, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 0, 3600, 9);

INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (3, 13, 10, NOW() - INTERVAL 60 DAY, 4, 1, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 0, 3400, 7);

INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (3, 14, 11, NOW() - INTERVAL 70 DAY, 4, 1, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 0, 3550, 8);

INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (3, 15, 12, NOW() - INTERVAL 80 DAY, 3, 1, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 0, 3500, 6);

-- 6) Peak booking hours: create several reservations at 18:00 to create a visible spike (showcases query 8)
INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (1, 2, 1, CONCAT(DATE(NOW() - INTERVAL 15 DAY), ' 18:00:00'), 4, 1, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 1, 2200, 1);

INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (7, 3, 1, CONCAT(DATE(NOW() - INTERVAL 20 DAY), ' 18:00:00'), 4, 1, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 1, 2100, 2);

INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (2, 4, 2, CONCAT(DATE(NOW() - INTERVAL 25 DAY), ' 18:00:00'), 5, 1, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 1, 2400, 1);

-- 7) Top client revenue: add high-value completed bookings for ClientID = 2 to increase total_spent (showcases query 3)
-- Use RoomID 7 (Space Station Odyssey, PricePerPersonPLN = 120) & RoomID 12 (Time Travel Paradox, PricePerPersonPLN = 130)
INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (7, 2, 1, NOW() - INTERVAL 12 DAY, 6, 1, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 1, 1800, 0);

INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (12, 2, 2, NOW() - INTERVAL 40 DAY, 4, 1, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 1, 2000, 1);

-- 8) Client who booked a 'Horror' themed room: pick an existing horror-mapped room (RoomID 4 or 5 or 6).
-- Here we add a Completed booking for ClientID = 1 in RoomID = 4 which is mapped to ThemeID = 1 (Horror).
INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (4, 1, 2, NOW() - INTERVAL 90 DAY, 5, 1, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 1, 3100, 3);

-- 9) Add a couple of extra completed runs for RoomID = 4 with low clues so comparison with RoomID = 3 is clear (query 9)
INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (4, 16, 2, NOW() - INTERVAL 20 DAY, 5, 1, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 1, 2000, 1);

INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (4, 17, 2, NOW() - INTERVAL 35 DAY, 4, 0, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 1, 2300, 2);

-- 10) Add one more reservation to make sure there are enough rows for ordering/limits in reports
INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES (1, 18, 1, NOW() - INTERVAL 5 DAY, 4, 1, 'Completed');
SET @rid = LAST_INSERT_ID();
INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed) VALUES (@rid, 1, 1990, 1);

