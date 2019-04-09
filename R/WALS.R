#' Filter WALS Data
#'
#' Filter the \code{\link{WALS}} dataset down to a subset by a logical condition.
#'
#' The \code{expr} argument should refer to columns in the \code{\link{WALS}}
#' data frame.
#'
#' @param expr Logical expression, must evaluate to a Boolean
#' @param data Optionally, a data frame (e.g. any subset of \code{\link{WALS}})
#' @return A portion of the \code{\link{WALS}} data frame
#' @seealso See \code{\link{WALS}} for a description of the columns of the returned data frame.
#' @examples
#' # Get the subset of WALS pertaining to Afro-Asiatic languages:
#' filter_WALS(family=="Afro-Asiatic")
#'
#' # Get the Semitic languages on the African continent:
#' filter_WALS(genus=="Semitic" & macroarea=="Africa")
#'
#' # Get the set of Celtic and Romance languages:
#' filter_WALS(genus=="Celtic" | genus=="Romance")
#'
#' # The same thing:
#' filter_WALS(genus %in% c("Celtic", "Romance"))
#'
#' # Get languages whose latitudes fall between 10 and 20 degrees:
#' filter_WALS(latitude >= 10 & latitude <= 20)
#'
#' # Get languages whose WALS language ID begins with the letters 'la'
#' filter_WALS(substr(language_ID, 1, 2) == "la")
#' @export
filter_WALS <- function(expr,
                        data = WALS) {
  x <- data
  e <- substitute(expr)
  r <- eval(e, x, parent.frame())
  if (!is.logical(r))
    stop("'expr' must be logical")
  x[r, ]
}


#' Get Feature
#'
#' Return the representation of a feature in WALS.
#'
#' Returns the relevant portion of the \code{\link{WALS}} data frame.
#' Feature values and value IDs are returned as factors.
#' @param id Feature's WALS ID
#' @param data Optionally, a data frame (such as a subset of \code{\link{WALS}})
#' @return A data frame
#' @export
get_feature <- function(id,
                        data = WALS) {
  data <- filter_WALS(feature_ID==id, data=data)
  data$value <- factor(data$value)
  data$value_ID <- factor(data$value_ID)
  data
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
#' \item{\code{in_WALS_100}}{Boolean flag: \code{TRUE} if language is included in the WALS 100 sample}
#' \item{\code{in_WALS_200}}{Boolean flag: \code{TRUE} if language is included in the WALS 200 sample}
#' }
#' @examples
#' language_metadata("fin")
#' language_metadata("fin")$family
#' language_metadata(c("fin", "swe"))
#' @export
language_metadata <- function(id) {
  WALS_languages[WALS_languages$language_ID %in% id, ]
}



#' Country Codes
#'
#' Return the country codes associated with a language
#' @param id Language's WALS ID, or a vector of IDs
#' @return A list of character vectors
#' @examples
#' country_codes("fre")
#' unlist(country_codes("fre"))
#' country_codes(c("fre", "ger"))
#' @export
country_codes <- function(id) {
  cc <- WALS_languages[WALS_languages$language_ID %in% id, ]$countrycodes
  ret <- strsplit(as.character(cc), "\\s")
  names(ret) <- id
  ret
}


#' Intersect Features
#'
#' Return a subset of WALS consisting of only those languages for which data is attested in each of a given set of features; in effect, produce a set-theoretic intersection of the features.
#'
#' @param ids Vector of IDs of features to intersect
#' @param data Optionally, a data frame (such as a subset of \code{\link{WALS}})
#' @return A portion of the \code{\link{WALS}} data frame.
#' @examples
#' # Intersection of features 23A and 32A:
#' intersect_features(c("23A", "32A"))
#'
#' # Intersection of features 1A, 9A and 13A:
#' intersect_features(c("1A", "9A", "13A"))
#'
#' # Intersection of features 1A ... 20A:
#' df <- intersect_features(paste0(1:20, "A"))
#'
#' # Find out which languages belong to that intersection:
#' unique(df$language_ID)
#'
#' # And get their metadata:
#' language_metadata(unique(df$language_ID))
#'
#' # Prove there is no language in WALS for which all features are attested:
#' df <- intersect_features(unique(WALS$feature_ID))
#' nrow(df) # == 0
#' @export
intersect_features <- function(ids,
                               data = WALS) {
  intersection <- data
  for (id in ids) {
    feature_df <- intersection[intersection$feature_ID==id, ]
    languages_in_this_feature <- unique(feature_df$language_ID)
    intersection <- intersection[intersection$language_ID %in% languages_in_this_feature, ]
  }
  intersection
}


#' WALS 100-Language Sample
#'
#' Return the WALS 100-language sample.
#'
#' Returns the portion of \code{\link{WALS}} where \code{in_WALS_100} is \code{TRUE}.
#' @return A subset of the \code{\link{WALS}} data frame.
#' @export
sample_WALS_100 <- function() {
  WALS[WALS$in_WALS_100, ]
}


#' WALS 200-Language Sample
#'
#' Return the WALS 200-language sample.
#'
#' Returns the portion of \code{\link{WALS}} where \code{in_WALS_200} is \code{TRUE}. Note that the WALS 200-languages sample contains \emph{202} languages.
#' @return A subset of the \code{\link{WALS}} data frame.
#' @export
sample_WALS_200 <- function() {
  WALS[WALS$in_WALS_200, ]
}
