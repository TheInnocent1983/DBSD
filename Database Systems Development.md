
---

### 1. Business Overview

>[! ]
>A local music store engages in selling musical instruments, accessories, and providing music lessons. It also allows customers to rent instruments for specific durations. Managing these operations manually has become cumbersome, so the store aims to implement a database system. This database must handle inventory, sales, rentals, customer information, lesson schedules, and supplier relationships. It should ensure data consistency, scalability, and ease of querying for reporting and decision-making.

#### Entities and Attributes

**1. Customer**
- Customers can purchase items, rent instruments, or attend lessons.
- Attributes:
  - ```CustomerID``` (Primary Key): A unique identifier for each customer.
  - ```Name```: The full name of the customer.
  - ```Address```: Physical address.
  - `Email`: Contact email address.
  - `Phone` (Multivalued Attribute): Customers may have multiple phone numbers.

**2. Instrument**
- Represents the musical instruments available in the store, categorized by type and brand.
- Attributes:
  - `InstrumentID` (Primary Key): A unique identifier for each instrument.
  - `Name`: The name of the instrument (e.g. Guitar, Piano).
  - `Type`: Category of the instrument (e.g. String, Percussion).
  - `Brand`: Manufacturer's brand.
  - `Price`: The price of the instrument.

**3. Rental**
- Tracks the details of instruments rented by customers.
- Attributes:
  - `RentalID` (Primary Key): A unique identifier for each rental record.
  - `StartDate`: Date when the rental begins.
  - `EndDate`: Date when the rental ends.
  - `Fee`: Rental fee.
  - Relationships:
    - `CustomerID` (Foreign Key): Links to the `Customer` entity.
    - `InstrumentID` (Foreign Key): Links to the `Instrument` entity.

**4. Sale**
- Records the sales transactions.
- Attributes:
  - `SalesID` (Primary Key): A unique identifier for each sale.
  - `SaleDate`: Date of the sale.
  - `TotalAmount`: Total sale amount.
  - Relationship:
    - `CustomerID` (Foreign Key): Links to the `Customer` entity.

**5. Lesson**
- Represents music lessons offered by the store.
- Attributes:
  - `LessonID` (Primary Key): A unique identifier for each lesson.
  - `Schedule`: The timing of the lesson.
  - Relationships:
    - `InstructorID` (Foreign Key): Links to the `Instructor` entity.
    - `InstrumentType` (Foreign Key): Links to the type of instrument associated with the lesson.

**6. Instructor**
- Represents instructors teaching music lessons.
- Attributes:
  - `InstructorID` (Primary Key): A unique identifier for each instructor.
  - `Name`: The full name of the instructor.
  - `ContactInfo`: Phone and/or email.
  - `Specialization` (Composite Attribute): Consists of `InstrumentType` and `ExpertiseLevel`.

**7. Supplier**
- Represents suppliers providing instruments and accessories.
- Attributes:
  - `SupplierID` (Primary Key): A unique identifier for each supplier.
  - `Name`: Supplier name.
  - `ContactInfo`: Supplier contact details.

**8. Maintenance**
- Tracks the maintenance of rented instruments.
- Attributes:
  - `MaintenanceID` (Primary Key): A unique identifier for each maintenance record.
  - `MaintenanceDate`: Date of maintenance.
  - `Cost`: Cost of maintenance.
  - `TechnicianDetails`: Information about the technician performing the maintenance.

**9. Accessory**
- Represents accessories linked to specific instruments.
- Attributes:
  - `AccessoryID` (Primary Key): A unique identifier for each accessory.
  - `Name`: The name of the accessory.
  - `Price`: The price of the accessory.
  - Relationships:
    - `InstrumentID` (Foreign Key): Links to the `Instrument` entity.

**10. Supplier Instrument**
- Resolves the many-to-many relationship between suppliers and instruments.

---

### 2. Enhanced ER Diagram (ER)

The **Enhanced ER Diagram** will include:
- **Entities**: As defined above.
- **Superclass/Subclass**: `Instrument` is a superclass with subclasses `RentedInstrument` and `SoldInstrument`.
- **Multivalued Attribute**: `Customer.Phone`.
- **Composite Attribute**: `Instructor.Specialization`.
- **Relationships**:
  - Include names and multiplicity (e.g. "One customer rents many instruments.")
  - Participation and disjoints constraints for the subclasses.

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