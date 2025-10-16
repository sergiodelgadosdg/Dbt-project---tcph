with customer as (

    select
        {{ dbt_utils.generate_surrogate_key(['customer_id'])}} as customer_key,
        customer_id,
        nation_id,
        phone,
        account_balance,
        mkt_segment
    from {{ ref('stg_customer') }} 

)

select *
from customer