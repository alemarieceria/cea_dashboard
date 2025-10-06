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
- All intermediate and processed files are saved in `data/processed/` and excluded from Git.

---

## Modular `{targets}` Pipelines

Each major section of the dashboard (Fisheries, Extents, Conditions, Recreation) will have its own modular pipeline — a self-contained ETL workflow that feeds into the main `_targets.R` file.

### Folder Structure
```
R/
├── fisheries/
│   ├── functions/
│   │   ├── load_fisheries_data.R
│   │   ├── process_fisheries_data.R
│   │   └── export_fisheries_data.R
│   └── fisheries_targets.R
└── _targets.R
```

**Why modular pipelines work well:**
1. **Reproducibility** – Every step is documented and cached, so anyone can rebuild the results exactly.  
2. **Efficiency** – `{targets}` only re-runs steps that are affected by a change.  
3. **Scalability** – You can add new pipelines or datasets easily without breaking the existing structure.

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

## Version Control Best Practices

- Check your work often with `git status`.  
- Stage intentionally — use `git add <file>` to commit only relevant edits.  
- Never commit large data or generated files; add folders like `data/` or `cache/` to `.gitignore`.  
- Push updates after completing a clear milestone (setup, new ETL pipeline, dashboard feature, etc.).  

---

## Code Style and Organization

- Keep scripts focused and under ~100 lines when possible.  
- Use comments to explain *why* something is done, not *what* the code does.  
- Maintain consistent indentation (2 spaces in R).  
- Store shared settings (like file paths, CRS, etc.) in `config.yml`.  
- Separate logic into smaller functions — it improves readability and testing.  

---

## Reproducibility Tools

| Tool | Purpose | How It’s Used |
|------|----------|---------------|
| `{renv}` | Dependency management | Snapshots package versions to reproduce environments. |
| `{targets}` | Workflow automation | Defines ETL steps and rebuild logic. |
| Rhino | Shiny framework | Provides a modular structure for the dashboard. |
| GitHub | Version control & collaboration | Tracks project evolution and makes sharing easier. |

---

## Project Folder Overview

```
cea_dashboard/
├── app/                  # Shiny app (Rhino)
├── data/                 # Raw and processed data (not tracked in Git)
├── R/                    # R scripts, ETL, and pipelines
│   └── fisheries/
│       ├── functions/    # Helper functions
│       └── fisheries_targets.R
├── _targets.R            # Main targets pipeline config
├── renv.lock             # Locked package versions
├── README.qmd            # Project documentation
└── .gitignore            # Excludes data and cache
```

---

## Key Takeaways

- Structure intentionally — organize by function, not just file type.  
- Keep naming consistent — `snake_case` for R, `camelCase` for Shiny UI.  
- Automate smartly — let `{targets}` handle re-running logic.  
- Commit often — track each meaningful change with clear messages.  
- Document everything — it saves time for you and your collaborators later.
