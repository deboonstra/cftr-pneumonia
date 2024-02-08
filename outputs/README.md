# outputs

This sub-directory contains all results produce by analysis conducted using script files from the `script` sub-directory. Additionally, the sub-directory contains *Rmarkdown* files displaying the results of the analyses performed. The *Rmarkdown* files are rendered assuming the working directory is the main `cftr-pneumonia` directory. There may be individual files or sub-directories listed in `outputs`. Generally, the `README.md` will provide a description of how these files are generated. Below are descriptions of files and sub-directories.

`outputs/carrier` 

contains results from the Bungeston and Cavanaugh (2005) structural decomposition perform by `scripts/split.R` and `scripts/extract.R` for the CF carriers. 

`outputs/control` 

contains results from the Bungeston and Cavanaugh (2005) structural decomposition perform by `scripts/split.R` and `scripts/extract.R` for the CF control. 

`results.Rmd` 

displays the results from the Bungeston and Cavanaugh (2005) structural decomposition of the CF carriers and control disease series. 