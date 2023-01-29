   {{
  config(
    materialized='table'
  )
}}
  
select r.product_id
    , r.order_id
    , r.user_id
    , p.name as product_name
    , session_id
    , r.created_at as event_created_at
    , sum(case when event_type = 'page_view' then 1 else 0 end) as product_page_view_ct
    , sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart_ct
from {{ ref('staging_postgres_events') }} r 
JOIN {{ ref('staging_postgres_products') }} p on p.product_id = r.product_id
group by 1,2,3,4,5,6