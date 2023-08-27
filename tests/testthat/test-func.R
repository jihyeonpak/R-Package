# unit test for CreateModelList()devo
testthat::test_that("CreateModelList() works",{
  dataOld <- gapminder::gapminder %>% filter(year <= 2000)
  mod1 <- lm(lifeExp ~ year + pop + gdpPercap, dataOld)
  mod2 <- lm(lifeExp ~ year, dataOld)
  mList <- CreateModelList(mod1, mod2)
  testthat::expect_equal(is.list(mList), TRUE)
})

# unit test for newModelList()
testthat::test_that("newModelList() works",{
  dataOld <- gapminder::gapminder %>% filter(year <= 2000)
  mod1 <- lm(lifeExp ~ year + pop + gdpPercap, dataOld)
  mod2 <- lm(lifeExp ~ year, dataOld)
  mList <- newModelList(CreateModelList(mod1, mod2))
  testthat::expect_equal(class(mList), "ModelList")
})

#unit test for summary.ModelList()
testthat::test_that("summary.ModelList() works",{
  dataOld <- gapminder::gapminder %>% filter(year <= 2000)
  mod1 <- lm(lifeExp ~ year + pop + gdpPercap, dataOld)
  mod2 <- lm(lifeExp ~ year, dataOld)
  mList <- newModelList(CreateModelList(mod1, mod2))
  s <- summary.ModelList(mList)
  testthat::expect_equal(dim(s), c(2, 2))
})

#unit test for predict.ModelList()
testthat::test_that("predict.ModelList() works",{
  dataOld <- gapminder::gapminder %>% filter(year <= 2000)
  dataNew <- gapminder::gapminder %>% filter(year > 2000)
  mod1 <- lm(lifeExp ~ year + pop + gdpPercap, dataOld)
  mod2 <- lm(lifeExp ~ year, dataOld)
  mList <- newModelList(CreateModelList(mod1, mod2))
  p <- predict.ModelList(mList, newdata = dataNew)
  testthat::expect_equal(is.matrix(p), TRUE)
})
