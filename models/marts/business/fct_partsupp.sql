with partsupp as (

    select
        {{ dbt_utils.generate_surrogate_key(['part_id', 'supplier_id'])}} as partsupp_key,
        part_id,
        supplier_id,
        supply_cost,
        availability
    from {{ ref('stg_partsupp') }}

)

select *
from partsupp