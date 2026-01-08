#' Download and import an empty FDZ file.
#'
#' Download and import an empty TIMSS data set from the \href{https://www.iqb.hu-berlin.de/fdz/studies/}{FDZ homepage}.
#'
#' The function downloads and imports an empty TIMSS data set (\code{Leerdatensatz}) from the FDZ homepage.
#' These data sets contain zero rows.
#' The data is imported via \code{\link[eatGADS]{import_spss}} as a \code{GADSdat} object.
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
      stud_par_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/120/TIMSS2007_Leer_S.sav",
      teach_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/120/TIMSS2007_Leer_L.sav",
      school_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/120/TIMSS2007_Leer_S_1.sav"
    ),
    "2011" = list(
      stud_par_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/106/TIMSS2011_SEFB_l.sav",
      teach_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/106/TIMSS2011_LSFB_l.sav",
      school_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/106/TIMSS2011_SLFB_l.sav"
    ),
    "2015" = list(
      stud_par_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/111/TIMSS2015_SEFB_v.sav",
      teach_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/111/TIMSS2015_LSFB_L.sav",
      school_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/111/TIMSS2015_SLFB_L.sav"
    ),
    "2019" = list(
      stud_par_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/100/TIMSS2019_MS_student_parent_quest_v4_1_Leerdaten.sav",
      teach_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/100/TIMSS2019_MS_teacher_quest_v3_1_Leerdaten.sav",
      teach_stud_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/100/TIMSS2019_MS_teacher_student_quest_v4_1_Leerdaten.sav",
      school_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/100/TIMSS2019_MS_principals_quest_v2_1_Leerdaten.sav",
      tracking = "https://fdz.iqb.hu-berlin.de/media/study_files/100/TIMSS2019_MS_tracking_v2_Leerdaten.sav"
    )
  )

  # call up URL for specific combination
  if (year %in% names(download_paths) &&
      data_type %in% names(download_paths[[year]])) {

    download_path <- download_paths[[year]][[data_type]]
  } else {
    stop("The combination of year and data type is not available.")
  }

  ### read data
  eatGADS::import_spss(download_path, checkVarNames = FALSE)
  #haven::read_sav(download_path, n_max = 1, user_na = TRUE)
}
