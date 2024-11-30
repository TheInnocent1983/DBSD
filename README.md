### 3. Mapping EER Diagram to Relational Model

#### 1. Superclass Attributes

**Superclass `Instrument`**

**Shared Attributes:**
- **InstrumentID (PK)**: A unique identifier for each instrument.
- **InstrumentName**: The name of the instrument (e.g., Piano, Guitar, etc.).
- **Category**: The category of the instrument (e.g., string).
- **Manufacturer**: The company that manufactured the instrument.
- **Condition**: The condition of the instrument (default - new).
  *Note: Enforced at application layer*.
- **SupplierID (FK)**: A unique identifier of the supplier.

**Justification**:
These attributes are **shared** across all instruments, regardless of whether they are sold or rented. Storing these attributes in a separate table ensures:
- **Data Normalization**: Avoids duplication of common fields across subclasses.
- **Consistency**: Any changes to common data (e.g., `Condition` or `Manufacturer`) are updated in one place.

#### 2. Subclass-Specific Attributes

**Subclass 1: `SoldInstrument`
- **SoldInstrumentID (PK)**: A unique identifier for each sold instrument.
- **InstrumentID (FK)**: A unique identifier for each instrument.
- **SaleID (FK)**: A unique identifier for each instrument on sale.
- **WarrantyPeriod**: The warranty period of the instrument.

**Subclass 2:** `RentedInstrument`
- **RentedInstrumentID (PK)**:
- **InstrumentID (FK)**: A unique identifier for each instrument.
- **RentalID (FK)**: A unique identifier for each instrument on rent.
- **RentalDuration**: The date when the instrument is rented and should be returned.

**Justification**:
These attributes are unique to the specific business processes of selling and renting instruments. Splitting them into subclasses ensures that:
- Each table only contains relevant attributes, avoiding **NULL values** for unused fields (e.g., `WarrantyPeriod` in a rented instrument).

#### 3. Why `Table per Subclass` Strategy was chosen?

Two alternative strategies, `Table per Hierarchy` and `Table per Concrete Class`, were considered but deemed unsuitable.

The `Table per Hierarchy` approach involves storing all attributes in a single table with a discriminator column to differentiate subclasses. While this simplifies the schema, it leads to many NULL values for attributes not relevant to specific subclasses (e.g., `WarrantyPeriod` for rented instruments) and lacks support for enforcing subclass-specific constraints.

The `Table per Concrete Class` strategy, where each subclass is represented by its own table without a superclass table, results in significant data duplication for shared attributes like `InstrumentName` and `Manufacturer`. This violates normalization principles, increases storage requirements, and complicates updates and queries.

In contrast, the `Table per Subclass` strategy avoids these issues by normalizing shared attributes in the `Instrument` table while maintaining separate tables for `SoldInstrument` and `RentedInstrument`. This approach enforces constraints, avoids redundancy, and keeps the schema scalable and easy to maintain.

**1. Reduces Redundancy and avoids sparse tables:**
- if all attributes were stored in a single table (e.g., `Instrument`), many rows would have **NULL values** for attributes that do not apply (e.g., a sold instrument would have NULL values for `RentalDuration`).
- Splitting into separate subclass tables eliminated the redundancy.

**2. Enforces Constraints Unique to Each Subclass:**
- Constraints, such as ensuring that `WarrantyPeriod` is **NOT NULL** for sold instruments, can be applied at the table level.
- This improves data integrity and reduces reliance on application-level validation.

**3. Aligns with MS SQL Server's Relational Schema:**
- MS SQL Server's relational schema design supports primary and foreign key relationships, making it easy to implement the `Table per Subclass` strategy.

#### 4. Implementation in Relational Schema**

**Tables and Relationships**:

1. `Instrument` **Table (Superclass)**
   - Stores shared attributes
   - Acts as a **parent table** for subclasses.
   - **Primary Key**: `InstrumentID`.
2. `SoldInstrument` **Table (Subclass)
   - References `Instrument` via `InstrumentID` as a **foreign key**.
   - Contains attributes specific to sold instruments.
   - **Primary Key**: `SoldInstrumentID`.
3. `RentedInstrument` **Table (Subclass)**
   - References `Instrument` via `InstrumentID` as a **foreign key**.
   - Contains attributes specific to rented instruments.
   - **Primary Key**: `RentedInstrumentID`.


![[Pasted image 20241127093319.png]]

*Note: It is attached as a separate file named ______________*.

1. `Instument` **Table**

```sql
CREATE TABLE Instrument (
    InstrumentID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each instrument
    InstrumentName VARCHAR(100) NOT NULL, -- Name of the instrument
    Category VARCHAR(50), -- Category of the instrument (e.g., string, percussion)
    Manufacturer VARCHAR(100), -- Manufacturer of the instrument
    Condition VARCHAR(50) DEFAULT 'New', -- Condition of the instrument (default set to 'New')
    SupplierID INT NOT NULL, -- Foreign Key to Supplier table
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);
```

2. `SoldInstrument` **Table**

```sql
CREATE TABLE SoldInstrument (
    SoldInstrumentID INT PRIMARY KEY IDENTITY(1,1), -- Unique ID for sold instruments
    InstrumentID INT NOT NULL, -- Foreign Key to Instrument table
    SaleID INT NOT NULL, -- Foreign Key to Sale table
    WarrantyPeriod INT, -- Warranty period for the sold instrument in months
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID),
    FOREIGN KEY (SaleID) REFERENCES Sale(SaleID)
);
```

3. `RentedInstrument` **Table**

```sql
CREATE TABLE RentedInstrument (
    RentedInstrumentID INT PRIMARY KEY IDENTITY(1,1), -- Unique ID for rented instruments
    InstrumentID INT NOT NULL, -- Foreign Key to Instrument table
    RentalID INT NOT NULL, -- Foreign Key to Rental table
    RentalDuration INT, -- Duration of the rental in days
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID),
    FOREIGN KEY (RentalID) REFERENCES Rental(RentalID)
);
```
