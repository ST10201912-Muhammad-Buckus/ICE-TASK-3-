--DATABASE CREATION SECTION
use master
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'MuhammadST10201912')
DROP DATABASE MuhammadST10201912
CREATE DATABASE MuhammadST10201912
use MuhammadST10201912

-- Create Venue Table
CREATE TABLE Venue (
    VenueId INT IDENTITY(1,1) PRIMARY KEY,
    VenueName VARCHAR(255) 
    Location VARCHAR(255) 
    Capacity INT 
    ImageUrl VARCHAR(500)
);
GO

-- Create Event Table
CREATE TABLE Event (
    EventId INT IDENTITY(1,1) PRIMARY KEY,
    EventName VARCHAR(255) 
    EventDate DATETIME 
    Description TEXT,
    VenueId INT 
    ImageUrl VARCHAR(500),
    FOREIGN KEY (VenueId) REFERENCES Venue(VenueId) ON DELETE CASCADE
);
GO

-- Create Booking Table (without multiple cascade paths)
CREATE TABLE Booking (
    BookingId INT IDENTITY(1,1) PRIMARY KEY,
    EventId INT 
    VenueId INT 
    EventDate DATE
    FOREIGN KEY (EventId) REFERENCES Event(EventId) ON DELETE CASCADE,
    FOREIGN KEY (VenueId) REFERENCES Venue(VenueId) ON DELETE NO ACTION,
    CONSTRAINT UQ_Booking UNIQUE (EventId, VenueId, EventDate)
);
GO

-- Insert Sample Venues
INSERT INTO Venue (VenueName, Location, Capacity, ImageUrl) VALUES
('Grand Hall', '123 Main St, New York', 500, 'https://example.com/venue1.jpg'),
('Conference Center', '456 Elm St, Boston', 300, 'https://example.com/venue2.jpg'),
('Open Air Park', '789 Sunset Blvd, Los Angeles', 1000, 'https://example.com/venue3.jpg');
GO

-- Insert Sample Events
INSERT INTO Event(EventName, EventDate, Description, VenueId, ImageUrl) VALUES
('Tech Summit 2025', '2025-06-15', 'Annual technology conference with top speakers.', 1, 'https://example.com/event1.jpg'),
('Music Festival', '2025-08-10', 'Outdoor music festival with live bands.', 3, 'https://example.com/event2.jpg'),
('Business Expo', '2025-09-05', 'Networking event for business professionals.', 2, 'https://example.com/event3.jpg');
GO

-- Insert Sample Bookings
INSERT INTO Booking (EventId, VenueId, EventDate) VALUES
(1, 1, '2025-06-01'),
(2, 3, '2025-07-20'),
(3, 2, '2025-08-25');
GO

-- View Data
SELECT * FROM Venue
SELECT * FROM Event
SELECT * FROM Booking

SELECT Event.[EventName], VENUE.[VenueName], Booking.[EventDate]
FROM Booking
JOIN Event ON Booking.EventId = Event.EventId
JOIN Venue ON Booking.VenueId = Venue.VenueId

 GO

CREATE VIEW BoookingView AS
SELECT Event.[EventName], VENUE.[VenueName], Booking.[EventDate]
FROM Booking
JOIN Event ON Booking.EventId = Event.EventId
JOIN Venue ON Booking.VenueId = Venue.VenueId
;

GO

SELECT * FROM BoookingView

INSERT INTO Venue
VALUES('Grand Hall', '123 Main St, New York', 500, 'https://example.com/venue1.jpg')

SELECT * FROM Venue