with supplier as (
    
    select
        {{ dbt_utils.generate_surrogate_key(['supplier_id'])}} as supplier_key,
        supplier_id,
        nation_id,
        phone,
        account_balance
    from {{ ref('stg_supplier') }} 

)

select *
from supplier