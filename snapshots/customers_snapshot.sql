{% snapshot customer_snapshot %}
    {{
        config(
            target_schema='snapshots',
            unique_key='customer_id',
            strategy='check',
            check_cols=['nation_id', 'phone', 'mkt_segment']
        )
    }}

    select * from {{ ref('dim_customer') }}

{% endsnapshot %}
