# Vendor Performance & Inventory Analytics

An end-to-end data analysis project using **MySQL, Python, Pandas, Statistical Analysis, and Power BI** to evaluate vendor performance, purchasing, sales, profitability, inventory efficiency, and unsold capital.

## Project Overview

The objective is to understand how vendors and products contribute to business performance and identify areas where purchasing, pricing, inventory, and vendor strategy can be improved.

## Dashboard Preview
<img width="1199" height="677" alt="Screenshot 2026-09-01 221648" src="https://github.com/user-attachments/assets/4b922cd3-8ed3-4433-b0ab-99a41f786b21" />


## Business Questions

1. Which vendors contribute the most to sales and gross profit?
2. Which brands have low sales but high profit margins and may need pricing or promotional attention?
3. How concentrated is purchasing spend among vendors?
4. Does bulk purchasing reduce unit purchase cost?
5. Which vendors have low inventory turnover?
6. How much capital is tied up in unsold inventory?
7. Do high-performing and low-performing vendors have different profit-margin behavior?

## Dataset

The project uses six source tables:

- `sales`
- `purchases`
- `begin_inventory`
- `end_inventory`
- `purchase_prices`
- `vendor_invoice`

The source data contains more than **12.8M sales records** and **2.37M purchase records**.

## Tech Stack

- **MySQL** — data storage, SQL analysis, joins, aggregations
- **Python** — data profiling, EDA, and statistical analysis
- **Pandas / NumPy** — data manipulation
- **SciPy / Statistics** — hypothesis testing and confidence intervals
- **Power BI** — interactive reporting
- **DAX** — business measures and analytical calculations

## Project Workflow

```text
CSV Files
   ↓
MySQL Database
   ↓
Data Validation
   ↓
SQL Aggregation & Analysis
   ↓
Python / Pandas EDA
   ↓
Statistical Analysis
   ↓
Power BI + DAX
   ↓
Business Insights
   ↓
Recommendations
```

## Data Validation

Initial validation found:

- No exact duplicate rows in the six datasets checked with Pandas.
- No negative values in the selected numeric validation fields.
- No invalid dates were detected during date parsing.
- `SalesDollars` was consistent with `SalesQuantity × SalesPrice`.
- `Dollars` in the purchases data was consistent with `Quantity × PurchasePrice`.
- Missing values were identified and investigated rather than blindly replaced or deleted.
- Vendor-name consistency and table relationships were treated as separate validation steps.

## SQL Analysis

MySQL was used for database-side analysis and to create the summarized analytical dataset:

```text
vendor_sales_summary
```

Key analytical fields include:

- Total Purchase Quantity
- Total Purchase Dollars
- Total Sales Quantity
- Total Sales Dollars
- Freight Cost
- Gross Profit
- Profit Margin
- Stock Turnover
- Sales-to-Purchase Ratio

## Python EDA

Python was used for:

- Data profiling
- Missing-value checks
- Duplicate checks
- Numeric validation
- Date validation
- Business-rule validation
- Correlation analysis
- Vendor and product analysis
- Statistical testing

## Key Findings

### Low-Sales, High-Margin Brands

The analysis identified **198 brands** with relatively low sales and relatively high profit margins.

### Vendor Purchase Concentration

The **top 10 vendors contribute 65.69% of total purchases**, indicating significant purchase concentration.

### Bulk Purchasing

The analysis reported a **72% lower unit cost** for the compared large-order group, with an observed unit cost of about **$10.78 per unit**.

### Unsold Inventory

The report identified approximately **$2.71M of unsold inventory capital**.

### Vendor Profitability Differences

Reported 95% confidence intervals:

- Top vendors: **30.74%–31.61%**, mean **31.17%**
- Low vendors: **40.48%–42.62%**, mean **41.55%**

The analysis indicates that lower-sales vendors can have higher margins while generating less sales volume.

## Correlation Findings

- Purchase Price vs Total Sales Dollars: **-0.012**
- Purchase Price vs Gross Profit: **-0.016**
- Total Purchase Quantity vs Total Sales Quantity: **0.999**
- Profit Margin vs Total Sales Price: **-0.179**
- Stock Turnover vs Gross Profit: **-0.038**
- Stock Turnover vs Profit Margin: **-0.055**

These are analytical relationships, not proof of causation.

## Statistical Analysis

### Hypothesis

**H₀:** There is no significant difference in profit margins between top- and low-performing vendor groups.

**H₁:** A significant difference exists in profit margins between the two groups.

The analysis rejected the null hypothesis, indicating a statistically significant difference between the two vendor groups.

## Power BI Dashboard

The dashboard focuses on:

- Total Sales
- Total Purchase
- Gross Profit
- Gross Margin %
- Unsold Capital
- Vendor performance
- Product performance
- Purchase contribution
- Stock turnover
- Target brands

Example DAX:

```DAX
Gross Margin % =
DIVIDE(
    SUM('vendor vendor_sales_summary'[GrossProfit]),
    SUM('vendor vendor_sales_summary'[TotalSalesDollars])
)
```

```DAX
UnsoldCapital =
(
    'vendor vendor_sales_summary'[TotalPurchaseQuantity]
    -
    'vendor vendor_sales_summary'[TotalSalesQuantity]
)
*
'vendor vendor_sales_summary'[PurchasePrice]
```

## Business Recommendations

- Re-evaluate pricing and promotional strategies for low-sales, high-margin brands.
- Diversify vendor partnerships to reduce supplier dependency.
- Use bulk-purchasing benefits while monitoring inventory movement.
- Reduce slow-moving inventory through better purchasing quantities and clearance strategies.
- Improve marketing and distribution for low-performing vendors with strong margins.
- Review vendor profitability and purchasing concentration regularly.

## Repository Structure

```text
Vendor-Performance-And-Inventory-Analytics/
│
├── data/
├── sql/
├── notebooks/
├── powerbi/
├── report/
└── README.md
```

## Key Takeaway

> **Which vendors and products are driving sales and profit, where is inventory capital getting stuck, and where should purchasing and vendor strategy be improved?**
