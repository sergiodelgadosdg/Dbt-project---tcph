{{ 
    config(
        materialized='incremental',
        unique_key='order_id',
        incremental_strategy='merge',
        on_schema_change='sync'
    )
}}

with orders as (
    select *
    from {{ ref('int_orders') }}
    {% if is_incremental() %}
        -- Solo traemos nuevas órdenes o actualizadas
        where order_date > (select max(order_date) from {{ this }})
    {% endif %}
),

orders_enriched as (
    select
        *,
        {{ calc_final_price('extended_price', 'discount', 'tax') }} as final_price,
        (supply_cost * quantity) as total_cost,
        {{ calc_final_price('extended_price', 'discount', 'tax') }} - (supply_cost * quantity) as profit,
        greatest(datediff(day, commit_date, ship_date), 0) as days_of_delay,
        datediff(day, ship_date, receipt_date) as shipping_days
    from orders
)

select *
from orders_enriched
