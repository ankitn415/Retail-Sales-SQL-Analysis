-- 1. Basic select
SELECT * FROM Sales;

-- 2. Filtered select
SELECT * FROM Sales
WHERE "Gender" = 'Female' AND "Age" BETWEEN 25 AND 35;

-- 3. Ordering data
SELECT * FROM Sales
ORDER BY "Total Amount" DESC;

-- 4. Group by with aggregates
SELECT "Product Category", COUNT(*) AS "Total Transactions", SUM("Total Amount") AS "Revenue"
FROM Sales
GROUP BY "Product Category"
ORDER BY "Revenue" DESC;

-- 5. Join with a customer demographic table
CREATE TABLE "Customer Info" (
    "Customer ID" VARCHAR(20),
    "Membership Level" VARCHAR(20)
);

INSERT INTO "Customer Info" ("Customer ID", "Membership Level")
SELECT DISTINCT "Customer ID", 
       CASE WHEN MOD(ABS(hashtext("Customer ID")), 2) = 0 THEN 'Gold' ELSE 'Silver' END
FROM Sales;
SELECT s."Customer ID", s."Product Category", c."Membership Level", SUM(s."Total Amount") AS "Total Spent"
FROM Sales s
JOIN "Customer Info" c ON s."Customer ID" = c."Customer ID"
GROUP BY s."Customer ID", s."Product Category", c."Membership Level";

-- 6. Subquery to get top spenders
SELECT * FROM Sales
WHERE "Customer ID" IN (
    SELECT "Customer ID"
    FROM Sales
    GROUP BY "Customer ID"
    HAVING SUM("Total Amount") > 2000
);

-- 7. View for high-value transactions
CREATE VIEW "High Value Transactions" AS
SELECT * FROM Sales
WHERE "Total Amount" > 1000;

-- 8. Optimizing queries using indexes
CREATE INDEX "Idx_Customer_ID" ON Sales ("Customer ID");
CREATE INDEX "Idx_Product_Category" ON Sales ("Product Category");
CREATE INDEX "Idx_Total_Amount" ON Sales ("Total Amount");
