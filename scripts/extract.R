# The function of this script file is to extract the latent processes from
# the modeled disease series. This script file is based on split.R

# Loading libraries and function ####
R <- list.files(path = "./R", pattern = "*.R", full.names = TRUE)
sapply(R, source, .GlobalEnv)

# Importing results ####

## Series ####
carrier_ts <- readRDS(file = "./data/carrier_ts.rds")
control_ts <- readRDS(file = "./data/control_ts.rds")

## Models ####
carrier_models <- readRDS(file = "./outputs/carrier/models.rds")
control_models <- readRDS(file = "./outputs/control/models.rds")

# Extraction ####

## Carrier data ####
carrier_extract <- lapply(
  X = seq_along(carrier_models),
  FUN = function(j) {
    signal_extract(
      data = carrier_ts[[j]],
      object = carrier_models[[j]]
    )
  }
)
names(carrier_extract) <- names(carrier_models)

## Control data ####
control_extract <- lapply(
  X = seq_along(control_models),
  FUN = function(j) {
    signal_extract(
      data = control_ts[[j]],
      object = control_models[[j]]
    )
  }
)
names(control_extract) <- names(control_models)

# Exporting results ####
saveRDS(
  object = carrier_extract,
  file = "./outputs/carrier/extract.rds"
)
saveRDS(
  object = control_extract,
  file = "./outputs/control/extract.rds"
)