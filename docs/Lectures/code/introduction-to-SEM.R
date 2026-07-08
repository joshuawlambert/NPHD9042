# Introduction to Structural Equation Modeling (SEM)

# Downloadable R code for the lecture examples.


# Example 1
# Load necessary libraries
library(lavaan)

mydata2<-read.csv("worland5.csv") # adjust the file path accordingly

# Specify the SEM model

model <- '
  # Measurement model
  adjustment  =~ motiv + harm + stabi
  risk =~ verbal + ppsych + ses
  achievement =~ read + arith + spell

  # Structural model
  achievement ~ adjustment+ risk
'

# Fit the model
MySEM_model <- sem(model, data=mydata2)

# Summarize the results
summary(MySEM_model, fit.measures = TRUE)

# visualize the SEM model
library(semPlot)

 # Visualize the path diagram
semPaths(MySEM_model, what = "std", edge.label.cex = 0.8, layout = "tree")
