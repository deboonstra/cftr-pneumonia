# The function of this script file is to split the disease series based on the
# Bungeston and Cavanaugh (2005) method.

# Loading libraries and function ####
R <- list.files(path = "./R", pattern = "*.R", full.names = TRUE)
sapply(R, source, .GlobalEnv)

# Creating output sub-directories ####
if (!dir.exists("./outputs/carrier/")) {
  dir.create("./outputs/carrier/")
}
if (!dir.exists("./outputs/control/")) {
  dir.create("./outputs/control/")
}

# Importing data ####
carrier_ts <- readRDS(file = "./data/carrier_ts.rds")
control_ts <- readRDS(file = "./data/control_ts.rds")

# Splitting of series ####

## Defining observation equation design matrix ####
a <- cbind(1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

## Defining the design matrix for the state equation
phi <- diag(0, length(a))
phi[1, 1] <- 1
phi[2, ] <- c(0, rep(-1, 11))
w <- which(a == 0)[1]
for (k in seq(w, nrow(phi))) {
  phi[k, (k - 1)] <- 1
}

## Splitting of series ####
carrier_models <- vector(mode = "list", length = length(carrier_ts))
names(carrier_models) <- names(carrier_ts)
control_models <- vector(mode = "list", length = length(control_ts))
names(control_models) <- names(control_ts)

### Carrier data ####

#### Asthma ####
carrier_models$asthma <- ss(
  y = carrier_ts$asthma,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.005),
  mu0 = rep(0, 12),
  sigma0 = diag(0.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Bronchiectasis ####
carrier_models$bronchiectasis <- ss(
  y = carrier_ts$bronchiectasis,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.05),
  mu0 = rep(0, 12),
  sigma0 = diag(0.75, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Acute bronchitis ####
carrier_models$bronchitis_acute <- ss(
  y = carrier_ts$bronchitis_acute,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.05),
  mu0 = rep(0, 12),
  sigma0 = diag(0.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Chronic bronchitis ####
carrier_models$bronchitis_chronic <- ss(
  y = carrier_ts$bronchitis_chronic,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.05),
  mu0 = rep(0, 12),
  sigma0 = diag(0.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Cough ####
carrier_models$cough <- ss(
  y = carrier_ts$cough,
  a = a,
  phi = phi,
  theta0 = c(0.05, 0.05),
  mu0 = rep(0, 12),
  sigma0 = diag(0.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Influenza ####
carrier_models$flu <- ss(
  y = carrier_ts$flu,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.005),
  mu0 = rep(0, 12),
  sigma0 = diag(0.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Gerd ####
carrier_models$gerd <- ss(
  y = carrier_ts$gerd,
  a = a,
  phi = phi,
  theta0 = c(0.0005, 0.005),
  mu0 = rep(0, 12),
  sigma0 = diag(0.75, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Nasal polyps ####
carrier_models$nasal_polyps <- ss(
  y = carrier_ts$nasal_polyps,
  a = a,
  phi = phi,
  theta0 = c(1, 0.5),
  mu0 = rep(0, 12),
  sigma0 = diag(1, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Other lower respiratory infections ####
carrier_models$other_lower_resp <- ss(
  y = carrier_ts$other_lower_resp,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.05),
  mu0 = rep(0, 12),
  sigma0 = diag(0.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Pneumonia ####
carrier_models$pneumonia2 <- ss(
  y = carrier_ts$pneumonia2,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.005),
  mu0 = rep(0, 12),
  sigma0 = diag(0.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Respiratory failure ####
carrier_models$resp_failure <- ss(
  y = carrier_ts$resp_failure,
  a = a,
  phi = phi,
  theta0 = c(0.05, 0.05),
  mu0 = rep(0, 12),
  sigma0 = diag(1, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Acute sinusitis ####
carrier_models$sinusitis_acute <- ss(
  y = carrier_ts$sinusitis_acute,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.05),
  mu0 = rep(0, 12),
  sigma0 = diag(1.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Chronic sinusitis ####
carrier_models$sinusitis_chronic <- ss(
  y = carrier_ts$sinusitis_chronic,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.05),
  mu0 = rep(0, 12),
  sigma0 = diag(1.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Unspecified upper respiratory infections ####
carrier_models$unspec_upper_resp <- ss(
  y = carrier_ts$unspec_upper_resp,
  a = a,
  phi = phi,
  theta0 = c(0.0005, 0.05),
  mu0 = rep(0, 12),
  sigma0 = diag(1.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

### Control data ####

#### Asthma ####
control_models$asthma <- ss(
  y = control_ts$asthma,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.005),
  mu0 = rep(0, 12),
  sigma0 = diag(0.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Bronchiectasis ####
control_models$bronchiectasis <- ss(
  y = control_ts$bronchiectasis,
  a = a,
  phi = phi,
  theta0 = c(5, 0.05),
  mu0 = rep(0, 12),
  sigma0 = diag(0.25, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Acute bronchitis ####
control_models$bronchitis_acute <- ss(
  y = control_ts$bronchitis_acute,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.005),
  mu0 = rep(0, 12),
  sigma0 = diag(0.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Chronic bronchitis ####
control_models$bronchitis_chronic <- ss(
  y = control_ts$bronchitis_chronic,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.005),
  mu0 = rep(0, 12),
  sigma0 = diag(0.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Cough ####
control_models$cough <- ss(
  y = control_ts$cough,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.0005),
  mu0 = rep(0, 12),
  sigma0 = diag(0.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Influenza ####
control_models$flu <- ss(
  y = control_ts$flu,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.005),
  mu0 = rep(0, 12),
  sigma0 = diag(0.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Gerd ####
control_models$gerd <- ss(
  y = control_ts$gerd,
  a = a,
  phi = phi,
  theta0 = c(0.05, 0.005),
  mu0 = rep(0, 12),
  sigma0 = diag(0.75, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Nasal polyps ####
control_models$nasal_polyps <- ss(
  y = control_ts$nasal_polyps,
  a = a,
  phi = phi,
  theta0 = c(1, 0.5),
  mu0 = rep(0, 12),
  sigma0 = diag(1, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Other lower respiratory infections ####
control_models$other_lower_resp <- ss(
  y = control_ts$other_lower_resp,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.05),
  mu0 = rep(0, 12),
  sigma0 = diag(0.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Pneumonia ####
control_models$pneumonia2 <- ss(
  y = control_ts$pneumonia2,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.05),
  mu0 = rep(0, 12),
  sigma0 = diag(0.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Respiratory failure ####
control_models$resp_failure <- ss(
  y = control_ts$resp_failure,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.005),
  mu0 = rep(0, 12),
  sigma0 = diag(0.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Acute sinusitis ####
control_models$sinusitis_acute <- ss(
  y = control_ts$sinusitis_acute,
  a = a,
  phi = phi,
  theta0 = c(0.0005, 0.00005),
  mu0 = rep(0, 12),
  sigma0 = diag(0.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Chronic sinusitis ####
control_models$sinusitis_chronic <- ss(
  y = control_ts$sinusitis_chronic,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.05),
  mu0 = rep(0, 12),
  sigma0 = diag(1.5, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

#### Unspecified upper respiratory infections ####
control_models$unspec_upper_resp <- ss(
  y = control_ts$unspec_upper_resp,
  a = a,
  phi = phi,
  theta0 = c(0.005, 0.0005),
  mu0 = rep(0, 12),
  sigma0 = diag(1, 12),
  control = list(trace = 1, REPORT = 1, maxit = 100)
)

# Exporting results ####
saveRDS(object = carrier_models, file = "./outputs/carrier/models.rds")
saveRDS(object = control_models, file = "./outputs/control/models.rds")