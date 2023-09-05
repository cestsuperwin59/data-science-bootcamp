library(RPostgreSQL)

## connect database

con <- dbConnect(PostgreSQL(), 
                 host = "balarama.db.elephantsql.com", # server
                 port = 5432, # default
                 user = "eytjjoqg",
                 pass = "r4Ktb8s7nSFufYFEpLiV_WYjaYchJNXU",
                 dbname = "eytjjoqg")

dbListTables(con)

## write table
dbWriteTable(con, "cars", mtcars %>% slice(1:5))
mtcars %>% slice(1:5)

## list table
dbListTables(con)

## get query
dbGetQuery(con, "select count(*) from cars")
dbGetQuery(con, "select * from cars")

## disconnect
dbDisconnect(con)
