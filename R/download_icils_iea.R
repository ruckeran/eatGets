#' Download and import an empty ICILS public use file.
#'
#' Download and import an empty ICILS public use file (containing only the first data row) from the \href{https://www.iea.nl/data-tools/repository/icils}{IEA homepage}.
#'
#' The function downloads a zip file from the IEA homepage into a temporary directory,
#' unzips it and imports the data with only a single data row via \code{\link[haven]{read_sav}}.
#' For downloading full ICILS data sets see the \href{https://cran.r-project.org/package=EdSurvey}{EdSurvey} package.
#' The data is imported as a \code{GADSdat} object.
#'
#'@param year Year of the assessment.
#'@param data_type Type of the data.
#'
#'@examples
#' iea_icils <- download_icils_iea(year = "2018",
#'                         data_type = "stud_dat")
#'@export
download_icils_iea <- function(year = c("2018", "2013"),
                               data_type = c("stud_dat", "stud_nat_dat", "stud_int_dat",
                                             "teach_dat", "teach_nat_dat", "teach_int_dat",
                                             "school_dat", "school_nat_dat", "school_int_dat",
                                             "it_dat")) {
  ## input validation
  year <- match.arg(year)
  data_type <- match.arg(data_type)

  # URL table for each study, year and data type
  download_paths <- list(
    "2013" = list(
      stud_nat_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/ICILS/ICILS2013/ICILS2013_IDB_SPSS.zip",
        dat_subdir = "BSGDEUI1.sav"
      ),
      # stud_int_dat = list(
      #   zip_path = "https://www.iea.nl/sites/default/files/data-repository/ICILS/ICILS2013/ICILS2013_IDB_SPSS.zip",
      #   dat_subdir = "CY07_MSU_STU_QQQ.sav"
      # ),
      teach_nat_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/ICILS/ICILS2013/ICILS2013_IDB_SPSS.zip",
        dat_subdir = "BTGDEUI1.sav"
      ),
      # teach_int_dat = list(
      #   zip_path = "https://www.iea.nl/sites/default/files/data-repository/ICILS/ICILS2013/ICILS2013_IDB_SPSS.zip",
      #   dat_subdir = "CY07_MSU_STU_QQQ.sav"
      # ),
      school_nat_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/ICILS/ICILS2013/ICILS2013_IDB_SPSS.zip",
        dat_subdir = "BCGDEUI1.sav"
      # ),
      # school_int_dat = list(
      #   zip_path = "https://www.iea.nl/sites/default/files/data-repository/ICILS/ICILS2013/ICILS2013_IDB_SPSS.zip",
      #   dat_subdir = "CY07_MSU_STU_QQQ.sav"
      )
    ),
    "2018" = list(
      stud_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/ICILS/ICILS2018/ICILS2018_IDB_SPSS.zip",
        dat_subdir = "BSGDEUI2.sav"
      ),
      teach_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/ICILS/ICILS2018/ICILS2018_IDB_SPSS.zip",
        dat_subdir = "BTGDEUI2.sav"
      ),
      school_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/ICILS/ICILS2018/ICILS2018_IDB_SPSS.zip",
        dat_subdir = "BTGDEUI1.sav"
      # ),
      # it_dat = list(
      #   zip_path = "https://www.iea.nl/sites/default/files/data-repository/ICILS/ICILS2018/ICILS2018_IDB_SPSS.zip",
      #   dat_subdir = "CY07_MSU_STU_QQQ.sav"
      )
    )
  )

  # call up URL for specific combination
  if (year %in% names(download_paths) &&
      data_type %in% names(download_paths[[year]])) {

    zip_path <- download_paths[[year]][[data_type]]$zip_path
    dat_subdir <- download_paths[[year]][[data_type]]$dat_subdir
  } else {
    stop("The corresponding download has not been implemented yet.")
  }

  ## Set up temporary folder
  temp_folder <- tempdir()

  # Set timeout for downloading large files
  old_timeout <- getOption("timeout")
  options(timeout = max(300, old_timeout))
  on.exit(options(timeout = old_timeout))

  ## Download the zip file
  zip_file <- file.path(temp_folder, "data.zip")
  utils::download.file(url = zip_path, destfile = zip_file)

  ## Recursive search for the file in the archive
  zip_contents <- utils::unzip(zipfile = zip_file, list = TRUE)
  matching_files <- zip_contents$Name[grepl(basename(dat_subdir), zip_contents$Name, ignore.case = TRUE)]

  ## Unzip the required file from the archive
  unzip_folder <- file.path(temp_folder, "unzipped_data")
  utils::unzip(zipfile = zip_file, files = matching_files[1], exdir = unzip_folder)

  ## Construct the full path to the extracted data file
  extracted_file_path <- file.path(unzip_folder, matching_files[1])

  ## Import the data using haven and convert to GADSdat
  haven_dat <- haven::read_sav(extracted_file_path, n_max = 1, user_na = TRUE)
  GADS <- eatGADS:::new_savDat(haven_dat)
  eatGADS:::prepare_labels(GADS, checkVarNames = FALSE, labeledStrings = "drop")

  return(GADS)
}
