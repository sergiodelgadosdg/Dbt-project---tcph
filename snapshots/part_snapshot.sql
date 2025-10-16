{% snapshot part_snapshot %}
    {{
        config(
            target_schema='snapshots',
            unique_key='part_id',
            strategy='check',
            check_cols=['name', 'brand_id', 'category', 'finish', 'material', 'size', 'container', 'retail_price']
        )
    }}

    select * from {{ ref('dim_part') }}

{% endsnapshot %}
