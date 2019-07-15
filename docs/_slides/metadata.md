---

---

## What is Metadata?

Metadata is the information needed for someone else to understand and use your data.  It is the Who, What, When, Where, Why, and How about your data.  

This includes _package-level_ and _file-level_ metadata.  

===

### Common components of metadata

Package-level:
 - Geographic extent of data (generally)
 - Data creator
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

This can mean using a controlled set of descriptors for your data specified by the standard. 

There are many metadata standards, and those standards can vary between disciplines
and types of data.  

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

Repository-specific methods

   - GUI for a repository 
     ![]({% include asset.html path="images/knb_snap.PNG" %}){: width="100%"} 
     
===     
   
Stand-alone software
   
   - [Data Curator](https://github.com/ODIQueensland/data-curator) - still in beta
     ![]({% include asset.html path="images/Data_Curator_snap.PNG" %}){: width="100%"} 

Coding 

   - R packages ([EML](https://github.com/ropensci/EML), [dataspice](https://github.com/ropenscilabs/dataspice), [emld](https://github.com/ropensci/emld))

===

### Example of coding up some metadata  

| R Package   | What does it do?                                           |
|-------------+------------------------------------------------------------|
| `dataspice` | creates metadata files in json-ld format                   |
| `here`      | facilitates finding your files in R                        |
| `emld`      | aids conversion of metadata files between EML and json-ld  |
| `EML`       | creates EML metadata files                                 |
| `jsonlite`  | reads json and json-ld file formats in R                   |


We'll use the [dataspice](https://github.com/ropenscilabs/dataspice) package. 



~~~r
library(dataspice) ; library(here)
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


Create data package templates.



~~~r
create_spice(dir = "data_package")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}

 
Look at your data_package folder, and see the CSV template files. 
 
=== 
 
The templates are empty, so now we need to populate them. 
We'll start with package-level metadata. 

Add extent, coverage, license, publication, funder, keywords, etc. 



~~~r
> range(stm_dat$YEAR)
> 
> range(stm_dat$BEGIN_LAT, na.rm=TRUE)
> range(stm_dat$BEGIN_LON, na.rm=TRUE)
~~~
{:title="Console" .no-eval .input}

  


~~~r
edit_biblio(metadata_dir = here::here("data_package", "metadata"))
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}


===

Describe the creators of the data. 



~~~r
edit_creators(metadata_dir = here::here("data_package", "metadata"))
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}


===

Add information about where the data can be accessed.



~~~r
prep_access(data_path = here::here("data_package"),
            access_path = here::here("data_package", "metadata", "access.csv"))
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}

  


~~~r
edit_access(metadata_dir = here::here("data_package", "metadata"))
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}


===

We'll describe the file-level metadata now.

Add attributes of the data.



~~~r
prep_attributes(data_path = here::here("data_package"),
                attributes_path = here::here("data_package", "metadata", "attributes.csv"))  
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}

  


~~~r
edit_attributes(metadata_dir = here::here("data_package", "metadata"))
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}


===

Now we can write our metadata to a json-ld file.



~~~r
write_spice(path = here::here("data_package", "metadata"))
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}


===

Now convert the json-ld file into EML (Ecological Metadata Language).



~~~r
library(emld) ; library(EML) ; library(jsonlite)

json <- jsonlite::read_json("data_package/metadata/dataspice.json")
eml <- emld::as_emld(json)
EML::write_eml(eml, "data_package/metadata/dataspice.xml")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}


===
