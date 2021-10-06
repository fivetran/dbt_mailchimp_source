{{ config(enabled=var('using_automations', True)) }}

select * from {{ var('campaign') }}