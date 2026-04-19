USE olist_project;

-- Analysis 3: Combined Impact of Delivery Timing and Order Value
-- Business Question: How do delivery performance and order value together influence customer satisfaction?
-- Description: Segments orders by delivery status and price category to evaluate how these factors jointly affect average review scores.

SELECT 
    CASE 
        WHEN o.order_delivered_customer_date IS NULL THEN 'Unknown'
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,

    CASE 
        WHEN t.total_order_value < 100 THEN 'Low'
        WHEN t.total_order_value BETWEEN 100 AND 200 THEN 'Medium'
        ELSE 'High'
    END AS price_category,

    COUNT(*) AS total_orders,
    AVG(CAST(r.review_score AS FLOAT)) AS avg_review_score

FROM dbo.olist_orders_dataset o
INNER JOIN dbo.olist_order_reviews_dataset r
    ON o.order_id = r.order_id
INNER JOIN (
    SELECT 
        order_id,
        SUM(price) AS total_order_value
    FROM dbo.olist_order_items_dataset
    GROUP BY order_id
) t
    ON o.order_id = t.order_id

GROUP BY 
    CASE 
        WHEN o.order_delivered_customer_date IS NULL THEN 'Unknown'
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Late'
        ELSE 'On Time'
    END,
    CASE 
        WHEN t.total_order_value < 100 THEN 'Low'
        WHEN t.total_order_value BETWEEN 100 AND 200 THEN 'Medium'
        ELSE 'High'
    END

ORDER BY delivery_status, price_category;