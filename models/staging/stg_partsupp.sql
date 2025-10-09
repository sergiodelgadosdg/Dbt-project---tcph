with source as (

    select * 
    from {{ source('tpch_sf1', 'partsupp')}}

),

transformed as (

    select 
        ps_partkey as part_id,
        ps_suppkey as supplier_id,
        ps_availqty as availability,
        ps_supplycost as supply_cost,
        ps_comment as comment
    from source

)

select *
from transformed