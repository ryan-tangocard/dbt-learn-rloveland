with orders as (
    select * from {{ ref('stg_orders')}}
),
payments as (
    select * from {{ ref('stg_payments')}}
)

SELECT
o.order_id,
o.customer_id,
o.order_created_date,
sum(p.payment_amount) AS payment_total

FROM orders o
    JOIN payments p ON o.order_id = p.order_id
GROUP BY 1,2,3