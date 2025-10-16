select *
from {{ ref('stg_orders') }}
where order_date < '1992-01-01'
   or order_date > current_date()
