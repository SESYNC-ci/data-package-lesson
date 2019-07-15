---

---

## Data  

Consistency is key when managing your data!

1. At a minimum, use the same terms to refer to the same things throughout your data.

   - "origin", not "starting place", "beginning location", and "source"
   - "*Orcinus orca*", not "killer Whale", "Killer whale", "killer.whale", and "orca"

2. Consider using a discipline-wide published vocabulary if appropriate (ex: [hydrological controlled vocab.](http://vocabulary.odm2.org/))

===

### Naming data files 

__Bad:__  "CeNsus data*2ndTry 2/15/2017.csv"   

__Good:__  "census_data_try_2.csv"  



~~~r
library(tidyverse)

stm_dat <- read_csv("data/StormEvents.csv")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


For more details see the [basic-R-lesson](https://cyberhelp.sesync.org/basic-R-lesson/).  

===

### Formatting data

1. One table/file for each type of observation.
2. Each variable has its own column.
3. Each observation has its own row.
4. Each value has its own cell.

Downstream operations/analysis require tidy data. 

You can work towards ready-to-analyze data incrementally, documenting the intermediate data and steps you took in your scripts.  This can be a powerful accelerator for your analysis both now and in the future.  
{:.notes}

For more details see the [data-manipulation-R-lesson](https://cyberhelp.sesync.org/data-manipulation-R-lesson/).  

===

Let's do a few checks to see if our data is tidy.

 - make sure data meet criteria above
 - make sure blanks are NA or some other standard
 


~~~r
> head(stm_dat)
> tail(stm_dat)
~~~
{:title="Console" .no-eval .input}

 
 - check date format


~~~r
> str(stm_dat)    
~~~
{:title="Console" .no-eval .input}


 - check case, white space, etc.  


~~~r
> unique(stm_dat$EVENT_NARRATIVE)    
~~~
{:title="Console" .no-eval .input}


===
    
### Outputting derived data 
    
Because we followed the principle of one table/file for each type of observation, 
we have one table to be written out to a file now.  



~~~r
dir.create('data_package', showWarnings = FALSE)
write_csv(stm_dat, "data_package/StormEvents_d2006.csv")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


For more details see the [basic-R-lesson](https://cyberhelp.sesync.org/basic-R-lesson/). 

===
    
### Versioning your derived data

Issue: Making sure you and your collaborators are using the same version of a dataset

One solution: version your data in a repository (more on this [later](#versioning-data))



