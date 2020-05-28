{% set results_list = dbt_utils.get_column_values( ref('stg_payments'), "payment_method") -%}

with payments as (
    select *
    from {{ ref('stg_payments')}}
),

amounts as (

select
order_id,
{%- for pm in results_list|sort %}
sum(iff(payment_method = '{{ pm }}', payment_amount, 0)) as {{ pm }}_amount
{%- if not loop.last -%} , {%- endif -%}
{% endfor %}
from payments
group by 1
)

select *
from amounts