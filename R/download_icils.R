#' Download and import an empty FDZ file.
#'
#' Download and import an empty ICILS data set from the \href{https://www.iqb.hu-berlin.de/fdz/studies/}{FDZ homepage}.
#'
#' The function downloads and imports an empty ICILS data set (\code{Leerdatensatz}) from the FDZ homepage.
#' These data sets contain zero rows.
#' The data is imported via \code{\link[eatGADS]{import_spss}} as a \code{GADSdat} object.
#'
#'@param year Year of the assessment.
#'@param data_type Type of the data.
#'
#'@examples
#' fdz_icils <- download_icils(year = "2018",
#'                         data_type = "stud_dat")
#'@export
download_icils <- function(year = c("2018", "2013"),
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
      stud_nat_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/81/ICILS_2013_SchuelerInnen_nat_v2_Leerdaten.sav",
      stud_int_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/81/ICILS_2013_SchuelerInnen_int_v2_Leerdaten.sav",
      teach_nat_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/81/ICILS_2013_Lehrkraefte_nat_v1_Leerdaten.sav",
      teach_int_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/81/ICILS_2013_Lehrkraefte_int_v1_Leerdaten.sav",
      school_nat_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/81/ICILS_2013_Schulleitung_nat_v1_Leerdaten.sav",
      school_int_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/81/ICILS_2013_Schulleitung_int_v1_Leerdaten.sav"
    ),
    "2018" = list(
      stud_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/56/ICILS_2018_Schueler_innenfragebogen_v2_Leerdaten.sav",
      teach_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/56/ICILS_2018_Lehrkraeftefragebogen_v1_Leerdaten.sav",
      school_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/56/ICILS_2018_Schulleitungsfragebogen_v1_Leerdaten.sav",
      it_dat = "https://fdz.iqb.hu-berlin.de/media/study_files/56/ICILS_2018_IT-Fragebogen_v1_Leerdaten.sav"
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

