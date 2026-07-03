{% macro clean_phone(phone) %}
    regexp_replace({{ phone }}, '[^0-9]', '', 'g')
{% endmacro %}