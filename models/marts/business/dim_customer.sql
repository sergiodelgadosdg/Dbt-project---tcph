with customer as (

    select
        customer_id,
        nation_id,
        phone,
        account_balance,
        mkt_segment
    from {{ ref('stg_customer') }} 

)

select *
from customer