with customer as (

    select *
    from {{ ref('stg_tpch__customer') }}

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
        c.customer_id,
        n.nation_id,
        r.region_id,

        -- customer attributes
        c.customer_name,
        c.customer_address,
        c.customer_phone,
        c.account_balance,
        c.account_balance_currency,
        c.market_segment,

        -- nation attributes
        n.nation_name,
        n.alpha_3 as nation_abbreviation,

        -- region attributes
        r.region_name

    from customer c 
    inner join nation n on c.nation_id = n.nation_id
    inner join region r on n.region_id = r.region_id

)

select 
    *
from joined