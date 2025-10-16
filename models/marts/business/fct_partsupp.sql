with partsupp as (

    select
        {{ dbt_utils.generate_surrogate_key(['part_id', 'supplier_id'])}} as partsupp_key,
        {{ dbt_utils.generate_surrogate_key(['part_id']) }} as part_key,
        {{ dbt_utils.generate_surrogate_key(['supplier_id']) }} as supplier_key,
        supply_cost,
        availability
    from {{ ref('stg_partsupp') }}

)

select *
from partsupp