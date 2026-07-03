{{
    config(
        pre_hook="insert into config.dbt_run_logs values (nextval('config.config_seq'), '{{ this.name }}', 'START', CURRENT_TIMESTAMP)",
        post_hook="insert into config.dbt_run_logs values (nextval('config.config_seq'), '{{ this.name }}', 'END', CURRENT_TIMESTAMP)"
    )
}}

with source as (

    select *
    from {{ ref('scd_customer') }}

)

select
    c_custkey as customer_id,
    c_name as customer_name,
    c_address as customer_address,
    c_nationkey as nation_id,
    {{ clean_phone('c_phone') }} as customer_phone,
    c_acctbal as account_balance,
    'USD' as account_balance_currency,
    c_mktsegment as market_segment,
    c_comment as comment -- new comment
from source
where dbt_valid_to is null