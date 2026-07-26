with 
source as (
    select * from {{ source('stripe', 'payment') }} 
),

renamed as (
    select 
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        amount as payment_amount,
        status as payment_status,
        created as payment_created,
        _batched_at
    from source
)
select * from renamed