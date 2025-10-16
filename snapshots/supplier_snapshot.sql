{% snapshot supplier_snapshot %}
    {{
        config(
            target_schema='snapshots',
            unique_key='supplier_id',
            strategy='check',
            check_cols=['nation_id', 'phone']
        )
    }}

    select * from {{ ref('dim_supplier') }}

{% endsnapshot %}
