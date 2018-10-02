#' Coordinates finder
#'
#' The 'geocode_f' contains a function that converts an address to coordinates.
#'
#' @field result A data frame contains address, lontitude, latitude.
#' @field addr A character represents address
#'
#' @import methods
#' @importFrom httr content GET
#' @importFrom rjson fromJSON
#'
#' @export geocode_f
#' @exportClass geocode_f

geocode_f <- setRefClass("geocode_f",
   fields = list(
                 addr = "character",
                 result = "data.frame"
                 ),
   methods = list(

     initialize = function(input){
       cat("User::initialize\n")
       if(!is.character(input))
       stop("Please check again your input")
       addr <<- input
       result <<- data.frame()
     },

     getCoordinate = function(){
         cat("Processing\n")
         key <- "42db6ca84392bff4038cde9470a0d24c"
         url<- paste("api.openweathermap.org/data/2.5/weather?q=",addr,"&appid=",key,sep = "")
         get_url <- httr::GET(url = url)
         get_url_text <- httr::content(get_url,"text")
         json <- rjson::fromJSON(get_url_text)
         if(json$cod==404)
           stop(json$message)
         result <<- data.frame(addr, lon=json$coord$lon, lat=json$coord$lat)
         result
     }
   )
)

