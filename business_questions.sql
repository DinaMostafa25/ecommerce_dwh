-- When is the peak season of our ecommerce 
-- total sales per year
with peak_season
as (
select  year(o.order_date) as _year,
        CEILING(MONTH(o.order_date) / 3.0) AS _quarter,
        MONTH(o.order_date) as _month,
        sum(f.price*f.shipping_cost) as total_cost
from order_dim o
join order_fact f on o.order_id = f.order_id
group by year(o.order_date), MONTH(o.order_date), CEILING(MONTH(o.order_date) / 3.0)
)
select _year, _quarter, _month, total_cost
from peak_season
where total_cost = (select max(total_cost) from peak_season)
------------------------------------------------------------------------------------------------------

--what time users are most likely make an order or using the ecommerce app?
with total_orders_per_hour as
(SELECT DATEPART(HOUR, o.order_date) AS order_hour,
    COUNT(o.order_id) AS total_orders
FROM order_dim o
GROUP BY DATEPART(HOUR, o.order_date)
) 
select order_hour, total_orders 
from total_orders_per_hour 
where total_orders =(select max(total_orders) from total_orders_per_hour )
----------------------------------------------------------------------------------
-- What is the preferred way to pay in the ecommerce?
with payment_type_count as
(SELECT payment_type, 
        COUNT(payment_type) AS usage_count
FROM payment_dim
GROUP BY payment_type
)
select payment_type as  preferred_way_to_pay
from payment_type_count
where usage_count = ( select max(usage_count) AS usage_count from payment_type_count )
----------------------------------------------------------------------------------
-- How many installment is usually done when paying in the ecommerce?
with installments_cnt as(
SELECT 
    payment_installments, 
    COUNT(payment_installments) AS usage_count
FROM payment_dim
GROUP BY payment_installments

)
select payment_installments as payment_installments_usually_done
from installments_cnt
where usage_count = (select max(usage_count) from installments_cnt )
----------------------------------------------------------------------------------
-- What is the average spending time for user for our ecommerce?
SELECT customer_name,
    AVG(DATEDIFF(DAY, order_date, delivered_date)) AS average_spending_time
FROM order_dim
WHERE delivered_date IS NOT NULL
group by customer_name
----------------------------------------------------------------------------------
--What is the frequency of purchase on each state
select c.customer_state,
       count(o.order_id) as frequency_of_purchase
from customer_dim as c
join order_dim as o on c.customer_id_sk = o.customer_id_sk
group by c.customer_state
order by frequency_of_purchase
----------------------------------------------------------------------------------
--Which logistic route that have heavy traffic in our ecommerce?
SELECT 
    c.customer_city AS origin_city,
    s.seller_city AS destination_city,
    COUNT(o.order_id) AS order_count
FROM order_dim o
JOIN customer_dim c ON o.customer_id_sk = c.customer_id_sk
JOIN order_fact f ON o.order_id = f.order_id
JOIN seller_dim s ON f.seller_id = s.seller_id
GROUP BY c.customer_city, s.seller_city
ORDER BY order_count DESC;
----------------------------------------------------------------------------------
-- How many late delivered order in our ecommerce? 
SELECT 
    COUNT(*) AS late_delivered_orders
FROM order_dim
WHERE delivered_date > estimated_time_delivery;
-- Are late order affecting the customer satisfaction?
-- Define CTEs for clarity and reusability
WITH late_orders AS (
    SELECT 
        o.order_id,
        o.delivered_date,
        o.estimated_time_delivery,
        CASE 
            WHEN o.delivered_date > o.estimated_time_delivery THEN 'Late Delivery'
            ELSE 'On-Time Delivery'
        END AS delivery_status
    FROM order_dim o
    WHERE o.delivered_date IS NOT NULL AND o.estimated_time_delivery IS NOT NULL
),
feedback_analysis AS (
    SELECT 
        lo.delivery_status,
        AVG(f.feedback_score) AS average_feedback_score,
        COUNT(lo.order_id) AS order_count
    FROM late_orders lo
    LEFT JOIN feedback_dim f ON lo.order_id = f.order_id
    GROUP BY lo.delivery_status
)
-- Final SELECT to get the results
SELECT 
    delivery_status,
    average_feedback_score,
    order_count
FROM feedback_analysis;
----------------------------------------------------------------------------------
--How long are the delay for delivery / shipping process in each state?
SELECT
    c.customer_state,
    SUM(DATEDIFF(DAY,o.pickup_date,  o.delivered_date)) AS delivery_shipping_delay
FROM order_dim o
JOIN customer_dim c ON o.customer_id_sk = c.customer_id_sk
WHERE o.pickup_date < o.delivered_date
GROUP BY customer_state
----------------------------------------------------------------------------------
--How long are the difference between estimated delivery time and actual delivery time in each state?
SELECT
    c.customer_state,
    SUM(DATEDIFF(DAY, o.estimated_time_delivery, o.delivered_date)) AS delivery_delay
FROM order_dim o
JOIN customer_dim c ON o.customer_id_sk = c.customer_id_sk
WHERE o.delivered_date > o.estimated_time_delivery
GROUP BY customer_state

----------------------------------------------------------------------------------




