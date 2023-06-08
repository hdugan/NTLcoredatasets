library(xml2)
library(rvest)
library(stringr)
library(tidyverse)
URL <- "https://ntllter.wiscweb.wisc.edu/core-datasets/"

pg <- read_html(URL)
links = as_tibble(html_attr(html_nodes(pg, "a"), "href")) %>%
  filter(str_detect(value, 'knb-lter-ntl'))


##### Get info from core datasets

coreLink = links$value[21]

pg2 <- read_html(coreLink)
linkend = as_tibble(html_attr(html_elements(pg2, "a"), "href")) %>%
  filter(str_detect(value, '/dataviewer')) |> 
  mutate(value = str_sub(value, 2, -1))

### Dataset link
newlink = paste0("https://portal.edirepository.org/nis", linkend$value[1])

infile1 <- tempfile()
download.file(newlink,infile1,method="curl")
dt1 <- read_csv(infile1)

### Get title 
html_text2(html_elements(pg2, "li"))[27]

# variables in dataset
varnames = names(dt1)

# lakeids
if("lakeid" %in% varnames) {
  lakenames = unique(dt1$lakeid)
  
  for (n in lakenames){
    dt1 |> filter(lakeid == lakenames[i])
    
  }
}


  