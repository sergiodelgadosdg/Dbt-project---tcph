{% test date_after_1992(model, column_name) %}
    select *
    from {{ model }}
    where {{ column_name }} < '1992-01-01'
{% endtest %}