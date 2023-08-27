# R-Package
Creating an R package and new class in R: ModelList  

This R package was created for an assignment in PH290: Biostatistical Computing (Xiongtao Dai) Fall 2022. For the assignment, I created an R package called ModelList that outputs a nested tibble containing summaries of input regression models, residual plots, and a matrix of predicted values through S3 objects and methods as a means of comparing models. On this page: see 'R/' directory for functions available in ModelList package, 'tests/' for all unit test files, and 'man/' for documentations of all functions.

Title: Contains all functions and class defintions for creating ModelList object  

Version: 0.0.0.9000  

Authors@R: 
    person("Jessica", "Pak", , "jhpak@berkeley.edu", role = c("aut", "cre"))  
    
Description: ModelList class is created to contain multiple regression models for easy manipulation. A summary method provides summaries of all input models. Predict method creates a matrix of predicted values from all input models.  

License: MIT + file LICENSE  

Encoding: UTF-8  

Roxygen: list(markdown = TRUE)  

RoxygenNote: 7.2.1  

Imports: 
    broom,
    dplyr,
    gapminder,
    magrittr,
    purrr,
    tibble  
    
Suggests: 
    testthat (>= 3.0.0)  
    
Config/testthat/edition: 3
