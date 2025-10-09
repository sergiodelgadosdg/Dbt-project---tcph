with source as (

    select *
    from {{ source('tpch_sf1', 'customer') }}

),

transformed as (

    select
        c_custkey as customer_id,
        c_name as customer_name,
        c_address as address,
        c_nationkey as nation_id,
        c_phone as phone,
        c_acctbal as account_balance,
        initcap(c_mktsegment) as mkt_segment,
        c_comment as comment
    from source
)

select *
from transformed
