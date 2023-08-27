## Functions and class definitions for Package: ModelList

#' Create Model List
#'
#' A generator function that creates a list of regression models assigned to objects that were predefined by user.
#' @param ... All objects containing regression models to be put into a list.
#' @return A list containing all regression models from user input.
#' @import gapminder
#' @examples
#' m1 <- lm(lifeExp ~ year + pop + gdpPercap, gapminder::gapminder)
#' m2 <- lm(lifeExp ~ year, gapminder::gapminder)
#' mList <- CreateModelList(m1, m2)
#'
#'
#' @export
CreateModelList <- function(...){
  models <- list(...)
  return(models)
}



#' Creating ModelList class
#'
#' A function to implement class ModelList for a list input containing regression models. This class holds multiple models for manipulation.
#' @param  list A list of models; consider using CreateModelList generator function to create this list.
#' @return A S3 class ModelList object, containing regression models
#' @import gapminder
#' @examples
#' m1 <- lm(lifeExp ~ year + pop + gdpPercap, gapminder::gapminder)
#' m2 <- lm(lifeExp ~ year, gapminder::gapminder)
#' mList <- CreateModelList(m1, m2)
#' mList <- newModelList(mList)
#'
#'
#' @export
newModelList <- function(list){
  stopifnot(is.list(list))

  structure(
    list,
    class = "ModelList"
  )
}



#' Summary Method for ModelList class
#'
#' A summary method for a ModelList class that generates compact summaries for models in list.
#' @param object An object of ModelList class containing list of models; consider using `CreateModelList()` generator function to create this list then `newModelList()` to assign ModelList class.
#' @param ... further arguments passed from generic function summary
#' @return A nested dataframe containing tidy summaries of regression model outputs. Each row specifies each model in input list. Second column 'Summary' contains the nested model summaries.
#' @import dplyr
#' @import gapminder
#' @importFrom tibble tibble
#' @importFrom broom tidy
#' @importFrom purrr map
#' @examples
#' m1 <- lm(lifeExp ~ year + pop + gdpPercap, gapminder::gapminder)
#' m2 <- lm(lifeExp ~ year, gapminder::gapminder)
#' mList <- CreateModelList(m1, m2)
#' mList <- newModelList(mList)
#' summary(mList)
#'
#'
#' @export
summary.ModelList <- function(object, ...){

  mods <- purrr::map(seq_along(1:length(object)), function(i) paste0("Model",i))
  sums <- purrr::map(object, function(x){
    # if model built from rpart
    if (is.null(x$variable.importance) == FALSE) {
      a <- x$variable.importance %>%
        tibble::tibble(variable = names(x$variable.importance),
                       importance = as.vector(x$variable.importance),
                       row.names = NULL) %>%
        dplyr::select(variable, importance)
      # if model compatible with broom::tidy
    } else {
      a <- broom::tidy(x)
    }
    return(a)
  })

  output <- tibble::tibble(Models = mods, Summary = sums)
  return(output)
}




#' Predict Method for ModelList class
#'
#' A predict method for a ModelList class that gets all predicted values for models contained in ModelList class object.
#' @param object An object of ModelList class containing list of models; consider using `CreateModelList()` generator function to create this list then `newModelList()` to assign ModelList class.
#' @param ... further arguments passed from generic function predict
#' @return A matrix with number of columns equal to the number of models in ModelList, each column containing the predicted values for model evaluated on the new dataframe specified by user input.
#' @import gapminder
#' @importFrom dplyr filter
#' @importFrom purrr map
#' @importFrom stats predict
#' @examples
#' m1 <- lm(lifeExp ~ year + pop + gdpPercap, gapminder::gapminder)
#' m2 <- lm(lifeExp ~ year, gapminder::gapminder)
#' mList <- newModelList(CreateModelList(m1, m2))
#' data <- dplyr::filter(gapminder::gapminder, year >2000)
#' predict(mList, newdata= data)
#'
#' @export
predict.ModelList <- function(object, ...){
  predList <- purrr::map(object, function(x){
    stats::predict(x, ...)
  })

  preds <- as.matrix(data.frame(do.call(cbind, predList)))
  return(preds)
}
