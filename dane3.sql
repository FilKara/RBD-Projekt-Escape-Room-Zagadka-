use EscapeRoomZagadka;

-- ==========================================
-- 1. DANE SŁOWNIKOWE I BAZOWE
-- ==========================================

INSERT INTO Themes (Name)
VALUES ('Horror'), ('Sci-Fi'), ('Fantasy'), ('Mystery'), ('Adventure'),
       ('Historical'), ('Thriller'), ('Comedy'), ('Military'), ('Abstract');

INSERT INTO Clients (FirstName, LastName, EMail, PhoneNumber)
VALUES ('Carina', 'Guys', 'cguys0@oakley.com', '601-872-3881'),
       ('Vonny', 'Bleibaum', 'vbleibaum1@ted.com', '103-798-6497'),
       ('Leshia', 'Alldre', 'lalldre2@usnews.com', '574-796-2766'),
       ('Benjamen', 'Laite', 'blaite3@squidoo.com', '447-405-1375'),
       ('Stefa', 'Gheorghescu', 'sgheorghescu4@house.gov', '384-508-5443'),
       ('Muffin', 'Boydle', 'mboydle5@adobe.com', '777-789-3678'),
       ('Noreen', 'MacKimmie', 'nmackimmie6@dailymail.co.uk', '742-148-5511'),
       ('Alisander', 'McKeefry', 'amckeefry7@hhs.gov', '126-988-7658'),
       ('Travis', 'Bachura', 'tbachura8@forbes.com', '947-913-9976'),
       ('Jody', 'Renyard', 'jrenyard9@digg.com', '199-794-4297'),
       ('Nona', 'Palfreyman', 'npalfreymana@fc2.com', '196-169-6126'),
       ('Hew', 'Klageman', 'hklagemanb@sfgate.com', '996-321-6554'),
       ('Barnard', 'Broske', 'bbroskec@cpanel.net', '631-733-7627'),
       ('Jonie', 'Fincher', 'jfincherd@sfgate.com', '726-332-7880'),
       ('Gustave', 'Donwell', 'gdonwelle@1und1.de', '784-468-4493'),
       ('Kendra', 'Skyrm', 'kskyrmf@yellowpages.com', '977-545-5133'),
       ('Minetta', 'Gerhardt', 'mgerhardtg@sourceforge.net', '563-767-0960'),
       ('Bobby', 'Pellman', 'bpellmanh@themeforest.net', '881-161-7128'),
       ('Sella', 'Tures', 'sturesi@blogspot.com', '162-498-5969'),
       ('Doralynn', 'Giocannoni', 'dgiocannonij@exblog.jp', '160-694-3820'),
       ('Anna-diane', 'Juarez', 'ajuarezk@gravatar.com', '717-845-7437'),
       ('Sayre', 'Powles', 'spowlesl@ihg.com', '730-753-1530'),
       ('Adey', 'Postans', 'apostansm@xrea.com', '975-966-0893'),
       ('Burg', 'Canero', 'bcaneron@hatena.ne.jp', '464-857-4999'),
       ('Noell', 'Sanja', 'nsanjao@php.net', '761-964-2403');

INSERT INTO Employees (FirstName, LastName, Role)
VALUES ('Kingston', 'Duckels', 'Customer Service'),
       ('Orren', 'Andreazzi', 'Game Master'),
       ('Jorgan', 'Pereira', 'Game Master'),
       ('Samson', 'Rowlands', 'Customer Service'),
       ('Konstance', 'Armin', 'Technician'),
       ('Elva', 'Gillam', 'Game Master'),
       ('Zachery', 'Frugier', 'Technician'),
       ('Rubi', 'Oakinfold', 'Technician'),
       ('Eleen', 'Hurne', 'Technician'),
       ('Andreana', 'Gounet', 'Technician'),
       ('Krystle', 'Lippitt', 'Customer Service'),
       ('Ab', 'Nobes', 'Game Master'),
       ('Davita', 'Elloy', 'Game Master'),
       ('Norri', 'Franzolini', 'Technician'),
       ('Joycelin', 'Janc', 'Game Master'),
       ('Jacobo', 'Valentine', 'Customer Service'),
       ('Humfrey', 'Bellson', 'Game Master'),
       ('Margarethe', 'Milsted', 'Customer Service'),
       ('Jeramey', 'Corkish', 'Customer Service'),
       ('Nada', 'Harverson', 'Game Master');

INSERT INTO Locations(City, StreetAddress)
VALUES ('Warszawa', 'Jana i Jędrzeja Śniadeckich 1/15'),
       ('Gdańsk', 'Startowa 4A'),
       ('Poznań', 'plac Wolności 5/5');

