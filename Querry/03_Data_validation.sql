-- Purpose: Read-only checks before cleaning.

USE vendor;

-- 0. Row counts
SELECT 'begin_inventory' AS table_name, COUNT(*) AS row_count FROM begin_inventory
UNION ALL SELECT 'end_inventory', COUNT(*) FROM end_inventory
UNION ALL SELECT 'purchase_prices', COUNT(*) FROM purchase_prices
UNION ALL SELECT 'purchases', COUNT(*) FROM purchases
UNION ALL SELECT 'sales', COUNT(*) FROM sales
UNION ALL SELECT 'vendor_invoice', COUNT(*) FROM vendor_invoice;


-- 1. Exact duplicate rows
SELECT InventoryId, Store, City, Brand, Description, Size, onHand, Price, startDate,
       COUNT(*) AS duplicate_count
FROM begin_inventory
GROUP BY InventoryId, Store, City, Brand, Description, Size, onHand, Price, startDate
HAVING COUNT(*) > 1;

SELECT InventoryId, Store, City, Brand, Description, Size, onHand, Price, endDate,
       COUNT(*) AS duplicate_count
FROM end_inventory
GROUP BY InventoryId, Store, City, Brand, Description, Size, onHand, Price, endDate
HAVING COUNT(*) > 1;

SELECT Brand, Description, Price, Size, Volume, Classification, PurchasePrice,
       VendorNumber, VendorName, COUNT(*) AS duplicate_count
FROM purchase_prices
GROUP BY Brand, Description, Price, Size, Volume, Classification, PurchasePrice,
         VendorNumber, VendorName
HAVING COUNT(*) > 1;

SELECT InventoryId, Store, Brand, Description, Size, VendorNumber, VendorName,
       PONumber, PODate, ReceivingDate, InvoiceDate, PayDate, PurchasePrice,
       Quantity, Dollars, Classification, COUNT(*) AS duplicate_count
FROM purchases
GROUP BY InventoryId, Store, Brand, Description, Size, VendorNumber, VendorName,
         PONumber, PODate, ReceivingDate, InvoiceDate, PayDate, PurchasePrice,
         Quantity, Dollars, Classification
HAVING COUNT(*) > 1;

SELECT InventoryId, Store, Brand, Description, Size, SalesQuantity, SalesDollars,
       SalesPrice, SalesDate, Volume, Classification, ExciseTax, VendorNo,
       VendorName, COUNT(*) AS duplicate_count
FROM sales
GROUP BY InventoryId, Store, Brand, Description, Size, SalesQuantity, SalesDollars,
         SalesPrice, SalesDate, Volume, Classification, ExciseTax, VendorNo,
         VendorName
HAVING COUNT(*) > 1;

SELECT VendorNumber, VendorName, InvoiceDate, PONumber, PODate, PayDate,
       Quantity, Dollars, Freight, Approval, COUNT(*) AS duplicate_count
FROM vendor_invoice
GROUP BY VendorNumber, VendorName, InvoiceDate, PONumber, PODate, PayDate,
         Quantity, Dollars, Freight, Approval
HAVING COUNT(*) > 1;


-- 2. Missing values
SELECT
    SUM(InventoryId IS NULL) AS null_inventory_id,
    SUM(Store IS NULL) AS null_store,
    SUM(City IS NULL) AS null_city,
    SUM(Brand IS NULL) AS null_brand,
    SUM(Description IS NULL) AS null_description,
    SUM(Size IS NULL) AS null_size,
    SUM(onHand IS NULL) AS null_onhand,
    SUM(Price IS NULL) AS null_price,
    SUM(startDate IS NULL) AS null_start_date
FROM begin_inventory;

SELECT
    SUM(InventoryId IS NULL) AS null_inventory_id,
    SUM(Store IS NULL) AS null_store,
    SUM(City IS NULL) AS null_city,
    SUM(Brand IS NULL) AS null_brand,
    SUM(Description IS NULL) AS null_description,
    SUM(Size IS NULL) AS null_size,
    SUM(onHand IS NULL) AS null_onhand,
    SUM(Price IS NULL) AS null_price,
    SUM(endDate IS NULL) AS null_end_date
FROM end_inventory;

SELECT
    SUM(Brand IS NULL) AS null_brand,
    SUM(Description IS NULL) AS null_description,
    SUM(Price IS NULL) AS null_price,
    SUM(Size IS NULL) AS null_size,
    SUM(Volume IS NULL) AS null_volume,
    SUM(Classification IS NULL) AS null_classification,
    SUM(PurchasePrice IS NULL) AS null_purchase_price,
    SUM(VendorNumber IS NULL) AS null_vendor_number,
    SUM(VendorName IS NULL) AS null_vendor_name
FROM purchase_prices;

