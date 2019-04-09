#' Contingency Tables
#'
#' Produce a contingency table from the values of two or more WALS features.
#'
#' This function calls \code{\link{intersect_features}} internally to establish the database intersection based on which a contingency table may be created.
#' @param ids Vector of feature IDs
#' @param names Boolean; should the output use prose value descriptions? If \code{FALSE}, value IDs are used instead.
#' @param absolute Boolean; should the output be in the form of absolute frequencies? If \code{FALSE}, relative frequencies are outputted.
#' @param data Optionally a data frame, e.g. a subset of \code{\link{WALS}}
#' @return An \emph{n}-by-\emph{n} contingency table, where \emph{n} is the length of \code{ids}
#' @examples
#' # 2x2 contingency table (absolute frequencies) of the first two features:
#' tab <- contingency_table(c("1A", "2A"))
#'
#' # Run a chi-square test on the above:
#' chisq.test(tab)
#'
#' # 3x3 contingency table of the first three features, showing relative
#' # frequencies and value IDs instead of value descriptions:
#' contingency_table(c("1A", "2A", "3A"), names=FALSE, absolute=FALSE)
#' @export
contingency_table <- function(ids,
                              names = TRUE,
                              absolute = TRUE,
                              data = WALS) {
  if (length(ids) < 2) {
    stop("You need to supply at least two feature IDs to create a contingency table")
  }
  intersection <- intersect_features(ids)

  if (names) {
    intersection$value_ID <- paste0(intersection$value_ID, " (", intersection$value, ")")
  }
  arguments <- parse(text=paste0("get_feature(\"", ids, "\", data=intersection)$value_ID"))
  arguments <- as.list(arguments)
  idnames <- rep("", length(ids))
  for (i in 1:length(ids)) {
    idnames[i] <- unique(WALS_features[WALS_features$feature_ID==ids[i], ]$feature)
  }
  arguments$dnn <- paste0(ids, " ", idnames)

  tab <- do.call(table, args=arguments)
  if (!absolute) {
    tab <- tab/sum(tab)
  }
  tab
}


#' Random Samples
#'
#' Take a random sample of \emph{N} languages from WALS.
#'
#' Languages in \code{data} are sampled uniformly at random without replacement, and their representation in \code{\link{WALS}} is returned.
#' @param N Sample size
#' @param data Optionally, a data frame (e.g. the output of \code{\link{filter_WALS}})
#' @return A subset of the \code{\link{WALS}} data frame.
#' @examples
#' # Just a random random sample of 100 languages:
#' random_WALS <- sample_random(100)
#'
#' # Random sample of 50 tonal languages (feature 13A has value 2 or 3):
#' tonal_lges <- filter_WALS(feature_ID == "13A" & value_ID %in% 2:3)
#' random_tonals <- sample_random(50, data=tonal_lges)
#'
#' # Random sample of 20 languages from the WALS 100-language sample:
#' sample_random(20, sample_WALS_100())
#' @export
sample_random <- function(N,
                          data = WALS) {
  langs <- unique(data$language_ID)
  if (N > length(langs)) {
    stop("N is larger than the number of languages in data; cannot sample")
  }
  sam <- sample(langs, size=N, replace=FALSE)
  WALS[WALS$language_ID %in% sam, ]
}
