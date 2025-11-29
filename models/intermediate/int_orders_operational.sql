select 
om.orders_id,
om.date_date,
om.margin + s.shipping_fee - s.logcost - s.ship_cost as opertional_margin
from {{ ref('int_orders_margin') }} as om
left join {{ ref('stg_gz_raw_data__raw_gz_ship') }} as s
on om.orders_id = s.orders_id