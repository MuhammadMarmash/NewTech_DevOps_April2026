# GitHub Actions Labs

Two hands-on labs that teach GitHub Actions CI/CD by building and testing real Python projects.

## Lab Structure

```
GH_Actions/
├── lab1/               # Calculator app — workflow already provided
│   ├── calculator.py
│   ├── test_calculator.py
│   ├── requirements.txt
│   └── README.md
├── lab2/               # String utils — you create the workflow
│   ├── string_utils.py
│   ├── test_string_utils.py
│   ├── requirements.txt
│   ├── README.md
│   └── SOLUTION.md     # Instructor solution guide
└── solutions/
    ├── lab1-solution.md   # Lab 1 workflow walkthrough (instructor reference)
    └── lab2-solution.yml  # Lab 2 full bonus solution workflow (instructor reference)
```

The active workflow files live at the **repository root** under `.github/workflows/`:

```
.github/
└── workflows/
    └── python-tests.yml   # Lab 1 starter workflow (provided)
```

## Labs

### Lab 1 — Python Calculator

Explore a working GitHub Actions workflow that automatically runs tests on every push.

**Goal:** Understand how a CI workflow is structured — triggers, jobs, and steps.

Start here: [lab1/README.md](./lab1/README.md)

### Lab 2 — String Utils

Create your own GitHub Actions workflow from scratch.

**Goal:** Write a workflow that runs tests for the String Utils project. Use the Lab 1 workflow in `.github/workflows/python-tests.yml` as your reference.

**Bonus challenges:** matrix builds, code coverage, linting, combined jobs.

Start here: [lab2/README.md](./lab2/README.md)

## Prerequisites

- A GitHub account
- Basic Python knowledge
- Python 3.11 installed locally (for running tests before pushing)

## Running Tests Locally

```bash
# Lab 1
cd GH_Actions/lab1
python -m unittest test_calculator.py -v

# Lab 2
cd GH_Actions/lab2
python -m unittest test_string_utils.py -v
```
