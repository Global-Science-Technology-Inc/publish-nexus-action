# Nexus Repository Publisher for GitHub Actions

Publish components from GitHub Action workflow to Nexus Repository.

## Inputs

### `serverUrl`

**Required** Nexus Repository Server URL

### `username`

**Required** Username to connect to Nexus Repo to publish components

### `password`

**Required** Password to connect to Nexus Repo to publish components

### `extension`

**Required** File extension

### `repository`

**Required** Name of target repository on Nexus Repo e.g. maven-releases

### `path`

**Required** Path to find files to publish

## Example Usage

RPM Build

```
name: RPM with Nexus Repository

on: [push]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v1
    - name: build RPM package
      id: rpm
      uses: global-science-technology-inc/rpmbuild-action@main
      with:
        spec_file: example.spec
    - name: Nexus Repo Publish
      uses: global-science-technology-inc/publish-nexus-action@master
      with:
        serverUrl: http://nexus.example.com
        username: admin
        password: ${{ secrets.password }}
        extension: rpm
        repository: repo-name
        path: ${{ steps.rpm.outputs.rpm_dir_path }}
```

## The Fine Print

It is worth noting that this is a contribution of ours to the open source community (read: you!)

Remember:

* Use this contribution at the risk tolerance that you have
* DO file issues here on GitHub, so that the community can pitch in

