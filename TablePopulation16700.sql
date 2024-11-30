-- Populating Supplier Table --
INSERT INTO Supplier (Name, ContactPerson, PhoneNumber, Email)
VALUES
    ('Yamaha', 'William Doe', '2345678901', 'yamaha.info@example.com'),
    ('Fender', 'Jane Smith', '3456789012', 'fender@example.com'),
    ('Steinway', 'Alice Brown', '4567890123', 'steinway@example.com'),
    ('Stradivarius', 'Bob Green', '5678901234', 'stradivarius@example.com');

-- Populating CategoryManufacturer Table --
INSERT INTO CategoryManufacturer (Category, Manufacturer)
VALUES
    ('String', 'Fender'),
    ('Percussion', 'Yamaha'),
    ('Keyboard', 'Steinway'),
    ('Wind', 'Yamaha');

-- Populating Instrument Table --
INSERT INTO Instrument (InstrumentID, InstrumentName, Category, SupplierID)
VALUES
    (1, 'Guitar', 'String', 2),       -- SupplierID 2 corresponds to Fender
    (2, 'Drum Set', 'Percussion', 1),-- SupplierID 1 corresponds to Yamaha
    (3, 'Piano', 'Keyboard', 3),     -- SupplierID 3 corresponds to Steinway
    (4, 'Flute', 'Wind', 1);         -- SupplierID 1 corresponds to Yamaha

-- Populating Customer Table --
INSERT INTO Customer (FirstName, LastName, Email, PhoneNumber, Address)
VALUES 
    ('William', 'Doe', 'william.doe@example.com', '1234567890', '123 Elm St, NY'),
    ('Jane', 'Smith', 'jane.smith@example.com', '2345678901', '456 Maple St, NY');


-- Populating Rental Table --
INSERT INTO Rental (CustomerID, InstrumentID, RentalDate, ReturnDate)
VALUES
    (1, 1, GETDATE(), NULL), -- William rented a Guitar
    (2, 3, GETDATE(), NULL); -- Jane rented a Piano

SELECT * FROM Supplier;

SELECT 
    i.InstrumentID,
    i.InstrumentName,
    i.Category,
    cm.Manufacturer,
    i.SupplierID
FROM 
    Instrument i
JOIN 
    CategoryManufacturer cm ON i.Category = cm.Category;
