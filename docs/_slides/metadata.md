---

---

## What is Metadata?

Metadata is the information needed for someone else to understand and use your data.  It is the Who, What, When, Where, Why, and How about your data.  

This includes _package-level_ and _file-level_ metadata.  

===

### Common components of metadata

Package-level:
 - Data creator 
 - Geographic and temporal extents of data (generally)
 - Funding source
 - Licensing information (Creative Commons, etc.)
 - Publication date

===

File-level:
 - Define variable names
 - Describe variables (units, etc.)
 - Define allowed values for a variable
 - Describe file formats

===

### Metadata Standards

The goal is to have a machine and human readable description of your data. 
 
Metadata standards create a structural expression of metadata necessary to document a data set.  
This can mean using a controlled set of descriptors for your data specified by the standard. 

===

Without metadata standards, your digital data may be irretrievable, unidentifiable or unusable. 
Metadata standards contain definitions of the data elements and standardized ways of representing them in digital formats such as databases and XML (eXtensible Markup Language).
{:.notes}

These standards ensure consistent structure that facilitates data sharing and searching, record provenance and technical processes, and manage access permissions.  Recording metadata in digital formats such as XML ensures effective machine searches through consistent structured data entry, and thesauri using controlled vocabularies.  
{:.notes}

===

Metadata standards are often developed by user communities.  

