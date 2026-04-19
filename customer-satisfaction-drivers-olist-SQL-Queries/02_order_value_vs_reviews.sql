-- Analysis 2: Order Value and Shipping Cost vs Review Scores
-- Business Question: Do higher-priced orders receive better or worse reviews?
-- Description: Aggregates total order value and shipping cost per order and compares these metrics across different review score levels.

USE olist_project
SELECT 
    r.review_score,
    COUNT(*) AS total_orders,
    AVG(t.total_order_value) AS avg_order_value,
    AVG(t.total_freight) AS avg_shipping_cost

FROM dbo.olist_orders_dataset o
INNER JOIN dbo.olist_order_reviews_dataset r
    ON o.order_id = r.order_id
INNER JOIN (
    SELECT 
        order_id,
        SUM(price) AS total_order_value,
        SUM(freight_value) AS total_freight
    FROM dbo.olist_order_items_dataset
    GROUP BY order_id
) t
    ON o.order_id = t.order_id

GROUP BY r.review_score
ORDER BY r.review_score;
