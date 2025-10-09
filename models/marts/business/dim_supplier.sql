with supplier as (
    
    select
        supplier_id,
        nation_id,
        phone,
        account_balance
    from {{ ref('stg_supplier') }} 

)

select *
from supplier