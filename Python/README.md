## Python Analysis

This folder contains the Python workflow used to clean, transform, and analyze the Brazilian Olist e-commerce dataset.

### Objective

The goal of this analysis is to extend the SQL exploration by performing data preprocessing, feature engineering, and deeper analysis of customer satisfaction drivers.

---

### Workflow Overview

#### 1. Data Loading

Multiple datasets were loaded, including:

* orders
* order items
* reviews
* products
* customers
* category translations

#### 2. Data Cleaning & Preparation

* Converted date columns to datetime format
* Calculated delivery delay in days
* Created a late delivery indicator (`is_late`)

#### 3. Feature Engineering

* Computed total order value per order
* Created price segments using quartiles

#### 4. Data Merging

* Combined multiple datasets into a single analytical dataset
* Joined orders, reviews, pricing, and product information

#### 5. Analysis

The following analyses were performed:

* **Delivery Performance vs Reviews**
  Late deliveries are associated with lower customer satisfaction.

* **Order Value vs Reviews**
  Higher-priced orders tend to receive slightly lower review scores.

* **Delivery + Price Interaction**
  Late deliveries have a stronger negative impact on high-value orders.

* **Product Category Performance**
  Some high-revenue categories show lower average review scores.

---

### Output

* A final cleaned dataset (`final_dataset.csv`) is generated for use in Power BI.

---

### File

* `analysis.py` – Main script containing the full data processing and analysis workflow

---

### Notes

* Update the `base_path` variable in the script to match your local dataset location before running.
* The analysis focuses on identifying relationships between variables rather than establishing causation.
