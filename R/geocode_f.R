#' Coordinates finder
#'
#' The 'geocode_func' function is a class that converts an address to coordinates.
#'
#' @field f A data frame
#'
#' @import methods
#' @importFrom httr content GET
#' @importFrom rjson fromJSON
#'
#' @export geocode_f
#' @exportClass geocode_f

geocode_f <- setRefClass("geocode_f",
   fields = list(
                 f="data.frame"
                 ),
   methods = list(

     initialize = function(){
       cat("User::initialize")
       f<<- data.frame()
     },

     getCoordinate = function(data){
       if (is.character(data)){
         data <- as.data.frame(data)
       }
       if(data=="" || grepl("[][!#$%()*.:;<=>@^_`|~.{}]", data[,1])==TRUE){
         stop("Please check again your input")
       }
       a<-vector("character")
       b<-vector("numeric")
       d<-vector("numeric")
       for(i in 1:nrow(data)){
         print("Processing")
         # key <- "AIzaSyCYgKKt2fn7Crt-V6Hnc5aw5lSfy7XLQ-Y"
         url<- "http://www.datasciencetoolkit.org/maps/api/geocode/json"
         json <-rjson::fromJSON(httr::content(httr::GET(url,query=list(sensor="FALSE",address=as.character(data[i,1]))),type="text"))
         if (json$status=="OK"){
           loc <- json$results[[1]]$geometry$location
           a[i]<-as.character(data[i,1])
           b[i]<-loc$lng
           d[i]<-loc$lat
         }else{
           a[i]<-as.character(data[i,1])
           b[i]<-NA
           d[i]<-NA
         }
       }
       f<<-data.frame(a,b,d)
       names(f) <<- c("Address","Longtitude","Latitude")
       return(f)
     }
   )
)

