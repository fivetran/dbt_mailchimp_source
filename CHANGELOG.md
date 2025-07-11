# dbt_mailchimp_source v0.8.0

[PR #27](https://github.com/fivetran/dbt_mailchimp_source/pull/27) includes the following updates:

## Breaking Change for dbt Core < 1.9.6

> *Note: This is not relevant to Fivetran Quickstart users.*

Migrated `freshness` from a top-level source property to a source `config` in alignment with [recent updates](https://github.com/dbt-labs/dbt-core/issues/11506) from dbt Core. This will resolve the following deprecation warning that users running dbt >= 1.9.6 may have received:

```
[WARNING]: Deprecated functionality
Found `freshness` as a top-level property of `mailchimp` in file
`models/src_mailchimp.yml`. The `freshness` top-level property should be moved
into the `config` of `mailchimp`.
```

**IMPORTANT:** Users running dbt Core < 1.9.6 will not be able to utilize freshness tests in this release or any subsequent releases, as older versions of dbt will not recognize freshness as a source `config` and therefore not run the tests.

If you are using dbt Core < 1.9.6 and want to continue running Mailchimp freshness tests, please elect **one** of the following options:
  1. (Recommended) Upgrade to dbt Core >= 1.9.6
  2. Do not upgrade your installed version of the `mailchimp_source` package. Pin your dependency on v0.7.0 in your `packages.yml` file.
  3. Utilize a dbt [override](https://docs.getdbt.com/reference/resource-properties/overrides) to overwrite the package's `mailchimp` source and apply freshness via the previous release top-level property route. This will require you to copy and paste the entirety of the previous release `src_mailchimp.yml` file and add an `overrides: mailchimp_source` property.

## Under the Hood
- Updates to ensure integration tests use latest version of dbt.
# dbt_mailchimp_source v0.7.0
This release includes the following updates.

## Schema Changes

**1 total change • 1 possible breaking change**
| **Model/Column** | **Change type** | **Old materialization** | **New materialization** | **Notes** |
| ---------------- | --------------- | ------------ | ------------ | --------- |
| [*_tmp](https://github.com/fivetran/dbt_mailchimp_source/tree/main/models/tmp) Models | New Materialization | Table  | View | Fixed the materialization config in the `dbt_project.yml` to ensure staging `*_tmp` models are materialized as views rather than tables. **This is a breaking change and will require a `dbt run --full-refresh`.** ([#25](https://github.com/fivetran/dbt_mailchimp_source/pull/25)) |

## Under the Hood
- Updated the package maintainer pull request template. ([#25](https://github.com/fivetran/dbt_mailchimp_source/pull/25)) 
- Updated the triggers for the `auto-release` GitHub Action workflow. ([#25](https://github.com/fivetran/dbt_mailchimp_source/pull/25))
- Added the `generate-docs` GitHub Action workflow. ([#26](https://github.com/fivetran/dbt_mailchimp_source/pull/26))

## Documentation
- Corrected references to connectors and connections in the README. ([#23](https://github.com/fivetran/dbt_mailchimp_source/pull/23))

## Under the hood
- Added the `generate-docs` GitHub Action Workflow. ([#26](https://github.com/fivetran/dbt_mailchimp_source/pull/26))

# dbt_mailchimp_source v0.6.0
[PR #22](https://github.com/fivetran/dbt_mailchimp_source/pull/22) includes the following updates:

## Breaking Changes
- Added the ability to disable the `unsubscribe` source and the `stg_mailchimp__unsubscribes` model by setting the `mailchimp_using_unsubscribes` variable in your `dbt_project.yml`. 
  - For details on configuring this variable, refer to the [README](https://github.com/fivetran/dbt_mailchimp_source/blob/main/README.md#step-4-disable-models-for-non-existent-sources).

# dbt_mailchimp_source v0.5.2
[PR #19](https://github.com/fivetran/dbt_mailchimp_source/pull/19) includes the following updates:

## 🐛 Bug Fixes 🔨
- Cast `activity_timestamp` in `stg_mailchimp__campaign_activities` and `send_timestamp` in `stg_mailchimp__campaigns` to `dbt.type_timestamp()`. This ensures the `dbt.datediff()` function in the `mailchimp__campaign_activities` model in the `dbt_mailchimp` package properly runs in Redshift.
- Corrected source freshness variables to properly reference `mailchimp_using_automations`.

## 🧪 Test Updates 🧪
- Updated the source freshness test enablement/disablement to leverage the dbt-core `config: enabled:` architecture.
- Added source freshness tests for models utilizing the `mailchimp_using_segments` variable.

## 🚘 Under the Hood 🚘 
- Updated the pull request [templates](/.github). 
- Included auto-releaser GitHub Actions workflow to automate future releases.

# dbt_mailchimp_source v0.5.1
[PR #17](https://github.com/fivetran/dbt_mailchimp_source/pull/17) includes the following updates:
## 🎉 Feature Update
- Updates the unique test for `stg_mailchimp__members` to include both `member_id` and `list_id`, as these make up the unique key for the respective source table.

## Under the Hood:
- Updates the seed data used in integration testing to include a new record for an existing `member_id` with a new `list_id`.

# dbt_mailchimp_source v0.5.0
## 🎉 Feature Update
- Databricks compatibility! ([#15](https://github.com/fivetran/dbt_mailchimp_source/pull/15))
## Under the Hood:
- Incorporated the new `fivetran_utils.drop_schemas_automation` macro into the end of each Buildkite integration test job. ([#14](https://github.com/fivetran/dbt_mailchimp_source/pull/14))
- Updated the pull request [templates](/.github). ([#14](https://github.com/fivetran/dbt_mailchimp_source/pull/14))

# dbt_mailchimp_source v0.4.0
[PR #12](https://github.com/fivetran/dbt_mailchimp_source/pull/12) includes the following breaking changes:
## 🚨 Breaking Changes 🚨:
- Dispatch update for dbt-utils to dbt-core cross-db macros migration. Specifically `{{ dbt_utils.<macro> }}` have been updated to `{{ dbt.<macro> }}` for the below macros:
    - `any_value`
    - `bool_or`
    - `cast_bool_to_text`
    - `concat`
    - `date_trunc`
    - `dateadd`
    - `datediff`
    - `escape_single_quotes`
    - `except`
    - `hash`
    - `intersect`
    - `last_day`
    - `length`
    - `listagg`
    - `position`
    - `replace`
    - `right`
    - `safe_cast`
    - `split_part`
    - `string_literal`
    - `type_bigint`
    - `type_float`
    - `type_int`
    - `type_numeric`
    - `type_string`
    - `type_timestamp`
    - `array_append`
    - `array_concat`
    - `array_construct`
- For `current_timestamp` and `current_timestamp_in_utc` macros, the dispatch AND the macro names have been updated to the below, respectively:
    - `dbt.current_timestamp_backcompat`
    - `dbt.current_timestamp_in_utc_backcompat`
- `dbt_utils.surrogate_key` has also been updated to `dbt_utils.generate_surrogate_key`. Since the method for creating surrogate keys differ, we suggest all users do a `full-refresh` for the most accurate data. For more information, please refer to dbt-utils [release notes](https://github.com/dbt-labs/dbt-utils/releases) for this update.
- Dependencies on `fivetran/fivetran_utils` have been upgraded, previously `[">=0.3.0", "<0.4.0"]` now `[">=0.4.0", "<0.5.0"]`.
## 🎉 Documentation and Feature Updates 🎉:
- Updated README documentation for easier navigation and dbt package setup.
- Included the `mailchimp_[source_table_name]_identifier` variables for easier flexibility of the package models to refer to differently named sources tables.

# dbt_mailchimp_source v0.3.0
🎉 dbt v1.0.0 Compatibility 🎉
## 🚨 Breaking Changes 🚨
- Adjusts the `require-dbt-version` to now be within the range [">=1.0.0", "<2.0.0"]. Additionally, the package has been updated for dbt v1.0.0 compatibility. If you are using a dbt version <1.0.0, you will need to upgrade in order to leverage the latest version of the package.
  - For help upgrading your package, I recommend reviewing this GitHub repo's Release Notes on what changes have been implemented since your last upgrade.
  - For help upgrading your dbt project to dbt v1.0.0, I recommend reviewing dbt-labs [upgrading to 1.0.0 docs](https://docs.getdbt.com/docs/guides/migration-guide/upgrading-to-1-0-0) for more details on what changes must be made.
- Upgrades the package dependency to refer to the latest `dbt_fivetran_utils`. The latest `dbt_fivetran_utils` package also has a dependency on `dbt_utils` [">=0.8.0", "<0.9.0"].
  - Please note, if you are installing a version of `dbt_utils` in your `packages.yml` that is not in the range above then you will encounter a package dependency error.

# dbt_mailchimp_source v0.2.0

## 🚨 Breaking Change 🚨
- Updating src_mailchimp database variable to reflect README files. Update `database` to `mailchimp_database`.([#7](https://github.com/fivetran/dbt_mailchimp_source/pull/8)).

## Contributors
- @dfagnan ([#7](https://github.com/fivetran/dbt_mailchimp_source/pull/8)).

# dbt_mailchimp_source v0.1.0

## Initial Release
- This is the initial release of this package. For more information refer to the [README](/README.md).
