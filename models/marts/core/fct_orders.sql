
with orders as  (
    select * from {{ ref('stg_orders' )}}

),
payments as (

    select * from {{ ref('stg_payments') }}
),

order_payments as (

    select
        order_id,
        sum(payment_amount) as payment_amount

    from payments
    group by 1
)

select
orders.order_id,
orders.customer_id,
orders.order_created_date,
orders.order_status,
coalesce(order_payments.payment_amount, 0) as payment_amount

from orders
    left join order_payments ON orders.order_id = order_payments.order_id