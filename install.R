## install packages from project DESCRIPTION
remotes::install_deps()

## install additional packages used by modules
SpaDES.core::packages(modules = list.files("modules"), paths = "modules") |>
  unlist() |>
  Require::pkgDep2() |>
  Require::Install()
