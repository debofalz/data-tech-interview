WITH base_termination_reasons AS
  (
  SELECT
  *
  FROM {{ref('base_hiive__termination_reasons')}}
  )

SELECT
*
FROM base_termination_reasons
