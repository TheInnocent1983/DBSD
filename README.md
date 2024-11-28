## **Sample Data Insertion**

**1. Inserting into Customer Table**

```sql
INSERT INTO Customer (FirstName, LastName, Email, PhoneNumber, Address)
VALUES 
('John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main Street'),
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '456 Elm Street');
```

**2. Inserting into Supplier Table**

```sql
INSERT INTO Supplier (Name, ContactPerson, PhoneNumber, Email)
VALUES 
('Instrument Supplies Co.', 'Alice Johnson', '555-123-4567', 'contact@instrumentco.com'),
('Music World', 'Bob Brown', '555-987-6543', 'sales@musicworld.com');
```

**3. Inserting into Instructor Table**

```sql
INSERT INTO Instructor (FirstName, LastName, Email, PhoneNumber)
VALUES 
('Michael', 'Thompson', 'michael.thompson@example.com', '555-111-2222'),
('Emily', 'Davis', 'emily.davis@example.com', '555-333-4444');
```

**4. Inserting into Instrument Table**

```sql
INSERT INTO Instrument (InstrumentName, Category, Manufacturer, Condition, SupplierID)
VALUES 
('Guitar', 'String', 'GuitarWorks', 'New', 1),
('Piano', 'Percussion', 'PianoTech', 'Used', 2);
```

**5. Inserting into Rental Table**

```sql
INSERT INTO Rental (CustomerID, InstrumentID, RentalDate)
VALUES 
(1, 1, '2024-11-28'),
(2, 2, '2024-11-27');
```

**6. Inserting into Lesson Table**

```sql
INSERT INTO Lesson (CustomerID, InstructorID, LessonDate, Topic)
VALUES 
(1, 1, '2024-11-29', 'Guitar Basics'),
(2, 2, '2024-11-30', 'Piano Fundamentals');
```

**7. Inserting into Sale Table**

```sql
INSERT INTO Sale (CustomerID, InstrumentID, SaleDate, Price)
VALUES 
(1, 1, '2024-11-28', 500.00),
(2, 2, '2024-11-27', 1000.00);
```

**8. Inserting into Maintenance Table**

```sql
INSERT INTO Maintenance (InstrumentID, Date, MaintenanceDetails, Cost)
VALUES 
(1, '2024-11-20', 'String replacement', 50.00),
(2, '2024-11-22', 'Key tuning', 75.00);
```

**9. Inserting into InstructorExpertise Table**

```sql
INSERT INTO InstructorExpertise (InstructorID, InstrumentTypeID, ExpertiseLevelID)
VALUES 
(1, 1, 1), -- Assuming InstrumentTypeID 1 and ExpertiseLevelID 1 correspond to specific values
(2, 2, 2); -- Same as above for different IDs
```

**10. Inserting into PhoneNumber Table**

```sql
INSERT INTO PhoneNumber (CustomerID, PhoneNumber)
VALUES 
(1, '123-456-7890'),
(2, '987-654-3210');
```

**11. Inserting into Address Table**

```sql
INSERT INTO Address (CustomerID, Street, City, State, ZIPCode)
VALUES 
(1, '123 Main Street', 'Springfield', 'IL', '62701'),
(2, '456 Elm Street', 'Shelbyville', 'IN', '46176');
```

**Why Insert Data?**

    Testing Constraints: Ensures that foreign key constraints are working properly (e.g., you can’t insert a Rental with an InstrumentID that doesn't exist).
    Validation: Helps confirm that your tables and relationships are properly structured and that queries involving joins work as expected.
    Data Integrity: You can verify that data in linked tables remains consistent when updates or deletions are performed.

By inserting sample data, you can test queries such as joining Customer and Rental to see which customers have rented instruments, checking Sale and Instrument for sales data, and much more.
