#' World Atlas of Language Structures
#'
#' The full WALS dataset.
#'
#' @name WALS
#' @docType data
#' @format A data frame with 76465 rows and 20 variables:
#' \describe{
#' \item{\code{combined_ID}}{}
#' \item{\code{language_ID}}{}
#' \item{\code{feature_ID}}{}
#' \item{\code{value_ID}}{}
#' \item{\code{code_ID}}{}
#' \item{\code{language}}{}
#' \item{\code{feature}}{}
#' \item{\code{value}}{}
#' \item{\code{iso_code}}{}
#' \item{\code{glottocode}}{}
#' \item{\code{latitude}}{}
#' \item{\code{longitude}}{}
#' \item{\code{genus}}{}
#' \item{\code{family}}{}
#' \item{\code{macroarea}}{}
#' \item{\code{countrycodes}}{}
#' \item{\code{in_WALS_100_sample}}{}
#' \item{\code{in_WALS_200_sample}}{}
#' \item{\code{source}}{}
#' \item{\code{contributors}}{}
#' }
#' @source \url{http://wals.info}
NULL


#' World Atlas of Language Structures (Without Metadata)
#'
#' The WALS dataset without metadata. It is recommended to use this instead of \code{\link{WALS}} for any computationally intensive operations.
#'
#' @name WALS_nometa
#' @format A data frame with 76465 rows and 5 variables:
#' \describe{
#' \item{\code{language_ID}}{}
#' \item{\code{feature_ID}}{}
#' \item{\code{value_ID}}{}
#' \item{\code{latitude}}{}
#' \item{\code{longitude}}{}
#' }
#' @source \url{http://wals.info}
NULL


#' World Atlas of Language Structures (100-Language Sample)
#'
#' The WALS 100-language sample: the portion of \code{\link{WALS}} pertaining to languages belonging to this sample.
#'
#' @name WALS_100
#' @format See \code{\link{WALS}}.
#' @source \url{http://wals.info}
NULL


#' World Atlas of Language Structures (200-Language Sample)
#'
#' The WALS 200-language sample: the portion of \code{\link{WALS}} pertaining to languages belonging to this sample.
#'
#' @name WALS_200
#' @format See \code{\link{WALS}}.
#' @source \url{http://wals.info}
NULL
