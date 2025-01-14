#' Download and import an empty IGLU public use file.
#'
#' Download and import an empty IGLU public use file (containing only the first data row) from the \href{https://www.iea.nl/data-tools/repository/pirls}{IEA homepage}.
#'
#' The function downloads a zip file from the IEA homepage into a temporary directory,
#' unzips it and imports the data with only a single data row via \code{\link[haven]{read_sav}}.
#' For downloading full ICILS data sets see the \href{https://cran.r-project.org/package=EdSurvey}{EdSurvey} package.
#' The data is imported as a \code{GADSdat} object.
#'
#'@param year Year of the assessment.
#'@param data_type Type of the data.
#'
#'@examples
#' iea_iglu <- download_iglu_iea(year = "2016",
#'                         data_type = "stud_par_dat")
#'@export
download_iglu_iea <- function(year = c("2016", "2011", "2006", "2001"),
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
      stud_par_dat = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU_2001/IGLU2001_SC_Lee.sav",
      teach_ger_dat = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU_2001/IGLU2001_DE_Lee.sav",
      teach_math_dat = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU_2001/IGLU2001_MA_Lee.sav",
      teach_gen_dat = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU_2001/IGLU2001_SU_Lee.sav",
      school_dat = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU_2001/IGLU2001_SL_Lee.sav"
    ),
    "2006" = list(
      stud_par_dat = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU-2006/IGLU2006_SC_EL_.sav",
      teach_dat = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU-2006/IGLU2006_DE_Lee.sav",
      school_dat = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU-2006/IGLU2006_SL_Lee.sav",
      testscores = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU-2006/IGLU2006_TS_Lee.sav"
    ),
    "2011" = list(
      stud_par_dat = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU_2011/IGLU2011_SEFB_le.sav",
      teach_dat = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU_2011/IGLU2011_LSFB_le.sav",
      school_dat = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU_2011/IGLU2011_SLFB_le.sav"
    ),
    "2016" = list(
      stud_par_dat = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU_2016/IGLU2016_SEFB_v1.sav",
      teach_dat = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU_2016/IGLU2016_LFB_v1_.sav",
      teach_stud_dat = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU_2016/IGLU2016_LSFB_v1.sav",
      school_dat = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU_2016/IGLU2016_SLFB_v1.sav",
      tracking = "https://www.iqb.hu-berlin.de/fdz/studies/IGLU_2016/IGLU2016_TR_v1_L.sav"
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

