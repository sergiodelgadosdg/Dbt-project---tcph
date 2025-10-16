{{ 
    config(
        materialized='incremental',
        unique_key='order_id',
        incremental_strategy='merge',
        on_schema_change='sync'
    )
}}

with new_orders as (
    select *
    from {{ ref('int_orders') }}
    {% if is_incremental() %}
        where order_date > (select max(order_date) from {{ this }})
    {% endif %}
),

orders_enriched as (
    select
        {{ dbt_utils.generate_surrogate_key(['order_id', 'line_number', 'part_id']) }} as orders_key,
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,
        {{ dbt_utils.generate_surrogate_key(['nation_id']) }} as nation_key,
        {{ dbt_utils.generate_surrogate_key(['part_id']) }} as part_key,
        {{ dbt_utils.generate_surrogate_key(['supplier_id']) }} as supplier_key,
        order_date,
        ship_date,
        quantity,
        extended_price,
        discount,
        tax,
        return_flag,
        line_status,
        commit_date,
        receipt_date,
        ship_instruct,
        ship_mode,
        clerk_id,
        order_priority,
        supply_cost,
        round((extended_price * (1 - discount)) * (1 + tax), 2) as final_price,
        round((supply_cost * quantity), 2) as total_cost,
        round((extended_price * (1 - discount)) * (1 + tax) - (supply_cost * quantity), 2) as profit,
        greatest(datediff(day, commit_date, ship_date), 0) as days_of_delay,
        datediff(day, ship_date, receipt_date) as shipping_days
    from new_orders
)

select * from orders_enriched
