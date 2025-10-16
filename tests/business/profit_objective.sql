select *
from (
    select sum(profit) as total_profit
    from {{ ref('fct_orders') }}
) t
where total_profit < 10000