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
      stud_par_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2001/PIRLS2001_IDB_SPSS.zip",
        dat_subdir = c("ASADEUR1.sav", "ASGDEUR1.sav", "ASHDEUr1.sav", "ASRDEUr1.sav", "ASTDEUR1.sav")
      ),
      teach_ger_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2001/PIRLS2001_IDB_SPSS.zip",
        dat_subdir = "ATGDEUr1.sav"
      ),
      teach_math_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2001/PIRLS2001_IDB_SPSS.zip",
        dat_subdir = "ATGDEUr1.sav"
      ),
      teach_gen_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2001/PIRLS2001_IDB_SPSS.zip",
        dat_subdir = "ATGDEUr1.sav"
      ),
      school_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2001/PIRLS2001_IDB_SPSS.zip",
        dat_subdir = "ACGDEUr1.sav"
      )
    ),
    "2006" = list(
      stud_par_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2006/PIRLS2006_IDB_SPSS.zip",
        dat_subdir = c("asadeur2.sav", "asgdeur2.sav", "ashdeur2.sav")
      ),
      teach_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2006/PIRLS2006_IDB_SPSS.zip",
        dat_subdir = c("atgdeur2.sav")
      ),
      school_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2006/PIRLS2006_IDB_SPSS.zip",
        dat_subdir = c("acgdeur2.sav")
      ),
      testscores = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2006/PIRLS2006_IDB_SPSS.zip",
        dat_subdir = c("astdeur2.sav", "asrdeur2.sav")
      )
    ),
    "2011" = list(
      stud_par_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2011/PIRLS2011_IDB_SPSS.zip",
        dat_subdir = c("asadeur3.sav", "asgdeur3.sav", "ashdeur3.sav", "asrdeur3.sav", "astdeur3.sav")
      ),
      teach_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2011/PIRLS2011_IDB_SPSS.zip",
        dat_subdir = c("atgdeur3.sav")
      ),
      school_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2011/PIRLS2011_IDB_SPSS.zip",
        dat_subdir = c("acgdeur3.sav")
      )
    ),
    "2016" = list(
      stud_par_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2016/PIRLS2016_IDB_SPSS.zip",
        dat_subdir = c("ASADEUR4.sav", "ASGDEUR4.sav", "ASHDEUR4.sav", "ASRDEUR4.sav", "ASTDEUR4.sav")
      ),
      teach_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2016/PIRLS2016_IDB_SPSS.zip",
        dat_subdir = c("ATGDEUR4.sav")
      ),
      teach_stud_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2016/PIRLS2016_IDB_SPSS.zip",
        dat_subdir = c("")
      ),
      school_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2016/PIRLS2016_IDB_SPSS.zip",
        dat_subdir = c("ACGDEUR4.sav")
      ),
      tracking = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2016/PIRLS2016_IDB_SPSS.zip",
        dat_subdir = c("")
      )
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

