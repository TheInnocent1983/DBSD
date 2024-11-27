
---

### 1. Business Overview

>A local music store engages in selling musical instruments, accessories, and providing music lessons. It also allows customers to rent instruments for specific durations. Managing these operations manually has become cumbersome, so the store aims to implement a database system. This database must handle inventory, sales, rentals, customer information, lesson schedules, and supplier relationships. It should ensure data consistency, scalability, and ease of querying for reporting and decision-making.

#### Entities and Attributes

#### 1. **Customer**

- **Attributes**:
    - `CustomerID` (Primary Key): A unique identifier for each customer.
    - `Name`: The full name of the customer.
    - `Address` (Composite Attribute): Contains separate components for the customer's address:
        - `Street`: The street name and number.
        - `City`: The city name.
        - `State`: The state or region.
        - `ZipCode`: The postal code.
        - `Country`: The country name.
    - `Email`: Contact email address.
    - `Phone` (Multivalued Attribute): Customers may have multiple phone numbers.
- **Relationships**:
    - One-to-Many with `Rental` (CustomerID in `Rental` references `CustomerID` in `Customer`).
    - One-to-Many with `Sale` (CustomerID in `Sale` references `CustomerID` in `Customer`).
    - One-to-Many with `Lesson` (CustomerID in `Lesson` references `CustomerID` in `Customer`).

#### 2. **Instrument**

- **Attributes**:
    - `InstrumentID` (Primary Key): A unique identifier for each instrument.
    - `Name`: The name of the instrument (e.g., Guitar, Piano).
    - `Type`: Category of the instrument (e.g., String, Percussion).
    - `Brand`: Manufacturer's brand.
    - `Price`: The price of the instrument.
- **Relationships**:
    - One-to-Many with `Rental` (InstrumentID in `Rental` references `InstrumentID` in `Instrument`).
    - One-to-Many with `Sale` (InstrumentID in `Sale` references `InstrumentID` in `Instrument`).
    - One-to-Many with `Maintenance` (InstrumentID in `Maintenance` references `InstrumentID` in `Instrument`).
    - One-to-Many with `Accessory` (InstrumentID in `Accessory` references `InstrumentID` in `Instrument`).
    - Many-to-Many with `Supplier` through `SupplierInstrument` (InstrumentID in `SupplierInstrument` references `InstrumentID` in `Instrument`).

#### 3. **Rental**

- **Attributes**:
    - `RentalID` (Primary Key): A unique identifier for each rental record.
    - `StartDate`: Date when the rental begins.
    - `EndDate`: Date when the rental ends.
    - `Fee`: Rental fee.
- **Relationships**:
    - `CustomerID` (Foreign Key): Links to the `Customer` entity.
    - `InstrumentID` (Foreign Key): Links to the `Instrument` entity.

#### 4. **Sale**

- **Attributes**:
    - `SalesID` (Primary Key): A unique identifier for each sale.
    - `SaleDate`: Date of the sale.
    - `TotalAmount`: Total sale amount.
- **Relationships**:
    - `CustomerID` (Foreign Key): Links to the `Customer` entity.
    - `InstrumentID` (Foreign Key): Links to the `Instrument` entity.

#### 5. **Lesson**

- **Attributes**:
    - `LessonID` (Primary Key): A unique identifier for each lesson.
    - `Schedule`: The timing of the lesson.
- **Relationships**:
    - `InstructorID` (Foreign Key): Links to the `Instructor` entity.
    - `InstrumentID` (Foreign Key): Links to the `Instrument` entity.

#### 6. **Instructor**

- **Attributes**:
    - `InstructorID` (Primary Key): A unique identifier for each instructor.
    - `Name`: The full name of the instructor.
    - `ContactInfo`: Phone and/or email.
    - `Specialization` (Composite Attribute): Consists of `InstrumentType` and `ExpertiseLevel`.
- **Relationships**:
    - One-to-Many with `Lesson` (InstructorID in `Lesson` references `InstructorID` in `Instructor`).

#### 7. **Supplier**

- **Attributes**:
    - `SupplierID` (Primary Key): A unique identifier for each supplier.
    - `Name`: Supplier name.
    - `ContactInfo`: Supplier contact details.
- **Relationships**:
    - Many-to-Many with `Instrument` through `SupplierInstrument` (SupplierID in `SupplierInstrument` references `SupplierID` in `Supplier`).

#### 8. **Maintenance**

- **Attributes**:
    - `MaintenanceID` (Primary Key): A unique identifier for each maintenance record.
    - `MaintenanceDate`: Date of maintenance.
    - `Cost`: Cost of maintenance.
    - `TechnicianDetails`: Information about the technician performing the maintenance.
- **Relationships**:
    - `InstrumentID` (Foreign Key): Links to the `Instrument` entity.

#### 9. **Accessory**

- **Attributes**:
    - `AccessoryID` (Primary Key): A unique identifier for each accessory.
    - `Name`: The name of the accessory.
    - `Price`: The price of the accessory.
- **Relationships**:
    - `InstrumentID` (Foreign Key): Links to the `Instrument` entity.

#### 10. **SupplierInstrument**

- **Attributes**:
    - `SupplierID` (Primary Key): Links to the `Supplier` entity.
    - `InstrumentID` (Primary Key): Links to the `Instrument` entity.
    - `SupplyDate`: Date when the instrument was supplied.
- **Relationships**:
    - `SupplierID` (Foreign Key): Links to the `Supplier` entity.
    - `InstrumentID` (Foreign Key): Links to the `Instrument` entity.

