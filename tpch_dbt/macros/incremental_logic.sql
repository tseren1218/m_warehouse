{% macro incremental_logic(watermark_column) %}
    {% set real_column = watermark_column  %}
    {% if is_incremental() %}
        {{ real_column }} > (select max({{ real_column }}) from {{ this }})
    {% else %}
        1=1
    {% endif %}
{% endmacro %}