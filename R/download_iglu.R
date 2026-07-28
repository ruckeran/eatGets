#' Download and import an empty FDZ file.
#'
#' Download and import an empty IGLU data set from the \href{https://www.iqb.hu-berlin.de/fdz/studies/}{FDZ homepage}.
#'
#' The function downloads and imports an empty IGLU data set (\code{Leerdatensatz}) from the FDZ homepage.
#' These data sets contain zero rows.
#' The data is imported via \code{\link[eatGADS]{import_spss}} as a \code{GADSdat} object.
#'
#'@param year Year of the assessment.
#'@param data_type Type of the data.
#'
#'@examples
#' fdz_iglu <- download_iglu(year = "2016",
#'                         data_type = "stud_par_dat")
#'@export
download_iglu <- function(year = c("2016", "2011", "2006", "2001"),
                          data_type = c("stud_par_dat",
                                        "teach_ger_dat", "teach_math_dat", "teach_gen_dat",
                                        "teach_dat", "teach_stud_dat",
                                        "school_dat", "tracking", "testscores")) {
  ## input validation
  year <- match.arg(year)
  data_type <- match.arg(data_type)

  # URL table for each study, year and data type
  download_paths <- list(
    "2001" = list(
      stud_par_dat = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/103/IGLU_2001_v2_0_blank.zip",
        dat_subdir = "IGLU2001_student_quest_v2_blank.sav"
      ),
      teach_ger_dat = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/103/IGLU_2001_v2_0_blank.zip",
        dat_subdir = "IGLU2001_teacher_german_v2_blank.sav"
      ),
      teach_math_dat = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/103/IGLU_2001_v2_0_blank.zip",
        dat_subdir = "IGLU2001_teacher_math_v2_blank.sav"
      ),
      teach_gen_dat = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/103/IGLU_2001_v2_0_blank.zip",
        dat_subdir = "IGLU2001_teacher_science_v2_blank.sav"
      ),
      school_dat = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/103/IGLU_2001_v2_0_blank.zip",
        dat_subdir = "IGLU2001_principal_quest_v2_blank.sav"
      )
    ),
    "2006" = list(
      stud_par_dat = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/130/IGLU_2006_v2_0_blank.zip",
        dat_subdir = "IGLU2006_student_parent_quest_v2_blank.sav"
      ),
      teach_dat = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/130/IGLU_2006_v2_0_blank.zip",
        dat_subdir = "IGLU2006_teacher_german_v2_blank.sav"
      ),
      school_dat = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/130/IGLU_2006_v2_0_blank.zip",
        dat_subdir = "IGLU2006_principal_quest_v2_blank.sav"
      ),
      testscores = list(
        zip_path = "https://fdz.iqb.hu-berlin.de/media/study_files/130/IGLU_2006_v2_0_blank.zip",
        dat_subdir = "IGLU2006_testscores_v2_blank.sav"
      )
    ),
    "2011" = list(
      stud_par_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/86/IGLU2011_SEFB_le.sav",
      teach_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/86/IGLU2011_LSFB_le.sav",
      school_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/86/IGLU2011_SLFB_le.sav"
    ),
    "2016" = list(
      stud_par_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/80/IGLU2016_SEFB_v1.sav",
      teach_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/80/IGLU2016_LFB_v1_.sav",
      teach_stud_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/80/IGLU2016_LSFB_v1.sav",
      school_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/80/IGLU2016_SLFB_v1.sav",
      tracking = "https://fdz.iqb.hu-berlin.de/media/study_files/80/IGLU2016_TR_v1_L.sav"
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
    zip_file <- file.path(temp_folder, "iglu_data.zip")

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
    unzip_folder <- file.path(temp_folder, "unzipped_iglu_data")
    utils::unzip(zipfile = zip_file, files = matching_files[1], exdir = unzip_folder)
    extracted_file_path <- file.path(unzip_folder, matching_files[1])

    gads <- eatGADS::import_spss(extracted_file_path, checkVarNames = FALSE)

    # Cleanup
    unlink(c(zip_file, unzip_folder))
  } else {
    gads <- eatGADS::import_spss(download_spec, checkVarNames = FALSE)
  }
  gads
}
