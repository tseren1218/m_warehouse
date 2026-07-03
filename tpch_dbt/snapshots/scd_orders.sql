{% snapshot scd_orders %}
{{ config(
    target_database='tpch',
    target_schema='snapshots',
    unique_key='order_id',
    strategy='check',
    check_cols=['order_priority', 'order_status', 'total_price']
) }}

select *
from {{ ref('stg_tpch__orders') }}


{% endsnapshot %}