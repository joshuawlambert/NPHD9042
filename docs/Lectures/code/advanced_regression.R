# Model Building and Advanced Linear and Logistic Regression

# Downloadable R code for the lecture examples.


# Example 1
#Forward selection for MLR
# Load necessary libraries
library(MASS)
library(readr)

# Load dataset
cars1993 <- read_csv("Cars 1993.csv")

#Build the full model
full_model <- lm(`Minimum Price ($1000)` ~ `Maximum Horsepower` + `Fuel Tank Capacity`+ `Passenger Capacity`, data = cars1993)

# Forward stepwise selection
step_model <- stepAIC(lm(`Minimum Price ($1000)` ~ 1, data = cars1993),
                      direction = "forward",
                      scope = list(lower = ~1, upper = full_model))

# Print summary of the final model selected by forward selection
summary(step_model)


# Example 2
#Backward selection with MLR
# Load necessary libraries
library(MASS)
library(readr)

# Load dataset
cars1993 <- read_csv("Cars 1993.csv")

#Build the full model
full_model <- lm(`Minimum Price ($1000)` ~ `Maximum Horsepower` + `Fuel Tank Capacity`+ `Passenger Capacity`, data = cars1993)

# Backward stepwise selection
step_model <- stepAIC(full_model, direction = "backward")

# Print summary of the final model selected by backward selection
summary(step_model)


# Example 3
# Stepwise Selection in R
library(MASS)
library(readr)

# Load dataset
cars1993 <- read_csv("Cars 1993.csv")

# Full model
full_model <- lm(`Minimum Price ($1000)` ~ `Maximum Horsepower` + `Fuel Tank Capacity`+ `Passenger Capacity`, data = cars1993)

# Stepwise selection
step_model <- stepAIC(full_model, direction = "both")

summary(step_model)


# Example 4
# Install glmnet package if not already installed
install.packages("glmnet")

# Lasso in R
library(glmnet)

# Prepare data
data_2 <- read.csv("Cars 1993.csv")
X <- model.matrix(`Minimum.Price...1000.` ~ `Maximum.Horsepower` + `Fuel.Tank.Capacity` + `Passenger.Capacity`, data = data_2)[, -1]
y <- data_2$`Minimum.Price...1000.`

#Fit LASSO using cross-validation
set.seed(123) #For reproducibility
cv_fit <- cv.glmnet(X, y, alpha = 1)

#Plot the cross-validation
plot(cv_fit)

#Extract the coefficients of the best model
best_lambda <- cv_fit$lambda.min
lasso_coefficients <- coef(cv_fit, s = "lambda.min")
print(lasso_coefficients)


# Example 5
# Multi-Step (Hierarchical Regression) in R
library(readr)

# Load dataset
cars1993 <- read_csv("Cars 1993.csv")

# Step 1
model1<- lm(`Minimum Price ($1000)` ~ `Maximum Horsepower`, data = cars1993)

# Step 2
model2 <- lm(`Minimum Price ($1000)` ~ `Maximum Horsepower` + `Fuel Tank Capacity`, data = cars1993)

# Step 3
model3 <- lm(`Minimum Price ($1000)` ~ `Maximum Horsepower` + `Fuel Tank Capacity`+ `Passenger Capacity`, data = cars1993)

# Compare models
summary(model1)
summary(model2)
summary(model3)

#ANOVA of models
anova(model1, model2, model3)
