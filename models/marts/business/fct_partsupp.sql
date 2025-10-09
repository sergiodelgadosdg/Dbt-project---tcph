with partsupp as (

    select 
        part_id,
        supplier_id,
        supply_cost,
        availability
    from {{ ref('stg_partsupp') }}

)

select *
from partsupp