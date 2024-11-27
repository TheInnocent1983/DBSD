-- Table for storing customer details.
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each customer
    FirstName VARCHAR(100) NOT NULL, -- First name of the customer
    LastName VARCHAR(100) NOT NULL, -- Last name of the customer
    Email VARCHAR(255) UNIQUE NOT NULL, -- Email address of the customer
    PhoneNumber VARCHAR(15), -- Main phone number of the customer
    Address VARCHAR(255) -- Main address of the customer
);

-- Table for storing supplier details.
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each supplier
    Name VARCHAR(100) NOT NULL, -- Name of the supplier
    ContactPerson VARCHAR(100), -- Name of the contact person at the supplier
    PhoneNumber VARCHAR(15), -- Contact phone number of the supplier
    Email VARCHAR(255) UNIQUE -- Email address of the supplier
);

-- Table for storing instrument details.
CREATE TABLE Instrument (
    InstrumentID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each instrument
    InstrumentName VARCHAR(100) NOT NULL, -- Name of the instrument
    Category VARCHAR(50), -- Category of the instrument (e.g., string, percussion)
    Manufacturer VARCHAR(100), -- Manufacturer of the instrument
    Condition VARCHAR(50) DEFAULT 'New', -- Condition of the instrument (default set to 'New')
    SupplierID INT NOT NULL, -- Foreign Key to Supplier table
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- Table for storing rental transactions. Represents a many-to-many relationship between customers and instruments.
CREATE TABLE Rental (
    RentalID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each rental
    CustomerID INT NOT NULL, -- Foreign Key to Customer table
    InstrumentID INT NOT NULL, -- Foreign Key to Instrument table
    RentalDate DATETIME DEFAULT GETDATE(), -- Date when the rental started
    ReturnDate DATETIME NULL, -- Date when the rental ended
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID)
);

-- Table for storing lesson details. Represents a relationship between a customer and an instructor.
CREATE TABLE Lesson (
    LessonID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each lesson
    CustomerID INT NOT NULL, -- Foreign Key to Customer table
    InstructorID INT NOT NULL, -- Foreign Key to Instructor table
    LessonDate DATETIME NOT NULL, -- Date of the lesson
    Topic VARCHAR(100) NOT NULL, -- Topic or subject of the lesson
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

-- Table for storing instructor details.
CREATE TABLE Instructor (
    InstructorID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each instructor
    FirstName VARCHAR(100) NOT NULL, -- First name of the instructor
    LastName VARCHAR(100) NOT NULL, -- Last name of the instructor
    Email VARCHAR(255) UNIQUE NOT NULL, -- Email address of the instructor
    PhoneNumber VARCHAR(15) -- Phone number of the instructor
);

-- Table for storing instrument types.
CREATE TABLE InstrumentType (
    InstrumentTypeID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for instrument type
    InstrumentName VARCHAR(100) UNIQUE NOT NULL -- Name of the instrument (e.g., Guitar, Piano)
);

-- Table for storing expertise levels.
CREATE TABLE ExpertiseLevel (
    ExpertiseLevelID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for expertise level
    LevelName VARCHAR(50) UNIQUE NOT NULL -- Name of the expertise level (e.g., Beginner, Intermediate, Advanced)
);

-- Linking table for composite attribute: associating instructors with instrument types and expertise levels.
CREATE TABLE InstructorExpertise (
    InstructorExpertiseID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each record
    InstructorID INT NOT NULL, -- Foreign Key to Instructor table
    InstrumentTypeID INT NOT NULL, -- Foreign Key to InstrumentType table
    ExpertiseLevelID INT NOT NULL, -- Foreign Key to ExpertiseLevel table
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID) ON DELETE CASCADE,
    FOREIGN KEY (InstrumentTypeID) REFERENCES InstrumentType(InstrumentTypeID) ON DELETE CASCADE,
    FOREIGN KEY (ExpertiseLevelID) REFERENCES ExpertiseLevel(ExpertiseLevelID) ON DELETE CASCADE
);

-- Table for storing sale transactions. Represents a many-to-many relationship between customers and instruments.
CREATE TABLE Sale (
    SaleID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each sale
    CustomerID INT NOT NULL, -- Foreign Key to Customer table
    InstrumentID INT NOT NULL, -- Foreign Key to Instrument table
    SaleDate DATETIME DEFAULT GETDATE(), -- Date of the sale
    Price DECIMAL(10, 2) NOT NULL, -- Price of the instrument at the time of sale
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID)
);

-- Table for storing maintenance records. Represents a one-to-many relationship between instruments and maintenance events.
CREATE TABLE Maintenance (
    MaintenanceID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each maintenance record
    InstrumentID INT NOT NULL, -- Foreign Key to Instrument table
    Date DATETIME NOT NULL, -- Date of the maintenance
    MaintenanceDetails VARCHAR(255), -- Description of the maintenance performed
    Cost DECIMAL(10, 2) NOT NULL, -- Cost of the maintenance service
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID)
);

-- Handling multivalued attributes (e.g., multiple phone numbers for customers).
CREATE TABLE PhoneNumber (
    PhoneID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each phone record
    CustomerID INT NOT NULL, -- Foreign Key to Customer table
    PhoneNumber VARCHAR(15) NOT NULL, -- Phone number associated with the customer
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Composite Attribute --
-- This table represents the address as a composite attribute of a customer, broken down into components (Street, City, State, ZIPCode).
CREATE TABLE Address (
    AddressID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each address record
    CustomerID INT, -- Foreign Key to Customer table (indicates the customer associated with the address)
    Street VARCHAR(255), -- Street component of the address
    City VARCHAR(100), -- City component of the address
    State VARCHAR(50), -- State component of the address
    ZIPCode VARCHAR(10), -- ZIP code component of the address
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Table for storing sold instruments. Indicates a one-to-one relationship with both the Instrument and Sale tables.
CREATE TABLE SoldInstrument (
    SoldInstrumentID INT PRIMARY KEY IDENTITY(1,1), -- Unique ID for sold instruments
    InstrumentID INT NOT NULL, -- Foreign Key to Instrument table
    SaleID INT NOT NULL, -- Foreign Key to Sale table
    WarrantyPeriod INT, -- Warranty period for the sold instrument in months
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID),
    FOREIGN KEY (SaleID) REFERENCES Sale(SaleID)
);

-- Table for storing rented instruments. Indicates a one-to-one relationship with both the Instrument and Rental tables.
CREATE TABLE RentedInstrument (
    RentedInstrumentID INT PRIMARY KEY IDENTITY(1,1), -- Unique ID for rented instruments
    InstrumentID INT NOT NULL, -- Foreign Key to Instrument table
    RentalID INT NOT NULL, -- Foreign Key to Rental table
    RentalDuration INT, -- Duration of the rental in days
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID),
    FOREIGN KEY (RentalID) REFERENCES Rental(RentalID)
);