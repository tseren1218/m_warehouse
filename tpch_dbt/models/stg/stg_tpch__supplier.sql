with source as (

    select *
    from {{ source('tpch', 'supplier') }}

)

select
    s_suppkey as supplier_id, 
    s_name as supplier_name, 
    s_address as supplier_address,
    s_nationkey as nation_id,
    {{ clean_phone('s_phone') }} as supplier_phone,
    s_acctbal as account_balance,
    'USD' as account_balance_currency,
    s_comment as comment
from source