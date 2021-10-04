{% macro get_automation_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "create_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "list_id", "datatype": dbt_utils.type_string()},
    {"name": "segment_id", "datatype": dbt_utils.type_int()},
    {"name": "segment_text", "datatype": dbt_utils.type_int()},
    {"name": "start_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "title", "datatype": dbt_utils.type_string()},
    {"name": "trigger_settings", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}