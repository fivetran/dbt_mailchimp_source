{% macro get_member_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "country_code", "datatype": dbt_utils.type_string()},
    {"name": "dstoff", "datatype": dbt_utils.type_float()},
    {"name": "email_address", "datatype": dbt_utils.type_string()},
    {"name": "email_client", "datatype": dbt_utils.type_string()},
    {"name": "email_type", "datatype": dbt_utils.type_string()},
    {"name": "gmtoff", "datatype": dbt_utils.type_float()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "ip_opt", "datatype": dbt_utils.type_string()},
    {"name": "ip_signup", "datatype": dbt_utils.type_string()},
    {"name": "language", "datatype": dbt_utils.type_string()},
    {"name": "last_changed", "datatype": dbt_utils.type_timestamp()},
    {"name": "latitude", "datatype": dbt_utils.type_float()},
    {"name": "list_id", "datatype": dbt_utils.type_string()},
    {"name": "longitude", "datatype": dbt_utils.type_float()},
    {"name": "member_rating", "datatype": dbt_utils.type_int()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "timestamp_opt", "datatype": dbt_utils.type_timestamp()},
    {"name": "timestamp_signup", "datatype": dbt_utils.type_timestamp()},
    {"name": "timezone", "datatype": dbt_utils.type_string()},
    {"name": "unique_email_id", "datatype": dbt_utils.type_string()},
    {"name": "vip", "datatype": "boolean"}
] %}

{{ return(columns) }}

{% endmacro %}