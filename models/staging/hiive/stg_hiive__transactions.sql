WITH base_transactions AS
(
  SELECT
  *
  FROM {{ref('base_hiive__transactions')}}
  WHERE  _fivetran_deleted = false
)

SELECT
*
,  {{is_closed('state')}} as is_closed
FROM base_transactions
