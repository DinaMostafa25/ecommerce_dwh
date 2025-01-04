
-- 1.Create User Dimension primary key  (customer_zip_code) and reference to outtrigger_dim
CREATE TABLE customer_dim (
    
	customer_name NVARCHAR(255),
	customer_zip_code NVARCHAR(20),
	customer_city NVARCHAR(100),
    customer_state NVARCHAR(50),
    customer_id_sk INT PRIMARY KEY
);

-- 3. Create Seller Dimension
CREATE TABLE seller_dim (
    seller_id NVARCHAR(100) PRIMARY KEY, 
    seller_zip_code NVARCHAR(20),
    seller_city NVARCHAR(100),
    seller_state NVARCHAR(50)
);

-- 4. Create Product Dimension
CREATE TABLE product_dim (
    product_id  NVARCHAR(100) PRIMARY KEY, 
    product_category NVARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photo_qty INT,
    product_weight_kg DECIMAL(10, 2),
    product_length_cm DECIMAL(10, 2),
    product_height_cm DECIMAL(10, 2),
    product_width_cm DECIMAL(10, 2)
);

-- 5. Create Date Dimension 
--created from the order_date field in order_dataset to 
--allow for time-based analysis (e.g., monthly or yearly aggregation
/*CREATE TABLE date_dim (
    order_id INT PRIMARY KEY, 
    full_date DATE,
    year INT,
    month INT,
    day INT,  
);*/
-- 6. Create Order Dimension
CREATE TABLE order_dim (
    order_id  NVARCHAR(100) PRIMARY KEY,
	customer_name NVARCHAR(255),
    order_status NVARCHAR(50),
    order_date DATE,
    order_approved_date DATE,
    pickup_date DATE,
    delivered_date DATE,
    estimated_time_delivery DATE,
	customer_id_sk INT
);
-- 7. Create Feedback Dimension
CREATE TABLE feedback_dim (
    feedback_id  NVARCHAR(100) ,
    order_id  NVARCHAR(100) PRIMARY KEY,
    feedback_score INT,
    feedback_form_sent_date DATE,
    feedback_answer_date DATE
   
);
-- 8. Create Payment Dimension
CREATE TABLE payment_dim (
    order_id  NVARCHAR(100) PRIMARY KEY, 
	payment_sequantial INT,
    payment_type NVARCHAR(50), 
    payment_installments INT, 
    payment_value DECIMAL(10, 2)
);
-- 9. Create Order Fact Table with composite primary key (order_id, order_item_id)
CREATE TABLE order_fact (
    order_id  NVARCHAR(100),
    order_item_id  NVARCHAR(100),
	product_id  NVARCHAR(100),
    seller_id  NVARCHAR(100),
	pickup_limit_date int,
    price DECIMAL(10, 2),
    shipping_cost DECIMAL(10, 2),
	delivery_time INT, 
	customer_id_sk INT,
    PRIMARY KEY (order_id, order_item_id), -- Composite primary key
    FOREIGN KEY (customer_id_sk) REFERENCES customer_dim(customer_id_sk),
    FOREIGN KEY (seller_id) REFERENCES seller_dim(seller_id),
    FOREIGN KEY (product_id) REFERENCES product_dim(product_id),
	FOREIGN KEY (order_id) REFERENCES order_dim(order_id),
	FOREIGN KEY (order_id) REFERENCES feedback_dim(order_id),
	FOREIGN KEY (order_id) REFERENCES payment_dim(order_id)

);


