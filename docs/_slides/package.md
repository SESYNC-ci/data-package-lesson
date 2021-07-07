---

---

## Packaging your data

Data packages can include metadata, data, and script files, as well as descriptions of the relationships between those files.   

Packaging your data together with the code you used to make the data file, and the metadata that describes the data, can benefit you and your research team because it keeps this information together so you can more easily share it, and it will be ready to publish (perhaps with minor updates if you wish) when you are ready.  
{:.notes}

===

Currently there are a few ways to make a data package:   

- [Frictionless Data](https://frictionlessdata.io/docs/data-package/) uses json-ld format, and has the R package [`datapackage.r`](https://github.com/frictionlessdata/datapackage-r) which creates metadata files using schema.org specifications and creates a data package.  

===

- [DataONE](https://www.dataone.org/) frequently uses EML format for metadata, and has related R packages [`datapack`](){:.rlib} and [`dataone`](){:.rlib} that create data packages and upload data packages to a repository.  

We'll follow the DataONE way of creating a data package in this lesson.  

===

| R Package   | What does it do?                                      |
|-------------+-------------------------------------------------------|
| `datapack`  | creates data package including file relationships     |
| `uuid`      | creates a unique identifier for your metadata         |

===

### Data, Metadata, and other objects

We'll create an empty local data package using the `new()` function from the [`datapack`](){:.rlib}: R package.



~~~r
library(datapack) 
library(uuid)

dp <- new("DataPackage") # create empty data package
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

Add the metadata file we created earlier to the blank data package.



~~~r
emlFile <- "./storm_project/eml/storm_events_package_id.xml"
emlId <- paste("urn:uuid:", UUIDgenerate(), sep = "")

mdObj <- new("DataObject", id = emlId, format = "eml://ecoinformatics.org/eml-2.1.1", file = emlFile)

dp <- addMember(dp, mdObj)  # add metadata file to data package
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

Add the data file we saved earlier to the data package.



~~~r
datafile <- "./storm_project/data_objects/StormEvents_d2006.csv"
dataId <- paste("urn:uuid:", UUIDgenerate(), sep = "")

dataObj <- new("DataObject", id = dataId, format = "text/csv", filename = datafile) 

dp <- addMember(dp, dataObj) # add data file to data package
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

Define the relationship between the data and metadata files.  The "subject" should be the metadata, and the "object" should be the data.   



~~~r
# NOTE: We have defined emlId and dataId in the code chunks above.  
dp <- insertRelationship(dp, subjectID = emlId, objectIDs = dataId)
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

You can also add scripts and other files to the data package.  Let's add a short script to our data package, as well as the two figures it creates. 



~~~r
scriptfile <- "./data/storm_script.R"
scriptId <- paste("urn:uuid:", UUIDgenerate(), sep = "")

scriptObj <- new("DataObject", id = scriptId, format = "application/R", filename = scriptfile)

dp <- addMember(dp, scriptObj)
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}




~~~r
fig1file <- "./data/Storms_Fig1.png"
fig1Id <- paste("urn:uuid:", UUIDgenerate(), sep = "")

fig1Obj <- new("DataObject", id = fig1Id, format = "image/png", filename = fig1file)

dp <- addMember(dp, fig1Obj)
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}




~~~r
fig2file <- "./data/Storms_Fig2.png"
fig2Id <- paste("urn:uuid:", UUIDgenerate(), sep = "")

fig2Obj <- new("DataObject", id = fig2Id, format = "image/png", filename = fig2file)

dp <- addMember(dp, fig2Obj)
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

### Provenance

Provenance defines the relationships between data, metadata, and other research objects (inputs and outputs) generated throughout the research process, from raw data to publication(s). It can be recorded in several different formats, but we'll explore a couple here.  

Resource Description Framework (RDF) describes links between objects, and is designed to be read and understood by computers.  RDF is not designed to be read by humans, and is written in XML.  Describing your data package relationships with RDF will help with displaying your data in an online repository.  If you're interested in the details, you can read more online such as from [w3](https://www.w3schools.com/XML/xml_rdf.asp).
{:.notes}

===

We'll create a Resource Description Framework (RDF) to define the relationships between our data and metadata in XML.  



