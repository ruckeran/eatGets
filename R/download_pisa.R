#' Download and import an empty FDZ file.
#'
#' Download and import an empty PISA data set from the \href{https://www.iqb.hu-berlin.de/fdz/studies/}{FDZ homepage}.
#'
#' The function downloads and imports an empty PISA data set (\code{Leerdatensatz}) from the FDZ homepage.
#' These data sets contain zero rows.
#' The data is imported via \code{\link[eatGADS]{import_spss}} as a \code{GADSdat} object.
#'
#'@param year Year of the assessment.
#'@param data_type Type of the data.
#'
#'@examples
#' fdz_pisa <- download_pisa(year = "2018",
#'                         data_type = "stud_par_dat_9kl")
#'@export
download_pisa <- function(year = c("2018", "2015", "2012", "2009", "2006", "2003", "2000"),
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
  download_paths <- list(
    "2000" = list(
      stud_dat_9kl = "https://fdz.iqb.hu-berlin.de/media/study_files/61/PISA2000_9kl_SC.sav",
      stud_dat_15j = "https://fdz.iqb.hu-berlin.de/media/study_files/61/PISA2000_15J_SC.sav",
      school_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/61/PISA2000_Schule.sav"
    ),
    "2003" = list(
      stud_dat_9kl = "https://fdz.iqb.hu-berlin.de/media/study_files/66/PISA2003_I_9grade_students_v2_Leerdaten.sav",
      stud_dat_15j = "https://fdz.iqb.hu-berlin.de/media/study_files/66/PISA2003_I_15y_students_v2_Leerdaten.sav",
      teach_dat_9kl = "https://fdz.iqb.hu-berlin.de/media/study_files/66/PISA2003_I_9grade_teacher_v2_Leerdaten.sav",
      teach_dat_15j = "https://fdz.iqb.hu-berlin.de/media/study_files/66/PISA2003_I_15y_teacher_v2_Leerdaten.sav",
      school_dat_9kl = "https://fdz.iqb.hu-berlin.de/media/study_files/66/PISA2003_I_9grade_schools_v2_Leerdaten.sav",
      school_dat_15j = "https://fdz.iqb.hu-berlin.de/media/study_files/66/PISA2003_I_15y_schools_v2_Leerdaten.sav"
    ),
    "2006" = list(
      stud_dat_9kl = "https://fdz.iqb.hu-berlin.de/media/study_files/59/PISA2006I_SC_9K.sav",
      stud_dat_15j = "https://fdz.iqb.hu-berlin.de/media/study_files/59/PISA2006I_SC_15.sav",
      teach_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/59/PISA2006I_LE_Le.sav",
      school_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/59/PISA2006I_Schull.sav",
      par_dat_9kl = "https://fdz.iqb.hu-berlin.de/media/study_files/59/PISA2006I_EL_9k.sav",
      par_dat_15j = "https://fdz.iqb.hu-berlin.de/media/study_files/59/PISA2006I_EL_15.sav"
    ),
    "2009" = list(
      stud_par_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/57/PISA09_Leer_SEFB.sav",
      teach_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/57/PISA09_Leer_LFB.sav",
      school_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/57/PISA09_Leer_SLFB.sav"
    ),
    "2012" = list(
      stud_dat_9kl = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/53/PISA_2012_v6_blank.zip",
        dat_subdir = "PISA_2012_student_quest_grade9_v6_blank.sav"
      ),
      stud_dat_15j = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/53/PISA_2012_v6_blank.zip",
        dat_subdir = "PISA_2012_student_quest_15yo_v6_blank.sav"
      ),
      teach_dat = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/53/PISA_2012_v6_blank.zip",
        dat_subdir = "PISA_2012_teacher_quest_v5_blank.sav"
      ),
      school_dat = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/53/PISA_2012_v6_blank.zip",
        dat_subdir = "PISA_2012_principal_quest_v5_blank.sav"
      ),
      par_dat = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/53/PISA_2012_v6_blank.zip",
        dat_subdir = "PISA_2012_parent_quest_v6_blank.sav"
      ),
      matching = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/53/PISA_2012_v6_blank.zip",
        dat_subdir = "PISA_2012_matching_v5_blank.sav"
      )
    ),
    "2015" = list(
      stud_par_dat_9kl = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/98/PISA_2015_blank.zip",
        dat_subdir = "PISA_2015_student_parent_quest_grade9_v4_blank.sav"
      ),
      stud_par_dat_15j = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/98/PISA_2015_blank.zip",
        dat_subdir = "PISA_2015_student_parent_quest_15yo_v4_blank.sav"
      ),
      teach_dat = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/98/PISA_2015_blank.zip",
        dat_subdir = "PISA_2015_teacher_quest_v3_blank.sav"
      ),
      school_dat = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/98/PISA_2015_blank.zip",
        dat_subdir = "PISA_2015_principal_quest_v2_blank.sav"
      ),
      timing = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/98/PISA_2015_blank.zip",
        dat_subdir = "PISA_2015_student_timing_15yo_v2_blank.sav"
      )
    ),
    "2018" = list(
      stud_par_dat_9kl = "https://fdz.iqb.hu-berlin.de/media/study_files/77/PISA_2018_SchuelerInnen_Eltern_9Kl_v2_Leerdaten.sav",
      stud_par_dat_15j = "https://fdz.iqb.hu-berlin.de/media/study_files/77/PISA_2018_SchuelerInnen_Eltern_15J_v2_Leerdaten.sav",
      teach_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/77/PISA_2018_LehrerInnen_v2_Leerdaten.sav",
      school_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/77/PISA_2018_Schulleitung_v2_Leerdaten.sav",
      timing = "https://fdz.iqb.hu-berlin.de/media/study_files/77/PISA_2018_Timing_15J_v2_Leerdaten.sav"
    )
  )

  # call up URL for specific combination
  if (year %in% names(download_paths) &&
      data_type %in% names(download_paths[[year]])) {

    download_spec <- download_paths[[year]][[data_type]]
  } else {
    stop("The combination of year and data type is not available.")
  }

  ### read data
  # Check if this is a zip file or direct URL
  if (is.list(download_spec)) {
    # Handle zip file download
    temp_folder <- tempdir()
    zip_file <- file.path(temp_folder, "pisa_data.zip")

    # Set timeout for downloading large files
    old_timeout <- getOption("timeout")
    options(timeout = max(600, old_timeout))
    on.exit(options(timeout = old_timeout), add = TRUE)

    # Download zip
    tryCatch({
      utils::download.file(
        url      = download_spec$zip_path,
        destfile = zip_file,
        headers  = c("User-Agent" = "Mozilla/5.0"),
        mode     = "wb"
      )
    }, error = function(e) {
      stop("Failed to download the file: ", e$message)
    })

    # Find matching file in zip
    zip_contents <- utils::unzip(zipfile = zip_file, list = TRUE)
    patterns <- basename(download_spec$dat_subdir)
    matches_logical <- Reduce(
      `|`,
      lapply(patterns, function(p) grepl(p, zip_contents$Name, ignore.case = TRUE))
    )
    matching_files <- zip_contents$Name[matches_logical]

    if (length(matching_files) == 0) {
      stop("No matching files found in the zip archive.")
    }

    # Extract to temp and import
    unzip_folder <- file.path(temp_folder, "unzipped_pisa_data")
    utils::unzip(zipfile = zip_file, files = matching_files[1], exdir = unzip_folder)
    extracted_file_path <- file.path(unzip_folder, matching_files[1])

    gads <- eatGADS::import_spss(extracted_file_path, checkVarNames = TRUE)

    # Cleanup
    unlink(c(zip_file, unzip_folder))
  } else {
    gads <- eatGADS::import_spss(download_spec, checkVarNames = TRUE)
  }
  names(gads$dat) <- tolower(names(gads$dat))
  gads$labels$varName <- tolower(gads$labels$varName)
  gads
  #haven::read_sav(download_path, n_max = 1, user_na = TRUE)
}

