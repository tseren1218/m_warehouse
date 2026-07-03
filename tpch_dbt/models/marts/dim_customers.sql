{{ config(
    tags=['daily'],
    pre_hook="insert into config.dbt_run_logs values (nextval('config.config_seq'), '{{ this.name }}', 'START', CURRENT_TIMESTAMP)",
    post_hook="insert into config.dbt_run_logs values (nextval('config.config_seq'), '{{ this.name }}', 'END', CURRENT_TIMESTAMP)"
) }}

with customers as (
    select * from {{ ref('int_customer_with_nation') }}
),

final as (
    select
        -- keys
        customer_id as customer_key,
       nation_id,
       region_id,

        -- attributes
        customer_name,
        customer_address,
        customer_phone,
        market_segment,
        nation_name, 
        region_name,

        -- financials
        account_balance,
        account_balance > 0     as is_positive_balance,
        market_segment = 'BUILDING' as is_building_segment

    from customers
)

select * from final