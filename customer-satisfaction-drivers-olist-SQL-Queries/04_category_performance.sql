USE olist_project;

-- Analysis 4: Product Category Performance Analysis
-- Business Question: Which product categories generate the most revenue and how do they perform in terms of customer satisfaction?
-- Description: Aggregates order volume, total revenue, and average review scores by product category to identify high- and low-performing segments.

SELECT TOP 20
    oi.order_id,
    oi.product_id,
    oi.price,
    p.product_category_name,
    t.product_category_name_english,
    r.review_score
FROM dbo.olist_order_items_dataset oi
INNER JOIN dbo.olist_products_dataset p
    ON oi.product_id = p.product_id
LEFT JOIN dbo.product_category_name_translation t
    ON p.product_category_name = t.product_category_name
INNER JOIN dbo.olist_order_reviews_dataset r
    ON oi.order_id = r.order_id;


SELECT 
    t.product_category_name_english,
    
    COUNT(DISTINCT oi.order_id) AS total_orders,
    
    SUM(oi.price) AS total_revenue,
    
    AVG(CAST(r.review_score AS FLOAT)) AS avg_review_score

FROM dbo.olist_order_items_dataset oi

INNER JOIN dbo.olist_products_dataset p
    ON oi.product_id = p.product_id

LEFT JOIN dbo.product_category_name_translation t
    ON p.product_category_name = t.product_category_name

INNER JOIN dbo.olist_order_reviews_dataset r
    ON oi.order_id = r.order_id

GROUP BY t.product_category_name_english

ORDER BY total_revenue DESC;
