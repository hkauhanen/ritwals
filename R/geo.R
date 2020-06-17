#' Great-Circle Distance
#'
#' Calculates the great-circle distance between two languages as determined
#' by their WALS latitude-longitude coordinates.
#'
#' WALS defines the geographical representation of a language as a point
#' in latitude-longitude space.
#' Calculation of great-circle distance is by the haversine formula assuming 
#' a perfectly spherical Earth of radius 6,371 km.
#' @param id1 WALS ID of first language
#' @param id2 WALS ID of second language
#' @examples
#' a <- great_circle_distance("fre", "ger")
#' b <- great_circle_distance("ger", "rus")
#' c <- great_circle_distance("fre", "rus")
#' if (a + b >= c) {
#'   print("The triangle inequality works!")
#' }
#' @export
great_circle_distance <- function(id1,
                                  id2) {
  lang1 <- WALS_languages[WALS_languages$language_ID %in% id1, ]
  lang2 <- WALS_languages[WALS_languages$language_ID %in% id2, ]
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
#' Computed using \code{\link{great_circle_distance}}.
#' By default (\code{data = WALS}), all languages in the WALS
#' atlas will be considered in the computation of the nearest neighbours.
#' By supplying a non-default \code{data} argument, it is possible to
#' override this behaviour, e.g. to supply only a subset of the languages.
#'
#' If the language does not have as many as \emph{k} neighbours (e.g. because
#' of a strict filtering by \code{data}), the neighbours that \emph{are}
#' found are returned with a warning.
#' @param id Language's WALS ID
#' @param k How many neighbours to return
#' @param data Dataset to consider; by default the entire \code{\link{WALS}}
#' @examples
#' # 10 nearest neighbours of Egyptian Arabic:
#' nearest_geo_neighbours("aeg", k=10)
#'
#' # 10 nearest neighbours of Egyptian Arabic among those languages for
#' # which feature 13A is attested:
#' nearest_geo_neighbours("aeg", k=10, data=filter_WALS(feature_ID=="13A"))
#'
#' # 10 nearest neighbours of Egyptian Arabic among those languages for
#' # which feature 13A is attested, among the Afro-Asiatic family:
#' nearest_geo_neighbours("aeg", k=10,
#'   data=filter_WALS(feature_ID=="13A" & family=="Afro-Asiatic"))
#' @export
nearest_geo_neighbours <- function(id,
                                   k,
                                   data = WALS) {
  # complain if arguments invalid
  if (k < 1) {
    stop("k must be at least 1")
  }
  if (!(id %in% WALS_languages$language_ID)) {
    stop(paste(id, "is not a valid WALS language ID"))
  }

  # prune out any stuff in 'data' we do not need
  data <- data[, c("language_ID", "language", "latitude", "longitude") ]
  data <- data[!duplicated(data), ]

  # find all neighbours
  out <- find_neighbours(id=id, data=data)

  # filter and return
  if (k <= nrow(out)) {
    return(droplevels(out[1:k,]))
  } else {
    warning(paste0("Language has only ", nrow(out), " neighbours with the given filtering; check your 'data' argument"))
    return(droplevels(out))
  }
}


#' Nearest Geographical Neighbours (Discoidal)
#'
#' Return the neighbours of a language residing within a disc of a specified
#' radius from that language.
#'
#' Computed using \code{\link{great_circle_distance}}.
#' By default (\code{data = WALS}), all languages in the WALS
#' atlas will be considered in the computation of the nearest neighbours.
#' By supplying a non-default \code{data} argument, it is possible to
#' override this behaviour, e.g. to supply only a subset of the languages.
#' @param id Language's WALS ID
#' @param radius Radius of disc in km
#' @param data Dataset to consider; by default the entire \code{\link{WALS}}
#' @examples
#' # Neighbours of Finnish within 1000 km:
#' nearest_geo_neighbours_discoidal("fin", radius=1000)
#'
#' # Neighbours of Finnish within 1000 km, within the Uralic family:
#' nearest_geo_neighbours_discoidal("fin", radius=1000,
#'   data=filter_WALS(family=="Uralic"))
#' @export
nearest_geo_neighbours_discoidal <- function(id,
                                             radius,
                                             data = WALS) {
  # complain if 'id' invalid
  if (!(id %in% WALS_languages$language_ID)) {
    stop(paste(id, "is not a valid WALS language ID"))
  }

  # prune out any stuff in 'data' we do not need
  data <- data[, c("language_ID", "language", "latitude", "longitude") ]
  data <- data[!duplicated(data), ]

  # find all neighbours
  out <- find_neighbours(id=id, data=data)

  # filter output
  droplevels(out[out$dist <= radius, ])
}


find_neighbours_OLD <- function(id,
                            data) {
  out <- data.frame(lang=data$language_ID, language=data$language, dist=NA)
  for (i in 1:nrow(out)) {
    out[i,]$dist <- great_circle_distance(id, out[i,]$lang)
  }
  out <- out[out$lang != id, ]
  out <- out[order(out$dist, decreasing=FALSE), ]
  names(out) <- c("language_ID", "language", "distance")
  out
}


find_neighbours <- function(id,
                            data) {
  dists <- unlist(lapply(X=data$language_ID, FUN=function(X) great_circle_distance(id, X)))
  langIDs <- data$language_ID
  langs <- data$language
  out <- data.frame(lang=langIDs, language=langs, dist=dists)
  out <- out[out$lang != id, ]
  out <- out[order(out$dist, decreasing=FALSE), ]
  names(out) <- c("language_ID", "language", "distance")
  out
}


