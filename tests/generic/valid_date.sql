{% test valid_date(model, column_name) %}
select *
from {{ model }}
where {{ column_name }} < '1992-01-01'
   or {{ column_name }} > current_date()
{% endtest %}