{{config(materialized='incremental', unique_key='transaction_id')}}

select transaction_id,transaction_value,actual_date
  from {{ ref('stg_transactions') }}
where 1 = 1
    {% if is_incremental() %}
and actual_date > (select max(actual_date) from {{this}})
    {% endif %}