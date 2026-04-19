# 📊 Customer Satisfaction Drivers in E-Commerce (Olist Dataset)

## 🎯 Objective
The goal of this project was to identify the key drivers of customer satisfaction in an e-commerce business, focusing on delivery performance, order value, and product categories.

---

## 📦 Dataset
Brazilian E-Commerce Public Dataset (Olist)

Includes multiple tables:
- Orders
- Order Items
- Reviews
- Products
- Customers
- Payments
- Category Translation

---

## 🧠 Approach

### 🔹 SQL Analysis
- Joined multiple tables to analyze relationships between delivery performance, pricing, and customer reviews
- Aggregated item-level data to order-level metrics (total order value)
- Performed multi-variable analysis (delivery status + price category)
- Identified category-level performance (revenue vs satisfaction)

---

### 🔹 Python (Pandas)
- Cleaned and transformed data (handled nulls, converted date types)
- Engineered key features:
  - `delivery_delay_days`
  - `is_late`
  - `order_total`
- Merged multiple datasets to create a unified analytical dataset
- Used `groupby()` and aggregations to replicate and extend SQL insights
- Created price segments using `qcut()`

---

### 🔹 Power BI Dashboard
- Built interactive dashboard with:
  - KPI overview (Revenue, Orders, Ratings, Late %)
  - Delivery impact analysis
  - Price vs satisfaction analysis
  - Category-level performance (revenue + rating)
- Added slicers for Delivery Status and Product Category

---

## 🔍 Key Insights

- Late deliveries significantly reduce customer satisfaction (~4.2 → ~2.3)
- Order value has minimal impact on satisfaction independently
- High-value orders delivered late receive the lowest ratings (~2.2)
- Some high-revenue categories (e.g., furniture, home goods) have lower satisfaction (~3.9)

---

## 💡 Business Recommendations

1. **Improve Delivery Performance**
   - Prioritize reducing late deliveries, especially for high-value orders
   - Delivery delays are the primary driver of customer dissatisfaction

2. **Prioritize High-Value Orders**
   - Implement priority shipping or alerts for premium purchases
   - High-value customers show greater sensitivity to delays

3. **Optimize Underperforming Categories**
   - Focus improvements on high-revenue, low-satisfaction categories
   - Investigate product quality, packaging, or logistics issues

4. **Reduce Shipping Cost Friction**
   - Higher costs correlate with lower reviews
   - Consider free shipping thresholds or cost transparency

---

## 📈 Business Impact

Improving delivery performance could significantly increase customer satisfaction and retention, particularly among high-value customers. Even small reductions in late deliveries may lead to disproportionately higher review scores and improved customer experience.

---

## 🚀 Next Steps

- Analyze customer lifetime value (CLV)
- Incorporate delivery distance/logistics data
- Build predictive model for customer satisfaction
- Perform cohort or segmentation analysis

---

## 🛠️ Tools Used

- SQL (data extraction & analysis)
- Python (pandas, data cleaning & transformation)
- Power BI (data visualization & dashboarding)

---
