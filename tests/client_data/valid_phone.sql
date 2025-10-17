select *
from {{ ref('stg_customer') }}
where not REGEXP_LIKE(phone, '^[0-9-]+$')
