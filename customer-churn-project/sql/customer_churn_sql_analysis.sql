-- ===============================
-- PROJECT: CUSTOMER CHURN ANALYSIS
-- TOOL: MySQL Workbench 8.0
-- ===============================
CREATE DATABASE churn_db;
USE churn_db;


CREATE TABLE telco_churn(
customerID VARCHAR(30),
gender VARCHAR(10),
SeniorCitizen INT,
Partner VARCHAR(5),
Dependents VARCHAR(5),
tenure INT,
PhoneService VARCHAR(5),
MultipleLines VARCHAR(20),
InternetService VARCHAR(20),
OnlineSecurity VARCHAR(20),
OnlineBackup VARCHAR(20),
DeviceProtection VARCHAR(20),
TechSupport VARCHAR(20),
StreamingTV VARCHAR(20),
StreamingMovies VARCHAR(20),
Contract VARCHAR(20),
PaperlessBilling VARCHAR(5),
PaymentMethod VARCHAR(30),
MonthlyCharges FLOAT,
TotalCharges FLOAT,
Churn VARCHAR(5)
);


-- Use Database
USE churn_db;

-- Check Data
SELECT COUNT(*) AS total_rows FROM telco_churn;
SELECT * FROM telco_churn LIMIT 10;

-- ===============================
-- CUSTOMER CHURN KPI METRICS
-- ===============================

-- Total Customers & Churn Rate
SELECT 
 COUNT(*) AS total_customers,
 SUM(Churn = 'Yes') AS churned_customers,
 ROUND(SUM(Churn='Yes')*100/COUNT(*),2) AS churn_rate_percent
FROM telco_churn;

-- ===============================
-- CHURN BY CONTRACT
-- ===============================
SELECT Contract,
COUNT(*) AS total,
SUM(Churn='Yes') AS churned,
ROUND(SUM(Churn='Yes')*100/COUNT(*),2) AS churn_percentage
FROM telco_churn
GROUP BY Contract;

-- ===============================
-- CHURN BY TENURE GROUP
-- ===============================
SELECT 
 CASE
  WHEN tenure <= 6 THEN '0-6 Months'
  WHEN tenure BETWEEN 7 AND 24 THEN '7-24 Months'
  ELSE '24+ Months'
 END AS tenure_group,
 COUNT(*) AS total,
 SUM(Churn='Yes') AS churned
FROM telco_churn
GROUP BY tenure_group;


-- ===============================
-- REVENUE LOSS
-- ===============================
SELECT 
 ROUND(SUM(MonthlyCharges),2) AS monthly_revenue_lost
FROM telco_churn
WHERE Churn='Yes';




