# 📊 Customer Satisfaction Drivers in E-Commerce (Olist Dataset)

## 🎯 Objective

Analyze the key factors influencing customer satisfaction in an e-commerce environment, with a focus on delivery performance, order value, and product categories.

---
## 📊 Dashboard Overview
<img width="1169" height="732" alt="dashboard_overview" src="https://github.com/user-attachments/assets/8a5d2f60-4ffb-46cb-9988-20db3fda242a" />


## 📦 Dataset

**Brazilian E-Commerce Public Dataset (Olist)**

Includes:

* Orders
* Order Items
* Reviews
* Products
* Customers
* Payments
* Category Translation

---

## 🧠 Approach

### 🔹 SQL Analysis

* Joined multiple tables to analyze relationships between delivery performance, pricing, and customer reviews
* Aggregated item-level data to order-level metrics (e.g., total order value)
* Performed multi-variable analysis (delivery status + price category)
* Evaluated product category performance (revenue vs satisfaction)

---

### 🔹 Python (Pandas)

* Cleaned and transformed data (date conversion, feature engineering)
* Created key features:

  * `delivery_delay_days`
  * `is_late`
  * `order_total`
* Merged datasets into a unified analytical dataset
* Replicated and extended SQL insights using `groupby()` and aggregations
* Created price segments using `qcut()`

---

### 🔹 Power BI Dashboard

* Built an interactive dashboard including:

  * KPI overview (Revenue, Orders, Ratings, Late %)
  * Delivery performance analysis
  * Order value vs satisfaction
  * Product category performance
* Added filters for Delivery Status and Product Category

---

## 🔍 Key Insights

* Late deliveries significantly reduce customer satisfaction (~4.2 → ~2.3)
* Order value alone has limited impact on review scores
* Late deliveries have the strongest negative impact on high-value orders
* Some high-revenue categories show lower customer satisfaction

---

## 💡 Business Recommendations

### Improve Delivery Performance

* Reduce late deliveries, especially for high-value orders
* Delivery delays are the primary driver of dissatisfaction

### Prioritize High-Value Orders

* Implement priority shipping or monitoring for expensive orders
* High-value customers are more sensitive to delays

### Optimize Underperforming Categories

* Investigate high-revenue, low-satisfaction categories
* Focus on product quality, packaging, and logistics

### Reduce Shipping Cost Friction

* Improve transparency or introduce incentives (e.g., free shipping thresholds)

---

## 📈 Business Impact

Improving delivery performance can significantly increase customer satisfaction and retention, particularly among high-value customers.

---

## 🛠️ Tools Used

* SQL
* Python (Pandas)
* Power BI

---
## 📁 Project Structure

- `sql/` – SQL queries for analysis  
- `python/` – Data cleaning and analysis (Pandas)  
- `powerbi/` – Dashboard and visualization  
- `README.md` – Project overview  


