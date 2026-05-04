# Download and import an empty PISA public use file.

Download and import an empty PISA public use file (zero rows, but full
metadata) from the [OECD
homepage](https://www.oecd.org/en/data/datasets/).

## Usage

``` r
download_pisa_oecd(
  year = c("2018", "2015", "2012", "2009", "2006", "2003", "2000"),
  data_type = c("stud_dat_9kl", "stud_dat_15j", "stud_par_dat", "stud_par_dat_9kl",
    "stud_par_dat_15j", "par_dat", "par_dat_9kl", "par_dat_15j", "teach_dat",
    "teach_dat_9kl", "teach_dat_15j", "school_dat", "school_dat_9kl", "school_dat_15j",
    "matching", "timing")
)
```

## Arguments

- year:

  Year of the assessment.

- data_type:

  Type of the data.

## Details

For PISA 2000–2012 the function uses the EdSurvey workflow
(`downloadPISA`, `readPISA`) and converts the resulting file formats
into a `GADSdat` object with zero rows but full metadata. For PISA 2015
and 2018 the function downloads a zip file from the OECD homepage into a
temporary directory, unzips it and imports the data via
[`read_sav`](https://haven.tidyverse.org/reference/read_spss.html) or
[`read.table`](https://rdrr.io/r/utils/read.table.html).

For downloading full PISA data sets see the
[EdSurvey](https://cran.r-project.org/package=EdSurvey) package.

## Examples

``` r
if (FALSE) { # interactive()
oecd_pisa <- download_pisa_oecd(year = "2018",
                        data_type = "school_dat")
}
```
