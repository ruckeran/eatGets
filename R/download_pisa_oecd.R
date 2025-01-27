#' Download and import an empty OECD public use file.
#'
#' Download and import an empty OECD public use file (containing only the first data row) from the \href{https://www.oecd.org/en/data/datasets/}{IEA homepage}.
#'
#' The function downloads a zip file from the OECD homepage into a temporary directory,
#' unzips it and imports the data with only a single data row via \code{\link[haven]{read_sav}}.
#' For downloading full ICILS data sets see the \href{https://cran.r-project.org/package=EdSurvey}{EdSurvey} package.
#' The data is imported as a \code{GADSdat} object.
#'
#'@param year Year of the assessment.
#'@param data_type Type of the data.
#'
#'@examples
#' oecd_pisa <- download_pisa_oecd(year = "2018",
#'                         data_type = "stud_par_dat_9kl")
#'@export
download_pisa_oecd <- function(year = c("2018", "2015", "2012", "2009", "2006", "2003", "2000"),
                          data_type = c("stud_dat_9kl", "stud_dat_15j", "stud_par_dat",
                                        "stud_par_dat_9kl", "stud_par_dat_15j",
                                        "par_dat", "par_dat_9kl", "par_dat_15j",
                                        "teach_dat", "teach_dat_9kl", "teach_dat_15j",
                                        "school_dat", "school_dat_9kl", "school_dat_15j",
                                        "matching", "timing")) {
  ## input validation
  year <- match.arg(year)
  data_type <- match.arg(data_type)

  # URL table for each study, year and data type
  download_paths <- list("2000" = list(
    stud_dat_15j = c(
      list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intcogn_v4.zip", dat_subdir = "intcogn_v4.txt"),
      list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intstud_math.zip", dat_subdir = "intstud_math_v3.txt"),
      list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intstud_read.zip", dat_subdir = "intstud_read_v3.txt"),
      list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intstud_scie.zip", dat_subdir = "intstud_scie_v3.txt")
    ),
    school_dat = list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intscho.zip", dat_subdir = "intscho.txt"),
  ),
  list("2003" = list(
    stud_dat_9kl = c(
      list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intcogn_v4.zip", dat_subdir = "intcogn_v4.txt"),
      list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intstud_math.zip", dat_subdir = "intstud_math_v3.txt"),
      list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intstud_read.zip", dat_subdir = "intstud_read_v3.txt"),
      list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intstud_scie.zip", dat_subdir = "intstud_scie_v3.txt")
    ),
    teach_dat_15j = list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intscho.zip", dat_subdir = "intscho.txt"),
    school_dat_15j = list(zip_path = "https://www.oecd.org/content/dam/oecd/en/data/datasets/pisa/pisa-2000-datasets/data-sets-in-txt-formats/intscho.zip", dat_subdir = "intscho.txt"),
  ))
  )


    download_paths <- list(

    "2003" = list(
      stud_dat_15j = "https://www.iqb.hu-berlin.de/fdz/studies/PISA-2003/PISA2003I_SC_15.sav",
      teach_dat_15j = "https://www.iqb.hu-berlin.de/fdz/studies/PISA-2003/PISA2003I_LE_15.sav",
      school_dat_15j = "https://www.iqb.hu-berlin.de/fdz/studies/PISA-2003/PISA2003I_SN_15.sav"
    ),
    "2006" = list(
      stud_dat_9kl = "https://www.iqb.hu-berlin.de/fdz/studies/PISA-2006/PISA2006I_SC_9K.sav",
      stud_dat_15j = "https://www.iqb.hu-berlin.de/fdz/studies/PISA-2006/PISA2006I_SC_15.sav",
      teach_dat = "https://www.iqb.hu-berlin.de/fdz/studies/PISA-2006/PISA2006I_LE_Le.sav",
      school_dat = "https://www.iqb.hu-berlin.de/fdz/studies/PISA-2006/PISA2006I_Schull.sav",
      par_dat_9kl = "https://www.iqb.hu-berlin.de/fdz/studies/PISA-2006/PISA2006I_EL_9k.sav",
      par_dat_15j = "https://www.iqb.hu-berlin.de/fdz/studies/PISA-2006/PISA2006I_EL_15.sav"
    ),
    "2009" = list(
      stud_par_dat = "https://www.iqb.hu-berlin.de/fdz/studies/PISA-2009/PISA09_Leer_SEFB.sav",
      teach_dat = "https://www.iqb.hu-berlin.de/fdz/studies/PISA-2009/PISA09_Leer_LFB.sav",
      school_dat = "https://www.iqb.hu-berlin.de/fdz/studies/PISA-2009/PISA09_Leer_SLFB.sav"
    ),
    "2012" = list(
      stud_dat_9kl = "https://www.iqb.hu-berlin.de/fdz/studies/PISA_2012/PISA2012_Schuele.sav",
      stud_dat_15j = "https://www.iqb.hu-berlin.de/fdz/studies/PISA_2012/PISA2012_Schuele_1.sav",
      teach_dat = "https://www.iqb.hu-berlin.de/fdz/studies/PISA_2012/PISA2012_LehrerI.sav",
      school_dat = "https://www.iqb.hu-berlin.de/fdz/studies/PISA_2012/PISA2012_Schulle.sav",
      par_dat = "https://www.iqb.hu-berlin.de/fdz/studies/PISA_2012/PISA2012_Eltern_.sav",
      matching = "https://www.iqb.hu-berlin.de/fdz/studies/PISA_2012/PISA2012_Matchin.sav"
    ),
    "2015" = list(
      stud_par_dat_9kl = "https://www.iqb.hu-berlin.de/fdz/studies/PISA_2015/PISA2015_Schuele.sav",
      stud_par_dat_15j = "https://www.iqb.hu-berlin.de/fdz/studies/PISA_2015/PISA2015_Schuele_1.sav",
      teach_dat = "https://www.iqb.hu-berlin.de/fdz/studies/PISA_2015/PISA2015_LehrerI.sav",
      school_dat = "https://www.iqb.hu-berlin.de/fdz/studies/PISA_2015/PISA2015_Schulle.sav",
      timing = "https://www.iqb.hu-berlin.de/fdz/studies/PISA_2015/PISA2015_Schuele_2.sav"
    ),
    "2018" = list(
      stud_par_dat_9kl = "https://www.iqb.hu-berlin.de/fdz/studies/PISA_2018/PISA2018_Datensa_1.sav",
      stud_par_dat_15j = "https://www.iqb.hu-berlin.de/fdz/studies/PISA_2018/PISA2018_Datensa_2.sav",
      teach_dat = "https://www.iqb.hu-berlin.de/fdz/studies/PISA_2018/PISA2018_Datensa.sav",
      school_dat = "https://www.iqb.hu-berlin.de/fdz/studies/PISA_2018/PISA2018_Datensa_4.sav",
      timing = "https://www.iqb.hu-berlin.de/fdz/studies/PISA_2018/PISA2018_Datensa_3.sav"
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
