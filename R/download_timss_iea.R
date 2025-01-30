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
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intcogn_v4.zip", dat_subdir = "intcogn_v4.txt"),
      teach_dat = list(
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intscho.zip", dat_subdir = "intscho.txt"),
      school_dat = list(
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intscho.zip", dat_subdir = "intscho.txt")
    ),
    "2011" = list(
      stud_par_dat = list(
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intcogn_v4.zip", dat_subdir = "intcogn_v4.txt"),
      teach_dat = list(
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intscho.zip", dat_subdir = "intscho.txt"),
      school_dat = list(
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intscho.zip", dat_subdir = "intscho.txt")
    ),
    "2015" = list(
      stud_par_dat = list(
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intcogn_v4.zip", dat_subdir = "intcogn_v4.txt"),
      teach_dat = list(
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intscho.zip", dat_subdir = "intscho.txt"),
      school_dat = list(
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intscho.zip", dat_subdir = "intscho.txt")
    ),
    "2019" = list(
      stud_par_dat = list(
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intcogn_v4.zip", dat_subdir = "intcogn_v4.txt"),
      teach_dat = list(
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intscho.zip", dat_subdir = "intscho.txt"),
      teach_stud_dat = list(
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intscho.zip", dat_subdir = "intscho.txt"),
      school_dat = list(
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intscho.zip", dat_subdir = "intscho.txt"),
      tracking = list(
        zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intscho.zip", dat_subdir = "intscho.txt")
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
