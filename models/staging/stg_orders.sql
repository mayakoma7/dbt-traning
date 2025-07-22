select 
-- from raw orders
    {{ dbt_utils.generate_surrogate_key(['o.orderid', 'c.customerid','p.productid']) }} as sk_orders,
    o.orderid,
    o.orderdate,
    o.shipdate,
    o.shipmode,
    o.ordersellingprice - o.ordercost as orderprofit,
    o.ordercost,
    o.ordersellingprice,
-- from raw customer
    c.customerid,
    c.customername,
    c.segment,
    c.country,
-- from raw product
    p.productid,
    p.CATEGORY,
    p.productname,
    p.subcategory,
    {{ markup('ordersellingprice', 'ordercost')}} as markup
    
from {{ ref('raw_orders') }} as o
    left join {{ ref('raw_customer') }} as c on o.customerid = c.customerid
    left join {{ ref('raw_product') }} as p on p.productid = o.productid


   