For example, the Ecological Metadata Language, EML, is a standard developed by ecologists to document environmental and ecological data. EML is a set of XML schema documents that allow for the structural expression of metadata. To learn more about EML check out their [site](https://eml.ecoinformatics.org).
{:.notes}

Therefore, the standards can vary between disciplines and types of data.  

===

![]({% include asset.html path="images/standards_xkcd.png" %}){: width="75%"} 

===

Some examples include:

   - General: [Dublin Core](http://dublincore.org/)
   - Ecological/Environmental/Biological: [EML](https://www.dcc.ac.uk/resources/metadata-standards/eml-ecological-metadata-language), [Darwin Core](https://dwc.tdwg.org/)
   - Social science: [DDI](http://www.ddialliance.org/), [EAD](https://www.loc.gov/ead/) 
   - Geospatial/Meterological/Oceanographic: [ISO 19115](https://www.iso.org/standard/53798.html), [COARDS Conventions](https://ferret.pmel.noaa.gov/Ferret/documentation/coards-netcdf-conventions)

===

### Creating metadata

Employer-specific mandated methods

For example, some government agencies specify the metadata standards to which their employees must adhere.  

===

Repository-specific methods

Repository websites frequently guide you through metadata creation during the process of uploading your data.  
{:.notes}

   - website for metadata entry on the [Knowledge Network for Biocomplexity](https://knb.ecoinformatics.org) repository 
     ![]({% include asset.html path="images/knb_snap.PNG" %}){: width="100%"} 

===     
   
Stand-alone software

Software designed for data curation may have more features and options.     
{:.notes}
   
   - [Data Curator](https://github.com/qcif/data-curator) 
     This software from the [Queensland Cyber Infratstructure Foundation](https://www.qcif.edu.au/) supports metadata creation, provenance, and data packaging.
     ![]({% include asset.html path="images/Data_Curator_snap.PNG" %}){: width="100%"} 
     
   - [ezEML](https://ezeml.edirepository.org/eml/user_guide)
     This software from the [Environmental Data Initiative](https://environmentaldatainitiative.org/) supports metadata creation, metadata editing, and multiple metadata co-authors.
     ![]({% include asset.html path="images/ez_eml.png" %}){: width="100%"} 
     
===

Coding 

Why would you want to create your metadata programmatically in R?  Scripting your metadata creation in R makes updates in the future easier (just update the relevant part of the script and run it), and automating metadata creation is extremely helpful if you are documenting large numbers of data files.
{:.notes}

Many methods for documenting and packaging data are also available in R packages developed by repository managers.  For example, `EMLassemblyline` was developed by the [Environmental Data Initiative](https://environmentaldatainitiative.org/) to facilitate documenting data in EML, and preparing data for publication.          
{:.notes}

   - R packages for metadata ([EML](){:.rlib}, [dataspice](https://github.com/ropenscilabs/dataspice), [emld](){:.rlib}),
   [EMLassemblyline](https://ediorg.github.io/EMLassemblyline/)
 
===

### Example of coding up some metadata  

| R Package         | What does it do?                                           |
|-------------------+------------------------------------------------------------|
| `EMLassemblyline` | creates high quality EML metadata for packaging data       |
| `EML`             | creates EML metadata files                                 |

===

We'll use the [EMLassemblyline](https://ediorg.github.io/EMLassemblyline/) package to create metadata in the EML metadata standard. 



~~~r
library(EMLassemblyline) 
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

Create the organization for the data package with the `EMLassemblyline::template_directories()` function.

- **data_objects** A directory of data and other digital objects to be packaged (e.g. data files, scripts, .zip files, etc.).
- **metadata_templates** A directory of EMLassemblyline template files.
- **eml** A directory of EML files created by EMLassemblyline.
- **run_EMLassemblyline.R** An example R file for scripting an EMLassemblyline workflow. This could be helpful if you're starting from scratch, but we walk through a metadata workflow in detail below instead.  




~~~r
template_directories(path = "~", dir.name = "storm_project") # create template files in a new directory

# move the derived data file to the new storm_project directory
file.copy("~/StormEvents_d2006.csv", "~/storm_project/data_objects/", overwrite = TRUE)
file.remove("~/StormEvents_d2006.csv")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}

 
Look at your storm_project folder, and see the template files and folders, and the derived data file we created earlier. 
 
=== 

### Describe the package-level metadata. 

We'll start by creating the package-level metadata. 

Essential metadata: Create templates for package-level metadata, including abstract, intellectual rights, keywords, methods, personnel, and additional info.  These are required for all data packages.



~~~r
template_core_metadata(path = "~/storm_project/metadata_templates",
                       license = "CCBY",
                       file.type = ".txt")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


We've chosen the "CCBY" license and the text file type (`.txt`) because text files are easily read into R and programmatically edited.    

You can choose the license you wish to apply to your data (["CC0"](https://creativecommons.org/publicdomain/zero/1.0/) or ["CCBY"](https://creativecommons.org/licenses/by/4.0/)), as well as the file type of the metadata (`.txt`, `.docx`, or `.md`). See the [help page for the function](https://ediorg.github.io/EMLassemblyline/reference/template_core_metadata.html) for more information. NOTE: The `.txt` template files are Tab delimited. 
{:.notes}

===

Now that the templates have been created, open the files and add the appropriate metadata.  They are located in the project directory, the metadata templates folder `~/storm_project/metadata_templates/`.   
{:.notes}

You could open the template files in RStudio and edit manually, or export to Excel and edit there, but let's read them into R and edit them programmatically.  This example can be used to automate the creation of your metadata  

We'll begin by adding a brief abstract.



~~~r
abs <- "Abstract: Storms can have impacts on people's lives.  These data document some storms in 2006, and the injuries and damage that might have occurred from them."

# this function from the readr package writes a simple text file without columns or rows
write_file(abs, "~/storm_project/metadata_templates/abstract.txt", append = FALSE)
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

Now we'll add methods. 



~~~r
methd <- "These example data were generated for the purpose of this lesson.  Their only use is for instructional purposes."

write_file(methd, "~/storm_project/metadata_templates/methods.txt", append = FALSE)
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

And some add keywords.  

NOTE: This must be a 2 column table. You may leave the Thesaurus column empty if you're not using a controlled vocabulary for your keywords.  



~~~r
keyw <- read.table("~/storm_project/metadata_templates/keywords.txt", sep = "\t", header = TRUE, colClasses = rep("character", 2))

keyw <- keyw[1:3,] # create a few blank rows  
keyw$keyword <- c("storm", "injury", "damage") # fill in a few keywords

write.table(keyw, "~/storm_project/metadata_templates/keywords.txt", row.names = FALSE, sep = "\t")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

Let's edit the personnel template file programmatically.  NOTE: The `.txt` template files are Tab delimited.



~~~r
# read in the personnel template text file
persons <- read.table("~/storm_project/metadata_templates/personnel.txt", 
                     sep = "\t", header = TRUE, colClasses = rep("character", 10))  

persons <- persons[1:4,] # create a few blank rows  

# edit the personnel information
persons$givenName <- c("Jane", "Jane", "Jane", "Hank")
persons$middleInitial <- c("A", "A", "A", "O")
persons$surName <- c("Doe", "Doe", "Doe", "Williams")
persons$organizationName <- rep("University of Maryland", 4)
persons$electronicMailAddress <- c("jadoe@umd.edu", "jadoe@umd.edu", "jadoe@umd.edu", "how@umd.edu")
persons$role <- c("PI", "contact", "creator", "Field Technician")
persons$projectTitle <- rep("Storm Events", 4)
persons$fundingAgency <- rep("NSF", 4)
persons$fundingNumber <- rep("000-000-0001", 4)  

# write new personnel file
write.table(persons, "~/storm_project/metadata_templates/personnel.txt", row.names = FALSE, sep = "\t")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


IMPORTANT: In the `personnel.txt` file, if a person has more than one role (for example PI and contact), make multiple rows for this person but change the role on each row.  See the help page for the [template function](https://ediorg.github.io/EMLassemblyline/reference/template_core_metadata.html) for more details.  
{:.notes}

===

Geographic coverage: Create the metadata for the geographic extent.



~~~r
template_geographic_coverage(path = "~/storm_project/metadata_templates", 
                             data.path = "~/storm_project/data_objects", 
                             data.table = "StormEvents_d2006.csv", 
                             lat.col = "BEGIN_LAT",
                             lon.col = "BEGIN_LON",
                             site.col = "STATE"
                             )
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===
  
### Describe the file-level metadata.

Now that we've created package-level metadata, we can create the file-level metadata.  
  
Data attributes: Create table attributes template (required when data tables are present)



~~~r
template_table_attributes(path = "~/storm_project/metadata_templates",
                          data.path = "~/storm_project/data_objects",
                          data.table = c("StormEvents_d2006.csv"))
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

The template function can't discover everything, so some columns are still empty. View the file in the metadata templates folder `~/storm_project/metadata_templates/` and enter the missing info.  



~~~r
# read in the attributes template text file
attrib <- read.table("~/storm_project/metadata_templates/attributes_StormEvents_d2006.txt", 
                     sep = "\t", header = TRUE)  
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}




~~~r
> View(attrib)
~~~
{:title="Console" .input}


===

We need to add attribute definitions for each column, and units or date/time specifications for numeric or date/time columns classes.  



~~~r
attrib$attributeDefinition <- c("event id number", "State", "FIPS code for state", "year",
                                "month", "type of event", "date event started", "timezone",
                                "date event ended", "injuries as direct result of storm",
                                "injuries as indirect result of storm", 
                                "deaths - direct result", "deaths - indirect result", 
                                "property damage", "crop damage", "source of storm info",
                                "manitude of damage", "type of magnitude",
                                "beginning latitude", "beginning longitude", "ending latitude",
                                "ending longitude", "narrative of the episode", 
                                "narrative of the event", "source of the data")

attrib$dateTimeFormatString <- c("","","","YYYY","","","MM/DD/YYYY HH:MM",
                                 "three letter time zone","MM/DD/YYYY HH:MM",
                                 "","","","","","","","","","","","","","","","")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

It is also important to define missing value codes. This is frequently `NA`, but should still be defined explicitly.  



~~~r
attrib$missingValueCode <- rep(NA_character_, nrow(attrib))

attrib$missingValueCodeExplanation <- rep("Missing value", nrow(attrib))
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

In addition, it's good to double check the class of variables inferred by the templating function.  In this case, we've decided four variables would be better described as *character* rather than *categorical*.  



~~~r
attrib$class <- attrib %>% select(attributeName, class) %>% 
                mutate(class = ifelse(attributeName %in% c("DAMAGE_PROPERTY", "DAMAGE_CROPS", 
                                                           "EVENT_TYPE", "SOURCE"), 
                                      "character", class)) %>% 
                select(class) %>% unlist(use.names = FALSE)
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

Units need to be defined from a controlled vocabulary of standard units.  Use the function `view_unit_dictionary()` to view these standard units.  

If you can't find your units here, they must be defined in the file `custom_units.txt` in the metadata templates folder.   Generally, if you are not comfortable with a definition then it is best to provide a custom unit definition.  There are some non-intuitive definitions, such as using the broad unit "degree" for latitude and longitude such as in our example data here.
{:.notes}



~~~r
> view_unit_dictionary()
~~~
{:title="Console" .no-eval .input}




~~~r
attrib$unit <- c("number","","number","","","","","","","number","number","number",
                 "number","","","","number","","degree",
                 "degree","degree","degree","","","")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

Check your edits are all correct.


~~~r
> View(attrib)
~~~
{:title="Console" .input}


Now we can write out the attribute file we just edited.



~~~r
write.table(attrib, "~/storm_project/metadata_templates/attributes_StormEvents_d2006.txt", row.names = FALSE, sep = "\t")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

Because we have categorical variables in our data file, we need to define those variables further using the following templating function. 

Categorical variables: Create metadata specific to categorical variables (required when the attribute metadata contains variables with a "categorical" class)



~~~r
template_categorical_variables(path = "~/storm_project/metadata_templates", 
                               data.path = "~/storm_project/data_objects")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


~~~
$catvars_StormEvents_d2006.txt
$catvars_StormEvents_d2006.txt$content
    attributeName           code definition
1     DATA_SOURCE            CSV           
2     DATA_SOURCE            PDS           
3  MAGNITUDE_TYPE             EG           
4  MAGNITUDE_TYPE             MG           
5      MONTH_NAME          April           
6      MONTH_NAME       February           
7      MONTH_NAME        January           
8      MONTH_NAME        October           
9           STATE         ALASKA           
10          STATE       ARKANSAS           
11          STATE       COLORADO           
12          STATE        GEORGIA           
13          STATE       ILLINOIS           
14          STATE        INDIANA           
15          STATE         KANSAS           
16          STATE       KENTUCKY           
17          STATE      LOUISIANA           
18          STATE       MARYLAND           
19          STATE       MICHIGAN           
20          STATE     NEW JERSEY           
21          STATE NORTH CAROLINA           
22          STATE           OHIO           
23          STATE       OKLAHOMA           
24          STATE          TEXAS           
25          STATE           UTAH           
26          STATE     WASHINGTON           
27          STATE  WEST VIRGINIA           
~~~
{:.output}


Define categorical variable codes.  

NOTE: You must add definitions, even for obvious things like month.  If you don't add definitions, your EML metadata will be invalid.



~~~r
# read in the attributes template text file
catvars <- read.table("~/storm_project/metadata_templates/catvars_StormEvents_d2006.txt", 
                      sep = "\t", header = TRUE)

catvars$definition <- c("csv file", "pds file", rep("magnitude", 2), rep("month", 4), rep("USA state", 19))

write.table(catvars, "~/storm_project/metadata_templates/catvars_StormEvents_d2006.txt", row.names = FALSE, sep = "\t")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

NOTE: If you have not filled in the table attributes template completely, the  `template_categorical_variables()` function may produce errors.  It also produces a useful warning message that you can use to look at the issues.  
{:.notes}

If you type `issues()` in your R console, you'll get helpful info on which issues you need to fix. 



~~~r
> issues()
~~~
{:title="Console" .no-eval .input}


===

### Write EML metadata file

Many repositories for environmental data use EML (Ecological Metadata Language) formatting for metadata.  The function `make_eml()` converts the text files we've been editing into EML document(s).

Check the function help documentation to see which arguments of `make_eml()` are required and which are optional.
{:.notes}



~~~r
make_eml(path = "~/storm_project/metadata_templates",
         data.path = "~/storm_project/data_objects",
         eml.path = "~/storm_project/eml",
         dataset.title = "Storm Events that occurred in 2006",
         temporal.coverage = c("2006-01-01", "2006-04-07"),
         geographic.description = "Continental United State of America", 
         geographic.coordinates = c(30, -79, 42.5, -95.5), 
         maintenance.description = "In Progress: Some updates to these data are expected",
         data.table = "StormEvents_d2006.csv",
         data.table.name = "Storm_Events_2006",
         data.table.description = "Storm Events in 2006", 
         # other.entity = c(""),
         # other.entity.name = c(""),
         # other.entity.description = c(""),
         user.id = "my_user_id",
         user.domain = "my_user_domain", 
         package.id = "storm_events_package_id")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


This function tries to validate your metadata against the EML standard.  If there are problems making your metadata invalid, type `issues()` into your console (as above), and you'll receive useful information on how to make your metadata valid.  
{:.notes}

===

After you create your EML file, it might be useful to double check it.  EML isn't very human-readable, so try using [the online Metadata Previewer tool](https://portal.edirepository.org/nis/metadataPreviewer.jsp) from the Environmental Data Initiative for viewing your EML.  
{:.notes}

===
