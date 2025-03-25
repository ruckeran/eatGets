test_that("stud_dat was successfully downloaded", {
  oecd_tvd <- download_tvd_oecd(data_type = "stud_dat")
  # testing if result is a data.frame
  expect_s3_class(oecd_tvd, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(oecd_tvd), 0)  # expecting more than 0 columns
})

test_that("teach_dat was successfully downloaded", {
  oecd_tvd <- download_tvd_oecd(data_type = "teach_dat")
  # testing if result is a data.frame
  expect_s3_class(oecd_tvd, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(oecd_tvd), 0)  # expecting more than 0 columns
})

test_that("teach_log_dat was successfully downloaded", {
  oecd_tvd <- download_tvd_oecd(data_type = "teach_log_dat")
  # testing if result is a data.frame
  expect_s3_class(oecd_tvd, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(oecd_tvd), 0)  # expecting more than 0 columns
})

test_that("video_timss_dat was successfully downloaded", {
  oecd_tvd <- download_tvd_oecd(data_type = "video_timss_dat")
  # testing if result is a data.frame
  expect_s3_class(oecd_tvd, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(oecd_tvd), 0)  # expecting more than 0 columns
})

test_that("video_dat was successfully downloaded", {
  oecd_tvd <- download_tvd_oecd(data_type = "video_dat")
  # testing if result is a data.frame
  expect_s3_class(oecd_tvd, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(oecd_tvd), 0)  # expecting more than 0 columns
})

test_that("video_subj_dat was successfully downloaded", {
  oecd_tvd <- download_tvd_oecd(data_type = "video_subj_dat")
  # testing if result is a data.frame
  expect_s3_class(oecd_tvd, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(oecd_tvd), 0)  # expecting more than 0 columns
})

test_that("video_teach_dat was successfully downloaded", {
  oecd_tvd <- download_tvd_oecd(data_type = "video_teach_dat")
  # testing if result is a data.frame
  expect_s3_class(oecd_tvd, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(oecd_tvd), 0)  # expecting more than 0 columns
})

test_that("video_third_dat was successfully downloaded", {
  oecd_tvd <- download_tvd_oecd(data_type = "video_third_dat")
  # testing if result is a data.frame
  expect_s3_class(oecd_tvd, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(oecd_tvd), 0)  # expecting more than 0 columns
})

test_that("artefact was successfully downloaded", {
  oecd_tvd <- download_tvd_oecd(data_type = "artefact")
  # testing if result is a data.frame
  expect_s3_class(oecd_tvd, "data.frame")
  # testing whether the data set is not empty
  expect_gt(ncol(oecd_tvd), 0)  # expecting more than 0 columns
})

