use EscapeRoomZagadka;

# Escape rate per room
SELECT  ROUND(SUM(s.DidEscape)/COUNT(s.ScoreID) * 100 , 2) as EscapeRatePrecent,  ro.RoomID, ro.Name FROM Scores s
LEFT JOIN Reservations r ON s.ReservationID = r.ReservationID
LEFT JOIN Rooms ro ON r.RoomID = ro.RoomID
GROUP BY ro.RoomID, ro.Name;

#
# use EscapeRoomZagadka;
#
# # Escape
#
#
# SELECT * FROM Employees e
# JOIN Employees_Locations on e.EmployeeID = Employees_Locations.EmployeeID
# JOIN Locations ON Employees_Locations.LocationID = Locations.LocationID
# where e.Role = 'Game Master' AND Locations.LocationID = 1;
#
# SELECT r.RoomID, r.Name, r.MaxPlayers, l.City FROM Rooms r
# LEFT JOIN Locations l ON r.LocationID = l.LocationID
# ORDER BY City