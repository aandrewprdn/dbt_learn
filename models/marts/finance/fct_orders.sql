with
payment as (
    select * from {{ ref('stg_stripe__payment') }}
),
orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
),
order_payments as (
    select
        order_id,
        sum((case when payment_status = 'success' then payment_amount end)) as amount
    from payment
    group by order_id
),
final as (
    select
        order_id,
        customer_id,
        order_date,
        coalesce(order_payments.amount, 0) as amount
    from orders
    left join order_payments using (order_id)
)
select * from final
