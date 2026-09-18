## this manual must be knitted by running this script.
## Package installation happens in install.R, ahead of it.

library(bibtex)
library(bookdown)
library(data.table)
library(knitr)
library(RefManageR)
library(SpaDES.docs)

paths <- manualPaths()

## bookdown writes referenced resources here; created ahead of the render so the
## directory exists whether or not this build produces figures
Require::checkPath(file.path(paths$docs, "figures"), create = TRUE)

## references ---------------------------------------

writePkgBib(file.path(paths$citations, "packages.bib"))

downloadCSL("ecology-letters", paths$citations)

## references.bib is both an input and the output: the manual accumulates into
## its own bibliography, and every input is read before anything is written
collapseModuleBibs(
  modulePath = file.path(paths$prj, "modules"),
  extraBibs = file.path(paths$citations, c("packages.bib", "references.bib")),
  outFile = file.path(paths$citations, "references.bib")
)

# RENDER BOOK ------------------------------------------

## set manual version
Sys.setenv(FIRESENSE_VERSION = read.dcf("DESCRIPTION", fields = "Version")[1])

## don't use Require for package installation etc.
Sys.setenv(R_USE_REQUIRE = "false")

## NOTE: need dot because knitting is doing `rm(list = ls())`
.copyModuleRmds <- prepManualRmds(modulePath = "./modules", rebuildCache = FALSE) ## use rel path!

## render the book using new env -- see <https://stackoverflow.com/a/46083308>
## `all` is every format _output.yml declares, which is bs4_book alone. See #11
## for whether this manual should also build a PDF and an EPUB.
bookdown::render_book(output_format = "all", envir = new.env())

## .nojekyll has to be inside the published directory: the deploy pushes the
## contents of docs/, so a file at the repository root never reaches the site.
stagePagesFiles(paths$docs)

## remove temporary .Rmds
unlink("_manual_rmds", recursive = TRUE)
