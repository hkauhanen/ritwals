#' World Atlas of Language Structures
#'
#' The full WALS dataset.
#'
#' @name WALS
#' @docType data
#' @format A data frame of 76465 rows (each row representing one language-feature combination) and 20 variables:
#' \describe{
#' \item{\code{combined_ID}}{Identifier combining \code{feature_ID} and \code{language_ID}; identifies a unique row in the data frame}
#' \item{\code{feature_ID}}{Feature ID}
#' \item{\code{feature}}{Feature name}
#' \item{\code{value_ID}}{Value ID}
#' \item{\code{value}}{Value name}
#' \item{\code{code_ID}}{Identifier combining \code{feature_ID} and \code{value_ID}}
#' \item{\code{language_ID}}{Language ID}
#' \item{\code{iso_code}}{Language's ISO code}
#' \item{\code{glottocode}}{Language's Glottolog code}
#' \item{\code{language}}{Language name}
#' \item{\code{family}}{Language's family}
#' \item{\code{genus}}{Language's genus}
#' \item{\code{macroarea}}{Language's macroarea}
#' \item{\code{countrycodes}}{Country codes associated with language}
#' \item{\code{latitude}}{Language's latitude in degrees}
#' \item{\code{longitude}}{Language's longitude in degrees}
#' \item{\code{in_WALS_100}}{Boolean: \code{TRUE} if language belongs to the WALS 100-language sample}
#' \item{\code{in_WALS_200}}{Boolean: \code{TRUE} if language belongs to the WALS 200-language sample}
#' \item{\code{source}}{Information source for this language-feature combination}
#' \item{\code{contributors}}{WALS contributors for this language-feature combination}
#' }
#' @source \url{http://wals.info}
NULL


#' WALS Feature Metadata
#'
#' Information about WALS features and their possible values.
#'
#' @name WALS_features
#' @format A data frame with the following variables:
#' \describe{
#' \item{\code{feature_ID}}{Feature's WALS ID}
#' \item{\code{feature}}{Feature's name}
#' \item{\code{value_ID}}{Value ID}
#' \item{\code{value}}{Value's name}
#' \item{\code{code_ID}}{Identifier combining \code{feature_ID} and \code{value_ID}}
#' }
#' @source \url{http://wals.info}
NULL


#' WALS Language Metadata
#'
#' Information about the languages in WALS.
#'
#' @name WALS_languages
#' @format A data frame of 2679 rows (one row per language) with the following 12 variables:
#' \describe{
#' \item{\code{language_ID}}{Language's WALS ID (or 'WALS code')}
#' \item{\code{iso_code}}{Language's ISO code}
#' \item{\code{glottocode}}{Language's Glottolog code}
#' \item{\code{language}}{Language's name}
#' \item{\code{family}}{Language's family}
#' \item{\code{genus}}{Language's genus}
#' \item{\code{macroarea}}{Language's macroarea}
#' \item{\code{countrycodes}}{Country codes associated with language}
#' \item{\code{latitude}}{Language's latitude in degrees}
#' \item{\code{longitude}}{Language's longitude in degrees}
#' \item{\code{in_WALS_100}}{Boolean: \code{TRUE} if language belongs to the WALS 100-language sample}
#' \item{\code{in_WALS_200}}{Boolean: \code{TRUE} if language belongs to the WALS 200-language sample}
#' }
#' @source \url{http://wals.info}
#' @examples
#' # The number of WALS genera:
#' length(unique(WALS_languages$genus))
#'
#' # Frequency table of languages per family:
#' table(WALS_languages$family)
NULL
