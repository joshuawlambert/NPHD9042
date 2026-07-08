# Introduction to Multivariate Analysis

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

load_packages(c("MASS", "readr", "haven", "psych"))


# Example 2
# Read the data file
data <- readr::read_csv(lecture_data("Owl Diet.csv"))
str(data)

#Perform the Discriminant Analysis
lda_model <- lda(`species` ~ `skull length` + `teeth row` + `palatine foramen` + `jaw length`, data = data)
print(lda_model)
summary(lda_model)


# Example 3
# Load the dataset
data_1 <- readr::read_csv(lecture_data("Blood Pressure.csv"))

#Perform the MANOVA
manova_model <- manova(cbind(`BP 8M`, `BP 12M`, `BP 6M`, `BP 8W`) ~ `Dose`, data = data_1)

#Print and summarize the results
print(manova_model)
summary(manova_model)


# Example 4
#Load Data
your_data <- read.csv(lecture_data("Body Measurements.csv"))
#Run PCA
pca_model <- prcomp(your_data, scale = TRUE)
#Print and view results
print(pca_model)
summary(pca_model)
plot(pca_model)
#Scree Plot
plot(pca_model, type = "l")


# Example 5
#Read the file
efa_data <- haven::read_sav(lecture_data("Williams.sav"))
#Run the EFA
efa_result <- fa(efa_data, nfactors = 3, rotate = "varimax")
print(efa_result)
fa.diagram(efa_result)
