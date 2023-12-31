% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/func.R
\name{summary.ModelList}
\alias{summary.ModelList}
\title{Summary Method for ModelList class}
\usage{
\method{summary}{ModelList}(object, ...)
}
\arguments{
\item{object}{An object of ModelList class containing list of models; consider using \code{CreateModelList()} generator function to create this list then \code{newModelList()} to assign ModelList class.}

\item{...}{further arguments passed from generic function summary}
}
\value{
A nested dataframe containing tidy summaries of regression model outputs. Each row specifies each model in input list. Second column 'Summary' contains the nested model summaries.
}
\description{
A summary method for a ModelList class that generates compact summaries for models in list.
}
\examples{
m1 <- lm(lifeExp ~ year + pop + gdpPercap, gapminder::gapminder)
m2 <- lm(lifeExp ~ year, gapminder::gapminder)
mList <- CreateModelList(m1, m2)
mList <- newModelList(mList)
summary(mList)


}
