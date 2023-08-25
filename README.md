# R-Package
Creating an R package: comparing outputs from linear regression models

## Comparing models

Compare models in a list according to the `coefficients` produced from the `summary` printed out from the `lm()` function as well as plots printed out from `plot()` of the `lm()` outputs

Input parameters for function should be a list of predefined linear regression models created from `lm()`.
The output will be a list of all coefficient values for each model in `mods` and 4 graphs of residuals.
Requires purrr, map packages.
