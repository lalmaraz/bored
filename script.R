#### Preamble ####
# Purpose: Get some ideas for when bored
# Author: Lorena Almaraz De La Garza
# Data: 1 Feb 2021
# Contact: l.almaraz@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - install packages if needed
# To do:
# - this whole thing could be prettier, we all know it

library(httr)
library(tidyverse)
library(rjson)
library(ggplot2)

# data from https://www.boredapi.com

# here's the first test
## request
option_1 <- httr::GET('https://www.boredapi.com/api/activity')

## grab text from response
option_1<- content(option_1, "text")

## turn response into data frame
result<-fromJSON(option_1)
json_data_frame <- as.data.frame(result) 



# now make a function that does what the lines above do
get_activity_row <- function(){
  x<-GET('https://www.boredapi.com/api/activity') 
  x_text<-content(x,"text") 
  x_parsed<-as_tibble(fromJSON(x_text))
  return(x_parsed)
}

# add new row
json_data_frame <- add_row(json_data_frame,get_activity_row()) # run as many times as desired
json_data_frame

# what is this if not a way to make graphs
cheap_ideas <-json_data_frame %>% 
  ggplot(aes(x = activity, y = price)) + 
  geom_col()+
  coord_flip()
cheap_ideas
