% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\name{WALS_languages}
\alias{WALS_languages}
\title{WALS Language Metadata}
\format{A data frame of 2679 rows (one row per language) with the following 12 variables:
\describe{
\item{\code{language_ID}}{Language's WALS ID (or 'WALS code')}
\item{\code{iso_code}}{Language's ISO code}
\item{\code{glottocode}}{Language's Glottolog code}
\item{\code{language}}{Language's name}
\item{\code{family}}{Language's family}
\item{\code{genus}}{Language's genus}
\item{\code{macroarea}}{Language's macroarea}
\item{\code{countrycodes}}{Country codes associated with language}
\item{\code{latitude}}{Language's latitude in degrees}
\item{\code{longitude}}{Language's longitude in degrees}
\item{\code{in_WALS_100}}{Boolean: \code{TRUE} if language belongs to the WALS 100-language sample}
\item{\code{in_WALS_200}}{Boolean: \code{TRUE} if language belongs to the WALS 200-language sample}
}}
\source{
\url{http://wals.info}
}
\description{
Information about the languages in WALS.
}
\examples{
# The number of WALS genera:
length(unique(WALS_languages$genus))

# Frequency table of languages per family:
table(WALS_languages$family)
}
