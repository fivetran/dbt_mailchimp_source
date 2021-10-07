{% macro get_segment_member_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "list_id", "datatype": dbt_utils.type_string()},
    {"name": "member_id", "datatype": dbt_utils.type_string()},
    {"name": "segment_id", "datatype": dbt_utils.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}