WITH stg_transaction_transitions AS
(
  SELECT *
  FROM {{ref('stg_hiive__transaction_transitions')}}
)

, transaction_transitions AS
(
  SELECT transition_id
  , transaction_id
  , transition_at
  , new_state
  , is_closed
  , ROW_NUMBER() OVER (PARTITION BY transaction_id,is_closed ORDER BY transition_at ASC) AS rank_state
  --rank state returns 1 for the first entry of an open or closed tranaction
  FROM stg_transaction_transitions
)

, opened_transactions AS
(
  SELECT transaction_id
  , transition_at AS opened_at
  , new_state AS opening_state
  FROM transaction_transitions
  WHERE is_closed = 0 AND rank_state = 1
--reduce table to return only the first open transaction information
)

, closed_transactions AS
(
  SELECT transaction_id
    , transition_at AS closed_at
    , new_state AS closing_state
  FROM transaction_transitions
  WHERE is_closed = 1 and rank_state = 1
--reduce table to retrun only the first closed transaction information
)

SELECT opened.*
  , closed.closed_at, closed.closing_state
FROM
opened_transactions opened
LEFT JOIN closed_transactions closed
ON opened.transaction_id = closed.transaction_id
