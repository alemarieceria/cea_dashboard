# Project Setup, Naming, and Workflow Conventions

This document explains how I structure, name, and organize my projects so that they’re reproducible, consistent, and easy for others to follow. It also covers how I use Git and commit messages to track progress clearly.

---

## Project Naming Conventions

The goal is to keep everything readable and consistent across systems.  
I use lowercase, underscores, and clear names for all folders, files, and functions.

| Type | Convention | Example | Notes |
|------|-------------|----------|--------|
| **Folders / Files** | `snake_case` | `cea_dashboard/`, `data/fisheries/`, `load_fisheries_data.R` | Always lowercase with underscores. Avoid spaces or hyphens. |
| **R Functions** | `snake_case()` | `process_fisheries_data()` | Start with a verb that describes what the function does (e.g., `load_`, `process_`, `export_`). |
| **Shiny UI / Server Objects** | `camelCase` | `fisheriesModuleUI()`, `fisheriesServer()` | Matches the common naming style for Shiny modules and UI components. |
| **Variables / Objects** | `snake_case` | `raw_fisheries_data`, `processed_fisheries_data` | Keep names descriptive but concise. |
| **Constants / Config Keys** | `ALL_CAPS` | `DATA_PATH`, `DEFAULT_CRS` | Use only for values that don’t change. |
| **Quarto / Markdown Files** | lowercase, descriptive | `readme.qmd`, `project_overview.qmd` | Keep filenames simple and consistent with GitHub’s case sensitivity. |

---

## ETL: Extract, Transform, Load

ETL is the process of taking raw data, cleaning and transforming it, and saving the results in a format ready for analysis or visualization.  
This project automates that workflow using the `{targets}` package.

### Example: Fisheries ETL
```
Raw Data (.csv / shapefiles)
   ↓
load_fisheries_data()       # Import and validate inputs
   ↓
process_fisheries_data()    # Clean, transform, join datasets
   ↓
export_fisheries_data()     # Write outputs to data/processed/
   ↓
Dashboard visualizations    # Read with tar_read()
```

**Best practices:**
- Each dataset (fisheries, recreation, etc.) has its own ETL pipeline under `R/`.  
- The `{targets}` package manages dependencies so only changed steps are re-run.  
- All raw data are ignored in Git, while processed outputs are tracked for reproducibility.

---

## Modular `{targets}` Pipelines

Each major section of the dashboard (Fisheries, Extents, Conditions, Recreation) has its own modular pipeline — a self-contained ETL workflow that feeds into the main `_targets.R` file.

### Folder Structure
```
R/                           # Custom R functions and modular ETL pipelines
├── fisheries_data/          # ETL pipeline for Fisheries dataset
│   ├── functions/           # Helper functions used in the Fisheries ETL
│   │   ├── 01_load_fisheries_data.R     # Loads raw fisheries input data
│   │   ├── 02_process_fisheries_data.R  # Cleans and transforms fisheries data
│   │   └── 03_export_fisheries_data.R   # Exports processed fisheries outputs
│   └── fisheries_targets.R  # Defines modular `{targets}` pipeline for Fisheries ETL
│
├── mokus_layer/             # ETL pipeline for Mokus layer data
│   ├── functions/           # Helper functions used in the Mokus ETL
│   │   ├── 01_load_mokus_layer.R        # Loads raw Mokus layer data
│   │   ├── 02_process_mokus_layer.R     # Cleans and transforms Mokus layer data
│   │   └── 03_export_mokus_layer.R      # Exports processed Mokus layer outputs
│   └── mokus_targets.R      # Defines modular `{targets}` pipeline for Mokus ETL
└── _targets.R               # Main `{targets}` pipeline configuration (imports all modular ETLs)
```

**Why modular pipelines work well:**
1. **Reproducibility** – Every step is documented and cached, so anyone can rebuild the results exactly.  
2. **Efficiency** – `{targets}` only re-runs steps that are affected by a change.  
3. **Scalability** – You can add new pipelines or datasets easily without breaking the existing structure.

---

## .gitignore Configuration

To ensure reproducibility and security, only the **raw data folders** inside `data/` are ignored.  
This keeps sensitive or large input data out of version control while still tracking processed outputs.

### Example .gitignore
```bash
# Ignore only raw data folders
data/**/raw/

# Keep processed data and structure
!data/**/processed/
!data/.gitkeep
```

