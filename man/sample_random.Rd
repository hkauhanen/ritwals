% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/typo.R
\name{sample_random}
\alias{sample_random}
\title{Random Samples}
\usage{
sample_random(N, data = WALS)
}
\arguments{
\item{N}{Sample size}

\item{data}{Optionally, a data frame (e.g. the output of \code{\link{filter_WALS}})}
}
\value{
A subset of the \code{\link{WALS}} data frame.
}
\description{
Take a random sample of \emph{N} languages from WALS.
}
\details{
Languages in \code{data} are sampled uniformly at random without replacement, and their representation in \code{\link{WALS}} is returned.
}
\examples{
# Just a random random sample of 100 languages:
random_WALS <- sample_random(100)

# Random sample of 50 tonal languages (feature 13A has value 2 or 3):
tonal_lges <- filter_WALS(feature_ID == "13A" & value_ID \%in\% 2:3)
random_tonals <- sample_random(50, data=tonal_lges)

# Random sample of 20 languages from the WALS 100-language sample:
sample_random(20, sample_WALS_100())
}
