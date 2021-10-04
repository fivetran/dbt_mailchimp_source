{% macro get_unsubscribe_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "campaign_id", "datatype": dbt_utils.type_string()},
    {"name": "list_id", "datatype": dbt_utils.type_string()},
    {"name": "member_id", "datatype": dbt_utils.type_string()},
    {"name": "reason", "datatype": dbt_utils.type_int()},
    {"name": "timestamp", "datatype": dbt_utils.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}