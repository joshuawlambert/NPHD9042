# Introduction to Exploratory Factor Analysis (EFA)

# Downloadable R code for the lecture examples.


# Example 1
library(haven)
my_data<-read_sav("Williams.sav")
library(psych)
head(my_data)

efa <- fa(my_data, nfactors = 2, rotate = "varimax")

        # View results
print(efa)

print(loadings(efa ))
