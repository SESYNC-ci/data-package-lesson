---

---

## Publishing your data 

Choosing to publish your data in a long-term repository can:

   - enable versioning of your data
   - fulfill a journal requirement to publish data
   - facilitate citing your dataset by assigning a permanent uniquely identifiable code (DOI)
   - improve discovery of and access to your dataset for others
   - enable re-use and greater visibility of your work

===

### Why can't I just put my data on Dropbox, Google Drive, my website, etc?

![]({% include asset.html path="images/facepalm.png" %}){: width="45%"} 

===

#### Key reasons to use a repository:

  - preservation (permanence)
  - stability (replication / backup)
  - access 
  - standards
  
===

### When to publish your data?

Near the beginning?  At the very end?  

===

A couple issues to think about: 

1) How do you know you're using the same version of a file as your collaborator?

   - Publish your data privately and use the unique ids of datasets to manage versions.

===

2) How do you control access to your data until you're ready to go public with it?

   - Embargoing - controlling access for a certain period of time and then making your data public.

===

### Get an ORCiD 
 
ORCiDs identify you and link you to your publications and research products.  They are used by journals, repositories, etc. and often as a log in.  

![]({% include asset.html path="images/Sign_In_snap.PNG" %}){: width="100%"} 

===

To obtain an ORCiD, register at [https://orcid.org](https://orcid.org).

![]({% include asset.html path="images/orcid_snap2.png" %}){: width="100%"} 

===

### Creating a data package

Data packages can include metadata, data, and script files, as well as descriptions of the relationships between those files.   

===

Currently there are a few ways to make a data package:   

- [Frictionless Data](https://frictionlessdata.io/docs/data-package/) uses json-ld format, and has the R package [`datapackage.r`](https://github.com/frictionlessdata/datapackage-r) which creates metadata files using schema.org specifications and creates a data package.  

===

- [DataONE](https://www.dataone.org/) frequently uses EML format for metadata, and has related R packages [`datapack`](){:.rlib} and [`rdataone`](){:.rlib} that create data packages and upload data packages to a repository.  

We'll follow the DataONE way of creating a data package in this lesson.  

===

| R Package   | What does it do?                                      |
|-------------+-------------------------------------------------------|
| `datapack`  | creates data package including file relationships     |
| `uuid`      | creates a unique identifier for your metadata         |

===

We'll create a local data package using [`datapack`](){:.rlib}:



~~~r
library(datapack) 
library(uuid)

dp <- new("DataPackage") # create empty data package
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

Add the metadata file we created earlier to the blank data package.



~~~r
emlFile <- "storm_project/metadata/dataspice.xml"
emlId <- paste("urn:uuid:", UUIDgenerate(), sep = "")

mdObj <- new("DataObject", id = emlId, format = "eml://ecoinformatics.org/eml-2.1.1", file = emlFile)

dp <- addMember(dp, mdObj)  # add metadata file to data package
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

Add the data file we saved earlier to the data package.



~~~r
datafile <- "storm_project/StormEvents_d2006.csv"
dataId <- paste("urn:uuid:", UUIDgenerate(), sep = "")

dataObj <- new("DataObject", id = dataId, format = "text/csv", filename = datafile) 

dp <- addMember(dp, dataObj) # add data file to data package
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

Define the relationship between the data and metadata. 



~~~r
dp <- insertRelationship(dp, subjectID = emlId, objectIDs = dataId)
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


You can also add scripts and derived data files to the data package.  

===

Create a Resource Description Framework (RDF) of the relationships between data and metadata.



~~~r
serializationId <- paste("resourceMap", UUIDgenerate(), sep = "")
filePath <- file.path(sprintf("%s/%s.rdf", tempdir(), serializationId))
status <- serializePackage(dp, filePath, id=serializationId, resolveURI = "")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

Save the data package to a file, using the [BagIt](https://tools.ietf.org/id/draft-kunze-bagit-16.html) packaging format.  

Right now this creates a zipped file in the tmp directory.  We'll have to move the file 
out of the temp directory after it is created.  Hopefully this will be [changed soon](https://github.com/ropensci/datapack/issues/108)!  
{:.notes}



~~~r
dp_bagit <- serializeToBagIt(dp) 
file.copy(dp_bagit, "storm_project/Storm_dp.zip") 
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}


===

### Picking a repository 

There are many repositories out there, and it can seem overwhelming picking a suitable one for your data. 

Repositories can be subject or domain specific.  [re3data](https://www.re3data.org/) lists repositories by subject and can help you pick an appropriate repository for your data.  

===

[DataONE](https://www.dataone.org/) is a federation of repositories housing many different types of data.  Some of these repositories include Knowledge Network for Biocomplexity [(KNB)](https://knb.ecoinformatics.org/), Environmental Data Initiative [(EDI)](https://environmentaldatainitiative.org/), [Dryad](https://datadryad.org/), [USGS Science Data Catalog](https://data.usgs.gov/datacatalog/)

For qualitative data, there are a few dedicated repositories: [QDR](https://qdr.syr.edu/), [Data-PASS](http://data-pass.org/)

===

Though a bit different, [Zenodo](https://zenodo.org/) facilitates publishing (with a DOI) and archiving all research outputs from all research fields.  

This can be used to publish releases of your code that lives in a GitHub repository.  However, since GitHub is not designed for data storage and is not a persistent repository, this is not a recommended way to store or publish data.  
{:.notes}

===

### Uploading to a repository

Uploading requirements can vary by repository and type of data.  The minimum you usually need is basic metadata, and a data file.  

If you have a small number of files, using a repository GUI will usually be simpler.  For large numbers of files, automating uploads from R will save time.  And it's reproducible!  

===

#### Example using DataONE:

If you choose to upload your data package to a repository in the DataONE federation, the following example might be useful. 

You'll need to do two basic steps:   

1) Get authentication token for DataONE (follow steps [here](https://github.com/DataONEorg/rdataone/blob/master/vignettes/v02-dataone-federation.Rmd))

2) Upload your data package using R (from vignette for [dataone](){:.rlib})

===

| R Package   | What does it do?                      |
|-------------+---------------------------------------|
| `dataone`   | uploads data package to repository    |

===

**Tokens:**

Different environments in DataONE take different authentication tokens.  See below for description of environments.
To get a token for the staging envrionment go here [https://dev.nceas.ucsb.edu](https://dev.nceas.ucsb.edu).  
To get a token for production environment go here [https://search.dataone.org](https://search.dataone.org).  
Then do the following: 

  - Click *Sign in*, or *Sign up* if necessary
  - Once signed in, move the cursor over the user name and select 'My profile' in the drop down menu.
  - Click on the "Settings" tab.
  - Click on "Authentication Token" in the menu below "Welcome"
  - Click on the "Token for DataONE R" tab.
  - Click "Renew authentication token" if the token you have been using has expired.
  - Click on the "Copy" button below the text window to copy the authentication string to the paste buffer.
  - Note the identity string and expiration date of the token.
  - In the R console, paste the string which is similar to this example:

===

#### Set your token now



#### Set access rules 



~~~r
> library(dataone)
> library(curl) 
> library(redland) 
> 
> dpAccessRules <- data.frame(subject="http://orcid.org/0000-0003-0847-9100", 
+                             permission="changePermission") 
~~~
{:title="Console" .no-eval .input}

This gives this particular orcid (person) permission to read, write, and change permissions for others for this package

===



~~~r
> dpAccessRules2 <- data.frame(subject = c("http://orcid.org/0000-0003-0847-9100",
+                                          "http://orcid.org/0000-0000-0000-0001"),
+                              permission = c("changePermission", "read")
+                              )
~~~
{:title="Console" .no-eval .input}

NOTE: When you upload the package, you also need to set `public = FALSE` if you don't want your package public yet.

===

#### Upload data package

The first argument here is the environment - "PROD" is production where you publish your data.
"STAGING" can be used if you're not yet sure you have everything in order and want to test uploading your data package. NOTE: "PROD" and "STAGING" require different tokens.  See above steps to get the correct token.


===

The second argument is the repository specification.  A table of member node IDs: (data/Nodes.csv) 



~~~r
> read.csv("data/Nodes.csv")
~~~
{:title="Console" .no-eval .input}


===

First set the environment and repository you'll upload to:
  


~~~r
> d1c <- D1Client("STAGING2", "urn:node:mnTestKNB") 
~~~
{:title="Console" .no-eval .input}

  
===  
  
Now do the actual uploading of your data package:
  


~~~r
> packageId <- uploadDataPackage(d1c, dp, public = TRUE, accessRules = dpAccessRules,
+                                quiet = FALSE)
~~~
{:title="Console" .no-eval .input}


===

### Citation

Getting a Digital Object Identifier (DOI) for your data package can make it easier for others to find and cite your data.  

===

You can assign a DOI to the metadata file for your data package using: 

First specify the environment and repository.  


~~~r
> cn <- CNode("PROD")
> mn <- getMNode(cn, "urn:node:DRYAD")  
> 
> doi <- generateIdentifier(mn, "DOI")
~~~
{:title="Console" .no-eval .input}


===

Now overwrite the previous metadata file with the new DOI identified metadata file



~~~r
> mdObj <- new("DataObject", id = doi, format = "eml://ecoinformatics.org/eml-2.1.1", 
+              file = emlFile)
~~~
{:title="Console" .no-eval .input}





