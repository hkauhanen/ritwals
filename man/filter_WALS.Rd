% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/WALS.R
\name{filter_WALS}
\alias{filter_WALS}
\title{Filter WALS Data}
\usage{
filter_WALS(expr, data = WALS)
}
\arguments{
\item{expr}{Logical expression, must evaluate to a Boolean}

\item{data}{Optionally, a data frame (e.g. any subset of \code{\link{WALS}})}
}
\value{
A portion of the \code{\link{WALS}} data frame
}
\description{
Filter the \code{\link{WALS}} dataset down to a subset by a logical condition.
}
\details{
The \code{expr} argument should refer to columns in the \code{\link{WALS}}
data frame.
}
\examples{
# Get the subset of WALS pertaining to Afro-Asiatic languages:
filter_WALS(family=="Afro-Asiatic")

# Get the Semitic languages on the African continent:
filter_WALS(genus=="Semitic" & macroarea=="Africa")

# Get the set of Celtic and Romance languages:
filter_WALS(genus=="Celtic" | genus=="Romance")

# The same thing:
filter_WALS(genus \%in\% c("Celtic", "Romance"))

# Get languages whose latitudes fall between 10 and 20 degrees:
filter_WALS(latitude >= 10 & latitude <= 20)

# Get languages whose WALS language ID begins with the letters 'la'
filter_WALS(substr(language_ID, 1, 2) == "la")
}
\seealso{
See \code{\link{WALS}} for a description of the columns of the returned data frame.
}
