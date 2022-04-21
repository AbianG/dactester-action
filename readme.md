# Dactester-action
This github action integrates the dactester python framework for documentation compliance testing into a repository. It is currently a PoC. When its ready, the repository for the dactester will be made public.

## Integrate this action in your repository

Create a workflow .yml file to integrate with the following basic tructure

```
on: [push]

jobs:
  test-documentation-compliance:
    runs-on: ubuntu-latest
    name: Test markdown for compliance
    steps:
      - name: Perform repository checkout
        uses: actions/checkout@v2

      - name: Perform test for markdown files
        id: RunTests
        uses: AbianG/dactester-action@master
        with:
          folderPath: 'tests'
    #Step not working as inteded yet
      - name: Get the output time
        run: echo "The results are ${{ steps.RunTests.outputs.results }}"
```

The **folderPath** parameter must be specified with the root path in your repository where dactester will start searching for markdown files
