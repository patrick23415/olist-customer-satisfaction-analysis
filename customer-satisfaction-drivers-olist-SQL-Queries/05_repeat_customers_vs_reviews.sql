USE olist_project;

-- Analysis 5: Customer Loyalty and Review Behavior
-- Business Question: Do repeat customers leave higher review scores than one-time customers?
-- Description: Classifies customers as one-time or repeat based on order count and compares their average review scores.

SELECT 
    CASE 
        WHEN c.total_orders = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_type,
    
    COUNT(*) AS total_orders,
    
    AVG(CAST(r.review_score AS FLOAT)) AS avg_review_score

FROM (
    SELECT 
        cu.customer_unique_id,
        COUNT(o.order_id) AS total_orders
    FROM dbo.olist_orders_dataset o
    INNER JOIN dbo.olist_customers_dataset cu
        ON o.customer_id = cu.customer_id
    GROUP BY cu.customer_unique_id
) c

INNER JOIN dbo.olist_customers_dataset cu
    ON c.customer_unique_id = cu.customer_unique_id

INNER JOIN dbo.olist_orders_dataset o
    ON cu.customer_id = o.customer_id

INNER JOIN dbo.olist_order_reviews_dataset r
    ON o.order_id = r.order_id

GROUP BY 
    CASE 
        WHEN c.total_orders = 1 THEN 'One-time'
        ELSE 'Repeat'
    END;
