# Model Building and Advanced Linear and Logistic Regression

# Downloadable R code for the lecture examples.


# Example 1
load_packages <- function(pkgs) {
  missing <- pkgs[!vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)]
  if (length(missing) > 0) {
    install.packages(missing, repos = "https://cloud.r-project.org")
  }
  invisible(lapply(pkgs, library, character.only = TRUE))
}

lecture_data <- function(filename) {
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", args, value = TRUE)
  script_dir <- if (length(file_arg) > 0) {
    dirname(normalizePath(sub("^--file=", "", file_arg)))
  } else {
    getwd()
  }

  candidates <- c(
    filename,
    file.path("Lectures", filename),
    file.path("..", filename),
    file.path(script_dir, "..", filename),
    file.path(script_dir, "..", "..", "Lectures", filename)
  )

  hit <- candidates[file.exists(candidates)]
  if (length(hit) == 0) {
    stop("Could not find ", filename, ". Run from the project, Lectures, or Lectures/code folder.")
  }
  normalizePath(hit[1], winslash = "/")
}

load_packages(c("MASS", "readr", "glmnet"))


# Example 2
#Forward selection for MLR
# Load dataset
cars1993 <- readr::read_csv(lecture_data("Cars 1993.csv"))

#Build the full model
full_model <- lm(`Minimum Price ($1000)` ~ `Maximum Horsepower` + `Fuel Tank Capacity`+ `Passenger Capacity`, data = cars1993)

# Forward stepwise selection
step_model <- stepAIC(lm(`Minimum Price ($1000)` ~ 1, data = cars1993),
                      direction = "forward",
                      scope = list(lower = ~1, upper = formula(full_model)))

# Print summary of the final model selected by forward selection
summary(step_model)


# Example 3
#Backward selection with MLR
# Load dataset
cars1993 <- readr::read_csv(lecture_data("Cars 1993.csv"))

#Build the full model
full_model <- lm(`Minimum Price ($1000)` ~ `Maximum Horsepower` + `Fuel Tank Capacity`+ `Passenger Capacity`, data = cars1993)

# Backward stepwise selection
step_model <- stepAIC(full_model, direction = "backward")

# Print summary of the final model selected by backward selection
summary(step_model)


# Example 4
# Stepwise Selection in R
# Load dataset
cars1993 <- readr::read_csv(lecture_data("Cars 1993.csv"))

# Full model
full_model <- lm(`Minimum Price ($1000)` ~ `Maximum Horsepower` + `Fuel Tank Capacity`+ `Passenger Capacity`, data = cars1993)

# Stepwise selection
step_model <- stepAIC(full_model, direction = "both")

summary(step_model)


# Example 5
# Prepare data
data_2 <- readr::read_csv(lecture_data("Cars 1993.csv"))
X <- model.matrix(`Minimum Price ($1000)` ~ `Maximum Horsepower` + `Fuel Tank Capacity` + `Passenger Capacity`, data = data_2)[, -1]
y <- data_2[["Minimum Price ($1000)"]]

#Fit LASSO using cross-validation
set.seed(123) #For reproducibility
cv_fit <- cv.glmnet(X, y, alpha = 1)

#Plot the cross-validation
plot(cv_fit)

#Extract the coefficients of the best model
best_lambda <- cv_fit$lambda.min
lasso_coefficients <- coef(cv_fit, s = "lambda.min")
print(lasso_coefficients)


# Example 6
# Multi-Step (Hierarchical Regression) in R
# Load dataset
cars1993 <- readr::read_csv(lecture_data("Cars 1993.csv"))

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
