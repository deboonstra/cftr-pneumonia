# The function of this script file is to produce clean data meant for analysis.
# Raw unaltered data will be read in from data-raw and the cleaned version will
# be saved to data. Additionally, we will be imputing series the have a monthly
# incidence rate of zero.

# Loading libraries and function ####
R <- list.files(path = "./R", pattern = "*.R", full.names = TRUE)
sapply(R, source, .GlobalEnv)

# Cleaning data ####

## Importing data ####
load(file = "./data-raw/cftr_incidence_series.RData")

## Copying data to make changes ####
all_data <- cftr_incidence_series

## Subsetting data to only include observations between 2008 and 2019
## Excluding 2020 and above due to the possibility of classifying
## the flu as COVID. Additionally, starting in 2008 because 2008 is minimum
## year that flu and flu without pneumonia have almost a complete set of data.
min_year <- 2008
max_year <- 2019
length_years <- length(min_year:max_year)
all_data <- subset(
  x = all_data,
  subset = year >= min_year & year <= max_year,
)

## Determining the rate of missing data ####
na_data_incidator <- all_data |>
  dplyr::group_by(case, code_set) |>
  dplyr::filter(incidence > 0) |>
  dplyr::count(year) |>
  dplyr::rename(no_month_recorded = n) |>
  dplyr::mutate(missing_rate = 1 - (no_month_recorded / 12))

## Subsetting data based on minimum missing rate ####
## Setting the rate to 1/4 or 3 months. This rate was choosen because
## it will not let an entire calendar season (fall, winter, spring, or summer)
## go unrecorded.

### Merging missing rates with data ####
all_data <- merge(
  x = all_data, y = na_data_incidator,
  by = c("case", "code_set", "year"),
  all.x = TRUE
)

### Subsetting data ####
all_data <- subset(
  x = all_data,
  subset = missing_rate <= 0.25
)

### Removing unwanted variables ####
all_data <- subset(
  x = all_data,
  select = -c(no_month_recorded, missing_rate)
)

## Replacing zero incidence rates ####
## Using the minimum incidence of each year given carrier status and
## disease type
all_data <- all_data |>
  dplyr::group_by(case, code_set, year) |>
  dplyr::mutate(
    incidence = ifelse(
      test = incidence == 0,
      yes = min(incidence[incidence != 0]),
      no = incidence
    )
  ) |>
  dplyr::ungroup()

### Checking missing rate
check_missing_rate <- all_data |>
  dplyr::group_by(case, code_set) |>
  dplyr::filter(incidence > 0) |>
  dplyr::count(year) |>
  dplyr::rename(no_month_recorded = n) |>
  dplyr::mutate(missing_rate = 1 - (no_month_recorded / 12))

## Removing disease that do NOT have both carrier statuses ####
check_missing_disease <- all_data |>
  dplyr::group_by(code_set) |>
  dplyr::count(case) |>
  dplyr::rename(no_months = n) |>
  dplyr::mutate(no_years = no_months / length_years) |>
  dplyr::group_by(code_set) |>
  dplyr::mutate(avg_years = mean(no_years)) |>
  dplyr::filter(!duplicated(avg_years)) |>
  dplyr::select(code_set, avg_years)

### Subsetting diseases with incomplete data ####
all_data <- merge(
  x = all_data, y = check_missing_disease,
  by = "code_set", all.x = TRUE
)
all_data <- subset(
  x = all_data,
  subset = avg_years == 12
)

## Splitting data into case status ####

### Carrier data ####
carrier <- subset(
  x = all_data,
  subset = case == 1,
  select = c(code_set, year, month, month_start, incidence)
)

### Control data ####
control <- subset(
  x = all_data,
  subset = case == 0,
  select = c(code_set, year, month, month_start, incidence)
)

## Creating time series objects ####

### Carrier data ####

#### Splitting based on disease type ####
carrier_ts <- split(
  x = carrier,
  f = factor(carrier$code_set)
)

#### Transforming each series into ts objects ####
carrier_ts <- lapply(
  X = carrier_ts,
  FUN = function(x) {
    x <- x[order(x$year, x$month), ]
    x <- subset(x = x, select = incidence)
    x <- stats::ts(
      data = x,
      start = c(min_year, 1),
      frequency = 12
    )
    return(x)
  }
)

### Control data ####

#### Splitting based on disease type ####
control_ts <- split(
  x = control,
  f = factor(control$code_set)
)

#### Transforming each series into ts objects ####
control_ts <- lapply(
  X = control_ts,
  FUN = function(x) {
    x <- x[order(x$year, x$month), ]
    x <- subset(x = x, select = incidence)
    x <- stats::ts(
      data = x,
      start = c(min_year, 1),
      frequency = 12
    )
    return(x)
  }
)

# Exporting data ####

## Carrier data ####
saveRDS(object = carrier_ts, file = "./data/imputed_carrier_ts.rds")

## Control data ####
saveRDS(object = control_ts, file = "./data/imputed_control_ts.rds")