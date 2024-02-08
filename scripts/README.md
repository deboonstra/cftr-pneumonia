# scripts

This sub-directory contains the scripts file needed to perform data cleaning and analysis. Generally, the results and/or data produced by these script files will be directed to the

- `data`,
- `figures`, and
- `outputs`

sub-directories. At the beginning of each of these script files, a comment will be written that describes the utility of the script file. All scripts execute assuming the working directory is the main `cftr-pneumonia` directory. Additionally, all figures are produced by a script within the sub-directory `scripts/figures` and has its own README file. Below are descriptions of script files.


`clean_data.R` 

produces clean data meant for analysis. Raw unaltered data will be read in from `data-raw` and the cleaned version will be saved to `data`. The data produced by this script file are

- `data/carrier_ts.rds` and
- `data/control_ts.rds`.

`impute_data.R` 

produces clean data meant for analysis. Raw unaltered data will be read in from `data-raw` and the cleaned version will be saved to `data`. Additionally, we imputed the series that have a monthly incidence rate of zero to be the minimum non-zero incidence for a given year. The data produced by this script file are

- `data/imputed_carrier_ts.rds` and
- `data/imputed_control_ts.rds`.

`split.R` 

splits and/or models the disease series based on the Bungeston and Cavanaugh (2005) structural decomposition method. The results produced by this script file are

- `outputs/carrier/models.rds` and
- `outputs/control/models.rds`.

`extract.R` 

extracts the latent processes (global, seasonal, and local trends) from the modeled disease series. This script file is based on `split.R`. The results produced by this script file are

- `outputs/carrier/extract.rds` and
- `outputs/control/extract.rds`.