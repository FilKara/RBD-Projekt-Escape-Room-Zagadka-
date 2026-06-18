use EscapeRoomZagadka;

# Escape rate per room
SELECT
    ROUND(SUM(s.DidEscape)/COUNT(s.ScoreID) * 100 , 2) as EscapeRatePrecent,  ro.RoomID, ro.Name
FROM Scores s
         LEFT JOIN Reservations r ON s.ReservationID = r.ReservationID
         LEFT JOIN Rooms ro ON r.RoomID = ro.RoomID
GROUP BY ro.RoomID, ro.Name;

-- 1) Upcoming reservations in the next 30 days (uses BETWEEN, ORDER BY, LIMIT)
SELECT
    r.ReservationID,
    CONCAT(c.FirstName, ' ', c.LastName) AS ClientName,
    rm.Name AS RoomName,
    r.ReservationDate,
    r.NumberOfPlayers,
    r.Status
FROM Reservations r
         INNER JOIN Clients c ON r.ClientID = c.ClientID
         INNER JOIN Rooms rm ON r.RoomID = rm.RoomID
WHERE r.ReservationDate BETWEEN NOW() AND (NOW() + INTERVAL 30 DAY)
ORDER BY r.ReservationDate
LIMIT 100;

-- 2) Rooms with low escape success rate in the last 180 days (GROUP BY + HAVING)
-- Useful to identify rooms that may need balancing or design fixes.
SELECT
    rm.RoomID,
    rm.Name AS RoomName,
    COUNT(s.ScoreID) AS Runs,
    100.0 * SUM(CASE WHEN s.DidEscape THEN 1 ELSE 0 END) / NULLIF(COUNT(s.ScoreID),0) AS EscapeRatePercent
FROM Rooms rm
         INNER JOIN Reservations r ON rm.RoomID = r.RoomID
         INNER JOIN Scores s ON r.ReservationID = s.ReservationID
WHERE r.ReservationDate >= NOW() - INTERVAL 180 DAY
GROUP BY rm.RoomID, rm.Name
HAVING COUNT(s.ScoreID) >= 5
   AND (SUM(CASE WHEN s.DidEscape THEN 1 ELSE 0 END) * 1.0 / COUNT(s.ScoreID)) < 0.5
ORDER BY EscapeRatePercent ASC;

-- 3) Top 10 clients by revenue (Completed reservations) (JOIN + GROUP BY + ORDER BY + LIMIT)
SELECT
    c.ClientID,
    CONCAT(c.FirstName, ' ', c.LastName) AS ClientName,
    COUNT(r.ReservationID) AS CompletedReservations,
    SUM(r.NumberOfPlayers * rm.PricePerPersonPLN) AS TotalSpentPln
FROM Clients c
         INNER JOIN Reservations r ON c.ClientID = r.ClientID
         INNER JOIN Rooms rm ON r.RoomID = rm.RoomID
WHERE r.Status = 'Completed'
GROUP BY c.ClientID, ClientName
ORDER BY TotalSpentPln DESC
LIMIT 10;

-- 4) Employees working in more than one location (INNER JOIN + GROUP BY + HAVING)
SELECT
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS employee_name,
    e.Role,
    COUNT(el.LocationID) AS location_count
FROM Employees e
         INNER JOIN Employees_Locations el ON e.EmployeeID = el.EmployeeID
GROUP BY e.EmployeeID, employee_name, e.Role
HAVING COUNT(el.LocationID) > 1
ORDER BY location_count DESC;

-- 5) Rooms that currently have no theme assigned (LEFT JOIN + IS NULL)
SELECT
    rm.RoomID,
    rm.Name AS room_name,
    rm.Difficulty,
    rm.MaxPlayers
FROM Rooms rm
         LEFT JOIN Rooms_Themes rt ON rm.RoomID = rt.RoomID
WHERE rt.RoomID IS NULL
ORDER BY rm.Difficulty DESC;

-- 6) Reservations where NumberOfPlayers violates room capacity rules (uses > and < operators)
SELECT
    r.ReservationID,
    CONCAT(c.FirstName, ' ', c.LastName) AS client_name,
    rm.Name AS room_name,
    r.NumberOfPlayers,
    rm.MaxPlayers