~~~r
serializationId <- paste("resourceMap", UUIDgenerate(), sep = "")
filePath <- file.path(sprintf("%s/%s.rdf", tempdir(), serializationId))
status <- serializePackage(dp, filePath, id = serializationId, resolveURI = "")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

When thinking about the relationships between your data, metadata, and other objects, it is often very helpful to create a diagram.  Here an couple example:

 - simple path diagram  
 
   ![]({% include asset.html path="images/simple_grv.png" %}){: width="40%"}
   {:.captioned}

===

Let's create a conceptual diagram of the relationships between our data, script, and figures.  



~~~r
library(DiagrammeR)

storm_diag <- grViz("digraph{
         
                     graph[rankdir = LR]
                     
                     node[shape = rectangle, style = filled]  
                     A[label = 'Storm data']
                     B[label = 'storm_script.R']
                     C[label = 'Fig. 1']
                     D[label = 'Fig. 2']

                     edge[color = black]
                     A -> B
                     B -> C
                     B -> D
                     
                     }")

storm_diag
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}
<div class="figure">
<!--html_preserve--><div id="htmlwidget-ad2f04083375781c000b" style="width:504px;height:504px;" class="grViz html-widget"></div>
<script type="application/json" data-for="htmlwidget-ad2f04083375781c000b">{"x":{"diagram":"digraph{\n         \n                     graph[rankdir = LR]\n                     \n                     node[shape = rectangle, style = filled]  \n                     A[label = \"Storm data\"]\n                     B[label = \"storm_script.R\"]\n                     C[label = \"Fig. 1\"]\n                     D[label = \"Fig. 2\"]\n\n                     edge[color = black]\n                     A -> B\n                     B -> C\n                     B -> D\n                     \n                     }","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption"> </p>
</div>

===

### Adding the provenance to your data package

Human-readable provenance can be added to a data package using [`datapack`](){:.rlib} and the function `describeWorkflow`, as in the example code below.  
See the [overview](https://docs.ropensci.org/datapack/articles/datapack-overview.html) or the [function documentation](https://docs.ropensci.org/datapack/reference/describeWorkflow.html) for more details.  
{:.notes}

===

We'll define the relationship between our data, our script that creates 2 figures, and our figures.  



~~~r
# NOTE: we defined the objects here in the code above
dp <- describeWorkflow(dp, sources = dataObj, program = scriptObj, derivations = c(fig1Obj, fig2Obj))
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

Now let's take a look at those relationships we just defined. 



~~~r
library(igraph)
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


~~~

Attaching package: 'igraph'
~~~
{:.output}


~~~
The following objects are masked from 'package:dplyr':

    as_data_frame, groups, union
~~~
{:.output}


~~~
The following objects are masked from 'package:purrr':

    compose, simplify
~~~
{:.output}


~~~
The following object is masked from 'package:tidyr':

    crossing
~~~
{:.output}


~~~
The following object is masked from 'package:tibble':

    as_data_frame
~~~
{:.output}


~~~
The following objects are masked from 'package:stats':

    decompose, spectrum
~~~
{:.output}


~~~
The following object is masked from 'package:base':

    union
~~~
{:.output}


~~~r
plotRelationships(dp)
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}
![ ]({% include asset.html path="images/package/unnamed-chunk-11-1.png" %})
{:.captioned}

Why does the diagram we created above differ from the provenance diagram created by the function `datapack::describeWorkflow`?  The datapack function adds additional descriptive nodes to the diagram that fulfill certain semantic requirements.  However, the basic relationships are still there if you look carefully.  
{:.notes}

===

Save the data package to a file, using the [BagIt](https://tools.ietf.org/id/draft-kunze-bagit-16.html) packaging format.  

Right now this creates a zipped file in the tmp directory.  We'll have to move the file 
out of the temp directory after it is created.  Hopefully this will be [changed soon](https://github.com/ropensci/datapack/issues/108)!  
{:.notes}



~~~r
dp_bagit <- serializeToBagIt(dp) 

file.copy(dp_bagit, "./storm_project/Storm_data_package.zip") 
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


~~~
[1] TRUE
~~~
{:.output}


The BagIt zipped file is an excellent way to share all of the files and metadata of a data package with a collaborator, or easily publish in a repository.

===
