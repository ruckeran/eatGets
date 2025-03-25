test_that("2013: stud_nat_dat was successfully downloaded", {
  iea_icils <- download_icils_iea(year = "2013", data_type = "stud_nat_dat")
  # testing if result is a data frame
  expect_s3_class(iea_icils, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_icils$dat), 0)  # expecting more than 0 columns
})

test_that("2013: stud_int_dat was successfully downloaded", {
  iea_icils <- download_icils_iea(year = "2013", data_type = "stud_int_dat")
  # testing if result is a data frame
  expect_s3_class(iea_icils, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_icils$dat), 0)  # expecting more than 0 columns
})

test_that("2013: teach_nat_dat was successfully downloaded", {
  iea_icils <- download_icils_iea(year = "2013", data_type = "teach_nat_dat")
  # testing if result is a data frame
  expect_s3_class(iea_icils, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_icils$dat), 0)  # expecting more than 0 columns
})

test_that("2013: teach_int_dat was successfully downloaded", {
  iea_icils <- download_icils_iea(year = "2013", data_type = "teach_int_dat")
  # testing if result is a data frame
  expect_s3_class(iea_icils, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_icils$dat), 0)  # expecting more than 0 columns
})

test_that("2013: school_nat_dat was successfully downloaded", {
  iea_icils <- download_icils_iea(year = "2013", data_type = "school_nat_dat")
  # testing if result is a data frame
  expect_s3_class(iea_icils, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_icils$dat), 0)  # expecting more than 0 columns
})

test_that("2013: school_int_dat was successfully downloaded", {
  iea_icils <- download_icils_iea(year = "2013", data_type = "school_int_dat")
  # testing if result is a data frame
  expect_s3_class(iea_icils, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_icils$dat), 0)  # expecting more than 0 columns
})

test_that("2018: stud_dat was successfully downloaded", {
  iea_icils <- download_icils_iea(year = "2018", data_type = "stud_dat")
  # testing if result is a data frame
  expect_s3_class(iea_icils, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_icils$dat), 0)  # expecting more than 0 columns
})

test_that("2018: teach_dat was successfully downloaded", {
  iea_icils <- download_icils_iea(year = "2018", data_type = "teach_dat")
  # testing if result is a data frame
  expect_s3_class(iea_icils, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_icils$dat), 0)  # expecting more than 0 columns
})

test_that("2018: school_dat was successfully downloaded", {
  iea_icils <- download_icils_iea(year = "2018", data_type = "school_dat")
  # testing if result is a data frame
  expect_s3_class(iea_icils, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_icils$dat), 0)  # expecting more than 0 columns
})

test_that("2018: it_dat was successfully downloaded", {
  iea_icils <- download_icils_iea(year = "2018", data_type = "it_dat")
  # testing if result is a data frame
  expect_s3_class(iea_icils, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_icils$dat), 0)  # expecting more than 0 columns
})

# error tests
test_that("error for invalid combination", {
  expect_error(
    download_icils_iea(year = "2013", data_type = "it_dat"),
    "The combination of year and data type is not available."
  )
})
