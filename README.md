# Coastal Ecosystem Accounting (Hawaii) Dashboard


- [Project Overview](#project-overview)
- [Project Structure](#project-structure)
- [Installation and Setup](#installation-and-setup)
- [Required Dependencies](#required-dependencies)
- [Reproducible Workflow](#reproducible-workflow)
- [Running the Shiny App](#running-the-shiny-app)
- [Deployment](#deployment)
- [Data Sources](#data-sources)
- [Reproducibility Notes](#reproducibility-notes)
- [Author](#author)

**A reproducible spatial data dashboard built with the [Rhino Shiny
framework](https://appsilon.github.io/rhino/),
[`{targets}`](https://books.ropensci.org/targets/) for automated ETL,
and [`{bs4Dash}`](https://bs4dash.rinterface.com/) for an interactive
UI.**

## Project Overview

The CEA Dashboard helps turn raw spatial data into clear, interactive
insights using reproducible R workflows. It brings together automated
data processing, organized project structure, and a modular Shiny
dashboard that makes it easier to explore and share results. This
project shows how I build reproducible data-to-dashboard workflows in R.

## Project Structure

## Installation and Setup

Clone this repository:

```` markdown
```{bash}
git clone https://github.com/<your-username>/cea_dashboard.git
cd cea_dashboard
```
````

Open the project in desired ID (I use Positron), then run to recreate
the exact R package environment recorded in `renv.lock`:

```` markdown
```{r}
install.packages("renv")
renv::restore()
```
````

## Required Dependencies

Core packages used in this project:

<center>

| Category      | Packages                             |
|---------------|--------------------------------------|
| Framework     | `rhino`, `bs4Dash`, `shiny`          |
| Automation    | `targets`, `tarchetypes`             |
| Spatial Data  | `sf`, `terra`, `dplyr`, `janitor`    |
| Visualization | `ggplot2`, `plotly`, `leaflet`, `DT` |
| Utilities     | `renv`, `purrr`, `here`, `readr`     |

</center>

## Reproducible Workflow

Run the automated ETL pipeline using `{targets}`:

```` markdown
```{r}
# Execute ETL pipeline
targets::tar_make()  

# Visualize pipeline dependencies     
targets::tar_visnetwork()    
```
````

All processed outputs will be saved in the `data/processed/` subfolder.
The pipeline ensures that only modified steps are re-run, improving
efficiency and reproducibility.

## Running the Shiny App

After processing the data, launch the dashboard locally:

```` markdown
```{r}
rhino::run_app()
```
````

This will star the Shiny server and open the app in your IDE or browser.
Ensure the processed data files exist before launching.

## Deployment

Once ready to share publicly, you can deploy your dashboard using the
following options:

1.  [shinyapps.io](https://www.shinyapps.io/)

Install the deployment package:

```` markdown
```{r}
pacman::p_load("rsconnect")
```
````

Ensure you’ve signed up for an account, then authenticate it:

```` markdown
```{r}
rsconnect::setAccountInfo(name = "<your-name>", token = "<token>", secret = "<secret>"
```
````

Deploy Shiny dashboard:

```` markdown
```{r}
rsconnect::deployApp()
```
````

Your dashboard will be hosted at:
`https://<your-username>.shinyapps.io/cea_dashboard`

2.  [Hugging Face Spaces](https://huggingface.co/spaces)

Instructions on how to publish the rhino app on hugging face can be
found
[here](https://appsilon.github.io/rhino/articles/how-to/publish-on-huggingface.html).

## Data Sources

<center>

| Dataset | Description | Source |
|---------|-------------|--------|

</center>

## Reproducibility Notes

- Developed on **Windows 11 Home (Build 26100)** using **R 4.5.0** in
  **Positron**
- Environment managed with `{renv}`
- Automated ETL via `{targets}`
- Modular `{shiny}` app structure using `{rhino}`
- Version control via Git and GitHub
- Data directories excluded from commits (`.gitignore`)

## Author

Alemarie Ceria  
Oleson Ecological Economics Lab, University of Hawaiʻi at Mānoa  
🗂️ [Portfolio](https://alemarieceria.github.io/portfolio/)
