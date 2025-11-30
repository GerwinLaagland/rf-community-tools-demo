# Accessible Automation with Robot Framework

A small, accessible demo project showing how Robot Framework, RobotCode, Robocop and community libraries (REST, Browser, Database, RPA) can be combined into a simple test automation setup.

> This repository accompanies the talk **“Robot Framework: Accessible Automation with Community‑Driven Tools”** at FOSDEM 2026 (Testing and Continuous Delivery devroom).

## What this project demonstrates

This repo is meant as a practical, small‑scale example of:

- **Accessible automation**  
  Keyword‑driven tests that are readable by developers, testers, and domain experts.

- **Community‑driven tools and libraries**  
  Using open source tools maintained by the Robot Framework community:
  - [RobotCode](https://github.com/d-biehl/robotcode) – VS Code extension for Robot Framework  
  - [Robocop](https://github.com/MarketSquare/robotframework-robocop) – linter for style and consistency  
  - [robotframework-requests](https://github.com/MarketSquare/robotframework-requests) – REST API tests  
  - [robotframework-browser](https://github.com/MarketSquare/robotframework-browser) – browser/UI tests  
  - [robotframework-databaselibrary](https://github.com/MarketSquare/Robotframework-Database-Library) – database checks  
  - [rpaframework](https://rpaframework.org/) – Windows Notepad interaction  

## Project structure

```text
.
├── resources/
│   ├── components/
│   │   ├── api.resource              # Keywords for API tests
│   │   ├── browser.resource          # Keywords for Browser/UI tests
│   │   ├── database.resource         # Keywords for DB checks
│   │   └── notepad.resource          # Keywords for RPA/Notepad
│   └── data/
│   └── domain/
│       ├── learningChuckAPI.resource      # Domain keywords for API 
│       ├── learningChuckDB.resource       # Domain keywords for DB 
│       ├── learningChuckNotepad.resource  # Domain keywords for Notepad 
│       └── learningIntegration.resource   # Domain keywords for Integration
├── results/                          # Test outputs (created by Robot)
├── suites/
│   ├── ChuckTechnicals.robot         # Suite focused on technical checks
│   ├── NorrisComponents.robot        # Component-level tests
│   └── NorrisIntegration.robot       # Integration-level tests
├── .gitignore
├── readme.md
├── requirements.txt
├── robocop.toml                      # Robocop configuration
└── robot.toml                        # Robot Framework settings
```
## How to run

### 1. Install prerequisites

- [Python](https://www.python.org/) 3.10+  
- A code editor (for example [VS Code](https://code.visualstudio.com/) with the RobotCode extension)  
- On Windows, if you want to run the Notepad/RPA part: the standard Notepad application  

### 2. Set up a virtual environment and install dependencies

From the project root:

```bash
python -m venv .venv

# On Linux/macOS
source .venv/bin/activate

# On Windows
.venv\Scripts\activate

pip install -r requirements.txt
```
### 3. Install Browser library dependencies

Run the following command in your activated virtual environment:

```bash
rfbrowser install
```
### 4. Run the tests

From the project root, run:

```bash
# Run all suites
robot suites/

# Or run one suite at a time
robot suites/ChuckTechnicals.robot
robot suites/NorrisComponents.robot
robot suites/NorrisIntegration.robot
```

# Credits
This project is heavily inspired by a technical demo created by Stavroula Ventoura which was first showcased at Athens Open‑conf. It has been repurposed with her assistance and permission.
