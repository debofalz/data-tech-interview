WITH transaction_transitions AS
(
  SELECT
    "ID" AS transition_id
    , "INSERTED_AT" AS inserted_at
    , "UPDATED_AT" AS updated_at
    , "TRANSACTION_ID" AS transaction_id
    , "NEW_STATE" AS new_state
    , "TRANSITIONED_AT" AS transition_at
    , "_FIVETRAN_DELETED" AS _fivetran_deleted
    , "_FIVETRAN_SYNCED" AS _fivetran_synced
  FROM {{source('raw', 'transaction_transitions_seed')}} 
)

SELECT *
FROM transaction_transitions
