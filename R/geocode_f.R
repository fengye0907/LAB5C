#' Coordinate finder
#'
#' The 'geocode_f' contains a function that converts an address to coordinates using an openweather API.
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
       Sys.setlocale(locale = "english")
       cat("User::initialize\n")

       if((!is.character(input))||nchar(input)<=0)
        stop("Please check again your input")
       addr <<- input
       result <<- data.frame()
     },

     getCoordinate = function(){
         cat("Processing\n")
         key <- "42db6ca84392bff4038cde9470a0d24c"
         url<- paste("http://api.openweathermap.org/data/2.5/forecast?q=",addr,"&APPID=",key,sep = "")
         get_url <- httr::GET(url = url)
         get_url_text <- httr::content(get_url,"text")
         json <- rjson::fromJSON(get_url_text)
         if(json$cod==404)
           stop(json$message)
         result <<- data.frame(addr=json$city$name, lon=json$city$coord$lon, lat=json$city$coord$lat)
         result
     }
   )
)

