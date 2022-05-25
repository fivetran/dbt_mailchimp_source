{{ config(enabled=var('mailchimp_using_segments', True)) }}

with base as (

    select * 
    from {{ ref('stg_mailchimp__segment_members_tmp') }}

),


fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_mailchimp__segment_members_tmp')),
                staging_columns=get_segment_member_columns()
            )
        }}
        
    from base

), 

final as (

    select
        segment_id,
        member_id,
        list_id
    from fields

), unique_key as (

    select 
        *, 
        {{ dbt_utils.surrogate_key(['segment_id','member_id']) }} as segment_member_id
    from final

)

select *
from unique_key
