# Normalization Justification

While a single flat table might seem simpler for a small dataset, it is not over-engineering; it is a necessity for data integrity. Using our orders_flat.csv as evidence, I strongly refute the position that a single table is sufficient for a growing business.

## 1. Data Integrity and Consistency
In the flat file, Rohan Mehta (C001) appears in multiple rows. If his email changes, we must update every single row. If we miss even one row, we create a "source of truth" conflict. In our normalized schema, we update the email once in the Customers table, and it reflects everywhere instantly.

## 2. Storage Efficiency and Redundancy
The full address (e.g., "Mumbai HQ, Nariman Point...") for every single order handled by Deepak Joshi (S001). This wastes significant storage space. By normalizing to 3NF, we store this long string only once in the SalesReps table, using a small (sales_rep_id) to link it to orders.

## 3. Logical Data Management
Without normalization, we suffer from Delete Anomalies. For instance, if we delete the only order for product P008, we lose the product's price and category entirely. Normalization ensures that our master data (products, customers, staff) exists independently of transaction data (orders).

## 4. Insert Anomaly
- **Description:** A new Sales Representative cannot be added without an order ID.
- **Example:** We cannot record "S005 (Arjun Singh)" until he makes his first sale.
- **Citation:** CSV columns: sales_rep_id and order_id.

## 5. Update Anomaly
- **Description:** Redundant data requires multiple updates, which can lead to inconsistency.
- **Example:** Customer **"Rohan Mehta (C001)"** is in rows 2, 10, and 14. Changing his city in one row but not others creates conflicting data.
- **Citation:** customer_id (C001), column: customer_city — Rows: 2, 10, 14.

## 6. Delete Anomaly
- **Description:** Deleting an order causes loss of product information.
- **Example:** Product **P008** only exists in Row 12. Deleting this order removes the product's price and details from the system.
- **Citation:** Row 12, order_id ORD1085, product_id P008.

## Conclusion
In conclusion, normalization transforms a fragile spreadsheet into a robust relational database that can scale without the risk of data corruption or loss.