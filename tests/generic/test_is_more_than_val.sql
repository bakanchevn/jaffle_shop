{% test is_more_than_val(model, column_name, value, strict=false) %}

with validation as (
    select {{ column_name }} as spec_field
      from {{ model }}
),
validation_errors as (
    select spec_field
    from validation
    {% if strict %}
    where not (spec_field > {{value}})
    {% else %}
    where not (spec_field >= {{value}})
    {% endif %}
)
select *
from validation_errors
{% endtest %}