INSERT INTO Rooms(LocationID, Name, Difficulty, MaxPlayers, PricePerPersonPLN)
VALUES (1, 'Prison Break', 3, 6, 70),
       (2, 'The Heist', 4, 5, 80),
       (3, 'Bunker 13', 5, 4, 100),
       (1, 'Haunted Mansion', 3, 6, 70),
       (2, 'Asylum', 4, 3, 85),
       (3, 'Zombie Lab', 3, 5, 65),
       (1, 'Space Station Odyssey', 4, 4, 120),
       (2, 'The Pharaohs''s Tomb', 2, 6, 60),
       (3, 'Submarine Peril', 4, 4, 120),
       (1, 'Wizard''s Alchemist Lab', 2, 5, 55),
       (2, 'Sherlock''s Study', 3, 2 ,110),
       (3, 'Time Travel Paradox', 5, 6, 130);

INSERT INTO Rooms_Themes(RoomID, ThemeID)
VALUES (1, 7), (2, 7), (3, 7), (3, 9), (4, 1), (4, 6),
       (5, 1), (6, 1), (7, 2), (7, 5), (8, 5), (8, 6),
       (9, 5), (10, 3), (10, 10), (11, 4), (12, 3), (12, 10);

-- Lokalizacje pracowników (wraz z dodatkowym z pliku 2)
INSERT INTO Employees_Locations (EmployeeID, LocationID)
VALUES (1, 1), (2, 1), (3, 1), (4,1), (5,1), (6,1), (7,1),
       (8,2), (9,2), (10,3), (11,2), (12,2), (13,2),
       (14,3), (15,3), (16,2), (17,3), (18,3), (19,3), (20,3),
       (1, 2);

-- ==========================================
-- 2. REZERWACJE (Zachowana oryginalna kolejność - wygenerują ID 1 do 42)
-- ==========================================

INSERT INTO Reservations (RoomID, ClientID, EmployeeID, ReservationDate, NumberOfPlayers, PaidUpFront, Status)
VALUES
  -- Plik 1: Pierwsze zapytanie bez jawnego statusu (Status domyślnie 'Pending')
  (1,  1,  2,  '2023-12-01 11:59:17', 6, true,  'Pending'), -- ID 1
  (7,  1,  3,  '2026-04-06 17:05:56', 4, true,  'Pending'), -- ID 2
  (4,  1,  6,  '2024-03-15 09:48:01', 5, false, 'Pending'), -- ID 3

  -- Plik 1: Drugie zapytanie (z jawnym statusem)
  (2,  2,  4,  '2024-01-05 18:00:00', 5, true,  'Completed'), -- ID 4
  (3,  3,  7,  '2024-01-12 14:00:00', 4, true,  'Completed'), -- ID 5
  (5,  4,  5,  '2024-02-20 20:00:00', 3, false, 'Cancelled'), -- ID 6
  (6,  6,  8,  '2024-03-03 19:00:00', 5, true,  'Completed'), -- ID 7
  (8,  9,  9,  '2024-03-15 17:30:00', 4, true,  'Completed'), -- ID 8
  (9, 10, 10,  '2024-04-01 11:00:00', 4, false, 'No-Show'),   -- ID 9
  (10, 11, 11, '2024-04-10 16:00:00', 5, true,  'Completed'), -- ID 10
  (11, 12, 12, '2024-05-20 18:00:00', 6, true,  'Pending'),   -- ID 11
  (1,  13, 13, '2024-06-01 19:00:00', 6, true,  'Completed'), -- ID 12
  (2,  14, 14, '2024-06-15 20:00:00', 5, false, 'Completed'), -- ID 13
  (3,  15, 15, '2024-07-04 15:00:00', 3, true,  'Completed'), -- ID 14
  (4,  16, 16, '2024-08-09 12:00:00', 5, true,  'Completed'), -- ID 15
  (5,  17, 17, '2024-09-11 13:30:00', 4, false, 'Cancelled'), -- ID 16
  (6,  18, 18, '2024-10-22 20:30:00', 5, true,  'Completed'), -- ID 17
  (7,  19, 19, '2024-11-30 17:00:00', 4, true,  'Completed'), -- ID 18
  (8,  21, 20, '2025-01-02 18:00:00', 6, false, 'Pending'),   -- ID 19
  (8,  21, 20, '2026-12-02 18:00:00', 6, false, 'Pending'),   -- ID 20
  (9,  22, 1,  '2025-02-14 14:00:00', 4, true,  'Completed'), -- ID 21

  -- Plik 2: Pojedyncze wpisy według kolejności w Twoim drugim pliku
  (2,  2,  1, NOW() + INTERVAL 7 DAY, 4, 1, 'Pending'),       -- ID 22
  (3,  5,  2, NOW() + INTERVAL 3 DAY, 5, 0, 'Pending'),       -- ID 23
  (11, 6,  3, NOW() + INTERVAL 4 DAY, 2, 0, 'Pending'),       -- ID 24
  (9,  7,  4, NOW() - INTERVAL 10 DAY, 4, 1, 'No-Show'),      -- ID 25

  (3,  8,  5, NOW() - INTERVAL 10 DAY, 4, 1, 'Completed'),    -- ID 26
  (3,  9,  6, NOW() - INTERVAL 20 DAY, 4, 1, 'Completed'),    -- ID 27
  (3,  10, 7, NOW() - INTERVAL 30 DAY, 3, 1, 'Completed'),    -- ID 28
  (3,  11, 8, NOW() - INTERVAL 40 DAY, 4, 1, 'Completed'),    -- ID 29
  (3,  12, 9, NOW() - INTERVAL 50 DAY, 4, 1, 'Completed'),    -- ID 30
  (3,  13, 10, NOW() - INTERVAL 60 DAY, 4, 1, 'Completed'),   -- ID 31
  (3,  14, 11, NOW() - INTERVAL 70 DAY, 4, 1, 'Completed'),   -- ID 32
  (3,  15, 12, NOW() - INTERVAL 80 DAY, 3, 1, 'Completed'),   -- ID 33

  (1,  2,  1, CONCAT(DATE(NOW() - INTERVAL 15 DAY), ' 18:00:00'), 4, 1, 'Completed'), -- ID 34
  (7,  3,  1, CONCAT(DATE(NOW() - INTERVAL 20 DAY), ' 18:00:00'), 4, 1, 'Completed'), -- ID 35
  (2,  4,  2, CONCAT(DATE(NOW() - INTERVAL 25 DAY), ' 18:00:00'), 5, 1, 'Completed'), -- ID 36

  (7,  2,  1, NOW() - INTERVAL 12 DAY, 6, 1, 'Completed'),    -- ID 37
  (12, 2,  2, NOW() - INTERVAL 40 DAY, 4, 1, 'Completed'),    -- ID 38

  (4,  1,  2, NOW() - INTERVAL 90 DAY, 5, 1, 'Completed'),    -- ID 39
  (4,  16, 2, NOW() - INTERVAL 20 DAY, 5, 1, 'Completed'),    -- ID 40
  (4,  17, 2, NOW() - INTERVAL 35 DAY, 4, 0, 'Completed'),    -- ID 41
  (1,  18, 1, NOW() - INTERVAL 5 DAY, 4, 1, 'Completed');     -- ID 42