SELECT
    SUM(InventoryId IS NULL) AS null_inventory_id,
    SUM(Store IS NULL) AS null_store,
    SUM(Brand IS NULL) AS null_brand,
    SUM(Description IS NULL) AS null_description,
    SUM(Size IS NULL) AS null_size,
    SUM(VendorNumber IS NULL) AS null_vendor_number,
    SUM(VendorName IS NULL) AS null_vendor_name,
    SUM(PONumber IS NULL) AS null_po_number,
    SUM(PODate IS NULL) AS null_po_date,
    SUM(ReceivingDate IS NULL) AS null_receiving_date,
    SUM(InvoiceDate IS NULL) AS null_invoice_date,
    SUM(PayDate IS NULL) AS null_pay_date,
    SUM(PurchasePrice IS NULL) AS null_purchase_price,
    SUM(Quantity IS NULL) AS null_quantity,
    SUM(Dollars IS NULL) AS null_dollars
FROM purchases;

SELECT
    SUM(InventoryId IS NULL) AS null_inventory_id,
    SUM(Store IS NULL) AS null_store,
    SUM(Brand IS NULL) AS null_brand,
    SUM(Description IS NULL) AS null_description,
    SUM(Size IS NULL) AS null_size,
    SUM(SalesQuantity IS NULL) AS null_sales_quantity,
    SUM(SalesDollars IS NULL) AS null_sales_dollars,
    SUM(SalesPrice IS NULL) AS null_sales_price,
    SUM(SalesDate IS NULL) AS null_sales_date,
    SUM(Volume IS NULL) AS null_volume,
    SUM(Classification IS NULL) AS null_classification,
    SUM(ExciseTax IS NULL) AS null_excise_tax,
    SUM(VendorNo IS NULL) AS null_vendor_no,
    SUM(VendorName IS NULL) AS null_vendor_name
FROM sales;

SELECT
    SUM(VendorNumber IS NULL) AS null_vendor_number,
    SUM(VendorName IS NULL) AS null_vendor_name,
    SUM(InvoiceDate IS NULL) AS null_invoice_date,
    SUM(PONumber IS NULL) AS null_po_number,
    SUM(PODate IS NULL) AS null_po_date,
    SUM(PayDate IS NULL) AS null_pay_date,
    SUM(Quantity IS NULL) AS null_quantity,
    SUM(Dollars IS NULL) AS null_dollars,
    SUM(Freight IS NULL) AS null_freight,
    SUM(Approval IS NULL) AS null_approval
FROM vendor_invoice;


-- 3. Duplicate business keys / repeated records
SELECT InventoryId, COUNT(*) AS row_count
FROM begin_inventory
GROUP BY InventoryId
HAVING COUNT(*) > 1
ORDER BY row_count DESC;

SELECT InventoryId, COUNT(*) AS row_count
FROM end_inventory
GROUP BY InventoryId
HAVING COUNT(*) > 1
ORDER BY row_count DESC;

-- PONumber can legitimately repeat because a PO may contain several items.
SELECT PONumber, COUNT(*) AS row_count
FROM purchases
GROUP BY PONumber
HAVING COUNT(*) > 1
ORDER BY row_count DESC
LIMIT 50;

-- Sales can legitimately repeat for the same InventoryId across dates/items.
SELECT InventoryId, SalesDate, COUNT(*) AS row_count
FROM sales
GROUP BY InventoryId, SalesDate
HAVING COUNT(*) > 1
ORDER BY row_count DESC
LIMIT 50;


-- 4. Date validation
SELECT MIN(startDate) AS min_date, MAX(startDate) AS max_date
FROM begin_inventory;

SELECT MIN(endDate) AS min_date, MAX(endDate) AS max_date
FROM end_inventory;

SELECT MIN(SalesDate) AS min_date, MAX(SalesDate) AS max_date
FROM sales;

-- Chronology: suspicious purchase dates
SELECT *
FROM purchases
WHERE ReceivingDate < PODate
   OR InvoiceDate < ReceivingDate
   OR PayDate < InvoiceDate
LIMIT 100;

SELECT *
FROM vendor_invoice
WHERE InvoiceDate < PODate
   OR PayDate < InvoiceDate
LIMIT 100;


-- 5. Data type / domain checks
SELECT MIN(onHand) AS min_onhand, MAX(onHand) AS max_onhand,
       MIN(Price) AS min_price, MAX(Price) AS max_price
FROM begin_inventory;

SELECT MIN(SalesQuantity) AS min_qty, MAX(SalesQuantity) AS max_qty,
       MIN(SalesDollars) AS min_sales, MAX(SalesDollars) AS max_sales,
       MIN(SalesPrice) AS min_price, MAX(SalesPrice) AS max_price
FROM sales;

SELECT MIN(Quantity) AS min_qty, MAX(Quantity) AS max_qty,
       MIN(PurchasePrice) AS min_purchase_price,
       MAX(PurchasePrice) AS max_purchase_price,
       MIN(Dollars) AS min_dollars, MAX(Dollars) AS max_dollars
FROM purchases;


-- 6. Invalid / suspicious values
SELECT *
FROM begin_inventory
WHERE onHand < 0 OR Price < 0
LIMIT 100;

SELECT *
FROM end_inventory
WHERE onHand < 0 OR Price < 0
LIMIT 100;

SELECT *
FROM sales
WHERE SalesQuantity <= 0
   OR SalesDollars < 0
   OR SalesPrice < 0
   OR ExciseTax < 0
