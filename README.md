
Hi, this shiny application can help you search the universe of Generation R
# GENERATION R data seach app 
Hi, this repository contains a [shiny](http://shiny.rstudio.com/) application that can help you 
navigate the wonderful universe of [**Generation R**](https://generationr.nl/) resources. 

The **Generation R Study** is a population-based prospective cohort study spanning from fetal life to  adulthood. It collects data from 9901 children born between 2002 and 2006 in Rotterdam (NL), as well as their parents, with the aim to identify early environmental, genomic (genetic, epi-genetic, microbiome), lifestyle-related and socio-demographic determinants of normal and abnormal development. 
Generation R is a multidisciplinary study focusing on several health outcomes: e.g., behaviour and cognition, body composition, eye development, growth, hearing, heart and vascular development, infectious disease and immunity, oral health and facial growth, respiratory health, allergy and skin disorders. Data collection includes questionnaires, interviews, detailed physical and ultrasound examinations, behavioural observations, lung function, Magnetic Resonance Imaging and biological sampling.[Kooijman et al., 2017](https://pubmed.ncbi.nlm.nih.gov/28070760/)

This application is a search tool to navigate and get more information about the wealth of variables that Generation R can provide. 

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
shiny::runGitHub("GenR-search-app", "SereDef", ref="main", launch.browser = T)
```
This will automatically load these packages and the data overview files that are needed. 
The argument ```launch.browser = T``` makes the app open in the default browser. 
If that is not desired, the agument can simply be removed.

I hope you will find this useful. 

P.S. This very much still a work in progress, so please feel free to write me with any suggestions 
and comments!
