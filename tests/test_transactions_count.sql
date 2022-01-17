select
    transaction_id,
    transaction_value
from {{ ref('transactions' )}}
group by 1, 2
having count(*) = 1