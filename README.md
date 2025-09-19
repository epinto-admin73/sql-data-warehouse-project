# sql-data-warehouse-project
building modern data wareehouse
# Data Catalog for Gold Layer

## Overview

The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases. It consists of **dimension tables** and **fact tables** for specific business metrics.

* * *

### 1. **gold.dim_customers**

* **Purpose:** Stores customer details enriched with demographic and geographic data.
* **Columns:**

| Column Name | Data Type | Description |
| --- | --- | --- |
| customer_key | INT | Surrogate key uniquely identifying each customer record in the dimension table. |
| customer_id | INT | Unique numerical identifier assigned to each customer. |
| customer_number | NVARCHAR(50) | Alphanumeric identifier representing the customer, used for tracking and referencing. |
| first_name | NVARCHAR(50) | The customer's first name, as recorded in the system. |
| last_name | NVARCHAR(50) | The customer's last name or family name. |
| country | NVARCHAR(50) | The country of residence for the customer (e.g., 'Australia'). |
| marital_status | NVARCHAR(50) | The marital status of the customer (e.g., 'Married', 'Single'). |
| gender | NVARCHAR(50) | The gender of the customer (e.g., 'Male', 'Female', 'n/a'). |
| birthdate | DATE | The date of birth of the customer, formatted as YYYY-MM-DD (e.g., 1971-10-06). |
| create_date | DATE | The date and time when the customer record was created in the system |

* * *

### 2. **gold.dim_products**

* **Purpose:** Provides information about the products and their attributes.
* **Columns:**

| Column Name | Data Type | Description |
| --- | --- | --- |
| product_key | INT | Surrogate key uniquely identifying each product record in the product dimension table. |
| product_id | INT | A unique identifier assigned to the product for internal tracking and referencing. |
| product_number | NVARCHAR(50) | A structured alphanumeric code representing the product, often used for categorization or inventory. |
| product_name | NVARCHAR(50) | Descriptive name of the product, including key details such as type, color, and size. |
| category_id | NVARCHAR(50) | A unique identifier for the product's category, linking to its high-level classification. |
| category | NVARCHAR(50) | The broader classification of the product (e.g., Bikes, Components) to group related items. |
| subcategory | NVARCHAR(50) | A more detailed classification of the product within the category, such as product type. |
| maintenance_required | NVARCHAR(50) | Indicates whether the product requires maintenance (e.g., 'Yes', 'No'). |
| cost | INT | The cost or base price of the product, measured in monetary units. |
| product_line | NVARCHAR(50) | The specific product line or series to which the product belongs (e.g., Road, Mountain). |
| start_date | DATE | The date when the product became available for sale or use, stored in |

* * *

### 3. **gold.fact_sales**

* **Purpose:** Stores transactional sales data for analytical purposes.
* **Columns:**

| Column Name | Data Type | Description |
| --- | --- | --- |
| order_number | NVARCHAR(50) | A unique alphanumeric identifier for each sales order (e.g., 'SO54496'). |
| product_key | INT | Surrogate key linking the order to the product dimension table. |
| customer_key | INT | Surrogate key linking the order to the customer dimension table. |
| order_date | DATE | The date when the order was placed. |
| shipping_date | DATE | The date when the order was shipped to the customer. |
| due_date | DATE | The date when the order payment was due. |
| sales_amount | INT | The total monetary value of the sale for the line item, in whole currency units (e.g., 25). |
| quantity | INT | The number of units of the product ordered for the line item (e.g., 1). |
| price | INT | The price per unit of the product for the line item, in whole currency units (e.g., 25). |
# **Naming Conventions**

This document outlines the naming conventions used for schemas, tables, views, columns, and other objects in the data warehouse.

## **Table of Contents**

1. [General Principles](#general-principles)
2. [Table Naming Conventions](#table-naming-conventions)
   - [Bronze Rules](#bronze-rules)
   - [Silver Rules](#silver-rules)
   - [Gold Rules](#gold-rules)
3. [Column Naming Conventions](#column-naming-conventions)
   - [Surrogate Keys](#surrogate-keys)
   - [Technical Columns](#technical-columns)
4. [Stored Procedure](#stored-procedure-naming-conventions)
---

## **General Principles**

- **Naming Conventions**: Use snake_case, with lowercase letters and underscores (`_`) to separate words.
- **Language**: Use English for all names.
- **Avoid Reserved Words**: Do not use SQL reserved words as object names.

## **Table Naming Conventions**

### **Bronze Rules**
- All names must start with the source system name, and table names must match their original names without renaming.
- **`<sourcesystem>_<entity>`**  
  - `<sourcesystem>`: Name of the source system (e.g., `crm`, `erp`).  
  - `<entity>`: Exact table name from the source system.  
  - Example: `crm_customer_info` → Customer information from the CRM system.

### **Silver Rules**
- All names must start with the source system name, and table names must match their original names without renaming.
- **`<sourcesystem>_<entity>`**  
  - `<sourcesystem>`: Name of the source system (e.g., `crm`, `erp`).  
  - `<entity>`: Exact table name from the source system.  
  - Example: `crm_customer_info` → Customer information from the CRM system.

### **Gold Rules**
- All names must use meaningful, business-aligned names for tables, starting with the category prefix.
- **`<category>_<entity>`**  
  - `<category>`: Describes the role of the table, such as `dim` (dimension) or `fact` (fact table).  
  - `<entity>`: Descriptive name of the table, aligned with the business domain (e.g., `customers`, `products`, `sales`).  
  - Examples:
    - `dim_customers` → Dimension table for customer data.  
    - `fact_sales` → Fact table containing sales transactions.  

#### **Glossary of Category Patterns**

| Pattern     | Meaning                           | Example(s)                              |
|-------------|-----------------------------------|-----------------------------------------|
| `dim_`      | Dimension table                  | `dim_customer`, `dim_product`           |
| `fact_`     | Fact table                       | `fact_sales`                            |
| `agg_`      | Aggregated table                 | `agg_customers`, `agg_sales_monthly`    |

## **Column Naming Conventions**

### **Surrogate Keys**  
- All primary keys in dimension tables must use the suffix `_key`.
- **`<table_name>_key`**  
  - `<table_name>`: Refers to the name of the table or entity the key belongs to.  
  - `_key`: A suffix indicating that this column is a surrogate key.  
  - Example: `customer_key` → Surrogate key in the `dim_customers` table.
  
### **Technical Columns**
- All technical columns must start with the prefix `dwh_`, followed by a descriptive name indicating the column's purpose.
- **`dwh_<column_name>`**  
  - `dwh`: Prefix exclusively for system-generated metadata.  
  - `<column_name>`: Descriptive name indicating the column's purpose.  
  - Example: `dwh_load_date` → System-generated column used to store the date when the record was loaded.
 
## **Stored Procedure**

- All stored procedures used for loading data must follow the naming pattern:
- **`load_<layer>`**.
  
  - `<layer>`: Represents the layer being loaded, such as `bronze`, `silver`, or `gold`.
  - Example: 
    - `load_bronze` → Stored procedure for loading data into the Bronze layer.
    - `load_silver` → Stored procedure for loading data into the Silver layer.

