#Checking install
Sys.getenv("PATH")
system('g++ -v')

## configuration

#This subsection is optional in the sense that RStan should work without it. Nevertheless, the following is strongly recommended.

#If you do not already have one, create a personal Makevars file as described at https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Customizing-package-compilation. The code below should work to specify this file programmatically from the R GUI, the terminal using command R, using the recommended RStudio application:
dotR <- file.path(Sys.getenv("HOME"), ".R")
if (!file.exists(dotR)) 
  dir.create(dotR)
M <- file.path(dotR, "Makevars")
if (!file.exists(M)) 
  file.create(M)
cat("\nCXXFLAGS=-O3 -Wno-unused-variable -Wno-unused-function", 
    file = M, sep = "\n", append = TRUE)

#Be advised that setting the optimization level to 3 may prevent some other R packages from installing from source if they are only tested with the stock R configuration.

#Starting with R version 3.3.x, it is possible to download Rtools for Windows that uses g++ 4.9.x, which supports the C++11 standard. Using the C++11 standard is not currently by supported by Stan for versions of g++ up to and including 4.6 but is believed to work for later versions of g++ and any recent version of clang++.

#Regardless of whether you utilize the C++11 standard, if you use Rtools33 (or higher) then you need to execute the following once:
cat('Sys.setenv(BINPREF = "C:/Rtools/mingw_$(WIN)/bin/")',
    file = file.path(Sys.getenv("HOME"), ".Rprofile"), 
    sep = "\n", append = TRUE)

#If you use g++ version 6 or higher, you may want to turn off some verbose warnings that are not relevant to Stan by executing
cat("\nCXXFLAGS += -Wno-ignored-attributes -Wno-deprecated-declarations", 
    file = M, sep = "\n", append = TRUE)

#You can verify that your configuration is correct by executing
cat(readLines(M), sep = "\n")

#You can also open the file at the path given by
cat(M)

# install rstan
install.packages("rstan", repos = "https://cloud.r-project.org/", dependencies=TRUE)

library("rstan")


# install statistical rethinking
install.packages(c("coda","mvtnorm","devtools"))
library(devtools)
devtools::install_github("rmcelreath/rethinking")

