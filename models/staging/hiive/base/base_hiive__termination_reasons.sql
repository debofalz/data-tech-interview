WITH termination_reasons AS
  (
    SELECT
      "TRANSACTION_ID" as transaction_id
      , "TERMINATION_REASON" as termination_reason
      FROM {{source('raw', 'transaction_termination_reasons_seed')}}
  )

SELECT
*
FROM termination_reasons
