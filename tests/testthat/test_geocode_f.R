context("geocode_func")
##Testing the package


test_that("Overall test",{expect_that(round(as.numeric(geocode_f("London")$getCoordinate()[1,"lat"]),2),equals(51.51))
  expect_that(round(as.numeric(geocode_f("london,uk")$getCoordinate()["lon"]),2),equals(-0.13))
  expect_error(geocode_f("")$getCoordinate(),"arguments imply differing number of rows: 1, 0")
  expect_error(geocode_f(123)$getCoordinate(),"Please check again your input")
  expect_error(geocode_f()$getCoordinate(),"argument \"input\" is missing, with no default")
  expect_error(geocode_f("sdfdf @@@ ~~!!")$getCoordinate(),"city not found")
})

