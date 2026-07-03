
{% set priorities = dbt_utils.get_column_values(table=ref('int_order_items'), column='order_priority') %}

with order_items as (

    select *
    from {{ ref('int_order_items') }}

)
select 
    order_id,
    {% for priority in priorities %}
        SUM(case when order_priority = '{{ priority }}' then gross_price else 0 end) as revenue_by_{{ priority | replace(" ", "_") | replace("-", "_") | lower }},
    {% endfor %}
from order_items
group by 1