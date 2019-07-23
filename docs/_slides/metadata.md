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
Metadata standards contain definitions of the data elements and standardised ways of representing them in digital formats such as databases and XML (eXtensible Markup Language).
{:.notes}

These standards ensure consistent structure that facilitates data sharing and searching, record provenance and technical processes, and manage access permissions.  Recording metadata in digital formats such as XML ensures effective machine searches through consistent sturctured data entry, and thesauri using controlled vocabularies.  
{:.notes}

Metadata standards are often developed by user communities.  

For example, [EML](https://knb.ecoinformatics.org/external//emlparser/docs/index.html) was developed by ecologists to describe environmental and ecological data.  
{:.notes}

Therefore, the standards can vary between disciplines and types of data.  

===

![]({% include asset.html path="images/standards_xkcd.png" %}){: width="75%"} 

===

Some examples include:

   - General: [Dublin Core](http://dublincore.org/)
   - Ecological/Environmental/Biological: [EML](https://knb.ecoinformatics.org/external//emlparser/docs/index.html), [Darwin Core](https://dwc.tdwg.org/)
   - Social science: [DDI](http://www.ddialliance.org/), [EAD](https://www.loc.gov/ead/) 
   - Geospatial/Meterological/Oceanographic: [ISO 19115](https://www.iso.org/standard/53798.html), FGDC/CSDGM (no longer current)

===

### Creating metadata

Employer-specific mandated methods (ex: USGS)

===

Repository-specific methods

   - website for a repository 
     ![]({% include asset.html path="images/knb_snap.PNG" %}){: width="100%"} 
     
Some repository websites guide you through metadata creation during the process of uploading your data.  
{:.notes}
     
===     
   
Stand-alone software
   
   - [Data Curator](https://github.com/ODIQueensland/data-curator) - still in beta
     ![]({% include asset.html path="images/Data_Curator_snap.PNG" %}){: width="100%"} 
     
===

Coding 

   - R packages ([EML](){:.rlib}, [dataspice](https://github.com/ropenscilabs/dataspice), [emld](){:.rlib})
 
===

### Example of coding up some metadata  

| R Package   | What does it do?                                           |
|-------------+------------------------------------------------------------|
| `dataspice` | creates metadata files in json-ld format                   |
| `here`      | facilitates finding your files in R                        |
| `emld`      | aids conversion of metadata files between EML and json-ld  |
| `EML`       | creates EML metadata files                                 |
| `jsonlite`  | reads json and json-ld file formats in R                   |

===

We'll use the [dataspice](https://github.com/ropenscilabs/dataspice) package to create metadata in the EML metadata standard. 



~~~r
library(dataspice) 
library(here)
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

Create data package templates.



~~~r
create_spice(dir = "storm_project")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}

 
Look at your data_package folder, and see the CSV template files. 
 
=== 
 
The templates are empty, so now we need to populate them. 
We'll start with package-level metadata. 

Add extent, coverage, license, publication, funder, keywords, etc. 

===

We can get the temporal and geographic extent information using the `range()` function. 



~~~r
> range(stm_dat$YEAR)
> 
> range(stm_dat$BEGIN_LAT, na.rm=TRUE)
> range(stm_dat$BEGIN_LON, na.rm=TRUE)
~~~
{:title="Console" .no-eval .input}

  
===  
  
This extent information can now be added to the `biblio.csv` metadata file.  
  


~~~r
edit_biblio(metadata_dir = here("storm_project", "metadata"))
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}


===

Describe the creators of the data. 



~~~r
edit_creators(metadata_dir = here("storm_project", "metadata"))
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}


===

Add information about where the data can be accessed.

The `prep_access()` function tries to discover the metadata for itself.  



~~~r
prep_access(data_path = here("storm_project"),
            access_path = here("storm_project", "metadata", "access.csv"))
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}

  
===  
  
The `edit_access()` function can be used to edit the generated metadata, or used by itself to manually enter access metadata.    
  


~~~r
edit_access(metadata_dir = here("storm_project", "metadata"))
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}


===

We'll describe the file-level metadata now.

Add attributes of the data.

The `prep_attributes()` function tries also to discover the metadata for itself.  



~~~r
prep_attributes(data_path = here("storm_project"),
                attributes_path = here("storm_project", "metadata", "attributes.csv"))  
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}

  
===  
  
The `edit_attributes()` function can be used to further edit the file attribute metadata.    
  


~~~r
edit_attributes(metadata_dir = here("storm_project", "metadata"))
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}


===

Now we can write our metadata to a json-ld file.



~~~r
write_spice(path = here("storm_project", "metadata"))
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

Now convert the json-ld file into EML (Ecological Metadata Language) format.



~~~r
library(emld) 
library(EML) 
library(jsonlite)

json <- read_json("storm_project/metadata/dataspice.json")
eml <- as_emld(json)
write_eml(eml, "storm_project/metadata/dataspice.xml")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===
