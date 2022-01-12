# dbt_mailchimp_source v0.4.0

## 🚨 Breaking Change 🚨
- Added unique key fields and respective tests to `stg_mailchimp__segment_members` and `stg_mailchimp__members`.
## Contributors
- @CraigWilson-ZOE ([#24](https://github.com/fivetran/dbt_mailchimp/issues/24)).

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
