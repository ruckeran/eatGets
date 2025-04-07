test_that("2007: stud_par_dat was successfully downloaded", {
  iea_timss <- download_timss_iea(year = "2007", data_type = "stud_par_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_timss, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_timss$dat), 0)  # expecting more than 0 columns
})

test_that("2007: teach_dat was successfully downloaded", {
  iea_timss <- download_timss_iea(year = "2007", data_type = "teach_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_timss, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_timss$dat), 0)  # expecting more than 0 columns
})

test_that("2007: school_dat was successfully downloaded", {
  iea_timss <- download_timss_iea(year = "2007", data_type = "school_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_timss, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_timss$dat), 0)  # expecting more than 0 columns
})

test_that("2011: stud_par_dat was successfully downloaded", {
  iea_timss <- download_timss_iea(year = "2011", data_type = "stud_par_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_timss, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_timss$dat), 0)  # expecting more than 0 columns
})

test_that("2011: teach_dat was successfully downloaded", {
  iea_timss <- download_timss_iea(year = "2011", data_type = "teach_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_timss, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_timss$dat), 0)  # expecting more than 0 columns
})

test_that("2011: school_dat was successfully downloaded", {
  iea_timss <- download_timss_iea(year = "2011", data_type = "school_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_timss, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_timss$dat), 0)  # expecting more than 0 columns
})

test_that("2015: stud_par_dat was successfully downloaded", {
  iea_timss <- download_timss_iea(year = "2015", data_type = "stud_par_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_timss, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_timss$dat), 0)  # expecting more than 0 columns
})

test_that("2015: teach_dat was successfully downloaded", {
  iea_timss <- download_timss_iea(year = "2015", data_type = "teach_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_timss, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_timss$dat), 0)  # expecting more than 0 columns
})

test_that("2015: school_dat was successfully downloaded", {
  iea_timss <- download_timss_iea(year = "2015", data_type = "school_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_timss, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_timss$dat), 0)  # expecting more than 0 columns
})

test_that("2019: stud_par_dat was successfully downloaded", {
  iea_timss <- download_timss_iea(year = "2019", data_type = "stud_par_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_timss, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_timss$dat), 0)  # expecting more than 0 columns
})

test_that("2019: teach_dat was successfully downloaded", {
  iea_timss <- download_timss_iea(year = "2019", data_type = "teach_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_timss, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_timss$dat), 0)  # expecting more than 0 columns
})

test_that("2019: teach_stud_dat was successfully downloaded", {
  iea_timss <- download_timss_iea(year = "2019", data_type = "teach_stud_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_timss, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_timss$dat), 0)  # expecting more than 0 columns
})

test_that("2019: school_dat was successfully downloaded", {
  iea_timss <- download_timss_iea(year = "2019", data_type = "school_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_timss, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_timss$dat), 0)  # expecting more than 0 columns
})

test_that("2019: tracking was successfully downloaded", {
  iea_timss <- download_timss_iea(year = "2019", data_type = "tracking")
  # testing if result is a GADSdat
  expect_s3_class(iea_timss, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_timss$dat), 0)  # expecting more than 0 columns
})

# error tests
test_that("error for invalid combination", {
  expect_error(
    download_timss_iea(year = "2007", data_type = "teach_stud_dat"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_timss_iea(year = "2007", data_type = "tracking"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_timss_iea(year = "2011", data_type = "teach_stud_dat"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_timss_iea(year = "2011", data_type = "tracking"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_timss_iea(year = "2015", data_type = "teach_stud_dat"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_timss_iea(year = "2015", data_type = "tracking"),
    "The combination of year and data type is not available."
  )
})

