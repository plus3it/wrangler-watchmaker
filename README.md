# wrangler-watchmaker
Manages public buckets and files needed for the default `watchmaker`
configuration.

This project uses `dev` and `release` pipelines to manage the public files and
other content needed for `watchmaker`, when using its default/public
configuration. All resources in the pipelines are defined in terraform
configurations and managed using terragrunt.

The `dev` pipeline is currently executed manually, and the `release` pipeline
executes automatically whenever the project version is bumped.

This project uses `terragrunt` to manage the backend for terraform state,
and to reduce boilerplate code duplication in terraform root modules.

Terragrunt is a simple wrapper around terraform... On the command line,
options passed to terragrunt are passed through to terraform. Commands you
would call as `terraform ...` you can instead just call as `terragrunt ...`.

Terragrunt will create a cache folder in its working directory, copy the root
module there, execute terragrunt hooks, and use `terraform init` to pull in
external modules and plugins. In some ways, Terragrunt is a bit like a Python
virtualenv, in that it isolates the working environment from the rest of the
system.

## Dev pipeline

The `dev` pipeline consists of three configurations: bucket, files-repo, and
salt-repo.

### Dev configurations

The bucket configuration creates an S3 bucket and applies a bucket policy.

The files-repo configuration retrieves files from various http/s, s3, or local
sources and places them in the S3 bucket.

The salt-repo configuration uses `rsync` to mirror the SaltStack yum repo
locally, and the `aws` cli to sync that repo to the S3 bucket.

### Dev workflows

There are three typical `dev` workflows: add/modify the file repo, add/modify
salt versions, and execute terraform/terragrunt to apply the updated
configurations.

After updating the file repo or salt version, commit the change and open a pull
request. The change will be reviewed and merged. Once merged, a project
maintainer will execute the third workflow to update the bucket contents.

#### Updating the dev file repo

To modify the file repo, update the `uri_map` in the
[dev files-repo configuration](dev/files-repo/wrangler.auto.tfvars). The left
side of the map (the key) represents the URI that will be retrieved. The right
side of the map (the value) is the path in the S3 Bucket where the file will be
stored.

#### Updating the dev salt repo

To modify the salt versions, update `salt_version` and/or `extra_salt_versions`
in the [dev salt-repo module](dev/salt-repo/wrangler.auto.tfvars).
`salt_version` specifies the version of salt that will be used in the yum repo
definition file hosted at an "unversioned" URI. `extra_salt_versions` is a list
of additional salt versions to retrieve. These versions will get yum repo
definition files with versioned URIs.

#### Apply the dev configurations

This workflow should be executed only _after_ updating the file repo or salt
repo configurations, and after the change has been reviewed and merged to the
master branch.

To execute terraform/terragrunt to update the bucket contents, checkout the
master branch, update it from upstream, export the environment variables used
by terragrunt for the backend state, and use the `deploy.dev` make target:

```
git checkout master
git pull upstream master
export WRANGLER_BUCKET=<wrangler-state-bucket>
export WRANGLER_DDB_TABLE=<wrangler-state-ddb>
export AWS_DEFAULT_REGION=<region>
make deploy.dev DEV_BUCKET=<dev-bucket>
```

## Release pipeline

The `release` pipeline also consists of three configurations: bucket,
copy-bucket, and salt-yum-defs.

Execution of the `release` pipeline is handled automatically by the build
system. It is initiated when the version is bumped. This project uses
[bumpversion](https://github.com/c4urself/bump2version) to manage project
versioning.

The execution of the pipeline then is simple: use `bumpversion` to increment
the version, open a pull request, and if/when merged the build system will
handle the rest.

### Release configurations

The bucket configuration creates an S3 bucket and applies a bucket policy.

The copy-bucket configuration copies files from the `dev` bucket to the
`release` bucket. This is structured to include the file repo and the salt
repo, but _not_ the `dev` salt yum definitions (since they point at the `dev`
bucket).

The salt-yum-defs configuration creates yum definitions for the salt repo that
point to the `release` bucket.

### Release workflows

There is really only one `release` workflow: managing the salt version.

#### Update the release salt version

This is very similar to the corresponding `dev` workflow, but only creates the
yum repo definition files, since the repo packages are copied from the `dev`
bucket.

To update the `release` salt version, update `salt_version` and/or
`extra_salt_versions` in the
[release salt-yum-defs configuration](release/salt-yum-defs/wrangler.auto.tfvars).

Some care should be taken when deciding to modify `salt_version` in the
`release` pipeline... The `watchmaker` default config uses the resulting
"unversioned" URI repo definition. When the `salt_version` is modified,
`watchmaker` client's will get the updated salt version.

`extra_salt_versions` works just as it does in the `dev` pipeline...
`watchmaker` client's may choose to use the versioned repo definitions in
custom configurations to pin/control the salt version they use.
