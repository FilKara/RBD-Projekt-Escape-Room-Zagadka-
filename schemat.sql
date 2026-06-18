# CREATE DATABASE EscapeRoomZagadka;

use EscapeRoomZagadka;

CREATE TABLE Locations(
    LocationID int AUTO_INCREMENT PRIMARY KEY ,
    City varchar(50) NOT NULL ,
    StreetAddress varchar(150) UNIQUE NOT NULL,

    CONSTRAINT UniqueCityStreetAddress UNIQUE (City, StreetAddress)
);

CREATE TABLE Employees(
    EmployeeID int AUTO_INCREMENT PRIMARY KEY ,
    FirstName varchar(50) NOT NULL ,
    LastName varchar(50) NOT NULL,
    Role varchar(50) NOT NULL DEFAULT 'Game Master'

);

CREATE TABLE Employees_Locations(
    EmployeeID int,
    LocationID int,

    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE ,
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID) ON DELETE CASCADE,

    PRIMARY KEY (EmployeeID, LocationID)
);
CREATE TABLE Rooms(
    RoomID int AUTO_INCREMENT PRIMARY KEY ,
    LocationID int NOT NULL ,
    Name varchar(50) NOT NULL UNIQUE ,
    Difficulty int NOT NULL CHECK (Difficulty BETWEEN 1 and 5),
    MaxPlayers int NOT NULL CHECK (MaxPlayers between 2 and 6),
    TimeToSolveSeconds int NOT NULL DEFAULT 3600,
    PricePerPersonPLN DECIMAL NOT NULL,

    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID) ON DELETE CASCADE
);

CREATE TABLE Themes(
  ThemeID int AUTO_INCREMENT PRIMARY KEY ,
  Name varchar(50) UNIQUE NOT NULL
);

CREATE TABLE Rooms_Themes(
    RoomID int,
    ThemeID int,

    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID) ON DELETE CASCADE,
    FOREIGN KEY (ThemeID) REFERENCES Themes(ThemeID) ON DELETE CASCADE,

    PRIMARY KEY (RoomID, ThemeID)
);

CREATE TABLE Clients(
    ClientID int AUTO_INCREMENT PRIMARY KEY ,
    FirstName varchar(50) NOT NULL ,
    LastName varchar(50) NOT NULL,
    PhoneNumber varchar(20) UNIQUE NOT NULL ,
    EMail varchar(100) UNIQUE NOT NULL
);

CREATE TABLE Reservations(
    ReservationID int AUTO_INCREMENT PRIMARY KEY,
    RoomID int NOT NULL ,
    ClientID int NOT NULL ,
    EmployeeID int NOT NULL,
    ReservationDate DATETIME NOT NULL ,
    NumberOfPlayers int NOT NULL CHECK (NumberOfPlayers BETWEEN 2 AND 6),
    PaidUpFront bool NOT NULL,
    Status varchar(50) NOT NULL DEFAULT 'Pending' CHECK ( Status IN ('Cancelled', 'Pending', 'Completed', 'No-Show')),

    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
    );

CREATE TABLE Scores(
    ScoreID int AUTO_INCREMENT PRIMARY KEY,
    ReservationID int NOT NULL UNIQUE ,
    DidEscape bool NOT NULL,
    TimeToSolveSeconds int NOT NULL,
    CluesUsed int NOT NULL DEFAULT 0,

    FOREIGN KEY (ReservationID) REFERENCES Reservations(ReservationID)
);

CREATE TABLE CancelledReservationsLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    ReservationID INT,
    CancelledAt DATETIME DEFAULT NOW()
);
