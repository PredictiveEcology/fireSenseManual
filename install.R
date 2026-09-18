## install packages from project DESCRIPTION
remotes::install_deps()

## install additional packages used by modules
SpaDES.docs::installModulePkgs("modules")
