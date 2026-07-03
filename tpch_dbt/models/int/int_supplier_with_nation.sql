with supplier as (

    select *
    from {{ ref('stg_tpch__supplier') }}

),

nation as (

    select * 
    from {{ ref('stg_tpch__nation') }}

),

region as (

    select * 
    from {{ ref('stg_tpch__region') }}

),

joined as (

    select
        -- keys
        s.supplier_id,
        n.nation_id,
        r.region_id,

        -- supplier attributes
        s.supplier_name,
        s.supplier_address,
        s.supplier_phone,
        s.account_balance,
        s.account_balance_currency,

        -- nation attributes
        n.nation_name,
        n.alpha_3 as nation_abbreviation,

        -- region attributes
        r.region_name

    from supplier s 
    inner join nation n on s.nation_id = n.nation_id
    inner join region r on n.region_id = r.region_id

)

select 
    *
from joined