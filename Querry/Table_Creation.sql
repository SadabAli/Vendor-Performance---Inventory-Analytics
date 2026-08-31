USE vendor;

DROP TABLE IF EXISTS begin_inventory;
CREATE TABLE begin_inventory (
    InventoryId VARCHAR(100),
    Store INT,
    City VARCHAR(100),
    Brand INT,
    Description VARCHAR(255),
    Size VARCHAR(50),
    onHand INT,
    Price DECIMAL(10,2),
    startDate DATE
);

DROP TABLE IF EXISTS end_inventory;
CREATE TABLE end_inventory (
    InventoryId VARCHAR(100),
    Store INT,
    City VARCHAR(100),
    Brand INT,
    Description VARCHAR(255),
    Size VARCHAR(50),
    onHand INT,
    Price DECIMAL(10,2),
    endDate DATE
);

DROP TABLE IF EXISTS purchase_prices;
CREATE TABLE purchase_prices (
    Brand INT,
    Description VARCHAR(255),
    Price DECIMAL(10,2),
    Size VARCHAR(50),
    Volume VARCHAR(50),
    Classification INT,
    PurchasePrice DECIMAL(10,2),
    VendorNumber INT,
    VendorName VARCHAR(255)
);

DROP TABLE IF EXISTS purchases;
CREATE TABLE purchases (
    InventoryId VARCHAR(100),
    Store INT,
    Brand INT,
    Description VARCHAR(255),
    Size VARCHAR(50),
    VendorNumber INT,
    VendorName VARCHAR(255),
    PONumber INT,
    PODate DATE,
    ReceivingDate DATE,
    InvoiceDate DATE,
    PayDate DATE,
    PurchasePrice DECIMAL(10,2),
    Quantity INT,
    Dollars DECIMAL(12,2),
    Classification INT
);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    InventoryId VARCHAR(100),
    Store INT,
    Brand INT,
    Description VARCHAR(255),
    Size VARCHAR(50),
    SalesQuantity INT,
    SalesDollars DECIMAL(12,2),
    SalesPrice DECIMAL(10,2),
    SalesDate DATE,
    Volume DECIMAL(10,2),
    Classification INT,
    ExciseTax DECIMAL(12,2),
    VendorNo INT,
    VendorName VARCHAR(255)
);

DROP TABLE IF EXISTS vendor_invoice;
CREATE TABLE vendor_invoice (
    VendorNumber INT,
    VendorName VARCHAR(255),
    InvoiceDate DATE,
    PONumber INT,
    PODate DATE,
    PayDate DATE,
    Quantity INT,
    Dollars DECIMAL(12,2),
    Freight DECIMAL(12,2),
    Approval VARCHAR(100)
);