---

### 2. Enhanced ER Diagram (ER)

![[Pasted image 20241127093319.png]]

The **Enhanced ER Diagram** will include:

- **Entities**: As defined above.
    
- **Superclass/Subclass**:
    
    - `Instrument` is a superclass with subclasses `RentedInstrument` and `SoldInstrument`.
    - `Rental` and `Sale` are not considered subclasses, as they track transactions (actions) involving instruments.
- **Attributes**:
    
    - **Multivalued Attribute**: `Customer.Phone`
    - **Composite Attribute**: `Customer.Address`

> **Note**: Multiplicity
> 
> - **1:1 (One-to-One)**: Each record in Entity A is linked to only one record in Entity B, and vice versa.
> - **1:M (One-to-Many)**: One record in Entity A can be linked to many records in Entity B, but each record in Entity B is linked to only one record in Entity A.
> - **M:M (Many-to-Many)**: Many records in Entity A can be linked to many records in Entity B.

### Multiplicity in Relationships:

Multiplicity defines how many instances of one entity (e.g., `Customer`, `Instrument`) can be linked to instances of another entity (e.g., `Rental`, `Sale`).

- **`Customer - Rental`**: A customer can rent multiple instruments, but each rental record is associated with only one customer. _This is a 1:M relationship_.
- **`Customer - Sale`**: A customer can purchase multiple instruments, but each sale record is associated with only one customer. _This is a 1:M relationship_.
- **`Customer - Lesson`**: A customer can take multiple lessons, but each lesson is associated with one customer. _This is a 1:M relationship_.
- **`ExpertiseLevel - InstructorExpertise`**: An expertise level can be associated with multiple instructors who share the same level of proficiency. Each record in `InstructorExpertise` points to one expertise level. _This is a 1:M relationship_.
- **`Instructor - InstructorExpertise`**: An instructor can have multiple areas of expertise, meaning they can be associated with various instrument types and expertise levels. Each record in the `InstructorExpertise` table points to one instructor. _This is a 1:M relationship_.
- **`Instructor - Lesson`**: An instructor can teach many lessons, but each lesson is taught by only one instructor. _This is a 1:M relationship_.
- **`Instrument - Maintenance`**: An instrument can undergo many maintenance activities, but each maintenance record refers to one specific instrument. _This is a 1:M relationship_.
- **`Instrument - RentedInstrument`**: An instrument can be rented multiple times, but each rental is associated with one instrument. _This is a 1:M relationship_.
- **`Instrument - SoldInstrument`**: An instrument can be sold many times, but each sale is associated with one instrument. _This is a 1:M relationship_.
- **`InstrumentType - InstructorExpertise`**: An instrument type can be associated with multiple instructors, each having varying expertise levels. Each record in `InstructorExpertise` links to one instrument type. _This is a 1:M relationship_.

### Participation:

- **Partial Participation**:
    - The `Instrument` does not necessarily have to be sold or rented. It can exist without being part of either `SoldInstrument` or `RentedInstrument`.

### Disjointness:

- **Overlapping**:
    - An instrument can be both sold and rented simultaneously (overlap allowed).


---

### 3. Mapping EER Diagram to Relational Model

**Relational Schema**

1. **Customer**
   
```scss
CUSTOMER(CustomerID, Name, Address, Email)
CUSTOMER_PHONE(CustomerID [FK], Phone) -- Multivalued attribute
```

2. **Instrument**

```scss
INSTRUMENT(InstrumentID, Name, Type, Brand, Price)
```

3. **Subclass Mapping** (using **Class Table**)

```scss
RENTED_INSTRUMENT(InstrumentID [FK], AvailabilityStatus)
SOLD_INSTRUMENT(InstrumentID [FK], WarrantyDetails)
```

4. **Rental**

```scss
RENTAL(RentalID, InstrumentID [FK], CustomerID [FK], StartDate, EndDate, Fee)
```

5. **Sale**

```scss
SALE(SaleID, CustomerID [FK], SaleDate, TotalAmount)
```

6. **Lesson**

```scss
LESSON(LessonID, InstrumentType [FK], Schedule, InstructorID [FK])
```

7. **Instructor**

```scss
INSTRUCTOR(InstructorID, Name, ContactInfo)
SPECIALIZATION(InstructorID [FK], InstrumentType, ExpertiseLevel) -- Composite Attribute
```

8. **Supplier**

```scss
SUPPLIER(SupplierID, Name, ContactInfo)
```

9. **Accessory**

```scss
ACCESSORY(AccessoryID, InstrumentID [FK], Name, Price)
```

10. **Supplier Instrument**

```scss
SUPPLIER_INSTRUMENT(SupplierID [FK], InstrumentID [FK])
```

11. **Maintenance**

```scss
MAINTENANCE(MaintenanceID, InstrumentID [FK], MaintenanceDate, Cost, TechnicianDetails)
```

---

### 4. Validation and Normalization

**Functional Dependencies (FDs)**
- Example FD:
  `InstrumentID -> Type, Brand, Price`

**Assumptions for Violations**
If no violations exist, assume:
- `Instructor.Name -> Specialization`
  This creates a transitive dependency.

**Normalization Steps**
1. Identify FDs violation 3NF.
2. Decompose relations:
   - Split `INSTRUCTOR` into 
     `INSTRUCTOR(InstructorID, Name, ContactInfo)`
     and
     `SPECIALIZATION(InstructorID [FK], Specialization)`.
 3. Verify new schema is in 3NF.