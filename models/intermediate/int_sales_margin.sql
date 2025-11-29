with

sales as (
    select *
    from {{ ref('stg_gz_raw_data__raw_gz_sales') }}
),

product as (
    select
        products_id,
        purchase_price
    from {{ ref('stg_gz_raw_data__raw_gz_product') }}
)
,joined as (
    select
        s.date_date,
        s.orders_id,
        s.product_id,
        s.quantity,
        s.revenue,
        p.purchase_price
    from sales as  s
    left join product as p
        on s.product_id = p.products_id
)
,final as (
    select
        date_date,
        orders_id,
        product_id,
        quantity,
        revenue,
        purchase_price,

        -- custo de compra
        quantity * purchase_price                  as purchase_cost,

        -- margem
        revenue - (quantity * purchase_price)      as margin
    from joined
)

select *
from final