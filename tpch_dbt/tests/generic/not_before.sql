{% test not_before(model, column_name, compare_column) %}

with validation as (

    select
        {{ column_name }} as later_value,
        {{ compare_column }} as earlier_value
    from {{ model }}

)

select *
from validation
where later_value is not null
  and earlier_value is not null
  and later_value < earlier_value

{% endtest %}
