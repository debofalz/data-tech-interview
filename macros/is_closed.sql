{% macro is_closed(new_state_column) %}
  CASE
      WHEN {{ new_state_column }} IN ('approval_declined', 'cancelled', 'closed_paid', 'expired')
      THEN 1
      ELSE 0
  END
{% endmacro %}
