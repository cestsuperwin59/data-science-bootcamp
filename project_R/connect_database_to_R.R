library(tidyverse)
library(lubridate)
library(RSQLite) 
library(RPostgreSQL)
library(janitor)

## connect database
con <- dbConnect(SQLite(), "chinook.db")

## list table names
dbListTables(con)

## list fields in a table
dbListFields(con, "customers")

## write SQL queries
df <- dbGetQuery(con, "select * from customers limit 10")

df %>% ##(deplyR)
  select(FirstName, LastName)

clean_df <- clean_names(df)
View(clean_df)

## write JOIN syntax
df2 <- dbGetQuery(con, "select * from albums, artists
                 where albums.artistid = artists.artistid") %>%
  
  clean_names()
View(df2)

## write a table
dbWriteTable(con, "cars", mtcars)
dbListTables(con)

dbGetQuery(con, "select * from cars limit 5;")

## drop table
dbRemoveTable(con, "cars") ##เอาtable cars ออก

## close connection
dbDisconnect(con)

