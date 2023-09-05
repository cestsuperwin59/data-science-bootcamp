library(tidyverse)
library(rvest)
library(dplyr)
library(stringr)

url <- "https://www.imdb.com/search/title/?groups=top_100&sort=user_rating,desc"

movie_name <- (gsub("\\s*\\([^\\)]+\\)","", url %>%
  read_html() %>%
  html_elements("h3.lister-item-header")%>%
  html_text2()))
  
movie_year <- as.numeric(gsub("[()]" , ""  , url %>%
  read_html()  %>%
  html_elements("span.lister-item-year.text-muted.unbold") %>%
  html_text2())) 

ratings <- url %>%
  read_html() %>%
  html_elements ("div.ratings-imdb-rating") %>%
  html_text2() %>%
  as.numeric()

movievotes_details <- url %>%
  read_html() %>%
  html_elements ("p.sort-num_votes-visible") %>%
  html_text2()
  gross = str_match(movievotes_details,"Gross:\\s*\\$(\\d+\\.\\d+)")[, 2]

metascore <- as.numeric(gsub("Metascore","",url %>%
  read_html() %>%
  html_elements ("div.ratings-metascore") %>%
  html_text2()))
  
imdb_df <- data.frame(
  movie_name,
  movie_year,
  ratings,
  gross,
  metascore
)
View(imdb_df)

  
