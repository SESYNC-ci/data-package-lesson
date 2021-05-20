# Documenting and Publishing your Data Worksheet

# Preparing Data for Publication
library(...)

stm_dat <- ...("data/StormEvents.csv")

# Outputting derived data
...('storm_project', showWarnings = FALSE)
...(stm_dat, "storm_project/StormEvents_d2006.csv")

# Creating metadata
library(...) 

...(dir = "storm_project")

# Describe the package-level metadata.
...(metadata_dir = "storm_project/metadata")

...(metadata_dir = "storm_project/metadata")

...(data_path = "storm_project",
    access_path = "storm_project/metadata/access.csv")

...(metadata_dir = "storm_project/metadata")

# Describe the file-level metadata
...(data_path = "storm_project",
    attributes_path = "storm_project/metadata/attributes.csv")  

...(metadata_dir = "storm_project/metadata")

# Write metadata file
...(path = "storm_project/metadata")
...(path = "storm_project/metadata/dataspice.json")

# convert the json-ld file into EML format
library(emld) 
library(EML) 
library(jsonlite)

json <- ...("storm_project/metadata/dataspice.json")
eml <- ...(json)  
...(eml, "storm_project/metadata/dataspice.xml")


# Creating a data package
library(datapack) 
library(uuid)

dp <- new("DataPackage") # create empty data package

emlFile <- "storm_project/metadata/dataspice.xml"
emlId <- paste("urn:uuid:", UUIDgenerate(), sep = "")

mdObj <- ...("DataObject", id = emlId, format = "eml://ecoinformatics.org/eml-2.1.1", file = emlFile)

dp <- ...(dp, mdObj)  # add metadata file to data package

datafile <- "storm_project/StormEvents_d2006.csv"
dataId <- paste("urn:uuid:", UUIDgenerate(), sep = "")

dataObj <- ...("DataObject", id = dataId, format = "text/csv", filename = datafile) 

dp <- ...(dp, dataObj) # add data file to data package

dp <- ...(dp, subjectID = emlId, objectIDs = dataId)

serializationId <- paste("resourceMap", UUIDgenerate(), sep = "")
filePath <- file.path(sprintf("%s/%s.rdf", tempdir(), serializationId))
status <- ...(dp, filePath, id=serializationId, resolveURI = "")

dp_bagit <- serializeToBagIt(dp) 
file.copy(dp_bagit, "storm_project/Storm_dp.zip") 


# Upload to a repository

# Set access rules
library(dataone)
library(curl) 
library(redland) 

dpAccessRules <- data.frame(subject="http://orcid.org/0000-0003-0847-9100",
                            permission="changePermission") 
dpAccessRules2 <- data.frame(subject = c("http://orcid.org/0000-0003-0847-9100",
                                         "http://orcid.org/0000-0000-0000-0001"),
                             permission = c("changePermission", "read"))

# upload data package

# this is a static copy of the DataONE member nodes as of July, 2019
read.csv("data/Nodes.csv")
d1c <- ...("STAGING2", "urn:node:mnTestKNB") 


packageId <- ...(d1c, dp, public = TRUE, 
                 accessRules = dpAccessRules,
                 quiet = FALSE)

# Citation
cn <- ...("PROD")
mn <- getMNode(cn, "urn:node:DRYAD")  

doi <- ...(mn, "DOI")

mdObj <- new("DataObject", id = doi, format = "eml://ecoinformatics.org/eml-2.1.1",
             file = emlFile)
