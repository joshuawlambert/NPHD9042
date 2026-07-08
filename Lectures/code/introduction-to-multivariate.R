# Introduction to Multivariate Analysis

# Downloadable R code for the lecture examples.


# Example 1
#Install Packages
install.packages("MASS")
install.packages("readr")
library(readr)
library(MASS)

# Read the data file
data <-read_csv("Owl Diet.csv")
str(data)

#Perform the Discriminant Analysis
lda_model <- lda(`species` ~ `skull length` + `teeth row` + `palatine foramen` + `jaw length`, data = data)
print(lda_model)
summary(lda_model)


# Example 2
# Load necessary libraries
library(tidyverse)

# Load the dataset
data_1 <-read_csv("Blood Pressure.csv")

#Perform the MANOVA
manova_model <- manova(cbind(`BP 8M`, `BP 12M`, `BP 6M`, `BP 8W`) ~ `Dose`, data = data_1)

#Print and summarize the results
print(manova_model)
summary(manova_model)


# Example 3
#Load Data
your_data<-read.csv("Body Measurements.csv")
#Run PCA
pca_model <- prcomp(your_data, scale = TRUE)
#Print and view results
print(pca_model)
summary(pca_model)
plot(pca_model)
#Scree Plot
plot(pca_model, type = "l")


# Example 4
#Install and load the libraries
install.packages("haven")
install.packages("psych")
library(haven)
library(psych)
#Read the file
efa_data <- haven::read_sav("Williams.sav")
#Run the EFA
efa_result <- fa(efa_data, nfactors = 3, rotate = "varimax")
print(efa_result)
fa.diagram(efa_result)
