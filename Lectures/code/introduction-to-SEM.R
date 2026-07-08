# Introduction to Structural Equation Modeling (SEM)

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

load_packages(c("lavaan", "semPlot"))


# Example 2
mydata2 <- read.csv(lecture_data("worland5.csv"))

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
summary(MySEM_model, fit.measures = TRUE, standardized = TRUE)

# visualize the SEM model
semPaths(MySEM_model, what = "std", edge.label.cex = 0.8, layout = "tree")
