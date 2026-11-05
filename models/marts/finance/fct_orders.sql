with payments_grouped as (

    select 
        order_id,
        SUM(amount) as amount

    from {{ ref('stg_stripe__payments') }}

    group by order_id

),

orders as ( 

    select order_id, customer_id from {{ ref('stg_jaffle_shop__orders') }}

),

final as (

    select 
        orders.order_id,
        orders.customer_id,
        payments_grouped.amount

    from orders

    left join payments_grouped using (order_id)

)

select * from final