#' Download and import an empty TVD public use file.
#'
#' Download and import an empty TVD public use file (containing only the first data row) from the \href{https://www.oecd.org/en/data/datasets/}{OECD homepage}.
#'
#' The function downloads a zip file from the OECD homepage into a temporary directory,
#' unzips it and imports the data with only a single data row via \code{\link[utils]{read.csv}}.
#' For downloading full TVD data sets see the \href{https://cran.r-project.org/package=EdSurvey}{EdSurvey} package.
#' The data is imported as a \code{GADSdat} object.
#'
#'@param data_type Type of the data.
#'
#'@examples
#' oecd_tvd <- download_tvd_oecd(data_type = "stud_dat")
#'@export
download_tvd_oecd <- function(data_type = c("stud_dat", "teach_dat", "teach_log_dat",
                                       "video_timss_dat", "video_dat", "video_subj_dat",
                                       "video_teach_dat", "video_third_dat", "artefact")) {

  ## input validation
  data_type <- match.arg(data_type)

  # URL table for each study, year and data type
  zip_url <- "https://web-archive.oecd.org/2020-11-16/569866-GTI%20Data%20csv.zip"

  download_paths <- list(
    stud_dat = list(list(zip_path = zip_url, dat_subdir = "GTI-Student-Data.csv")),
    teach_dat = list(list(zip_path = zip_url, dat_subdir = "GTI-Teacher-Data.csv")),
    teach_log_dat = list(list(zip_path = zip_url, dat_subdir = "GTI-TeachLog-Data.csv")),
    # video_timss_dat = list(list(zip_path = zip_url, dat_subdir = "GTI-VidComp-Data.csv")), #check necessary
    # video_dat = list(list(zip_path = zip_url, dat_subdir = "GTI-VidInd-Data.csv")), #check necessary
    # video_subj_dat = list(list(zip_path = zip_url, dat_subdir = "?no_data_in_excel")),
    # video_teach_dat = list(list(zip_path = zip_url, dat_subdir = "?no_data_in_excel")),
    # video_third_dat = list(list(zip_path = zip_url, dat_subdir = "?no_data_in_excel")),
    artefact = list(list(zip_path = zip_url, dat_subdir = "GTI-Artefact-Data.csv"))
  )

  # Check if the data type exists
  if (!(data_type %in% names(download_paths))) {
    stop("The corresponding download has not been implemented yet.")
  }

  # Extract zip_path and dat_subdir from the list
  path_info <- download_paths[[data_type]][[1]]
  zip_path <- path_info$zip_path
  dat_subdir <- path_info$dat_subdir

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
  haven_dat <- utils::read.csv(extracted_file_path, sep = ",", header = TRUE)
  GADS <- eatGADS:::new_savDat(haven_dat)
  eatGADS:::prepare_labels(GADS, checkVarNames = FALSE, labeledStrings = "drop")

  return(GADS)
}