FROM Reservations r
         INNER JOIN Rooms rm ON r.RoomID = rm.RoomID
         INNER JOIN Clients c ON r.ClientID = c.ClientID
WHERE r.NumberOfPlayers > rm.MaxPlayers OR r.NumberOfPlayers < 2
ORDER BY r.ReservationDate DESC;

-- 7) Recent No-Show reservations that have no Scores recorded (NOT EXISTS)
-- These may need follow-up/refund or manual review.
SELECT
    r.ReservationID,
    CONCAT(c.FirstName, ' ', c.LastName) AS client_name,
    r.ReservationDate,
    r.Status
FROM Reservations r
         INNER JOIN Clients c ON r.ClientID = c.ClientID
WHERE r.Status = 'No-Show'
  AND r.ReservationDate >= NOW() - INTERVAL 90 DAY
  AND NOT EXISTS (
    SELECT 1 FROM Scores s WHERE s.ReservationID = r.ReservationID
)
ORDER BY r.ReservationDate DESC;

-- 8) Peak booking hours (HOUR(), GROUP BY, ORDER BY, LIMIT)
-- Helps staff scheduling and shift planning.
SELECT
    HOUR(r.ReservationDate) AS booking_hour,
    COUNT(*) AS bookings
FROM Reservations r
WHERE r.ReservationDate >= NOW() - INTERVAL 365 DAY
GROUP BY booking_hour
ORDER BY bookings DESC
LIMIT 5;

-- 9) Rooms with highest average clues used (GROUP BY + HAVING + ORDER BY)
SELECT
    rm.RoomID,
    rm.Name AS room_name,
    AVG(s.CluesUsed) AS avg_clues_used,
    COUNT(s.ScoreID) AS runs_count
FROM Rooms rm
         INNER JOIN Reservations r ON rm.RoomID = r.RoomID
         INNER JOIN Scores s ON r.ReservationID = s.ReservationID
GROUP BY rm.RoomID, rm.Name
HAVING COUNT(s.ScoreID) >= 3
ORDER BY avg_clues_used DESC
LIMIT 10;

-- 10) Clients who have booked at least one room with the 'Horror' theme (IN subquery) and email domain filter (LIKE)
SELECT DISTINCT
    c.ClientID,
    CONCAT(c.FirstName, ' ', c.LastName) AS ClientName,
    c.EMail
FROM Clients c
WHERE c.ClientID IN (
    SELECT r.ClientID
    FROM Reservations r
             INNER JOIN Rooms_Themes rt ON r.RoomID = rt.RoomID
             INNER JOIN Themes t ON rt.ThemeID = t.ThemeID
    WHERE t.Name = 'Horror'
)
ORDER BY ClientName;

#WIDOK
CREATE OR REPLACE VIEW RankingTop10 AS
SELECT
    ReservationID,
    RoomName,
    DidEscape,
    CluesUsed,
    TimeToSolveSeconds
FROM (
         SELECT
             s.ReservationID,
             rm.Name AS RoomName,
             s.DidEscape,
             s.CluesUsed,
             s.TimeToSolveSeconds,
             ROW_NUMBER() OVER (PARTITION BY rm.RoomID ORDER BY s.TimeToSolveSeconds ASC) AS RoomRank
         FROM Scores s
                  LEFT JOIN Reservations r ON s.ReservationID = r.ReservationID
                  LEFT JOIN Rooms rm ON r.RoomID = rm.RoomID
     ) AS RankedScores
WHERE RoomRank <= 10;

SELECT * FROM RankingTop10 ORDER BY RoomName, TimeToSolveSeconds;

DELIMITER //
CREATE PROCEDURE MakeReservation(
    IN PRoomID INT,
    IN PClientID INT,
    IN PEmployeeID INT,
    IN ReservationStartDateTime DATETIME,
    IN PNumberOfPlayers INT,
    IN PPaidUpFront BOOL,
    OUT PReservationID INT,
    OUT PSTATUS VARCHAR(20),
    OUT PErrorMessage TEXT
)
BEGIN
    DECLARE ValidateTimeSeconds INT;

    SET PReservationID = NULL;
    SET PErrorMessage = NULL;

    SELECT TimeToSolveSeconds
    INTO ValidateTimeSeconds
    FROM Rooms
    WHERE RoomID = PRoomID;

end //
