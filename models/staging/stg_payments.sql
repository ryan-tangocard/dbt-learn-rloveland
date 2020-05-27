select
    id as payment_id,
    "orderID" as order_id,
    "paymentMethod" as payment_method,
    amount/100::DECIMAL(16,5) as payment_amount,
    created as payment_created_at
from raw.stripe.payment