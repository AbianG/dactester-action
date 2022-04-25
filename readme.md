# Dactester-action
This github action integrates the dactester python framework for documentation compliance testing into a repository. It is currently a PoC. When its ready, the repository for the dactester will be made public.

## To-do

* Accept dinamically changing `ruleconfig.yml` files.
* Validate ruleconfig with a validator to sanitize wrong input.
* Action must ouput the results in pretty JSON so it can be parsed and reported by github

## Components
* Testing engine: Python code that performs the tests based on the rules
* Configuration (rules) file: A .yml file, currently needs to be called `ruleconfig.yml` and placed on the repository's root for the testing to work.

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

## Ruleconfig.yml format

Its a YAML that can contain as many rules as needed. Rules are of a predefined type and must be created with mandatory parameters.

### Line before rule

Checks that the line in parameter `first` is located before line in parameter `after` in the document or documents.

```
line-before-example:
  - type: line-before
  - desc: "Short description, may be blank but MUST exist"
  - first: "Line that must go first"
  - after: "Line that must go after"
```

### Line after rule

Similar to **line before rule**, checks that line in parameter `after` exists after line in parameter `first` in the document or documents.

```
line-after-example:
  - type: line-after
  - desc: "Short description, may be blank but MUST exist"
  - first: "Line that must go first"
  - after: "Line that must go after"
```
### Line is top rule

Checks that the line in parameter `value` exist before any other line in the document or documents.

```
line-is-top-example:
  - type: line-top
  - desc: "Short description, may be blank but MUST exist"
  - value: "This is the first line of the document"
```

### Line is bottom rule

The opossite of **line is top rule**

```
line-is-bottom-example:
  - type: line-bottom
  - desc: "Short description, may be blank but MUST exist"
  - value: "This is the last line of the document"
```

### Document contains rule

This rule checks that the string in `value` exists as many times as the parameter `times` specifies.

```
doc-contains-example:
  - type: doc-contains
  - desc: "Short description, may be blank but MUST exist"
  - value: "A random line inside"
  - times: 2
```

### Header is present rule

This rule checks that the string in `value` is present on the document as a header.

```
header-present-example:
  - type: header-present
  - desc: "Short description, may be blank but MUST exist"
  - value: "This is a title"
```

### Headers present rule

This rule checks that the strings in the `headers-list` exist on the document as headers and in the order specified. Parameter `allow-only-selecter-headers` is still not active.

```
headers-present-in-order-example:
  - type: headers-present-in-order
  - desc: "Short description, may be blank but MUST exist"
  - allow-only-selected-headers: False
  - headers-list:
    - "First header"
    - "Second header"
    - "Third header"
```
