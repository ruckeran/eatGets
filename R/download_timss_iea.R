#' Download and import an empty TIMSS public use file.
#'
#' Download and import an empty TIMSS public use file (containing only the first data row) from the \href{https://www.iea.nl/data-tools/repository/icils}{IEA homepage}.
#'
#' The function downloads a zip file from the IEA homepage into a temporary directory,
#' unzips it and imports the data with only a single data row via \code{\link[haven]{read_sav}}.
#' For downloading full TIMSS data sets see the \href{https://cran.r-project.org/package=EdSurvey}{EdSurvey} package.
#' The data is imported as a \code{GADSdat} object.
#'
#'@param year Year of the assessment.
#'@param data_type Type of the data.
#'
#'@examples
#' fdz_timss <- download_timss(year = "2019",
#'                         data_type = "stud_par_dat")
#'@export
download_timss <- function(year = c("2019", "2015", "2011", "2007"),
                           data_type = c("stud_par_dat",
                                         "teach_dat", "teach_stud_dat",
                                         "school_dat",
                                         "tracking")) {
  ## input validation
  year <- match.arg(year)
  data_type <- match.arg(data_type)

  # URL table for each study, year and data type
  download_paths <- list(
    "2007" = list(
      stud_par_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/TIMSS/TIMSS2007/TIMSS2007_IDB_SPSS_G4.zip", dat_subdir = c("asadeum4.sav", "asgdeum4.sav", "asrdeum4.sav", "astdeum4.sav")),
      teach_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/TIMSS/TIMSS2007/TIMSS2007_IDB_SPSS_G4.zip", dat_subdir = "atgdeum4.sav"),
      school_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/TIMSS/TIMSS2007/TIMSS2007_IDB_SPSS_G4.zip", dat_subdir = "acgdeum4.sav")
    ),
    "2011" = list(
      stud_par_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/TIMSS/TIMSS2011/TIMSS2011_IDB_SPSS_G4.zip", dat_subdir = c("asadeum5.sav", "asgdeum5.sav", "ashdeum5.sav", "asrdeum5.sav", "astdeum5.sav")),
      teach_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/TIMSS/TIMSS2011/TIMSS2011_IDB_SPSS_G4.zip", dat_subdir = "atgdeum5.sav"),
      school_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/TIMSS/TIMSS2011/TIMSS2011_IDB_SPSS_G4.zip", dat_subdir = "acgdeum5.sav")
    ),
    "2015" = list(
      stud_par_dat = list(
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intcogn_v4.zip", dat_subdir = c("ASADEUM6.sav", "ASGDEUM6.sav", "ASHDEUM6.sav", "ASRDEUM6.sav", "ASTDEUM6.sav")),
      teach_dat = list(
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intscho.zip", dat_subdir = "ATGDEUM6.sav"),
      school_dat = list(
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intscho.zip", dat_subdir = "ACGDEUM6.sav")
    ),
    "2019" = list(
      stud_par_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/TIMSS/TIMSS2019/TIMSS2019_IDB_SPSS_G4.zip", dat_subdir = c("asadeub7.sav", "asadeum7.sav", "asadeuz7.sav", "asgdeub7.sav", "asgdeum7.sav", "asgdeuz7.sav", "ashdeub7.sav", "ashdeum7.sav", "ashdeuz7.sav", "asrdeub7.sav", "asrdeum7.sav", "asrdeuz7.sav", "astdeub7.sav", "astdeum7.sav", "astdeuz7.sav")),
      teach_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/TIMSS/TIMSS2019/TIMSS2019_IDB_SPSS_G4.zip", dat_subdir = c("atgdeub7.sav", "atgdeum7.sav", "atgdeuz7.sav")),
      # teach_stud_dat = list(
      #   zip_path = "https://www.iea.nl/sites/default/files/data-repository/TIMSS/TIMSS2019/TIMSS2019_IDB_SPSS_G4.zip", dat_subdir = "?"),
      school_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/TIMSS/TIMSS2019/TIMSS2019_IDB_SPSS_G4.zip", dat_subdir = c("acgdeub7.sav", "acgdeum7.sav", "acgdeuz7.sav"))
      # tracking = list(
      #   zip_path = "https://www.iea.nl/sites/default/files/data-repository/TIMSS/TIMSS2019/TIMSS2019_IDB_SPSS_G4.zip", dat_subdir = "?")
    )
  )

  # call up URL for specific combination
  if (year %in% names(download_paths) &&
      data_type %in% names(download_paths[[year]])) {

    download_path <- download_paths[[year]][[data_type]]
  } else {
    stop("The corresponding download has not been implemented yet.")
  }

  ### read data
  eatGADS::import_spss(download_path, checkVarNames = FALSE)
  #haven::read_sav(download_path, n_max = 1, user_na = TRUE)
}
