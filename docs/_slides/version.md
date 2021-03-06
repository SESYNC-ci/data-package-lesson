---

---
  
## Versioning Data

How do you know you're using the same version of a data file as your collaborator?

 - Do not edit raw data files!  Make edits/changes via your code only, and then output a derived "clean" data file. 

===

Potential ways forward: 

1. Upload successive versions of the data to a repo with versioning, but keep it private until you've reached the final version or the end of the project.  (see below)

2. Google Sheets has some support for viewing the edit history of cells, added or deleted columns and rows, changed formatting, etc.  

===

### Updating your data package on the repository

To take advantage of the versioning of data built into many repositories, you can update the data package (replace files with new versions).  

Please see the vignettes for [`dataone`](){:.rlib} , in the section on ["Replace an object with a newer version"](https://github.com/DataONEorg/rdataone/blob/master/vignettes/v06-update-package.Rmd).
{:.notes}

It's also possible to automate data publication for data that are updated periodically, such as monitoring data, or time-series data.  The R package [EMLassemblyline](https://ediorg.github.io/EMLassemblyline/) has a [vignette describing the process](https://ediorg.github.io/EMLassemblyline/articles/auto_pub.html).
{:.notes}

===

## Closing thoughts

Starting to document your data at the beginning of your project will save you time and headache at the end of your project.

Integrating data documentation and publication into your research workflow will increase collaboration efficiency, reproducibility, and impact in the science community.  