You can add an empty `.gitkeep` file inside each `processed/` folder to ensure the directory structure remains visible in Git.

---

## Commit Message Conventions

I follow the **Conventional Commits** format so my Git history stays organized and easy to read.

```
<type>(<scope>): <short, descriptive message>
```

| Type | When to Use | Example |
|------|--------------|----------|
| `feat` | Adding a new feature or function | `feat(targets): add modular ETL pipeline for fisheries data` |
| `fix` | Correcting a bug | `fix(import): resolve CRS mismatch in shapefile load` |
| `docs` | Updating documentation | `docs(readme): add reproducibility instructions` |
| `chore` | Setup or maintenance tasks | `chore: initialize Rhino Shiny and targets project with renv setup` |
| `refactor` | Restructuring code without changing behavior | `refactor(fisheries): modularize data processing steps` |
| `style` | Updating formatting or naming consistency | `style: align all filenames to snake_case` |

**Good habits:**
- Commit after every meaningful change (new feature, setup step, or bug fix).  
- Write short, action-based messages (“add,” “update,” “fix”).  
- Include a scope when it adds clarity, like `(targets)` or `(readme)`.

---

## Project Folder Overview

```
cea_dashboard/
├── .github/                     # GitHub configuration (actions, workflows, etc.)
│
├── app/                         # Rhino Shiny application structure
│   ├── js/                      # Custom JavaScript files
│   ├── logic/                   # Server-side logic scripts
│   ├── static/                  # Images or static assets
│   ├── styles/                  # Custom CSS and styling
│   ├── view/                    # UI layout and component files
│   └── main.R                   # Main app entry point (calls Rhino's app structure)
│
├── data/
│   └── fisheries/               # Data used for the Fisheries page
│       ├── processed/           # Output from `{targets}` (cleaned datasets)
│       └── raw/                 # Input data (excluded from Git; not shared)
│
├── R/                           # Custom R functions and modular ETL pipelines
│   ├── fisheries_data/          # ETL pipeline for Fisheries dataset
│   │   ├── functions/           # Helper functions used in the Fisheries ETL
│   │   │   ├── 01_load_fisheries_data.R     # Loads raw fisheries input data
│   │   │   ├── 02_process_fisheries_data.R  # Cleans and transforms fisheries data
│   │   │   └── 03_export_fisheries_data.R   # Exports processed fisheries outputs
│   │   └── fisheries_targets.R  # Defines modular `{targets}` pipeline for Fisheries ETL
│
│   ├── mokus_layer/             # ETL pipeline for Mokus layer data
│   │   ├── functions/           # Helper functions used in the Mokus ETL
│   │   │   ├── 01_load_mokus_layer.R        # Loads raw Mokus layer data
│   │   │   ├── 02_process_mokus_layer.R     # Cleans and transforms Mokus layer data
│   │   │   └── 03_export_mokus_layer.R      # Exports processed Mokus layer outputs
│   │   └── mokus_targets.R      # Defines modular `{targets}` pipeline for Mokus ETL
│
├── renv/                        # Local R environment managed by `{renv}`
├── tests/                       # (Optional) Automated tests for reproducibility
├── _targets.R                   # Main `{targets}` pipeline configuration (imports all modular ETLs)
├── .gitignore                   # Specifies ignored raw data folders and tracked processed outputs
├── .lintr                       # Linting configuration for code style
├── .Renviron                    # Environment variables
├── .Rprofile                    # R session startup settings
├── app.R                        # Rhino launcher script (calls `rhino::app()`)
├── cea_dashboard.Rproj          # RStudio/Posit project file
├── config.yml                   # Rhino configuration for environment and app options
├── dependencies.R               # Script to install key project dependencies
├── README.qmd                   # Quarto README (rendered documentation)
├── README.md                    # Rendered Markdown version for GitHub
├── renv.lock                    # Snapshot of R package versions for reproducibility
└── rhino.yml                    # Rhino project configuration (defines app entry and structure)
```

---

## Key Takeaways

- Structure intentionally — organize by function, not just file type.  
- Keep naming consistent — `snake_case` for R, `camelCase` for Shiny UI.  
- Automate smartly — let `{targets}` handle re-running logic.  
- Commit often — track each meaningful change with clear messages.  
- Document everything — it saves time for you and your collaborators later.
