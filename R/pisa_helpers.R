# --------------------------------------------------------------------------------------------------
# Internal helper I:
# Download PISA 2000–2012 via EdSurvey and convert to an empty GADSdat with full metadata. ---------

.download_pisa_edSurvey_to_GADS <- function(year, data_type) {

# 0) Short-circuit for unsupported types (avoiding downloads)
  if (data_type %in% c("timing", "matching")) {
    stop("Data type '", data_type, "' is not available for years 2000–2012.")
  }


  ## 1) Download and read PISA using EdSurvey --------------------------------------------------------

  root <- tempdir()

  EdSurvey::downloadPISA(
    root     = root,
    years    = as.integer(year),
    database = "INT"
  )

  es_dat <- EdSurvey::readPISA(
    path        = file.path(root, "PISA", year),
    countries   = "deu",
    forceReread = TRUE
  )

  ## 2) Assign data_type to EdSurvey dataList element ---------------------------------------------------

  dl_name <- switch(
    data_type,
    "stud_dat_15j"      = "Student",
    "stud_dat_9kl"      = "Student",
    "stud_par_dat"      = "Student",
    "stud_par_dat_15j"  = "Student",
    "stud_par_dat_9kl"  = "Student",
    "par_dat"           = "Parent",
    "par_dat_15j"       = "Parent",
    "par_dat_9kl"       = "Parent",
    "school_dat"        = "School",
    "school_dat_15j"    = "School",
    "school_dat_9kl"    = "School",
    "teach_dat"         = "Teacher",
    "teach_dat_15j"     = "Teacher",
    "teach_dat_9kl"     = "Teacher",
  )

  if (!dl_name %in% names(es_dat$dataList)) {
    stop("Element '", dl_name, "' not found in EdSurvey object for year ", year, ".")
  }

  file_format <- es_dat$dataList[[dl_name]]$fileFormat
  file_format$variableName <- tolower(file_format$variableName)

  ## 3) Parse labelValues into value / label pairs ---------------------------------------------------

  max_parts <- max(
    stringr::str_count(file_format$labelValues, "\\^"),
    na.rm = TRUE
  ) + 1

  value_cols <- paste0("val", seq_len(max_parts))

  # Split labelValues at "^" and keep only needed columns
  wide <- tidyr::separate(
    file_format,
    labelValues,
    into = value_cols,
    sep  = "\\^",
    fill = "right"
  ) %>%
    dplyr::select(
      dplyr::any_of(c("variableName", "Labels", "missing")),
      dplyr::all_of(value_cols)
    )

  # Reshape to long format
  long <- wide %>%
    tidyr::pivot_longer(
      cols = dplyr::all_of(value_cols),
      names_to      = "valnum",
      values_to     = "pair",
      values_drop_na = TRUE
    ) %>%
    # Split "code=label" into separate columns
    tidyr::separate(
      col  = pair,
      into = c("code", "label"),
      sep  = "=",
      fill = "right"
    ) %>%
    # Standardize column names for GADSdat metadata
    dplyr::rename(
      varName  = variableName,
      varLabel = Labels,
      value    = code,
      valLabel = label
    )


  ## 4) Create missing tags --------------------------------------------------------------------------

  setMissingTags <- function(val, miss_str) {
    val_chr <- as.character(val)
    if (is.na(val_chr)) return(NA_character_)
    miss_vals <- unlist(strsplit(as.character(miss_str), ";"))
    if (val_chr %in% miss_vals || val_chr %in% c("n", "r")) "miss" else "valid"
  }

  long$missings <- mapply(setMissingTags, long$value, long$missing, USE.NAMES = FALSE)


  ## 5) Build GADS label data.frames and empty data.frame --------------------------------------------

  vars <- file_format$variableName
  n    <- length(vars)

  varLabels <- data.frame(
    varName       = vars,
    varLabel      = file_format$Labels,
    format        = rep(NA_character_, n),
    display_width = rep(NA_integer_,  n),
    labeled       = rep(NA,           n),
    stringsAsFactors = FALSE
  )

  valLabels <- data.frame(
    varName  = long$varName,
    value    = long$value,
    valLabel = long$valLabel,
    missings = long$missings,
    stringsAsFactors = FALSE
  )

  labels <- merge(
    varLabels,
    valLabels,
    by    = "varName",
    all.x = FALSE,
    sort  = FALSE
  )

  # Empty data.frame with 0 rows but all variables
  dat <- as.data.frame(
    setNames(
      rep(list(character(0)), length(vars)),
      vars
    ),
    stringsAsFactors = FALSE
  )


  ## 6) Create GADSdat object ------------------------------------------------------------------------

  gads <- eatGADS:::new_GADSdat(dat, labels)
  gads
}


# --------------------------------------------------------------------------------------------------
# Internal helper II:
# Read data and convert to GADSdat -----------------------------------------------------------------
.import_pisa_file_to_GADS <- function(extracted_file_path) {

  file_extension <- tools::file_ext(extracted_file_path)

  # Import depending on file format
  if (identical(tolower(file_extension), "sav")) {
    haven_dat <- haven::read_sav(extracted_file_path, user_na = TRUE)
  } else if (identical(tolower(file_extension), "txt")) {
    haven_dat <- utils::read.table(
      extracted_file_path,
      stringsAsFactors = FALSE
    )
  } else {
    stop("Unknown file format: ", extracted_file_path)
  }

  # Converting to GADSdat
  GADS <- eatGADS:::new_savDat(haven_dat)
  GADS <- eatGADS:::prepare_labels(
    GADS,
    checkVarNames  = FALSE,
    labeledStrings = "drop"
  )
  names(GADS$dat)     <- tolower(names(GADS$dat))
  GADS$labels$varName <- tolower(GADS$labels$varName)

  GADS
}

# --------------------------------------------------------------------------------------------------
