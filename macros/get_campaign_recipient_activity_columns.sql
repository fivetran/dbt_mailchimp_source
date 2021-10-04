{% macro get_campaign_recipient_activity_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "action", "datatype": dbt_utils.type_string()},
    {"name": "bounce_type", "datatype": dbt_utils.type_int()},
    {"name": "campaign_id", "datatype": dbt_utils.type_string()},
    {"name": "combination_id", "datatype": dbt_utils.type_int()},
    {"name": "ip", "datatype": dbt_utils.type_string()},
    {"name": "list_id", "datatype": dbt_utils.type_string()},
    {"name": "member_id", "datatype": dbt_utils.type_string()},
    {"name": "timestamp", "datatype": dbt_utils.type_timestamp()},
    {"name": "url", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}