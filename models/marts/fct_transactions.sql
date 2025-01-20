WITH stg_transactions AS
(
  SELECT *
  FROM {{ref('stg_hiive__transactions')}}
)

, stg_termination_reasons as
(
  SELECT *
  FROM {{ref('stg_hiive__termination_reasons')}}
)

, int_transaction_transitions as
(
SELECT *
FROM {{ref('int_hiive__transaction_transitions')}}
)

, final AS
(
  SELECT
    transactions.transaction_id
    , transactions.bid_id
    , transactions.state
    , transactions.is_closed
    , transactions.transfer_method
    , transactions.company_id
    , transactions.num_shares
    , transactions.price_per_share
    , transactions.gross_proceeds
    , transitions.opened_at
    , transitions.closed_at
    , COALESCE(date(closed_at), current_date) - date(opened_at) AS days_open
    , transitions.opening_state
    , transitions.closing_state
    , reasons.termination_reason
  FROM stg_transactions transactions
  LEFT JOIN int_transaction_transitions transitions
    ON transactions.transaction_id = transitions.transaction_id
  LEFT JOIN stg_termination_reasons reasons
    ON transactions.transaction_id = reasons.transaction_id
)

SELECT  *
FROM final
