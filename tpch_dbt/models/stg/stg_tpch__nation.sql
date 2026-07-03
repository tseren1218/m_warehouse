with source as (
    select
        * 
    from {{ source('tpch', 'nation') }}
),

csv_data as (

    select
        name,
        "alpha-2" as alpha_2,
        "alpha-3" as alpha_3,
        "iso_3166-2" as iso_code
    from {{ source('tpch', 'country_iso_code') }}

)

select 
    s.n_nationkey as nation_id,
    s.n_name as nation_name,
    s.n_regionkey as region_id,
    c.alpha_2,
    c.alpha_3,
    c.iso_code,
    s.n_comment as comment
from source s
left join csv_data c on lower(s.n_name) = lower(c.name)
