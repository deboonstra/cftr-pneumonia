# The function of this script file is generate a collection for figures for the
# global trend of the disease series.

# Loading libraries and function ####
R <- list.files(path = "./R", pattern = "*.R", full.names = TRUE)
sapply(R, source, .GlobalEnv)

# Creating figure sub-directories ####
if (!dir.exists("./figures/trend/")) {
  dir.create("./figures/trend/")
}

# Importing results ####
carrier_extract <- readRDS("./outputs/carrier/extract.rds")
control_extract <- readRDS("./outputs/control/extract.rds")

# Defining global plotting parameters ####
col <- boonstra::pal(2)
fill <- boonstra::pal(2, alpha = 0.5)
alpha <- 0.05
crit_val <- stats::qnorm(p = 1 - (alpha / 2))
plot_names <- c(
  "Asthma", "Bronchiectasis", "Acute bronchitis", "Chronic bronchitis",
  "Cough", "Influenza", "Gerd", "Nasal polyps",
  "Other lower respiratory infections", "Pneumonia", "Respiratory failure",
  "Acute sinusitis", "Chronic sinusitis",
  "Unspecified upper respiratory infections"
)

# Plotting series ####
carrier_tsm <- lapply(
  X = carrier_extract,
  FUN = function(x) {
    x$tsm
  }
)
control_tsm <- lapply(
  X = control_extract,
  FUN = function(x) {
    x$tsm
  }
)
carrier_tsm_se <- lapply(
  X = carrier_extract,
  FUN = function(x) {
    x$tsm_se
  }
)
control_tsm_se <- lapply(
  X = control_extract,
  FUN = function(x) {
    x$tsm_se
  }
)
for (j in seq_along(carrier_extract)) {
  xx_carrier <- c(
    stats::time(carrier_tsm[[j]]),
    rev(stats::time(carrier_tsm[[j]]))
  )
  yy_carrier <- c(
    carrier_tsm[[j]] - (crit_val * carrier_tsm_se[[j]]),
    rev(carrier_tsm[[j]] + (crit_val * carrier_tsm_se[[j]]))
  )
  xx_control <- c(
    stats::time(control_tsm[[j]]),
    rev(stats::time(control_tsm[[j]]))
  )
  yy_control <- c(
    control_tsm[[j]] - (crit_val * control_tsm_se[[j]]),
    rev(control_tsm[[j]] + (crit_val * control_tsm_se[[j]]))
  )
  tsm <- data.frame(
    tsm_carrier = carrier_tsm[[j]],
    tsm_control = control_tsm[[j]]
  )
  ylim <- floor(
    1.10 * c(
      min(c(yy_carrier, yy_control)),
      max(c(yy_carrier, yy_control))
    )
  )
  svglite::svglite(
    filename = paste0("./figures/trend/", names(carrier_extract)[j], ".svg")
  )
  graphics::par(oma = c(0, 0, 0, 7))
  astsa::tsplot(
    x = tsm,
    main = paste0("Global trend: ", plot_names[j]),
    col = col, lwd = 2,
    ylab = "Incidence per 10,000", xlab = "Time",
    ylim = ylim, spaghetti = TRUE
  )
  graphics::polygon(
    x = xx_carrier, y = yy_carrier,
    col = fill[1], border = FALSE
  )
  graphics::polygon(
    x = xx_control, y = yy_control,
    col = fill[2], border = FALSE
  )
  boonstra::legend_right(
    legend = c("Carriers", "Controls"), col = col, lty = 1, lwd = 2
  )
  grDevices::dev.off()
}