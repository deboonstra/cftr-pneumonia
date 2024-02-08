# scripts/figures

This sub-directory contains the scripts file needed to produce all figures. Below are descriptions of script files. Generally, the figures produced by these script files will be directed to the `figures` sub-directory of the main `cftr-pneumonia` direcotry. At the beginning of each of these script files, a comment will be written that describes the utility of the script file. All scripts execute assuming the working directory is the main `cftr-pneumonia` directory. Usually, the figures will be SVG as they provide high-quality images with small file sizes. The SVGs may be converted to other formats using various methods. Below are descriptions of script files.

`obs.R`

generates a collection for figures for the observed disease series modeled using the Bungeston and Cavanaugh (2005) structural decomposition method. The resulting figures are located in the `figures/obs` sub-directory.

`trend.R`

generates a collection for figures for the global trend of the disease series modeled using the Bungeston and Cavanaugh (2005) structural decomposition method. The resulting figures are located in the `figures/trend` sub-directory.

`seasonal.R`

generates a collection for figures for the seasonal trend of the disease series modeled using the Bungeston and Cavanaugh (2005) structural decomposition method. The resulting figures are located in the `figures/seasonal` sub-directory.

`local.R`

generates a collection for figures for the local trend of the disease series modeled using the Bungeston and Cavanaugh (2005) structural decomposition method. The resulting figures are located in the `figures/local` sub-directory.