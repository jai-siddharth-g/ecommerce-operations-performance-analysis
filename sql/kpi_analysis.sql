

-- Project: E-Commerce Operations Performance Analysis.
-- Tool: BigQuery.
-- Description: SQL queries used to calculate On-Time Delivery %, delay trends, warehouse performance, and logistics KPIs.
----------------------------------------------------------------------------------------------------------------------------

#OTD % Overall

SELECT 
    COUNT(*) AS total_orders,
    COUNTIF(On_Time_Flag = TRUE) AS on_time_orders,
    ROUND(COUNTIF(On_Time_Flag = TRUE) * 100.0 / COUNT(*), 2) AS OTD_Percentage
FROM `sage-now-488303-f1.Ecommerce.ORDERS`;

----------------------------------------------------------------------------------------------------------------------------

#OTD Trend Over Time

SELECT 
    Order_Date,
    COUNT(*) AS total_orders,
    COUNTIF(On_Time_Flag = TRUE) AS on_time_orders,
    ROUND(
        COUNTIF(On_Time_Flag = TRUE) * 100.0 / COUNT(*),2) AS OTD_Percentage
FROM `sage-now-488303-f1.Ecommerce.ORDERS`
GROUP BY Order_Date
ORDER BY Order_Date;

----------------------------------------------------------------------------------------------------------------------------

#Delays by Warehouse

SELECT 
    Warehouse_ID,
    COUNT(*) AS total_orders,
    COUNTIF(On_Time_Flag = FALSE) AS delayed_orders,
    ROUND(
        COUNTIF(On_Time_Flag = FALSE) * 100.0 / COUNT(*),
        2
    ) AS delay_percentage
FROM `sage-now-488303-f1.Ecommerce.ORDERS`
GROUP BY Warehouse_ID
ORDER BY delay_percentage DESC;

----------------------------------------------------------------------------------------------------------------------------

#Delay Reasons Distribution

SELECT 
    Delay_Reason,
    COUNT(*) AS delay_count
FROM `sage-now-488303-f1.Ecommerce.ORDERS`
WHERE On_Time_Flag = FALSE
GROUP BY Delay_Reason
ORDER BY delay_count DESC;

----------------------------------------------------------------------------------------------------------------------------

#Priority vs Delay

SELECT 
    Priority,
    COUNT(*) AS total_orders,
    COUNTIF(On_Time_Flag = FALSE) AS delayed_orders,
    ROUND(
        COUNTIF(On_Time_Flag = FALSE) * 100.0 / COUNT(*),
        2
    ) AS delay_percentage
FROM `sage-now-488303-f1.Ecommerce.ORDERS`
GROUP BY Priority
ORDER BY delay_percentage DESC;

----------------------------------------------------------------------------------------------------------------------------

#Fleet Utilization by Region

SELECT 
    Region,
    ROUND(
        AVG((Available_Hours - Idle_Hours) / Available_Hours) * 100,
        2
    ) AS fleet_utilization_percentage
FROM `sage-now-488303-f1.Ecommerce.Fleet`
GROUP BY Region
ORDER BY fleet_utilization_percentage DESC;

----------------------------------------------------------------------------------------------------------------------------

#Peak Hour Vehicle Availability

SELECT 
    Peak_Hour_Flag,
    COUNT(*) AS vehicle_count
FROM `sage-now-488303-f1.Ecommerce.Fleet`
GROUP BY Peak_Hour_Flag;

----------------------------------------------------------------------------------------------------------------------------









