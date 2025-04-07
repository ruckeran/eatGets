test_that("2001: stud_par_dat was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2001", data_type = "stud_par_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

test_that("2001: teach_ger_dat was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2001", data_type = "teach_ger_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

test_that("2001: teach_math_dat was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2001", data_type = "teach_math_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

test_that("2001: teach_gen_dat was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2001", data_type = "teach_gen_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

test_that("2001: school_dat was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2001", data_type = "school_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

test_that("2006: stud_par_dat was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2006", data_type = "stud_par_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

test_that("2006: teach_dat was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2006", data_type = "teach_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

test_that("2006: school_dat was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2006", data_type = "school_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

test_that("2006: testscores was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2006", data_type = "testscores")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

test_that("2011: stud_par_dat was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2011", data_type = "stud_par_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

test_that("2011: teach_dat was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2011", data_type = "teach_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

test_that("2011: school_dat was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2011", data_type = "school_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

test_that("2016: stud_par_dat was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2016", data_type = "stud_par_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

test_that("2016: teach_dat was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2016", data_type = "teach_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

test_that("2016: teach_stud_dat was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2016", data_type = "teach_stud_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

test_that("2016: school_dat was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2016", data_type = "school_dat")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

test_that("2016: tracking was successfully downloaded", {
  iea_iglu <- download_iglu_iea(year = "2016", data_type = "tracking")
  # testing if result is a GADSdat
  expect_s3_class(iea_iglu, "GADSdat")
  # testing whether the data set is not empty
  expect_gt(ncol(iea_iglu$dat), 0)  # expecting more than 0 columns
})

# error tests
test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2001", data_type = "teach_dat"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2001", data_type = "testscores"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2001", data_type = "teach_stud_dat"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2001", data_type = "tracking"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2006", data_type = "teach_ger_dat"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2006", data_type = "teach_math_dat"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2006", data_type = "teach_gen_dat"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2006", data_type = "teach_stud_dat"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2006", data_type = "tracking"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2011", data_type = "teach_ger_dat"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2011", data_type = "teach_math_dat"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2011", data_type = "teach_gen_dat"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2011", data_type = "testscores"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2011", data_type = "teach_stud_dat"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2011", data_type = "tracking"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2016", data_type = "teach_ger_dat"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2016", data_type = "teach_math_dat"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2016", data_type = "teach_gen_dat"),
    "The combination of year and data type is not available."
  )
})

test_that("error for invalid combination", {
  expect_error(
    download_iglu_iea(year = "2016", data_type = "testscores"),
    "The combination of year and data type is not available."
  )
})
