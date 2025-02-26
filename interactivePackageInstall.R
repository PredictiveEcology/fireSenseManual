
if (interactive()) {
  
  options(
    Ncpus = min(parallel::detectCores() / 2, 8),
    repos = c("predictiveecology.r-universe.dev", getOption("repos")),
    width = 60
  )
  pkgPath <- normalizePath(file.path("packages", version$platform, 
                                     paste0(version$major, ".", strsplit(version$minor, "[.]")[[1]][1])), 
                           winslash = "/")
  dir.create(pkgPath, recursive = TRUE)
  .libPaths(pkgPath, include.site = FALSE)
  
  # switch to library
  
  Require::Install(c("PredictiveEcology/SpaDES.docs@development",
                     "bookdown", "ROpenSci/bibtex", "data.table", "downlit",
                     "formatR", "git2r", "kableExtra", "knitr", "PredictiveEcology/SpaDES.project@development",
                     "fansi", "xml2", "vctrs", "RefManageR", "remotes"), libPaths = .libPaths()[[1]])
  modulepkgs <- SpaDES.core::packages(modules = list.files("modules"), paths = "..")[[1]]
  Require::Require(modulepkgs[[1]], require = FALSE)
  
}