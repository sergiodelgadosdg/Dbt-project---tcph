with customers as (

    select 
        customer_id,
        nation_id
    from {{ ref('stg_customer') }}

),

partsupp as (

    select 
        part_id,
        supplier_id,
        supply_cost
    from {{ ref('stg_partsupp') }}

),

orders as (

    select 
        order_id,
        customer_id,
        order_date,
        regexp_replace(clerk, '[^0-9]', '')::int as clerk_id,
        initcap(split_part(order_priority, '-', 1))::int as order_priority
    from {{ ref('stg_orders') }}

),

lineitem as (
    select 
        order_id,
        part_id,
        supplier_id,
        line_number,
        quantity,
        extended_price,
        discount,
        tax,
        return_flag,
        line_status,
        ship_date,
        commit_date,
        receipt_date,
        initcap(ship_instruct) as ship_instruct,
        initcap(ship_mode) as ship_mode
    from {{ ref('stg_lineitem') }}
),

joined as (
    select 
        l.order_id,
        l.line_number,
        l.part_id,
        l.supplier_id,
        o.customer_id,
        c.nation_id,
        l.quantity,
        l.extended_price,
        l.discount,
        l.tax,
        l.return_flag,
        l.line_status,
        l.ship_date,
        l.commit_date,
        l.receipt_date,
        l.ship_instruct,
        l.ship_mode,
        o.order_date,
        o.clerk_id,
        o.order_priority,
        ps.supply_cost
    from lineitem l
    inner join orders o
        on l.order_id = o.order_id
    inner join customers c
        on o.customer_id = c.customer_id
    left join partsupp ps
        on l.part_id = ps.part_id
        and l.supplier_id = ps.supplier_id
)


select * from joined