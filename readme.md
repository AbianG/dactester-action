# Dactester-action
This github action allows to perform compliance testing in markdown files in a *documentation as code* repository. It makes use of a custom built dockerized python application: Doc-as-code Tester (Dactester). It allows for custom rules, its goal is to be as flexible and simple as possible to allow for automation of documentation file's structure and content.

## Structure

* `action.yml` describes the action.
* `Dockerfile` sets the container image the action will run on.
  * Dactester is the application that performs all underlying tester, a custom Python app.
* `entrypoint.sh` acts as the entry point and handles all IO (get user configuration arguments and present output to github).
* `ruleconfig.yml` a file describing the rules that will be tested, this **must be present on the doc-as-code repository's root**.  

## How to use

Create a workflow .yml file to integrate with the following basic structure:

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
```

* `folderPath` can be set to anything inside the repository, the action will perform the test on all files in the folder and subfolders.
* A `ruleconfig.yml` file containing test definitions must be present at the root of your doc-as-code repository.


### Ruleconfig.yml format

Its a YAML file that can contain as many rules as needed. Rules are flexible but have a predefined type and must be created with mandatory parameters.

#### Line before rule 

Checks that the line in parameter `first` is located before line in parameter `after` in the document or documents. 

```
line-before-example:
  - type: line-before
  - desc: "Short description, may be blank but MUST exist"
  - first: "Line that must go first"
  - after: "Line that must go after"
```
#### Line after rule

Similar to **line before rule**, checks that line in parameter `after` exists after line in parameter `first` in the document or documents.

```
line-after-example:
  - type: line-after
  - desc: "Short description, may be blank but MUST exist"
  - first: "Line that must go first"
  - after: "Line that must go after"
```
#### Line is top rule

Checks that the line in parameter `value` exist before any other line in the document or documents.

```
line-is-top-example:
  - type: line-top
  - desc: "Short description, may be blank but MUST exist"
  - value: "This is the first line of the document"
```

#### Line is bottom rule

The opossite of **line is top rule**

```
line-is-bottom-example:
  - type: line-bottom
  - desc: "Short description, may be blank but MUST exist"
  - value: "This is the last line of the document"
```

#### Document contains rule

This rule checks that the line in `value` appears as many times as the parameter `times` specifies.

```
doc-contains-example:
  - type: doc-contains
  - desc: "Short description, may be blank but MUST exist"
  - value: "Some line in the document"
  - times: 2
```

#### Header is present rule

This rule checks that the line in `value` appears on the document as a header.

```
header-present-example:
  - type: header-present
  - desc: "Short description, may be blank but MUST exist"
  - value: "This is a title"
```

#### Headers present rule

This rule checks that the lines in the `headers-list` appear on the document as headers and in the order specified. Parameter `allow-only-selecter-headers` is still not active.

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


## Roadmap

* Improve results presentation and logging.