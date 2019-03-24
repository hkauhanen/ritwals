#' Get WALS Language
#'
#' Returns a dataframe containing the WALS representation of a language.
#' @param id Language's WALS ID.
#' @return The portion of the \code{\link{WALS}} dataframe pertaining to this language.
#' @export
get_language <- function(id) {
  WALS[WALS$language_ID==id, ]
}


#' Get WALS Feature
#'
#' Returns a dataframe containing the WALS coverage of a feature.
#' @param id Feature's WALS ID.
#' @return The portion of the \code{\link{WALS}} dataframe pertaining to this feature.
#' @export
get_feature <- function(id) {
  WALS[WALS$feature_ID==id, ]
}


#' WALS Feature Metadata
#'
#' Returns information about a WALS feature. Use this to find the possible
#' values the feature can take.
#' @param id Feature's WALS ID, or a vector of IDs
#' @return A dataframe with the following columns:
#' \describe{
#' \item{\code{feature_ID}}{Feature's WALS ID}
#' \item{\code{feature}}{Feature's name}
#' \item{\code{value_ID}}{Value ID}
#' \item{\code{value}}{Prose description of value}
#' }
#' @examples
#' feature_metadata("13A")
#' feature_metadata("13A")$value_ID
#' feature_metadata(c("13A", "9A", "83A"))
#' @export
feature_metadata <- function(id) {
  WALS_features[WALS_features$feature_ID %in% id, ]
}


#' WALS Language Metadata
#'
#' Returns information about a WALS language.
#' @param id Language's WALS ID, or a vector of IDs
#' @return A dataframe with the following columns:
#' \describe{
#' \item{\code{language_ID}}{Language's WALS ID}
#' \item{\code{iso_code}}{Language's ISO code}
#' \item{\code{glottocode}}{Language's Glottocode}
#' \item{\code{language}}{Language's name}
#' \item{\code{latitude}}{Language's latitude}
#' \item{\code{longitude}}{Language's longitude}
#' \item{\code{genus}}{Language's genus}
#' \item{\code{family}}{Language's family}
#' \item{\code{macroarea}}{Language's macroarea}
#' \item{\code{countrycodes}}{Country codes associated with the language}
#' \item{\code{in_WALS_100_sample}}{Boolean flag; set to \code{TRUE} if language is included in the WALS 100 sample}
#' \item{\code{in_WALS_200_sample}}{Boolean flag; set to \code{TRUE} if language is included in the WALS 200 sample}
#' }
#' @examples
#' language_metadata("fin")
#' language_metadata("fin")$family
#' language_metadata(c("fin", "swe"))
#' @export
language_metadata <- function(id) {
  WALS_languages[WALS_languages$language_ID %in% id, ]
}
