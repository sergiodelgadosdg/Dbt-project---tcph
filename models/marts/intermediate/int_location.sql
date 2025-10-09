with region as (
    select 
        region_id,
        region_name
    from {{ ref('stg_region') }}
),

nation as (
    select 
        nation_id,
        nation_name,
        region_id
    from {{ ref('stg_nation') }}
),

location as (
    select
        n.nation_id, -- lo usamos como PK en la dimensión
        initcap(n.nation_name) as nation_name,
        initcap(r.region_name) as region_name
    from nation n
    inner join region r 
        on r.region_id = n.region_id
)

select * from location
