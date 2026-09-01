USE vendor;


/*
I perform data validation by using Python


*/

-- 1. Sales InventoryId not found in Begin Inventory
SELECT COUNT(*) AS unmatched_sales_begin
FROM sales s
LEFT JOIN begin_inventory b
    ON s.InventoryId = b.InventoryId
WHERE b.InventoryId IS NULL;


-- 2. Sales InventoryId not found in End Inventory
SELECT COUNT(*) AS unmatched_sales_end
FROM sales s
LEFT JOIN end_inventory e
    ON s.InventoryId = e.InventoryId
WHERE e.InventoryId IS NULL;


-- 3. Purchase VendorNumber not found in Purchase Prices
SELECT COUNT(*) AS unmatched_purchase_vendor
FROM purchases p
LEFT JOIN purchase_prices pp
    ON p.VendorNumber = pp.VendorNumber
WHERE pp.VendorNumber IS NULL;


-- 4. Purchase PONumber not found in Vendor Invoice
SELECT COUNT(*) AS unmatched_po_invoice
FROM purchases p
LEFT JOIN vendor_invoice v
    ON p.PONumber = v.PONumber
WHERE v.PONumber IS NULL;