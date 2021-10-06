{{ config(enabled=var('using_automations', True)) }}

select * from {{ var('campaign_recipient_activity') }}
