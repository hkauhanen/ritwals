#' Great-Circle Distance
#'
#' Calculates the great-circle distance between two languages as determined
#' by their WALS latitude-longitude coordinates.
#'
#' Calculation is by the haversine formula assuming a perfectly spherical 
#' Earth of radius 6,371 km.
#' @param id1 WALS ID of first language
#' @param id2 WALS ID of second language
#' @export
great_circle_distance <- function(id1,
                                  id2) {
  lang1 <- WALS_languages[WALS_languages$language_ID==id1, ]
  lang2 <- WALS_languages[WALS_languages$language_ID==id2, ]
  haversine(lat1=lang1$latitude,
            lat2=lang2$latitude,
            lon1=lang1$longitude,
            lon2=lang2$longitude,
            R=6371)
}


haversine <- function(lat1,
                      lat2,
                      lon1,
                      lon2,
                      R = 6371) {
  # R trigonometric functions expect angles in radians
  lat1 <- (pi/180)*lat1
  lat2 <- (pi/180)*lat2
  lon1 <- (pi/180)*lon1
  lon2 <- (pi/180)*lon2

  # haversine formula
  2*R*asin(sqrt((sin(0.5*(lat2-lat1)))^2 + cos(lat1)*cos(lat2)*(sin(0.5*(lon2-lon1)))^2))
}


#' Nearest Geographical Neighbours
#'
#' Return the \emph{k} nearest geographical neighbours of a language.
#'
#' WALS defines the geographical representation of a language as a point
#' in latitude-longitude space.
#' Pairwise geographical distance between languages is computed as the 
#' great-circle distance (see \code{\link{great_circle_distance}}).
#' By default (\code{languages = WALS_languages}), all languages in the WALS
#' atlas will be considered in the computation of the nearest neighbours.
#' By supplying a non-default \code{languages} argument, it is possible to
#' override this behaviour, e.g. to supply only a subset of the languages.
#' @param id Language's WALS ID
#' @param k How many neighbours to return
#' @param languages Set of languages to consider; by default all
#' @export
nearest_geo_neighbours <- function(id,
                                   k = 1,
                                   languages = WALS_languages) {
  if (k >= nrow(languages)) {
    stop("k must be strictly less than the total number of languages!")
  }
  if (k < 1) {
    stop("k must be at least 1")
  }
  if (!(id %in% WALS_languages$language_ID)) {
    stop(paste(id, "is not a valid WALS language ID"))
  }
  out <- data.frame(lang=languages$language_ID, language=languages$language, dist=NA)
  for (i in 1:nrow(out)) {
    out[i,]$dist <- great_circle_distance(id, out[i,]$lang)
  }
  out <- out[out$lang != id, ]
  out <- out[order(out$dist, decreasing=FALSE), ]
  names(out) <- c("language_ID", "language", "distance")
  out[1:k,]
}


#' Nearest Geographical Neighbours (Discoidal)
#'
#' Return the neighbours of a language residing within a disc of a specified
#' radius from that language.
#'
#' WALS defines the geographical representation of a language as a point
#' in latitude-longitude space.
#' Pairwise geographical distance between languages is computed as the 
#' great-circle distance (see \code{\link{great_circle_distance}}).
#' By default (\code{languages = WALS_languages}), all languages in the WALS
#' atlas will be considered in the computation of the nearest neighbours.
#' By supplying a non-default \code{languages} argument, it is possible to
#' override this behaviour, e.g. to supply only a subset of the languages.
#' @param id Language's WALS ID
#' @param radius Radius of neighbourhood disc in kilometres
#' @param languages Set of languages to consider; by default all
#' @export
nearest_geo_neighbours_discoidal <- function(id,
                                             radius = 1000,
                                             languages = WALS_languages) {
  if (radius <= 0) {
    stop("radius must be positive")
  }
  if (!(id %in% WALS_languages$language_ID)) {
    stop(paste(id, "is not a valid WALS language ID"))
  }
  out <- data.frame(lang=languages$language_ID, language=languages$language, dist=NA)
  for (i in 1:nrow(out)) {
    out[i,]$dist <- great_circle_distance(id, out[i,]$lang)
  }
  out <- out[out$lang != id, ]
  out <- out[order(out$dist, decreasing=FALSE), ]
  names(out) <- c("language_ID", "language", "distance")
  out[out$dist <= radius, ]
}



#' Country Codes
#'
#' Return the country codes of a language as a character vector.
#' @param id Language's WALS ID
#' @export
country_codes <- function(id) {
  cc <- WALS_languages[WALS_languages$language_ID==id, ]$countrycodes
  unlist(strsplit(cc, "\\s"))
}


