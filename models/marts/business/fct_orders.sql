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
        {{ dbt_utils.generate_surrogate_key(['order_id', 'line_number', 'part_id'])}} as orders_key,
        *,
        round({{ calc_final_price('extended_price', 'discount', 'tax') }}, 2) as final_price,
        round((supply_cost * quantity), 2) as total_cost,
        round({{ calc_final_price('extended_price', 'discount', 'tax') }} - (supply_cost * quantity), 2) as profit,
        greatest(datediff(day, commit_date, ship_date), 0) as days_of_delay,
        datediff(day, ship_date, receipt_date) as shipping_days
    from orders
)


select *
from orders_enriched
