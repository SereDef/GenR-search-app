
Hi, this shiny application can help you search the universe of Generation R
# GENERATION R data seach app 
Hi, this repository contains a [shiny](http://shiny.rstudio.com/) application that can help you 
navigate the universe of [**Generation R**](https://generationr.nl/) resources. 

This is an ongoing population based study based in Rotterdam. 

The app requires [R](http://cran.r-project.org/) (version >= 4.0.3) and the following packages:

* [shiny](http://cran.r-project.org/package=shiny) (version >= 1.6.0)
* [shinyWidgets](https://cran.r-project.org/package=shinyWidgets) (version >= 0.6.0)
* [shinyTree](https://CRAN.R-project.org/package=shinyTree) (version >= 0.2.7)

These packages can be installed using the following function call:
```r
install.packages(c("shiny", "shinyWidgets", "shinyTree"), dependencies = TRUE)
```
and then the app can be directly invoked using the command:
```r
shiny::runGitHub("GenR-search-app", "SereDef", ref="main")
```

The app will automatically load these packages and the data overview files it needs. 

I hope you will find this useful. 

This very much a work in progress still so please feel free to write me with any suggestions 
and comments!
