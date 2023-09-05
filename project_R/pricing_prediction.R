library(tidyverse)
library(caret)
library(readxl)

#Import data set

house_price_india <- read_xlsx("House_Price_India.xlsx") 
glimpse(house_price_india)
View(house_price_india)

#Data Visualization

ggplot(house_price_india, aes(Price)) +
  geom_histogram()

#The Price column is skewed positively
#Fix by using log transformation
log_house_price_india <- house_price_india %>%
  mutate(Price_log = log(Price + 1))

View(log_house_price_india)

#Visualization log_price
ggplot(log_house_price_india, aes(Price_log)) +
  geom_histogram()


#Prepare data-Rename columns
house_price_renamed <- log_house_price_india %>%
  rename("number_of_bedrooms" = "number of bedrooms" ,
         "Area_of_the_house_excluding_basement" = "Area of the house(excluding basement)",
         "Built_Year" = "Built Year",
         "Grade_of_the_house" = "grade of the house",
         "Postal_Code" = "Postal Code")
glimpse(house_price_renamed)

# Build function split data

train_test_split <- function(data, train_ratio = 0.7){
  set.seed(42)
  n <- nrow(data)
  id <- sample (n, size = train_ratio * n)
  
  train_data <- data[id, ]
  test_data <- data[-id, ]
  return(list( train_data, test_data ))
}

#1. split train, test data
set.seed(42)
splitdata <- train_test_split(house_price_renamed, 0.8)
train_data <- splitdata[[1]]
test_data <- splitdata[[2]]

#2. train data
# Price_log = f(number_of_bedrooms,Area_of_the_house_excluding_basement,Built_Year,Grade_of_the_house,Postal_Code)
#Set train control parameter
ctrl <- trainControl(
  method = "cv", # k-fold golden standard
  number = 5, # k=5
  verboseIter = TRUE
)

#Training 3 models
#2.1 Linear Regression
set.seed(42)
#Linear Regression Model
lm_model <- train(Price_log ~ number_of_bedrooms 
               + Area_of_the_house_excluding_basement
               + Built_Year 
               + Grade_of_the_house
               + Postal_Code, data = train_data, method = "lm", trControl = ctrl)

#Random Forest Model
rf_model <- train(Price_log ~ number_of_bedrooms 
                  + Area_of_the_house_excluding_basement
                  + Built_Year 
                  + Grade_of_the_house
                  + Postal_Code, data = train_data, method = "rf", trControl = ctrl)

#K-Nearest Neighbors Model
knn_model <- train(Price_log ~ number_of_bedrooms 
                  + Area_of_the_house_excluding_basement
                  + Built_Year 
                  + Grade_of_the_house
                  + Postal_Code, data = train_data, method = "knn", trControl = ctrl)

#3. score model
p_lm <- predict(lm_model, newdata = test_data)
p_rf <- predict(rf_model, newdata = test_data)
p_knn <- predict(knn_model, newdata = test_data)

#4. evaluate model
#4.1 Evaluate Model with Metrics
#Mean Absolute Error
MAE <- function(actual, prediction) {
  abs_error <- abs(actual - prediction)
  mean(abs_error)
}
#Mean Squared Error
MSE <- function(actual, prediction) {
  sq_error <- (actual - prediction) ** 2
  mean(sq_error)
}

#Root Mean Squared Error
RMSE <- function(actual, prediction) {
  sq_error <- (actual - prediction) ** 2
  sqrt(mean(sq_error))
}

##4.2 evaluate train - test comparison
#lm 
lm_model
MAE(test_data$Price_log, p_lm)
MSE(test_data$Price_log, p_lm)
RMSE(test_data$Price_log, p_lm)

#rf test
rf_model
MAE(test_data$Price_log, p_rf)
MSE(test_data$Price_log, p_rf)
RMSE(test_data$Price_log, p_rf)

#knn test
knn_model
MAE(test_data$Price_log, p_knn)
MSE(test_data$Price_log, p_knn)
RMSE(test_data$Price_log, p_knn)

#5. save model
saveRDS(lm_model, "lm_model_v1.RDS") #keep file .RDS
saveRDS(rf_model, "rf_model_v1.RDS")
saveRDS(knn_model, "knn_model_v1.RDS")









