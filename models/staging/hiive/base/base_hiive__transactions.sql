WITH transactions AS
(
  SELECT
    "ID" AS transaction_id
    , "BID_ID" AS bid_id
    , "STATE" as state
    , "TRANSFER_METHOD" AS transfer_method
    , "INSERTED_AT" AS inserted_at
    , "COMPANY_ID" AS company_id
    , "NUM_SHARES" AS num_shares
    , "PRICE_PER_SHARE" AS price_per_share
    , "GROSS_PROCEEDS" AS gross_proceeds
    , "_FIVETRAN_DELETED" AS _fivetran_deleted
    , "_FIVETRAN_SYNCED" AS _fivetran_synced
  FROM {{source('raw', 'transactions_seed')}}
)

SELECT
*
FROM transactions
