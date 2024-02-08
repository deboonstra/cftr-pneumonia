# The function of this script file is generate a collection for figures for the
# seasonal trend of the disease series.

# Loading libraries and function ####
R <- list.files(path = "./R", pattern = "*.R", full.names = TRUE)
sapply(R, source, .GlobalEnv)

# Creating figure sub-directories ####
if (!dir.exists("./figures/seasonal/")) {
  dir.create("./figures/seasonal/")
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
carrier_ssm <- lapply(
  X = carrier_extract,
  FUN = function(x) {
    x$ssm
  }
)
control_ssm <- lapply(
  X = control_extract,
  FUN = function(x) {
    x$ssm
  }
)
carrier_ssm_se <- lapply(
  X = carrier_extract,
  FUN = function(x) {
    x$ssm_se
  }
)
control_ssm_se <- lapply(
  X = control_extract,
  FUN = function(x) {
    x$ssm_se
  }
)
for (j in seq_along(carrier_extract)) {
  xx_carrier <- c(
    stats::time(carrier_ssm[[j]]),
    rev(stats::time(carrier_ssm[[j]]))
  )
  yy_carrier <- c(
    carrier_ssm[[j]] - (crit_val * carrier_ssm_se[[j]]),
    rev(carrier_ssm[[j]] + (crit_val * carrier_ssm_se[[j]]))
  )
  xx_control <- c(
    stats::time(control_ssm[[j]]),
    rev(stats::time(control_ssm[[j]]))
  )
  yy_control <- c(
    control_ssm[[j]] - (crit_val * control_ssm_se[[j]]),
    rev(control_ssm[[j]] + (crit_val * control_ssm_se[[j]]))
  )
  ssm <- data.frame(
    ssm_carrier = carrier_ssm[[j]],
    ssm_control = control_ssm[[j]]
  )
  ylim <- floor(
    1.10 * c(
      min(c(yy_carrier, yy_control)),
      max(c(yy_carrier, yy_control))
    )
  )
  svglite::svglite(
    filename = paste0("./figures/seasonal/", names(carrier_extract)[j], ".svg")
  )
  graphics::par(oma = c(0, 0, 0, 7))
  astsa::tsplot(
    x = ssm,
    main = paste0("Seasonal trend: ", plot_names[j]),
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