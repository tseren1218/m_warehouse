with partsupp as (

    select * 
    from {{ ref('stg_tpch__partsupp') }}

),

part as (

    select * 
    from {{ ref('stg_tpch__part') }}

),

supplier as (

    select *
    from {{ ref('int_supplier_with_nation') }}

),

joined as (

    select
    -- keys
        ps.part_id,
        ps.supplier_id,

    -- partsupplier attributes
        ps.availqty as available_quantity,
        ps.supply_cost,
    
    -- part attributes
        p.name as part_name,
        p.manufacturer as part_manufacturer,
        p.brand as part_brand,
        p.type as part_type,
        p.size as part_size,
        p.container as part_container,
        p.retail_price,

    -- supplier attributes
        s.supplier_name,
        s.nation_name,
        s.region_name,

    -- derived metrics
        ps.availqty * ps.supply_cost as inventory_value

    from partsupp ps 
    inner join part p on ps.part_id = p.part_id
    inner join supplier s on ps.supplier_id = s.supplier_id
)

select *
from joined