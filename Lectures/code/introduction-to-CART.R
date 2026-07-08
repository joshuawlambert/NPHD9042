# Introduction to CART Modeling

# Downloadable R code for the lecture examples.


# Example 1
# Load necessary libraries
library(rpart)
library(rpart.plot)

# Load the dataset
Passengers <- read.csv("Titanic_Passengers.csv") # adjust path

# Define the CART model
model <- rpart(Survived ~ Sex+Age+Passenger.Class+Port,
data = Passengers , method = "class")

# Plot the decision tree
rpart.plot(model)
