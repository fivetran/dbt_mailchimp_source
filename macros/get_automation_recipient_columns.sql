{% macro get_automation_recipient_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "automation_email_id", "datatype": dbt_utils.type_string()},
    {"name": "list_id", "datatype": dbt_utils.type_string()},
    {"name": "member_id", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}