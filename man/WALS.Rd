% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{WALS}
\alias{WALS}
\title{World Atlas of Language Structures}
\format{A data frame of 76465 rows (each row representing one language-feature combination) and 20 variables:
\describe{
\item{\code{combined_ID}}{Identifier combining \code{feature_ID} and \code{language_ID}; identifies a unique row in the data frame}
\item{\code{feature_ID}}{Feature ID}
\item{\code{feature}}{Feature name}
\item{\code{value_ID}}{Value ID}
\item{\code{value}}{Value name}
\item{\code{code_ID}}{Identifier combining \code{feature_ID} and \code{value_ID}}
\item{\code{language_ID}}{Language ID}
\item{\code{iso_code}}{Language's ISO code}
\item{\code{glottocode}}{Language's Glottolog code}
\item{\code{language}}{Language name}
\item{\code{family}}{Language's family}
\item{\code{genus}}{Language's genus}
\item{\code{macroarea}}{Language's macroarea}
\item{\code{countrycodes}}{Country codes associated with language}
\item{\code{latitude}}{Language's latitude in degrees}
\item{\code{longitude}}{Language's longitude in degrees}
\item{\code{in_WALS_100}}{Boolean: \code{TRUE} if language belongs to the WALS 100-language sample}
\item{\code{in_WALS_200}}{Boolean: \code{TRUE} if language belongs to the WALS 200-language sample}
\item{\code{source}}{Information source for this language-feature combination}
\item{\code{contributors}}{WALS contributors for this language-feature combination}
}}
\source{
\url{http://wals.info}
}
\description{
The full WALS dataset.
}
