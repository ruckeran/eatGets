#' Download and import an empty PISA public use file.
#'
#' Download and import an empty PISA public use file (zero rows, but full metadata)
#' from the \href{https://www.oecd.org/en/data/datasets/}{OECD homepage}.
#'
#' For PISA 2000–2012 the function uses the \pkg{EdSurvey} workflow (\code{downloadPISA},
#' \code{readPISA}) and converts the resulting file formats into a \code{GADSdat} object
#' with zero rows but full metadata.
#' For PISA 2015 and 2018 the function downloads a zip file from the OECD homepage into a
#' temporary directory, unzips it and imports the data via
#' \code{\link[haven]{read_sav}} or \code{\link[utils]{read.table}}.
#'
#' For downloading full PISA data sets see the \href{https://cran.r-project.org/package=EdSurvey}{EdSurvey} package.
#'
#' @param year Year of the assessment.
#' @param data_type Type of the data.
#'
#' @examples
#' oecd_pisa <- download_pisa_oecd(year = "2018",
#'                         data_type = "school_dat")
#' @export
download_pisa_oecd <- function(
    year = c("2018", "2015", "2012", "2009", "2006", "2003", "2000"),
    data_type = c("stud_dat_9kl", "stud_dat_15j", "stud_par_dat",
                  "stud_par_dat_9kl", "stud_par_dat_15j",
                  "par_dat", "par_dat_9kl", "par_dat_15j",
                  "teach_dat", "teach_dat_9kl", "teach_dat_15j",
                  "school_dat", "school_dat_9kl", "school_dat_15j",
                  "matching", "timing")
) {
  # Input validation
  year <- match.arg(year)
  data_type <- match.arg(data_type)


## 1) Early years 2000–2012: EdSurvey workflow -----------------------------------------------------

  early_years <- c("2000", "2003", "2006", "2009", "2012")
  if (year %in% early_years) {
    return(.download_pisa_edSurvey_to_GADS(year = year, data_type = data_type))
  }

## 2) Later years 2015-2018: direct download from OECD ---------------------------------------------

  # URL table for each study, year, and data type
  download_paths <- list(
    "2015" = list(
      stud_par_dat_15j = list(
        list(zip_path = "https://webfs.oecd.org/pisa/PUF_SPSS_COMBINED_CMB_STU_QQQ.zip",
             dat_subdir = c("CY6_MS_CMB_STU_QQQ.sav", "CY6_MS_CMB_STU_QQ2.sav")),
        list(zip_path = "https://webfs.oecd.org/pisa/PUF_SPSS_COMBINED_CMB_STU_COG.zip",
             dat_subdir = "CY6_MS_CMB_STU_COG.sav")
      ),
      teach_dat = list(
        list(zip_path = "https://webfs.oecd.org/pisa/PUF_SPSS_COMBINED_CMB_TCH_QQQ.zip",
             dat_subdir = "CY6_MS_CMB_TCH_QQQ.sav")
      ),
      school_dat = list(
        list(zip_path = "https://webfs.oecd.org/pisa/PUF_SPSS_COMBINED_CMB_SCH_QQQ.zip",
             dat_subdir = "CY6_MS_CMB_SCH_QQQ.sav")
      ),
      timing = list(
        list(zip_path = "https://webfs.oecd.org/pisa/PUF_SPSS_COMBINED_CMB_STU_QTM.zip",
             dat_subdir = "CY6_MS_CMB_STU_QTM.sav")
      )
    ),
    "2018" = list(
      stud_par_dat_15j = list(
        list(zip_path = "https://webfs.oecd.org/pisa2018/SPSS_STU_QQQ.zip",
             dat_subdir = "CY07_MSU_STU_QQQ.sav"),
        list(zip_path = "https://webfs.oecd.org/pisa2018/SPSS_STU_COG.zip",
             dat_subdir = "CY07_MSU_STU_COG.sav")
      ),
      teach_dat = list(
        list(zip_path = "https://webfs.oecd.org/pisa2018/SPSS_TCH_QQQ.zip",
             dat_subdir = "CY07_MSU_TCH_QQQ.sav")
      ),
      school_dat = list(
        list(zip_path = "https://webfs.oecd.org/pisa2018/SPSS_SCH_QQQ.zip",
             dat_subdir = "CY07_MSU_SCH_QQQ.sav")
      ),
      timing = list(
        list(zip_path = "https://webfs.oecd.org/pisa2018/SPSS_STU_TIM.zip",
             dat_subdir = "CY07_MSU_STU_TIM.sav")
      )
    )
  )

  # Call up URL for specific combination
  if (year %in% names(download_paths) && data_type %in% names(download_paths[[year]])) {
    zip_path   <- download_paths[[year]][[data_type]][[1]]$zip_path
    dat_subdir <- download_paths[[year]][[data_type]][[1]]$dat_subdir
  } else {
    stop("The combination of year and data type is not available.")
  }

  # Set up temporary folder
  temp_folder <- tempdir()

  # Set timeout for downloading large files
  old_timeout <- getOption("timeout")
  options(timeout = max(600, old_timeout))
  on.exit(options(timeout = old_timeout), add = TRUE)

  # Download the zip file
  zip_file <- file.path(temp_folder, "data.zip")
  tryCatch({
    utils::download.file(
      url      = zip_path,
      destfile = zip_file,
      headers  = c("User-Agent" = "Mozilla/5.0") # to bypass 403
    )
  }, error = function(e) {
    stop("Failed to download the file: ", e$message)
  })

  # Recursive search for the file in the archive
  zip_contents <- utils::unzip(zipfile = zip_file, list = TRUE)

  # allow that dat_subdir can be a vector of patterns (for more than one data set)
  patterns <- basename(dat_subdir)
  matches_logical <- Reduce(
    `|`,
    lapply(patterns, function(p) grepl(p, zip_contents$Name, ignore.case = TRUE))
  )
  matching_files <- zip_contents$Name[matches_logical]

  if (length(matching_files) == 0) {
    stop("No matching files found in the zip archive.")
  }

  # Unzip the first required file from the archive
  unzip_folder <- file.path(temp_folder, "unzipped_data")
  utils::unzip(zipfile = zip_file, files = matching_files[1], exdir = unzip_folder)

  # Construct the full path to the extracted data file
  extracted_file_path <- file.path(unzip_folder, matching_files[1])

  # Import and convert to GADSdat
  .import_pisa_file_to_GADS(extracted_file_path)
}
