use vendor;


/*
LOAD DATA LOCAL INFILE will currently fail due to  "local_infile = OFF"
*/
SHOW VARIABLES LIKE 'local_infile'; -- check whether local_infile = OFF/ON

-- We need to Enable it
SET GLOBAL local_infile = 1;


-- Loading the CSV data to the SQL
LOAD DATA LOCAL INFILE
'C:/Users/DELL/Desktop/Vendor Performance & Inventory Analytics/data/vendor_invoice.csv'
INTO TABLE vendor_invoice
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SELECT COUNT(*) AS row_count
FROM vendor_invoice;



LOAD DATA LOCAL INFILE
'C:/Users/DELL/Desktop/Vendor Performance & Inventory Analytics/data/begin_inventory.csv'
INTO TABLE begin_inventory
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE
'C:/Users/DELL/Desktop/Vendor Performance & Inventory Analytics/data/end_inventory.csv'
INTO TABLE end_inventory
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE
'C:/Users/DELL/Desktop/Vendor Performance & Inventory Analytics/data/purchase_prices.csv'
INTO TABLE purchase_prices
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE
'C:/Users/DELL/Desktop/Vendor Performance & Inventory Analytics/data/purchases.csv'
INTO TABLE purchases
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE
'C:/Users/DELL/Desktop/Vendor Performance & Inventory Analytics/data/sales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;




-- Then verify all six 

SELECT 'begin_inventory' AS table_name, COUNT(*) AS row_count FROM begin_inventory
UNION ALL
SELECT 'end_inventory', COUNT(*) FROM end_inventory
UNION ALL
SELECT 'purchase_prices', COUNT(*) FROM purchase_prices
UNION ALL
SELECT 'purchases', COUNT(*) FROM purchases
UNION ALL
SELECT 'sales', COUNT(*) FROM sales
UNION ALL
SELECT 'vendor_invoice', COUNT(*) FROM vendor_invoice;

