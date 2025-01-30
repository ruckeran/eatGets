#' Download and import an empty IGLU public use file.
#'
#' Download and import an empty IGLU public use file (containing only the first data row) from the \href{https://www.iea.nl/data-tools/repository/pirls}{IEA homepage}.
#'
#' The function downloads a zip file from the IEA homepage into a temporary directory,
#' unzips it and imports the data with only a single data row via \code{\link[haven]{read_sav}}.
#' For downloading full IGLU data sets see the \href{https://cran.r-project.org/package=EdSurvey}{EdSurvey} package.
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
        dat_subdir = "atgdeur2.sav"
      ),
      school_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2006/PIRLS2006_IDB_SPSS.zip",
        dat_subdir = "acgdeur2.sav"
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
        dat_subdir = "atgdeur3.sav"
      ),
      school_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2011/PIRLS2011_IDB_SPSS.zip",
        dat_subdir = "acgdeur3.sav"
      )
    ),
    "2016" = list(
      stud_par_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2016/PIRLS2016_IDB_SPSS.zip",
        dat_subdir = c("ASADEUR4.sav", "ASGDEUR4.sav", "ASHDEUR4.sav", "ASRDEUR4.sav", "ASTDEUR4.sav")
      ),
      teach_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2016/PIRLS2016_IDB_SPSS.zip",
        dat_subdir = "ATGDEUR4.sav"
      ),
      teach_stud_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2016/PIRLS2016_IDB_SPSS.zip",
        dat_subdir = "ATGDEUR4.sav"
      ),  # Datensatz anpassen!
      school_dat = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2016/PIRLS2016_IDB_SPSS.zip",
        dat_subdir = "ACGDEUR4.sav"
      ),
      tracking = list(
        zip_path = "https://www.iea.nl/sites/default/files/data-repository/PIRLS/PIRLS2016/PIRLS2016_IDB_SPSS.zip",
        dat_subdir = "ACGDEUR4.sav"
      ) # Datensatz anpassen!
    )
  )

  # call up URL for specific combination
  if (year %in% names(download_paths) &&
      data_type %in% names(download_paths[[year]])) {

    zip_path <- download_paths[[year]][[data_type]]$zip_path
    dat_subdir <- download_paths[[year]][[data_type]]$dat_subdir
    print(paste("zip_path:", zip_path))
    print(paste("dat_subdir:", dat_subdir))
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
  if (!is.character(dat_subdir)) {
    stop("dat_subdir must be a character vector.")
  }
  if (length(dat_subdir) == 0 || all(dat_subdir == "")) {
    stop("dat_subdir is empty or contains only empty strings.")
  }

  print(paste("dat_subdir is:", toString(dat_subdir)))
  matching_files <- sapply(dat_subdir, function(pattern) {
    found_file <- zip_contents$Name[grepl(pattern, zip_contents$Name, ignore.case = TRUE)]
    if (length(found_file) > 0) {
      return(found_file)
    } else {
      warning(paste("file", pattern, "was not found in the ZIP."))
      return(NA)
    }
  })

  matching_files <- na.omit(matching_files) # Remove files that were not found


  if (length(matching_files) == 0) {
    stop("None of the files were found in the ZIP archive.")
  }

  ## Unzip the required file from the archive
  unzip_folder <- file.path(temp_folder, "unzipped_data")
  utils::unzip(zipfile = zip_file, files = matching_files, exdir = unzip_folder)

  ## Import and combine data
  data_list <- lapply(matching_files, function(file) {
    file_path <- file.path(unzip_folder, file) # Absolute path to the extracted file
    if (file.exists(file_path)) {
      haven::read_sav(file_path, user_na = TRUE)
    } else {
      warning(paste("The file", file, "does not exist in the extraction folder."))
      return(NULL)
    }
  })

  ## Combine data if possible
  data_list <- Filter(Negate(is.null), data_list) # Remove NULL entries

  if (length(data_list) > 1) {
    combined_data <- dplyr::bind_rows(data_list)
  } else if (length(data_list) == 1) {
    combined_data <- data_list[[1]]
  } else {
    stop("Could not load any data.")
  }

  ## Convert to GADSdat
  GADS <- eatGADS:::new_savDat(combined_data)
  eatGADS:::prepare_labels(GADS, checkVarNames = FALSE, labeledStrings = "drop")

  return(GADS)
}
