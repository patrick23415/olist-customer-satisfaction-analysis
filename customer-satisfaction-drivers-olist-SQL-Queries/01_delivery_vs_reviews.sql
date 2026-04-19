-- Analysis 1: Delivery Performance vs Customer Reviews
-- Business Question: Are late deliveries associated with lower review scores?
-- Description: Classifies orders by delivery status (On Time, Late, Unknown) and compares average review scores across each group.

-- Goal: Analyze whether late deliveries are associated with lower customer review scores

USE olist_project;

-- First Query-joined orders with reviews amd checked
-- for review score vs delivery status
SELECT 
    o.order_id,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    r.review_score,
    
    CASE 
        WHEN o.order_delivered_customer_date IS NULL 
            THEN 'Unknown'
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
            THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status

FROM dbo.olist_orders_dataset o
INNER JOIN dbo.olist_order_reviews_dataset r
    ON o.order_id = r.order_id;

-- Query 2: Aggregate results by delivery status to evaluate how
-- delivery performance relates to customer satisfaction
SELECT 
    CASE 
        WHEN o.order_delivered_customer_date IS NULL 
            THEN 'Unknown'
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
            THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,
    
    COUNT(*) AS total_orders,
    ROUND(AVG(CAST(r.review_score AS FLOAT)), 2) AS avg_review_score

FROM dbo.olist_orders_dataset o
INNER JOIN dbo.olist_order_reviews_dataset r
    ON o.order_id = r.order_id

GROUP BY 
    CASE 
        WHEN o.order_delivered_customer_date IS NULL 
            THEN 'Unknown'
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
            THEN 'Late'
        ELSE 'On Time'
    END

ORDER BY avg_review_score DESC;
