[![Apache License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) ![dbt logo and version](https://img.shields.io/static/v1?logo=dbt&label=dbt-version&message=>=0.20.0&color=orange)
# Mailchimp (Source) 

This package models Mailchimp data from [Fivetran's connector](https://fivetran.com/docs/applications/mailchimp). It uses data in the format described by [this ERD](https://fivetran.com/docs/applications/mailchimp/#schemainformation).

This package enriches your Fivetran data by doing the following:
- Adds descriptions to tables and columns that are synced using Fivetran
- Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
- Models staging tables, which will be used in our transform package

## Models
This package contains staging models, designed to work simultaneously with our [Mailchimp modeling package](https://github.com/fivetran/dbt_mailchimp).  The staging models name columns consistently across all packages:
    - Boolean fields are prefixed with `is_` or `has_`
    - Timestamps are appended with `_at`
    - ID primary keys are prefixed with the name of the table.  For example, the `campaign` table's ID column is renamed `campaign_id`.
    - Foreign keys include the table that they refer to. For example, a campaign's `list` ID column is renamed `list_id`.

## Installation Instructions
Add the following to your `packages.yml` file:
```yml
# packages.yml
packages:
  - package: fivetran/mailchimp_source
    version: [">=0.3.0", "<0.4.0"]
```

Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

## Configuration
By default, this package looks for your Mailchimp data in the `mailchimp` schema of your [target database](https://docs.getdbt.com/docs/running-a-dbt-project/using-the-command-line-interface/configure-your-profile). If this is not where your Mailchimp data is, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
config-version: 2

vars:
    mailchimp_database: your_database_name
    mailchimp_schema: your_schema_name 
```


### Passthrough Columns

This package includes all of the source columns that are defined in the macros folder. We recommend including custom columns in this package because the staging models only bring in the standard columns for the `MEMBER` table.

You can add more columns using our passthrough column variables. These variables allow the passthrough columns to be aliased (`alias`) and casted (`transform_sql`) if you want, although it is not required. You can configure datatype casting by using a SQL snippet within the `transform_sql` key. You may add the desired SQL snippet while omitting the `as field_name` part of the casting statement - we rename this column with the alias attribute - and your custom passthrough columns will be casted accordingly.

Use the following format for declaring the respective passthrough variables (note to call the alias name, not original name, in the transform_sql):

```yml
# dbt_project.yml

vars:

  mailchimp__members_pass_through_columns:
    - name:           "custom_field_name"
      alias:          "normal_field_name"
      transform_sql:  "cast(normal_field_name as string)"
```


### Disabling models

It's possible that your Mailchimp connector does not sync every table that this package expects. If your syncs exclude certain tables, it is because you either don't use that functionality in Mailchimp or actively excluded some tables from your syncs. To disable the corresponding functionality in the package, you must add the relevant variables. By default, all variables are assumed to be `true`. Add variables for only the tables you would like to disable:  

```yml
# dbt_project.yml

...
config-version: 2

vars:
    usting_automations: false   # Disable if you are not using automations 
    
```

### Changing the Build Schema
By default this package will build the Mailchimp staging models within a schema titled (<target_schema> + `_stg_mailchimp`) in your target database. If this is not where you would like your Mailchimp staging data to be written to, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
models:
    mailchimp_source:
      +schema: my_new_schema_name # leave blank for just the target_schema
```

### Changing the Build Schema

By default, this package builds the Pendo staging models within a schema titled (`<target_schema>` + `_stg_mailchimp`) in your target database. If this is not where you would like your Mailchimp staging data to be written to, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
models:
    mailchimp_source:
        +schema: my_new_schema_name # leave blank for just the target_schema
```

> Note that if your profile does not have permissions to create schemas in your warehouse, you can set the `+schema` to blank. The package will then write all tables to your pre-existing target schema.

## Contributions
Additional contributions to this package are very welcome! Please create issues
or open PRs against `master`. Check out 
[this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) 
on the best workflow for contributing to a package.

## Database Support
This package has been tested on BigQuery, Snowflake, Redshift, and Postgres.

## Resources:
- Provide [feedback](https://www.surveymonkey.com/r/DQ7K7WW) on our existing dbt packages or what you'd like to see next
- Have questions or feedback, or need help? Book a time during our office hours [here](https://calendly.com/fivetran-solutions-team/fivetran-solutions-team-office-hours) or email us at solutions@fivetran.com.
- Find all of Fivetran's pre-built dbt packages in our [dbt hub](https://hub.getdbt.com/fivetran/)
- Learn how to orchestrate dbt transformations with Fivetran [here](https://fivetran.com/docs/transformations/dbt).
- Learn more about Fivetran overall [in our docs](https://fivetran.com/docs)
- Check out [Fivetran's blog](https://fivetran.com/blog)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the dbt blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