-- ==========================================
-- 3. WYNIKI GIER (Zachowane w 100% z plików źródłowych)
-- ==========================================

INSERT INTO Scores (ReservationID, DidEscape, TimeToSolveSeconds, CluesUsed)
VALUES
  -- Plik 1 (zgodne 1:1 z Twoim wklejonym kodem)
  (1,  TRUE,  2500, 1),
  (2,  TRUE,  3000, 2),
  (3,  FALSE, 3600, 3),
  (4,  TRUE,  2200, 1),
  (5,  TRUE,  1850, 0),
  (6,  FALSE, 3600, 0),
  (7,  TRUE,  2100, 2),
  (9,  TRUE,  2400, 1),
  (10, TRUE,  2700, 2),
  (11, TRUE,  2000, 0),
  (12, TRUE,  2600, 1),
  (13, FALSE, 3600, 4),
  (14, TRUE,  1800, 1),
  (15, TRUE,  2300, 2),
  (16, TRUE,  3100, 3),
  (17, TRUE,  2900, 1),
  (18, TRUE,  2050, 0),
  (19, TRUE,  1990, 1),
  (20, TRUE,  2150, 1),

  -- Plik 2 (zastąpione LAST_INSERT_ID z zachowaniem precyzyjnej kolejności)
  (26, 0, 3600, 7),
  (27, 0, 3500, 8),
  (28, 0, 3600, 6),
  (29, 1, 3200, 4),
  (30, 0, 3600, 9),
  (31, 0, 3400, 7),
  (32, 0, 3550, 8),
  (33, 0, 3500, 6),
  (34, 1, 2200, 1),
  (35, 1, 2100, 2),
  (36, 1, 2400, 1),
  (37, 1, 1800, 0),
  (38, 1, 2000, 1),
  (39, 1, 3100, 3),
  (40, 1, 2000, 1),
  (41, 1, 2300, 2),
  (42, 1, 1990, 1);