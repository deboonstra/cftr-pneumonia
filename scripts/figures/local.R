# The function of this script file is generate a collection for figures for the
# local trend of the disease series.

# Loading libraries and function ####
R <- list.files(path = "./R", pattern = "*.R", full.names = TRUE)
sapply(R, source, .GlobalEnv)

# Creating figure sub-directories ####
if (!dir.exists("./figures/local/")) {
  dir.create("./figures/local/")
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
carrier_asm <- lapply(
  X = carrier_extract,
  FUN = function(x) {
    x$asm
  }
)
control_asm <- lapply(
  X = control_extract,
  FUN = function(x) {
    x$asm
  }
)
for (j in seq_along(carrier_extract)) {
  asm <- data.frame(
    obs_carrier = carrier_asm[[j]],
    obs_control = control_asm[[j]]
  )
  svglite::svglite(
    filename = paste0("./figures/local/", names(carrier_extract)[j], ".svg")
  )
  graphics::par(oma = c(0, 0, 0, 7))
  astsa::tsplot(
    x = asm,
    main = paste0("Local trend: ", plot_names[j]),
    col = col, lwd = 2,
    ylab = "Incidence per 10,000",
    xlab = "Time",
    spaghetti = TRUE
  )
  boonstra::legend_right(
    legend = c("Carriers", "Controls"), col = col, lty = 1, lwd = 2
  )
  grDevices::dev.off()
}