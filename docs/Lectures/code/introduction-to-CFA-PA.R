# Introduction to Confirmatory Factor Analysis (CFA) and Path Analysis (PA)

# Downloadable R code for the lecture examples.


# Example 1
# Load necessary library
library(lavaan)
#load your data
mydata3<-read.csv("worland5.csv") # adjust the file path accordingly

# Define the model
model <- 'adjustment  =~ motiv + harm + stabi'

# Fit the model
fit <- cfa(model, data = mydata3)

# Summarize the results
summary(fit, fit.measures = TRUE)
