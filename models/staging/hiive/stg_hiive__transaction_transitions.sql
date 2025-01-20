WITH base_transaction_transitions AS
(
  SELECT
  *
  FROM {{ref('base_hiive__transaction_transitions')}}
  WHERE  _fivetran_deleted = false
)

SELECT
*
,  {{is_closed('new_state')}} as is_closed
FROM base_transaction_transitions
