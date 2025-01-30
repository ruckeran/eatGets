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
      stud_par_dat = "https://www.iqb.hu-berlin.de/fdz/studies/TIMSS2007/TIMSS2007_Leer_S.sav",
      teach_dat = "https://www.iqb.hu-berlin.de/fdz/studies/TIMSS2007/TIMSS2007_Leer_L.sav",
      school_dat = "https://www.iqb.hu-berlin.de/fdz/studies/TIMSS2007/TIMSS2007_Leer_S_1.sav"
    ),
    "2011" = list(
      stud_par_dat = "https://www.iqb.hu-berlin.de/fdz/studies/TIMSS_2011/TIMSS2011_SEFB_l.sav",
      teach_dat = "https://www.iqb.hu-berlin.de/fdz/studies/TIMSS_2011/TIMSS2011_LSFB_l.sav",
      school_dat = "https://www.iqb.hu-berlin.de/fdz/studies/TIMSS_2011/TIMSS2011_SLFB_l.sav"
    ),
    "2015" = list(
      stud_par_dat = "https://www.iqb.hu-berlin.de/fdz/studies/TIMSS_2015_v2/TIMSS2015_SEFB_v.sav",
      teach_dat = "https://www.iqb.hu-berlin.de/fdz/studies/TIMSS_2015_v2/TIMSS2015_LSFB_L.sav",
      school_dat = "https://www.iqb.hu-berlin.de/fdz/studies/TIMSS_2015_v2/TIMSS2015_SLFB_L.sav"
    ),
    "2019" = list(
      stud_par_dat = "https://www.iqb.hu-berlin.de/fdz/studies/TIMSS_2019/TIMSS2019_HS_SEF.sav",
      teach_dat = "https://www.iqb.hu-berlin.de/fdz/studies/TIMSS_2019/TIMSS2019_HS_LFB.sav",
      teach_stud_dat = "https://www.iqb.hu-berlin.de/fdz/studies/TIMSS_2019/TIMSS2019_HS_LSF.sav",
      school_dat = "https://www.iqb.hu-berlin.de/fdz/studies/TIMSS_2019/TIMSS2019_HS_SLF.sav",
      tracking = "https://www.iqb.hu-berlin.de/fdz/studies/TIMSS_2019/TIMSS2019_HS_Tra.sav"
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
