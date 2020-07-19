---
---

## Exercises
  
===

### Exercise 1 

ORCiDs identify you (like a DOI identifies a paper) and link you to your publications and research products.  
If you don't have an ORCiD, register and obtain your number at  [https://orcid.org](https://orcid.org).

===

### Exercise 2

The DataONE federation of repositories requires a unique authentication token for you to upload a data package.  
Follow the steps [here](https://github.com/DataONEorg/rdataone/blob/master/vignettes/dataone-federation.Rmd) to obtain your token.  

===

### Exercise 3

There are many repositories you could upload your data package to within the DataONE federation.  
Pick a repository from the list (located at data/Nodes.csv) and upload a test data package to the "STAGING" environment.   

[Use the example code from the lesson.](#upload-data-package)

===

### Exercise 4

DOIs (digital object identifiers) are almost univerally used to identify papers.  They also improve citation and discoverability for your published data packages.  
Get a DOI for your published data package.  

[Use the example code from the lesson.](#citation)

===

### Exercise 5

If you're using a data repository to manage versions of your derived data files, you will likely want to update your data file at some point.  Use the vignette from the `dataone` package to ["replace an older version of your derived data"](https://github.com/DataONEorg/rdataone/blob/master/vignettes/upload-data.Rmd) with a newer version.  

===

### Exercise 6

Provenance is an important description of how your data have been obtained, cleaned, processed, and analyzed.  It is being incorporated into descriptions of data packages in some repositories.  
Use the `describeWorkflow()` function from the `datapack` package to add provenance to your test data package.  

[Use the example code from the lesson.](#adding-provenance-to-your-data-package)


