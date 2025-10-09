with location as (

    select
        nation_id, 
        nation_name,
        region_name
        from {{ ref('int_location') }} 
)

select * 
from location