# ======================
# 1. IMPORTS
# ======================

import pandas as pd
import os

# ======================
# 2. DATA PATH (UPDATE REQUIRED)
# ======================
# Update this path to match where the dataset is stored on your machine
# Example: r"C:\Users\YourName\Downloads\dataset_folder"

base_path = r"C:\Users\patri\Downloads\Brazilian E-commerce Public Dataset"

# ======================
# 3. LOAD DATA
# ======================

orders = pd.read_csv(os.path.join(base_path, "olist_orders_dataset.csv"))
order_items = pd.read_csv(os.path.join(base_path, "olist_order_items_dataset.csv"))
payments = pd.read_csv(os.path.join(base_path, "olist_order_payments_dataset.csv"))
reviews = pd.read_csv(os.path.join(base_path, "olist_order_reviews_dataset.csv"))
products = pd.read_csv(os.path.join(base_path, "olist_products_dataset.csv"))
customers = pd.read_csv(os.path.join(base_path, "olist_customers_dataset.csv"))
category_translation = pd.read_csv(os.path.join(base_path, "product_category_name_translation.csv"))

print("ORDERS:", orders.shape)
print("ORDER ITEMS:", order_items.shape)
print("REVIEWS:", reviews.shape)
print("PRODUCTS:", products.shape)
print("CUSTOMERS:", customers.shape)
print("CATEGORY TRANSLATION:", category_translation.shape)

# ======================
# 4. DATA CLEANING & PREPARATION
# ======================

date_cols = [
    "order_purchase_timestamp",
    "order_approved_at",
    "order_delivered_carrier_date",
    "order_delivered_customer_date",
    "order_estimated_delivery_date"
]

for col in date_cols:
    orders[col] = pd.to_datetime(orders[col])

orders["delivery_delay_days"] = (
    orders["order_delivered_customer_date"] - orders["order_estimated_delivery_date"]
).dt.days

orders["is_late"] = orders["delivery_delay_days"] > 0

print("\n--- DELIVERY DELAY SAMPLE ---")
print(orders[[
    "order_delivered_customer_date",
    "order_estimated_delivery_date",
    "delivery_delay_days",
    "is_late"
]].head())

# ======================
# 5. FEATURE ENGINEERING
# ======================

order_value = order_items.groupby("order_id")["price"].sum().reset_index()
order_value.rename(columns={"price": "order_total"}, inplace=True)

print("\n--- ORDER VALUE SAMPLE ---")
print(order_value.head())

# ======================
# 6. MERGE DATASETS
# ======================

orders_reviews = pd.merge(orders, reviews, on="order_id", how="inner")
orders_full = pd.merge(orders_reviews, order_value, on="order_id", how="inner")

orders_full["price_group"] = pd.qcut(
    orders_full["order_total"],
    q=4,
    labels=["Low", "Mid-Low", "Mid-High", "High"]
)

print("\n--- MERGED DATASET SHAPES ---")
print("orders_reviews:", orders_reviews.shape)
print("orders_full:", orders_full.shape)

# ======================
# 7. ANALYSIS
# ======================

# ----------------------
# 7.1 Delivery vs Reviews
# ----------------------

delivery_analysis = orders_reviews.groupby("is_late")["review_score"].mean()
delivery_counts = orders_reviews["is_late"].value_counts()

print("\n--- AVG REVIEW SCORE BY LATE DELIVERY ---")
print(delivery_analysis)

print("\n--- COUNT BY LATE DELIVERY ---")
print(delivery_counts)

# Insight:
# Late deliveries are associated with lower average review scores


# ----------------------
# 7.2 Price vs Reviews
# ----------------------

price_analysis = orders_full.groupby("price_group")["review_score"].mean()
price_counts = orders_full["price_group"].value_counts()

print("\n--- AVG REVIEW SCORE BY PRICE GROUP ---")
print(price_analysis)

print("\n--- COUNT BY PRICE GROUP ---")
print(price_counts)

# Insight:
# Higher-priced orders tend to receive lower review scores


# ----------------------
# 7.3 Interaction: Price + Delivery
# ----------------------

interaction_analysis = orders_full.groupby(
    ["is_late", "price_group"]
)["review_score"].mean().unstack()

print("\n--- REVIEW SCORE: PRICE + DELIVERY ---")
print(interaction_analysis)

# Insight:
# The negative impact of late deliveries is stronger for high-value orders


# ----------------------
# 7.4 Category Analysis
# ----------------------

products_full = pd.merge(
    products,
    category_translation,
    on="product_category_name",
    how="left"
)

order_items_full = pd.merge(
    order_items,
    products_full,
    on="product_id",
    how="left"
)

final_df = pd.merge(
    orders_full,
    order_items_full,
    on="order_id",
    how="inner"
)

category_analysis = final_df.groupby(
    "product_category_name_english"
).agg(
    total_revenue=("price", "sum"),
    avg_review=("review_score", "mean"),
    order_count=("order_id", "count")
).sort_values(by="total_revenue", ascending=False)

print("\n--- TOP 10 CATEGORY ANALYSIS ---")
print(category_analysis.head(10))

# Insight:
# Some high-revenue categories show lower average review scores


# ======================
# 8. EXPORT DATA
# ======================

output_path = os.path.join(base_path, "final_dataset.csv")
final_df.to_csv(output_path, index=False)

print("\nFinal dataset exported to:")
print(output_path)