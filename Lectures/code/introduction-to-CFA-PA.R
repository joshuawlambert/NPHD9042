# Introduction to Confirmatory Factor Analysis (CFA) and Path Analysis (PA)

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

load_packages(c("lavaan"))


# Example 2
#load your data
mydata3 <- read.csv(lecture_data("worland5.csv"))

# Define the model
model <- 'adjustment  =~ motiv + harm + stabi'

# Fit the model
fit <- cfa(model, data = mydata3)

# Summarize the results
summary(fit, fit.measures = TRUE, standardized = TRUE)
