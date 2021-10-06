{{ config(enabled=var('using_automations', True)) }}

select * from {{ var('segment_member') }}