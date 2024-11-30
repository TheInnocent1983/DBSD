## 4. Validation and Normalization

#### **Objective**

This part validates the relational database schema to ensure it adheres to the Third Normal Form (3NF). Where necessary, functional dependencies (FDs) violating 3NF are introduced, analyzed, and resolved through normalization. The schema is updated and demonstrated using SQL scripts and example data.

### **1. Functional Dependencies and Violations**

#### **Initial Analysis**

The original schema satisfies 3NF. However, to demonstrate normalization, an assumption was added:

**Assumption:**

- An instrument's category determines its manufacturer:  
    `Category → Manufacturer`

#### **Impact of the New FD**

This assumption introduces a **transitive dependency** in the `Instrument` table:

- Primary key: `InstrumentID`
- Dependencies:
    - `InstrumentID → Category`
    - `Category → Manufacturer`

**Violation:**  
This creates a transitive dependency:  
`InstrumentID → Category → Manufacturer`

- **Reason for Violation:**
    - `Manufacturer` is dependent on `Category`, which is not part of the primary key (`InstrumentID`).
    - This violates 3NF, where all non-prime attributes must be directly dependent on the table's primary key.

### **2. Normalization Process**

#### **Decomposition to 3NF**

To resolve the violation, the `Instrument` table was decomposed into two tables:

1. **CategoryManufacturer Table**
    
    - Captures the functional dependency `Category → Manufacturer`.
    - Eliminates redundancy in the `Instrument` table.

**Schema:**
```sql
CREATE TABLE CategoryManufacturer (
    Category VARCHAR(50) PRIMARY KEY,
    Manufacturer VARCHAR(100) NOT NULL
);
```

2. **Modified Instrument Table**
    
    - Retains attributes directly dependent on the primary key (`InstrumentID`).

**Schema:**
```sql
CREATE TABLE Instrument (
    InstrumentID INT PRIMARY KEY,
    InstrumentName VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    SupplierID INT NOT NULL,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (Category) REFERENCES CategoryManufacturer(Category)
);
```

#### **Steps to Normalize**

1. Identified the transitive dependency: `InstrumentID → Category → Manufacturer`.
2. Moved the dependency `Category → Manufacturer` to a new table (`CategoryManufacturer`).
3. Updated `Instrument` to reference `CategoryManufacturer` via the `Category` attribute.

### **3. Final Schema**

#### **CategoryManufacturer Table**

Stores the FD `Category → Manufacturer`.

```sql
CREATE TABLE CategoryManufacturer (
    Category VARCHAR(50) PRIMARY KEY,
    Manufacturer VARCHAR(100) NOT NULL
);
```
#### **Instrument Table**

References `CategoryManufacturer` for the `Category` attribute.

```sql
CREATE TABLE Instrument (
    InstrumentID INT PRIMARY KEY,
    InstrumentName VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    SupplierID INT NOT NULL,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (Category) REFERENCES CategoryManufacturer(Category)
);
```

### **4. Data Population**

#### **Populating CategoryManufacturer**

```sql
INSERT INTO CategoryManufacturer (Category, Manufacturer)
VALUES
    ('String', 'Fender'),
    ('Percussion', 'Yamaha'),
    ('Keyboard', 'Steinway'),
    ('Wind', 'Yamaha');
```

#### **Populating Instrument**

```sql
INSERT INTO Instrument (InstrumentID, InstrumentName, Category, SupplierID)
VALUES
    (1, 'Guitar', 'String', 2),       -- SupplierID 2 corresponds to Fender
    (2, 'Drum Set', 'Percussion', 1),-- SupplierID 1 corresponds to Yamaha
    (3, 'Piano', 'Keyboard', 3),     -- SupplierID 3 corresponds to Steinway
    (4, 'Flute', 'Wind', 1);         -- SupplierID 1 corresponds to Yamaha
```

### **5. Verification**

#### **Join Query: Retrieve Instrument Details with Manufacturer**

```sql
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
```

**Result:**

|**InstrumentID**|**InstrumentName**|**Category**|**Manufacturer**|**SupplierID**|
|---|---|---|---|---|
|1|Guitar|String|Fender|2|
|2|Drum Set|Percussion|Yamaha|1|
|3|Piano|Keyboard|Steinway|3|
|4|Flute|Wind|Yamaha|1|

### **6. Explanation of Changes**

#### **Why These Changes Were Made**

- To eliminate the transitive dependency `InstrumentID → Category → Manufacturer`.
- To ensure all tables are in 3NF, with non-key attributes directly dependent on the primary key.

#### **How the Schema Satisfies 3NF**

1. **Instrument Table:**
    - All attributes (`InstrumentName`, `Category`, `SupplierID`) depend solely on the primary key (`InstrumentID`).
2. **CategoryManufacturer Table:**
    - The `Manufacturer` attribute depends solely on the primary key (`Category`).

#### **Benefits of the Normalized Schema**

- Eliminates redundancy by storing `Manufacturer` information in one place.
- Avoids anomalies during updates, deletions, or insertions.
- Maintains data integrity across related tables.

### **7. Conclusion**

The relational schema has been successfully validated and normalized to 3NF. The process included introducing a functional dependency that violates 3NF, analyzing its impact, and decomposing the schema to eliminate violations. The final schema is now free of redundancy and anomalies, adhering to database design best practices.
