select
    order_id,
    order_date
from {{ ref('fact_orders') }}
where order_date > current_timestamp