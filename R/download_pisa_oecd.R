#' Download and import an empty PISA public use file.
#'
#' Download and import an empty PISA public use file (containing only the first data row) from the \href{https://www.oecd.org/en/data/datasets/}{OECD homepage}.
#'
#' The function downloads a zip file from the OECD homepage into a temporary directory,
#' unzips it and imports the data with only a single data row via \code{\link[haven]{read_sav}} or \code{\link[utils]{read.table}}.
#' For downloading full PISA data sets see the \href{https://cran.r-project.org/package=EdSurvey}{EdSurvey} package.
#' The data is imported as a \code{GADSdat} object.
#'
#'@param year Year of the assessment.
#'@param data_type Type of the data.
#'
#'@examples
#' oecd_pisa <- download_pisa_oecd(year = "2018",
#'                         data_type = "school_dat")
#'@export
download_pisa_oecd <- function(year = c("2018", "2015", "2012", "2009", "2006", "2003", "2000"),
                               data_type = c("stud_dat_9kl", "stud_dat_15j", "stud_par_dat",
                                             "stud_par_dat_9kl", "stud_par_dat_15j",
                                             "par_dat", "par_dat_9kl", "par_dat_15j",
                                             "teach_dat", "teach_dat_9kl", "teach_dat_15j",
                                             "school_dat", "school_dat_9kl", "school_dat_15j",
                                             "matching", "timing")) {
  # Input validation
  year <- match.arg(year)
  data_type <- match.arg(data_type)

  # URL table for each study, year, and data type
  download_paths <- list(
    "2000" = list(
      stud_dat_15j = list(
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intcogn_v4.zip", dat_subdir = "intcogn_v4.txt"),
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intstud_math.zip", dat_subdir = "intstud_math_v3.txt"),
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intstud_read.zip", dat_subdir = "intstud_read_v3.txt"),
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intstud_scie.zip", dat_subdir = "intstud_scie_v3.txt")
      ),
      school_dat = list(
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intscho.zip", dat_subdir = "intscho.txt")
      )
    ),
    "2003" = list(
      stud_dat_15j = list(
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2003-datasets/data-sets-in-txt-formats/INT_cogn_2003.zip", dat_subdir = "INT_cogn_2003_v2.txt"),
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2003-datasets/data-sets-in-txt-formats/INT_stui_2003_v2.zip", dat_subdir = "INT_stui_2003_v2.txt")
      ),
      school_dat_15j = list(
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2003-datasets/data-sets-in-txt-formats/INT_schi_2003.zip", dat_subdir = "INT_schi_2003.txt")
      )
    ),
    "2006" = list(
      stud_dat_15j = list(
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2006-datasets/data-sets-in-txt-format/INT_Cogn06_T_Dec07.zip", dat_subdir = "INT_Cogn06_T_Dec07.txt"),
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2006-datasets/data-sets-in-txt-format/INT_Cogn06_S_Dec07.zip", dat_subdir = "INT_Cogn06_S_Dec07.txt"),
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2006-datasets/data-sets-in-txt-format/INT_Stu06_Dec07.zip", dat_subdir = "INT_Stu06_Dec07.txt")),
      school_dat = list(
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2006-datasets/data-sets-in-txt-format/INT_Sch06_Dec07.zip", dat_subdir = "INT_Sch06_Dec07.txt")),
      par_dat_15j = list(
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2006-datasets/data-sets-in-txt-format/INT_Par06_Dec07.zip", dat_subdir = "INT_Par06_Dec07.txt"))
    ),
    "2009" = list(
      stud_par_dat = list(
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2009-datasets/data-sets-in-txt-format/INT_STQ09_DEC11.zip", dat_subdir = "INT_STQ09_DEC11.txt"),
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2009-datasets/data-sets-in-txt-format/INT_PAR09_DEC11.zip", dat_subdir = "INT_PAR09_DEC11.txt"),
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2009-datasets/data-sets-in-txt-format/INT_COG09_TD_DEC11.zip", dat_subdir = "INT_COG09_TD_DEC11.txt")),
      school_dat = list(
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2009-datasets/data-sets-in-txt-format/INT_SCQ09_Dec11.zip", dat_subdir = "INT_SCQ09_Dec11.txt"))
    ),
    "2012" = list(
      stud_dat_15j = list(
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2012-datasets/main-survey/data-sets-in-txt-format/INT_STU12_DEC03.zip", dat_subdir = "INT_STU12_DEC03.txt"),
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2012-datasets/main-survey/data-sets-in-txt-format/INT_COG12_S_DEC03.zip", dat_subdir = "INT_COG12_S_DEC03.txt")),
      school_dat = list(
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2012-datasets/main-survey/data-sets-in-txt-format/INT_SCQ12_DEC03.zip", dat_subdir = "INT_SCQ12_DEC03.txt")),
      par_dat = list(
        list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2012-datasets/main-survey/data-sets-in-txt-format/INT_PAQ12_DEC03.zip", dat_subdir = "INT_PAQ12_DEC03.txt"))
    ),
    "2015" = list(
      stud_par_dat_15j = list(
        list(zip_path = "https://webfs.oecd.org/pisa/PUF_SPSS_COMBINED_CMB_STU_QQQ.zip", dat_subdir = c("CY6_MS_CMB_STU_QQQ.sav", "CY6_MS_CMB_STU_QQ2.sav")),
        list(zip_path = "https://webfs.oecd.org/pisa/PUF_SPSS_COMBINED_CMB_STU_COG.zip", dat_subdir = "CY6_MS_CMB_STU_COG.sav")),
      teach_dat = list(
        list(zip_path = "https://webfs.oecd.org/pisa/PUF_SPSS_COMBINED_CMB_TCH_QQQ.zip", dat_subdir = "CY6_MS_CMB_TCH_QQQ.sav")),
      school_dat = list(
        list(zip_path = "https://webfs.oecd.org/pisa/PUF_SPSS_COMBINED_CMB_SCH_QQQ.zip", dat_subdir = "CY6_MS_CMB_SCH_QQQ.sav")),
      timing = list(
        list(zip_path = "https://webfs.oecd.org/pisa/PUF_SPSS_COMBINED_CMB_STU_QTM.zip", dat_subdir = "CY6_MS_CMB_STU_QTM.sav"))
    ),
    "2018" = list(
      stud_par_dat_15j = list(
        list(zip_path = "https://webfs.oecd.org/pisa2018/SPSS_STU_QQQ.zip", dat_subdir = "CY07_MSU_STU_QQQ.sav"),
        list(zip_path = "https://webfs.oecd.org/pisa2018/SPSS_STU_COG.zip", dat_subdir = "CY07_MSU_STU_COG.sav")),
      teach_dat = list(
        list(zip_path = "https://webfs.oecd.org/pisa2018/SPSS_TCH_QQQ.zip", dat_subdir = "CY07_MSU_TCH_QQQ.sav")),
      school_dat = list(
        list(zip_path = "https://webfs.oecd.org/pisa2018/SPSS_SCH_QQQ.zip", dat_subdir = "CY07_MSU_SCH_QQQ.sav")),
      timing = list(
        list(zip_path = "https://webfs.oecd.org/pisa2018/SPSS_STU_TIM.zip", dat_subdir = "CY07_MSU_STU_TIM.sav"))
    )
  )

  # Call up URL for specific combination
  if (year %in% names(download_paths) && data_type %in% names(download_paths[[year]])) {
    zip_path <- download_paths[[year]][[data_type]][[1]]$zip_path
    dat_subdir <- download_paths[[year]][[data_type]][[1]]$dat_subdir
  } else {
    stop("The combination of year and data type is not available.")
  }

  # Set up temporary folder
  temp_folder <- tempdir()

  # Set timeout for downloading large files
  old_timeout <- getOption("timeout")
  options(timeout = max(600, old_timeout))
  on.exit(options(timeout = old_timeout))

  # Download the zip file
  zip_file <- file.path(temp_folder, "data.zip")
  tryCatch({
    utils::download.file(url = zip_path, destfile = zip_file,
                         headers = c("User-Agent" = "Mozilla/5.0")) #to bypass the error message "403 forbidden"
  }, error = function(e) {
    stop("Failed to download the file: ", e$message)
  })

  # Recursive search for the file in the archive
  zip_contents <- utils::unzip(zipfile = zip_file, list = TRUE)
  matching_files <- zip_contents$Name[grepl(basename(dat_subdir), zip_contents$Name, ignore.case = TRUE)]

  if (length(matching_files) == 0) {
    stop("No matching files found in the zip archive.")
  }

  # Unzip the required file from the archive
  unzip_folder <- file.path(temp_folder, "unzipped_data")
  utils::unzip(zipfile = zip_file, files = matching_files[1], exdir = unzip_folder)

  # Construct the full path to the extracted data file
  extracted_file_path <- file.path(unzip_folder, matching_files[1])

  # Import function for PISA datasets (differentiates between .sav and .txt)
  import_pisa_data <- function(extracted_file_path) {
    # Certain file extension
    file_extension <- tools::file_ext(extracted_file_path)

    # Import depending on file format
    if (file_extension == "sav") {
      haven_dat <- haven::read_sav(extracted_file_path, user_na = TRUE)
    } else if (file_extension == "txt") {
      haven_dat <- utils::read.table(
        extracted_file_path,
        stringsAsFactors = FALSE
      )
    } else {
      stop("Unknown file format: ", extracted_file_path)
    }

  # Converting to GADSdat
  GADS <- eatGADS:::new_savDat(haven_dat)
  GADS <- eatGADS:::prepare_labels(GADS, checkVarNames = FALSE, labeledStrings = "drop")

  return(GADS)
  }
}
