---

---

## Data  

Consistency is key when managing your data!

1. At a minimum, use the same terms to refer to the same things throughout your data.

2. Potentially use a discipline-wide published vocabulary (ex: [hydrological controlled vocab.](http://vocabulary.odm2.org/))

===

### Naming data files - review from basic-R-lesson

Bad:
"CeNsus data*2ndTry 2/15/2017.csv"   

Good:
"census_data_try_2.csv"  



~~~r
library(tidyverse)

stm_dat <- read_csv("data/StormEvents.csv")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===

### Formatting data - review from data-manipulation-R-lesson

1. One table/file for each type of observation.
2. Each variable has its own column.
3. Each observation has its own row.
4. Each value has its own cell.

Downstream operations/analysis require tidy data. You can work towards ready-to-analyze data incrementally,
documenting the intermediate data and steps you took in your scripts.  This can be a powerful accelerator 
for your analysis both now and in the future.  

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
    
### Outputting derived data - review from the basic-R-lesson
    
Because we followed the principle of one table/file for each type of observation, 
we have one table to be written out to a file now.  



~~~r
dir.create('data_package', showWarnings = FALSE)
write_csv(stm_dat, "data_package/StormEvents_d2006.csv")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}


===
    
### Versioning your derived data

Issue: Making sure you and your collaborators are using the same version of a dataset

One solution: version your data in a repository (more on this later)