LIMIT 100;

SELECT *
FROM purchases
WHERE Quantity <= 0
   OR PurchasePrice < 0
   OR Dollars < 0
LIMIT 100;

SELECT *
FROM vendor_invoice
WHERE Quantity <= 0
   OR Dollars < 0
   OR Freight < 0
LIMIT 100;


-- 7. Vendor consistency
-- One VendorNumber should normally map to one vendor name.
SELECT VendorNumber,
       COUNT(DISTINCT TRIM(VendorName)) AS vendor_name_count
FROM purchase_prices
GROUP BY VendorNumber
HAVING COUNT(DISTINCT TRIM(VendorName)) > 1
ORDER BY vendor_name_count DESC;

SELECT VendorNumber,
       COUNT(DISTINCT TRIM(VendorName)) AS vendor_name_count
FROM purchases
GROUP BY VendorNumber
HAVING COUNT(DISTINCT TRIM(VendorName)) > 1
ORDER BY vendor_name_count DESC;

SELECT VendorNumber,
       COUNT(DISTINCT TRIM(VendorName)) AS vendor_name_count
FROM vendor_invoice
GROUP BY VendorNumber
HAVING COUNT(DISTINCT TRIM(VendorName)) > 1
ORDER BY vendor_name_count DESC;

-- Detect leading/trailing spaces in vendor names
SELECT DISTINCT VendorName, TRIM(VendorName) AS cleaned_vendor_name
FROM purchases
WHERE VendorName <> TRIM(VendorName)
LIMIT 100;


-- 8. Brand / product consistency
SELECT Brand,
       COUNT(DISTINCT TRIM(Description)) AS description_count
FROM purchase_prices
GROUP BY Brand
HAVING COUNT(DISTINCT TRIM(Description)) > 1
ORDER BY description_count DESC
LIMIT 100;

-- Sales brands missing from purchase_prices
SELECT DISTINCT s.Brand
FROM sales s
LEFT JOIN purchase_prices p
    ON s.Brand = p.Brand
WHERE p.Brand IS NULL
ORDER BY s.Brand;

-- Purchase-price brands missing from sales
SELECT DISTINCT p.Brand
FROM purchase_prices p
LEFT JOIN sales s
    ON p.Brand = s.Brand
WHERE s.Brand IS NULL
ORDER BY p.Brand;


-- 9. Join relationship checks
-- Sales InventoryId missing from begin inventory
SELECT COUNT(*) AS unmatched_sales_inventory
FROM sales s
LEFT JOIN begin_inventory b
    ON s.InventoryId = b.InventoryId
WHERE b.InventoryId IS NULL;

-- Sales InventoryId missing from end inventory
SELECT COUNT(*) AS unmatched_sales_end_inventory
FROM sales s
LEFT JOIN end_inventory e
    ON s.InventoryId = e.InventoryId
WHERE e.InventoryId IS NULL;

-- Purchases PONumber missing from vendor invoice
SELECT COUNT(*) AS unmatched_purchase_orders
FROM purchases p
LEFT JOIN vendor_invoice v
    ON p.PONumber = v.PONumber
WHERE v.PONumber IS NULL;

-- Purchase vendor missing from purchase_prices
SELECT COUNT(*) AS unmatched_purchase_vendors
FROM purchases p
LEFT JOIN purchase_prices pp
    ON p.VendorNumber = pp.VendorNumber
WHERE pp.VendorNumber IS NULL;


-- 10. Row counts after transformations
-- Re-run after creating cleaned tables/views.
SELECT 'sales' AS table_name, COUNT(*) AS row_count FROM sales
UNION ALL SELECT 'purchases', COUNT(*) FROM purchases
UNION ALL SELECT 'begin_inventory', COUNT(*) FROM begin_inventory
UNION ALL SELECT 'end_inventory', COUNT(*) FROM end_inventory
UNION ALL SELECT 'purchase_prices', COUNT(*) FROM purchase_prices
UNION ALL SELECT 'vendor_invoice', COUNT(*) FROM vendor_invoice;


-- 11. Useful data profile
SELECT COUNT(DISTINCT Store) AS distinct_stores,
       COUNT(DISTINCT Brand) AS distinct_brands,
       COUNT(DISTINCT VendorNo) AS distinct_vendors
FROM sales;

SELECT MIN(SalesDate) AS first_sales_date,
       MAX(SalesDate) AS last_sales_date,
       COUNT(DISTINCT SalesDate) AS distinct_sales_dates
FROM sales;

SELECT YEAR(SalesDate) AS sales_year,
       COUNT(*) AS rows,
       SUM(SalesQuantity) AS total_quantity,
       SUM(SalesDollars) AS total_sales
FROM sales
GROUP BY YEAR(SalesDate)
ORDER BY sales_year;


-- IMPORTANT:
-- Do not delete records just because a check returns rows.
-- First determine whether the issue is:
--   1) exact duplicate
--   2) legitimate repeated business event
--   3) missing relationship
--   4) legitimate NULL
--   5) real data-quality problem
-- Then create the cleaning step.
