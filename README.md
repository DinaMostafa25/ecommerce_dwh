# *Data Modeling for eCommerce Data Warehouse*
## **Project Overview**
This project focuses on designing and implementing a data warehouse for an eCommerce platform. The process involves data extraction from multiple sources, transformation for analytical readiness, and loading into a structured data warehouse schema to support business insights and decision-making.<br>
[presentation](https://www.canva.com/design/DAGcKrJimwc/K4xRFwQKYikbX2OqEV_CEw/edit?utm_content=DAGcKrJimwc&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)<br>

## **Project Objectives**
Build a data warehouse model for efficient data storage and query performance.<br>
Develop an ETL pipeline to clean, transform, and load data from Excel files.<br>
Execute analytical queries to derive insights on customer behavior, product performance, and order management.<br>

## **Data Sources**
#### Data is sourced from 7 Excel files:<br>
&nbsp;&nbsp;&nbsp;&nbsp;- user_dataset.xlsx<br>
&nbsp;&nbsp;&nbsp;&nbsp;- seller_dataset.csv<br>
&nbsp;&nbsp;&nbsp;&nbsp;- product_dataset.csv<br>
&nbsp;&nbsp;&nbsp;&nbsp;- order_dataset.csv<br>
&nbsp;&nbsp;&nbsp;&nbsp;- payment_dataset.csv<br>
&nbsp;&nbsp;&nbsp;&nbsp;- order_item_dataset.csv<br>
&nbsp;&nbsp;&nbsp;&nbsp;- feedback_dataset.csv<br>
**- the name in the notebook is different, but it is the same data.**<br> 

## *Data Warehouse Schema*
#### The schema consists of:<br>
**Fact Table**:<br>
&nbsp;&nbsp;&nbsp;&nbsp;- Order Fact Table<br>
**Dimension Tables**:<br>
&nbsp;&nbsp;&nbsp;&nbsp;- Customer Dimension<br>
&nbsp;&nbsp;&nbsp;&nbsp;- Product Dimension<br>
&nbsp;&nbsp;&nbsp;&nbsp;- Order Dimension<br>
&nbsp;&nbsp;&nbsp;&nbsp;- Seller Dimension<br>
&nbsp;&nbsp;&nbsp;&nbsp;- Payment Dimension<br>
&nbsp;&nbsp;&nbsp;&nbsp;- Feedback Dimension<br>
## *ETL Process*
**Extract**:<br> &nbsp;&nbsp;&nbsp;&nbsp;Data extraction from Excel files using Python and pandas.<br>
**Transform**:<br> &nbsp;&nbsp;&nbsp;&nbsp;Data cleaning, merging, and transformation steps applied to ensure data consistency and completeness.<br>
**Load**:<br> &nbsp;&nbsp;&nbsp;&nbsp;Loading cleaned data into the data warehouse structure.<br>
## *Project Phases*
**Data Warehouse Modeling:**<br> &nbsp;&nbsp;&nbsp;&nbsp;- Creating a schema to support business queries effectively.
**ETL Pipeline Development:**<br> &nbsp;&nbsp;&nbsp;&nbsp;- Reading, transforming, and loading data into the warehouse using Jupyter Notebook.
**Analytical Queries:**<br> &nbsp;&nbsp;&nbsp;&nbsp;- Running SQL queries to address business questions such as customer purchasing trends and delivery &nbsp;&nbsp;&nbsp;&nbsp;performance.
## *Tools and Technologies*
**Data Processing:** &nbsp;&nbsp;&nbsp;&nbsp; Jupyter Notebook, pandas.<br>
**Data Storage:** &nbsp;&nbsp;&nbsp;&nbsp; Data Warehouse Schema.<br>
**Data Analysis:** &nbsp;&nbsp;&nbsp;&nbsp; SQL.<br>
## *How to Run the Project*
&nbsp;&nbsp;&nbsp;&nbsp; - Clone the repository.<br>
&nbsp;&nbsp;&nbsp;&nbsp; - Open the Jupyter Notebook file in your environment.<br>
&nbsp;&nbsp;&nbsp;&nbsp; - Ensure all required Excel files are in the designated folder path.<br>
&nbsp;&nbsp;&nbsp;&nbsp; - Execute each notebook cell to run the ETL pipeline and generate insights.<br>

