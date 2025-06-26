# Mailchimp Source dbt Package ([Docs](https://fivetran.github.io/dbt_mailchimp_source/))

<p align="left">
    <a alt="License"
        href="https://github.com/fivetran/dbt_mailchimp_source/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" /></a>
    <a alt="dbt-core">
        <img src="https://img.shields.io/badge/dbt_Core™_version->=1.3.0_<2.0.0-orange.svg" /></a>
    <a alt="Maintained?">
        <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" /></a>
    <a alt="PRs">
        <img src="https://img.shields.io/badge/Contributions-welcome-blueviolet" /></a>
</p>

## What does this dbt package do?
- Materializes [Mailchimp staging tables](https://fivetran.github.io/dbt_mailchimp_source/#!/overview/mailchimp_source/models/?g_v=1) which leverage data in the format described by [this ERD](https://fivetran.com/docs/applications/mailchimp/#schemainformation). These staging tables clean, test, and prepare your Mailchimp data from [Fivetran's connector](https://fivetran.com/docs/applications/mailchimp) for analysis by doing the following:
  - Name columns for consistency across all packages and for easier analysis
  - Adds freshness tests to source data
    - dbt Core >= 1.9.6 is required to run freshness tests out of the box.
  - Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
- Generates a comprehensive data dictionary of your Mailchimp data through the [dbt docs site](https://fivetran.github.io/dbt_mailchimp_source/).
- These tables are designed to work simultaneously with our [Mailchimp transformation package](https://github.com/fivetran/dbt_mailchimp).

## How do I use the dbt package?
### Step 1: Prerequisites
To use this dbt package, you must have the following:
- At least one Fivetran Mailchimp connection syncing data into your destination.
- A **BigQuery**, **Snowflake**, **Redshift**, **PostgreSQL**, or **Databricks** destination.

#### Databricks dispatch configuration
If you are using a Databricks destination with this package, you must add the following (or a variation of the following) dispatch configuration within your `dbt_project.yml`. This is required in order for the package to accurately search for macros within the `dbt-labs/spark_utils` then the `dbt-labs/dbt_utils` packages respectively.
```yml
dispatch:
  - macro_namespace: dbt_utils
    search_order: ['spark_utils', 'dbt_utils']
```

### Step 2: Install the package (skip if also using the `mailchimp` transformation package)
If you  are **NOT** using the [Mailchimp transformation package](https://github.com/fivetran/dbt_mailchimp), include the following package version in your `packages.yml` file. If you are installing the transform package, the source package is automatically installed as a dependency.
> TIP: Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.
```yml
packages:
  - package: fivetran/mailchimp_source
    version: [">=0.8.0", "<0.9.0"] # we recommend using ranges to capture non-breaking changes automatically
```

### Step 3: Define database and schema variables
By default, this package runs using your destination and the `mailchimp` schema. If this is not where your Mailchimp data is (for example, if your Mailchimp schema is named `mailchimp_fivetran`), add the following configuration to your root `dbt_project.yml` file:

```yml
vars:
    mailchimp_database: your_database_name
    mailchimp_schema: your_schema_name 
```

### Step 4: Disable models for non-existent sources
Your Mailchimp connection may not sync every table that this package expects. If your syncs exclude certain tables, it is because you either do not use that functionality in Mailchimp or actively excluded some tables from your syncs. To disable the corresponding functionality in the package, you must set the relevant config variables to `false`. By default, all variables are set to `true`. Alter variables for only the tables you want to disable:

```yml
vars:
  mailchimp_using_automations: false #disable if you do not have the automation_email, automation_email, or automation_recipient_activity tables
  mailchimp_using_segments: false #disable if you do not have the segment or segment_member table
  mailchimp_using_unsubscribes: false #disable if you do not have the unsubscribe table
```

### (Optional) Step 5: Additional configurations
<details open><summary>Expand/collapse configurations</summary>

#### Changing the Build Schema
By default, this package builds the Mailchimp staging models within a schema titled (`<target_schema>` + `_stg_mailchimp`) in your destination. If this is not where you would like your Mailchimp staging data to be written to, add the following configuration to your root `dbt_project.yml` file:

```yml
models:
    mailchimp_source:
      +schema: my_new_schema_name # leave blank for just the target_schema
```

#### Change the source table references
If an individual source table has a different name than the package expects, add the table name as it appears in your destination to the respective variable:
> IMPORTANT: See this project's [`dbt_project.yml`](https://github.com/fivetran/dbt_mailchimp_source/blob/main/dbt_project.yml) variable declarations to see the expected names.
    
```yml
vars:
    mailchimp_<default_source_table_name>_identifier: your_table_name 
```

#### Passthrough Columns

This package includes all of the source columns that are defined in the macros folder. We recommend including custom columns in this package because the staging models only bring in the standard columns for the `MEMBER` table.

You can add more columns using our passthrough column variables. These variables allow the passthrough columns to be aliased (`alias`) and casted (`transform_sql`) if you want, although it is not required. You can configure datatype casting by using a SQL snippet within the `transform_sql` key. You may add the desired SQL snippet while omitting the `as field_name` part of the casting statement - we rename this column with the alias attribute - and your custom passthrough columns will be casted accordingly.

Use the following format for declaring the respective passthrough variables (note to call the alias name, not original name, in the transform_sql):

```yml
vars:
  mailchimp__members_pass_through_columns:
    - name:           "custom_field_name"
      alias:          "normal_field_name"
      transform_sql:  "cast(normal_field_name as string)"
```
</details>

### (Optional) Step 6: Orchestrate your models with Fivetran Transformations for dbt Core™
<details><summary>Expand to view details</summary>
<br>
    
Fivetran offers the ability for you to orchestrate your dbt project through [Fivetran Transformations for dbt Core™](https://fivetran.com/docs/transformations/dbt). Learn how to set up your project for orchestration through Fivetran in our [Transformations for dbt Core™ setup guides](https://fivetran.com/docs/transformations/dbt#setupguide).
</details>

## Does this package have dependencies?
This dbt package is dependent on the following dbt packages. These dependencies are installed by default within this package. For more information on the following packages, refer to the [dbt hub](https://hub.getdbt.com/) site.
> IMPORTANT: If you have any of these dependent packages in your own `packages.yml` file, we highly recommend that you remove them from your root `packages.yml` to avoid package version conflicts.
    
```yml
packages:
    - package: fivetran/fivetran_utils
      version: [">=0.4.0", "<0.5.0"]

    - package: dbt-labs/dbt_utils
      version: [">=1.0.0", "<2.0.0"]
```

## How is this package maintained and can I contribute?
### Package Maintenance
The Fivetran team maintaining this package _only_ maintains the latest version of the package. We highly recommend that you stay consistent with the [latest version](https://hub.getdbt.com/fivetran/mailchimp_source/latest/) of the package and refer to the [CHANGELOG](https://github.com/fivetran/dbt_mailchimp_source/blob/main/CHANGELOG.md) and release notes for more information on changes across versions.

### Contributions
A small team of analytics engineers at Fivetran develops these dbt packages. However, the packages are made better by community contributions.

We highly encourage and welcome contributions to this package. Check out [this dbt Discourse article](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) to learn how to contribute to a dbt package.

## Are there any resources available?
- If you have questions or want to reach out for help, see the [GitHub Issue](https://github.com/fivetran/dbt_mailchimp_source/issues/new/choose) section to find the right avenue of support for you.
- If you would like to provide feedback to the dbt package team at Fivetran or would like to request a new dbt package, fill out our [Feedback Form](https://www.surveymonkey.com/r/DQ7K7WW).
