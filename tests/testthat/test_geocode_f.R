context("geocode_func")
##Testing the package


test_that("Overall test",{expect_that(as.numeric(geocode_f("New York")$getCoordinate()["lat"]),equals(40.73))
  expect_that(round(as.numeric(geocode_f("New York")$getCoordinate()["lon"]),2),equals(-73.99))
  expect_error(geocode_f("")$getCoordinate(),"arguments imply differing number of rows: 1, 0")
  expect_error(geocode_f(123)$getCoordinate(),"Please check again your input")
  expect_error(geocode_f()$getCoordinate(),"argument \"input\" is missing, with no default")
  expect_error(geocode_f("sdfdf @@@ ~~!!")$getCoordinate(),"city not found")
})

