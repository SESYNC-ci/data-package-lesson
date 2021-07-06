---

---

## Publishing your data 

Now that you've packaged up your data, it's easier to publish! 

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

If you don't have one yet, get an ORCiD.  Register at [https://orcid.org](https://orcid.org).

![]({% include asset.html path="images/orcid_snap2.png" %}){: width="100%"} 

===

### Picking a repository 

There are many repositories out there, and it can seem overwhelming picking a suitable one for your data. 

Repositories can be subject or domain specific.  [re3data](https://www.re3data.org/) lists repositories by subject and can help you pick an appropriate repository for your data.  

===

[DataONE](https://www.dataone.org/) is a federation of repositories housing many different types of data.  Some of these repositories include Knowledge Network for Biocomplexity [(KNB)](https://knb.ecoinformatics.org/), Environmental Data Initiative [(EDI)](https://environmentaldatainitiative.org/), [Dryad](https://datadryad.org/), [USGS Science Data Catalog](https://data.usgs.gov/datacatalog/)

For qualitative data, there are a few dedicated repositories: [QDR](https://qdr.syr.edu/), [Data-PASS](http://data-pass.org/)

===

Though a bit different, [Zenodo](https://zenodo.org/) facilitates publishing (with a DOI) and archiving all research outputs from all research fields.  

One example is using Zenodo to publish releases of your code that lives in a GitHub repository.  However, since GitHub is not designed for data storage and is not a persistent repository, this is not a recommended way to store or publish data.  
{:.notes}

===

### Uploading to a repository

Uploading requirements can vary by repository and type of data.  The minimum you usually need is basic metadata, and a data file.  

If you have a small number of files, using a repository GUI will usually be simpler.  For large numbers of files, automating uploads from R will save time.  And it's reproducible!  

===

#### Data Upload Example using DataONE:

If you choose to upload your data package to a repository in the DataONE federation, the following example might be useful. 

You'll need to do two basic steps:   

1) Get authentication token for DataONE (follow steps [here](https://github.com/DataONEorg/rdataone/blob/master/vignettes/v02-dataone-federation.Rmd))

2) Get a DOI (if desired)

3) Upload your data package using R (from vignette for [dataone](){:.rlib})

===

| R Package   | What does it do?                      |
|-------------+---------------------------------------|
| `dataone`   | uploads data package to repository    |



~~~r
library(dataone)
library(curl) 
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


~~~
Using libcurl 7.47.0 with GnuTLS/3.4.10
~~~
{:.output}


~~~

Attaching package: 'curl'
~~~
{:.output}


~~~
The following object is masked from 'package:readr':

    parse_date
~~~
{:.output}


~~~r
library(redland) 
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

**Tokens:**

Different environments in DataONE take different authentication tokens.  Essentially, the staging environment is for testing, and the production environment is for publishing.    

To get a token for the staging environment start here [https://dev.nceas.ucsb.edu](https://dev.nceas.ucsb.edu).  
To get a token for the production environment start here [https://search.dataone.org](https://search.dataone.org).  

Then do the following (similar to #1 above): 

  - Click *Sign in*, or *Sign up* if necessary
  - Once signed in, move the cursor over the user name and select 'My profile' in the drop down menu.
  - Click on the "Settings" tab.
  - Click on "Authentication Token" in the menu below "Welcome"
  - Click on the "Token for DataONE R" tab.
  - Click "Renew authentication token" if the token you have been using has expired.
  - Click on the "Copy" button below the text window to copy the authentication string to the paste buffer.
  - Note the identity string and expiration date of the token.
  - In the R console, paste the token string.

===

#### Set your token now

Paste your token in R console, as in the above instructions.  
You can also past your token in the provided `D1_token` R script and then load it.  



~~~r
> #### Load my API token
> source("D1_token.R")
~~~
{:title="Console" .no-eval .input}


===

### Citation

Getting a Digital Object Identifier (DOI) for your data package can make it easier for others to find and cite your data.  

===

You can assign a DOI to your data package by editing the metadata file.  

First specify the environment and repository (also called a member node).



~~~r
cn <- CNode("PROD")
mn <- getMNode(cn, "urn:node:KNB")  

doi <- generateIdentifier(mn, "DOI")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}


===

Now overwrite the previous metadata file with the new DOI identified metadata file



~~~r
emlFile <- "./storm_project/eml/storm_events_package_id.xml"

mdObj <- new("DataObject", id = doi, format = "eml://ecoinformatics.org/eml-2.1.1", file = emlFile)
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .no-eval .text-document}


Then zip up all your files for your data package with BagIt as shown in the previous section.    

===

#### Set access rules 



~~~r
dpAccessRules <- data.frame(subject="http://orcid.org/0000-0003-0847-9100", 
                            permission="changePermission") 
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


This gives this particular orcid (person) permission to read, write, and change permissions for others for this package.

===



~~~r
dpAccessRules2 <- data.frame(subject = c("http://orcid.org/0000-0003-0847-9100",
                                         "http://orcid.org/0000-0000-0000-0001"),
                             permission = c("changePermission", "read")
                             )
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


The second person (orcid) only has access to read the files in this package.  

NOTE: When you upload the package, you also need to set `public = FALSE` if you don't want your package public yet.

===

#### Upload data package

The first argument here is the environment - "PROD" is production where you publish your data.
"STAGING" can be used if you're not yet sure you have everything in order and want to test uploading your data package.  
NOTE: "PROD" and "STAGING" require different tokens.  
See above steps to get the correct token.


===

The second argument is the repository specification.  If you don't know your repository specs, look it up in this table of member node IDs: (data/Nodes.csv) 



~~~r
read.csv("data/Nodes.csv")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


~~~
                                                                           name
1                                                                      cn-unm-1
2                                                                     cn-ucsb-1
3                                                                      cn-orc-1
4                                                           KNB Data Repository
5                                                             ESA Data Registry
6                                                      SANParks Data Repository
7                                                                     ORNL DAAC
8                                                             U.S. LTER Network
9                                                                   UC3 Merritt
10                                                                     PISCO MN
11                                                 ONEShare DataONE Member Node
12                                         DataONE ORC Dedicated Replica Server
13                                         DataONE UNM Dedicated Replica Server
14                                        DataONE UCSB Dedicated Replica Server
15                                                            TFRI Data Catalog
16                                               USA National Phenology Network
17                                                         SEAD Virtual Archive
18                                                   Gulf of Alaska Data Portal
19                                University of Kansas - Biodiversity Institute
20                                                      LTER Europe Member Node
21                                                     Dryad Digital Repository
22                                           Cornell Lab of Ornithology - eBird
23                                                       EDAC Gstore Repository
24                                                  Montana IoE Data Repository
25                                                  Minnesota Population Center
26                            Environmental Data for the Oak Ridge Area (EDORA)
27                       Regional and Global biogeochemical dynamics Data (RGD)
28                                                        GLEON Data Repository
29                                                            IARC Data Archive
30                                                        NM EPSCoR Tier 4 Node
31                                                               TERN Australia
32                                                  Northwest Knowledge Network
33                                                    USGS Science Data Catalog
34                                                     NRDC DataONE member node
35                                         NOAA NCEI Environmental Data Archive
36                                                                        PPBio
37                                                             NEON Member Node
38                                            The Digital Archaeological Record
39                                                           Arctic Data Center
40        Biological and Chemical Oceanography Data Management Office (BCO-DMO)
41 Gulf of Mexico Research Initiative Information and Data Cooperative (GRIIDC)
42                                             Rolling Deck to Repository (R2R)
43                                                Environmental Data Initiative
44                         A Member Node for University of Illinois at Chicago.
45                                                           Research Workspace
46                          Forest Ecosystem Monitoring Cooperative Member Node
47                  Organization for Tropical Studies - Neotropical Data Center
48                                                                      PANGAEA
49                                ESS-DIVE: Deep Insight for Earth Science Data
50                                    Chinese Ecosystem Research Network (CERN)
51                    Cary Institute of Ecosystem Studies (powered by Figshare)
52                                                               IEDA EARTHCHEM
53                                                                    IEDA USAP
54                                                                    IEDA MGDL
55                          California Ocean Protection Council Data Repository
                   node_id type
1          urn:node:CNUNM1   cn
2         urn:node:CNUCSB1   cn
3          urn:node:CNORC1   cn
4             urn:node:KNB   mn
5             urn:node:ESA   mn
6        urn:node:SANPARKS   mn
7        urn:node:ORNLDAAC   mn
8            urn:node:LTER   mn
9             urn:node:CDL   mn
10          urn:node:PISCO   mn
11       urn:node:ONEShare   mn
12         urn:node:mnORC1   mn
13         urn:node:mnUNM1   mn
14        urn:node:mnUCSB1   mn
15           urn:node:TFRI   mn
16         urn:node:USANPN   mn
17           urn:node:SEAD   mn
18            urn:node:GOA   mn
19           urn:node:KUBI   mn
20    urn:node:LTER_EUROPE   mn
21          urn:node:DRYAD   mn
22       urn:node:CLOEBIRD   mn
23     urn:node:EDACGSTORE   mn
24            urn:node:IOE   mn
25         urn:node:US_MPC   mn
26          urn:node:EDORA   mn
27            urn:node:RGD   mn
28          urn:node:GLEON   mn
29           urn:node:IARC   mn
30       urn:node:NMEPSCOR   mn
31           urn:node:TERN   mn
32            urn:node:NKN   mn
33       urn:node:USGS_SDC   mn
34           urn:node:NRDC   mn
35           urn:node:NCEI   mn
36          urn:node:PPBIO   mn
37           urn:node:NEON   mn
38           urn:node:TDAR   mn
39         urn:node:ARCTIC   mn
40         urn:node:BCODMO   mn
41         urn:node:GRIIDC   mn
42            urn:node:R2R   mn
43            urn:node:EDI   mn
44            urn:node:UIC   mn
45             urn:node:RW   mn
46           urn:node:FEMC   mn
47        urn:node:OTS_NDC   mn
48        urn:node:PANGAEA   mn
49       urn:node:ESS_DIVE   mn
50       urn:node:CAS_CERN   mn
51  urn:node:FIGSHARE_CARY   mn
52 urn:node:IEDA_EARTHCHEM   mn
53      urn:node:IEDA_USAP   mn
54      urn:node:IEDA_MGDL   mn
55         urn:node:CA_OPC   mn
~~~
{:.output}


===

First set the environment and repository you'll upload to:
  




