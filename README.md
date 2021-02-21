# GitHub Mirror

Github Mirror is a [GitHub Action](https://github.com/features/actions) that keeps a GitHub repository up to date as
a mirror of an external repository. It will synchronize all branches and commits from the specified repository; it
will not copy non-Git data such as Pull Requests.

## Create from Template
If you'd prefer to use the GitHub UI instead of the CLI, you can use the [template repository](https://github.com/bridgelightcloud/github-mirror-template).

Steps:
1. Click [Use this template](https://github.com/bridgelightcloud/github-mirror-template/generate).
2. Name your repository
3. Edit `.github/workflows/mirror.yml` and enter the URL you wish to mirror where it says `origin: ''`
4. Commit your change

## Manual Setup
To create a mirror, start by creating a repository locally and creating a branch to hold the workflow file. The branch
should be named such that it will not conflict with a branch name in the source repository.

```
$ gh repo create --public --confirm mirror
$ git -C mirror checkout -b __mirror
$ mkdir -p mirror/.github/workflows
```

Create a file like the one below in your repository. Replace *TARGET_REPO_HERE* with the URL of a the git repository
to mirror.

```yml
# .github/workflows/mirror.yml
name: 'mirror'
on:
  push:
    branches:
        - __mirror
  schedule:
    - cron: '* 3 * * *'
  workflow_dispatch:

jobs:
  mirror:
    runs-on: ubuntu-latest
    name: mirror
    steps:
      - name: mirror
        id: mirror
        uses: bridgelightcloud/github-mirror-action@v1
        with:
          origin: 'TARGET_REPO_HERE'
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

Commit and push your changes

```
$ git -C mirror add .
$ git -C mirror commit -am 'Add mirror workflow'
$ git -C mirror push -u origin __mirror
```

The workflow will start immediately and copy the source repository. The workflow will continue to run on the schedule 
specified on the `cron` line (in the example above, 3 AM UTC every day). You can also run the workflow manually
by selecting it in the Actions tab on GitHub.

## License
The code is trivial, as such this repository is licensed under the Creative Commons CC-0 license.
