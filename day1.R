# RECSM Summer School 2018
# Automated data collection of web and social data
# 05/07/2018 - Day 1

library(XML)
library(RCurl)

url <- "https://en.wikipedia.org/wiki/Municipalities_of_Catalonia"

content <- getURL(url)
parsed_content <- htmlParse(content)
tables <- readHTMLTable(parsed_content)[[1]]

View(tables)

library(stringr)
library(rvest)

setwd("Z:/teacher/Social media research - Big data 2")

local_html <- "Z:/teacher/Social media research - Big data 2/fortunes.html"
fname <- basename(local_html)
if(!file.exists(fname)){
  download.file(local_html, fname)
}
html <- read_html(local_html)

# New example

url <-  "http://www.r-datacollection.com/materials/html/fortunes.html"
fname <- basename(url)
if(!file.exists(fname)){
  download.file(url, fname)
}
html <- read_html(fname)

# Here we are creating a 
x="/html/body/div[2]/h1"
html_nodes(html, xpath=x)


## ---- message=FALSE------------------------------------------------------
require(rvest)
require(stringr)

## ------------------------------------------------------------------------
url <- "http://www.r-datacollection.com/materials/html/fortunes.html"
fname <- basename(url)

if(!file.exists(fname)){
  download.file(url, fname)
}

html <- read_html(fname)

## ------------------------------------------------------------------------
xml2::html_structure(html)

## ------------------------------------------------------------------------
x="/html/body/div[2]/h1"
html_nodes(html, xpath=x)

## ------------------------------------------------------------------------
html_nodes(html, xpath="//h1")

## ------------------------------------------------------------------------
html_nodes(html, xpath="//a/@href")

## ------------------------------------------------------------------------
html_nodes(html, xpath="//p/i/text()")

## ------------------------------------------------------------------------
html_nodes(html, xpath="//div[1]/p/i")

## ------------------------------------------------------------------------
html_nodes(html, xpath="//div")
html_nodes(html, xpath="//div[1]")
html_nodes(html, xpath="//div[1]/p/i/text()")

## ------------------------------------------------------------------------
html_nodes(html, xpath="//div[@date='October/2011']")
html_nodes(html, xpath="//div[contains(@date, 'October/2011')]")
html_nodes(html, xpath="//div[contains(.//a/@href, 'https')]")

## ------------------------------------------------------------------------
html_nodes(html, xpath="//a[contains(@href, 'https')]")
html_nodes(html, xpath="//a[contains(., 'homepage')]")

## ------------------------------------------------------------------------
html_nodes(html, xpath="//a")
html_nodes(html, xpath="//a/..")

## ------------------------------------------------------------------------
html_nodes(html, xpath="//*")

## ------------------------------------------------------------------------
html_nodes(html, xpath="//*/text()")

## ------------------------------------------------------------------------
html_nodes(html, xpath="//i | //b")

## ------------------------------------------------------------------------
html_nodes(html, xpath="//a/..")
html_nodes(html, xpath="//a/parent::*")
html_nodes(html, xpath="//a/parent::p")

## ------------------------------------------------------------------------
html_nodes(html, xpath="//p/i")
html_nodes(html, xpath="//p/child::*")
html_nodes(html, xpath="//p/child::i")

## ------------------------------------------------------------------------
html_nodes(html, xpath="//b/ancestor::*")
html_nodes(html, xpath="//b/ancestor::*/text()")

## ------------------------------------------------------------------------
html_nodes(html, xpath="//p/descendant::*")
html_nodes(html, xpath="//p/descendant::*/text()")

## ------------------------------------------------------------------------
html_nodes(html, xpath="//b/..")
html_nodes(html, xpath="//b/following-sibling::*")

## ------------------------------------------------------------------------
html_nodes(html, "p")
html_nodes(html, "b, i")

## ------------------------------------------------------------------------
html_nodes(html, ".pink")

## ------------------------------------------------------------------------
html_nodes(html, css = "#R_Inventor")
html_nodes(html, css = "[id='R_Inventor']")

## ------------------------------------------------------------------------
html_nodes(html, css = "[lang]")
html_nodes(html, css = "[href]")

## ------------------------------------------------------------------------
html_nodes(html, css = "[id=R_Inventor]") # equal
html_nodes(html, css = "[id^=R]")         # starts 
html_nodes(html, css = "[id$=r]")         # ends
html_nodes(html, css = "[id*=ven]")       # conatains

## ------------------------------------------------------------------------
html_nodes(html, css = "i")
html_nodes(html, css = "a i")

## ------------------------------------------------------------------------
html_nodes(html, css = "p > i")
html_nodes(html, css = "a > i")

## ------------------------------------------------------------------------
html_nodes(html, css = "p:first-of-type")

## ------------------------------------------------------------------------
html_nodes(html, css = "a:nth-child(1)")
html_nodes(html, css = "a:nth-child(2)")

## ------------------------------------------------------------------------
html_nodes(html, css = "a:nth-last-child(1)")
html_nodes(html, css = "a:nth-last-child(2)")

## ------------------------------------------------------------------------
html_nodes(html, css = "p:nth-of-type(1)")

# We can copy the attibute, or the xpath from a web browser by right clicking on
# the object we are interested in since the browser.
xpath <- '//*[@id="mw-content-text"]/div/table[1]/tbody/tr[1]/td[2]/b/a'

url <- "https://en.wikipedia.org/wiki/List_of_cities_and_towns_in_Austria"

html <- read_html(url)
html_nodes(html, xpath = xpath)

# EXERCISE
##### 1) xml2 package
# a) Getting started
# Load the xml2 package.
install.packages("xml2")
library("xml2")
# Use ls(package:xml2) to get a list of available functions.
ls(package:xml2)
# Use read_xml() to read the resource printed below into R.
my_xml <- read_xml("http://www.r-datacollection.com/materials/ch-4-xpath/potus/potus.xml")
# Save the information in the file myxml.xml.
# http://www.r-datacollection.com/materials/ch-4-xpath/potus/potus.xml
# Use your browser to look at the XML.
write_xml(x = my_xml, file = "myxml.xml")
myxml <- read_xml("myxml.xml")
# b) Convenience functions
# How many entries does the XML contain? 
xml_length(myxml)
xml_parent(myxml)
xml_children(myxml)
# Which function can you use to extract this information?

# Extract the text of the XML and use cat() to print the text to the screen.
cat(xml_text(myxml))
# Use a function of the xml2 package to look at the structure of the XML.
xml_structure(myxml) #?? That is a mess!

# c) Extraction
# Use an XPath expression to extract all religion nodes
xml_find_all(my_xml, xpath = "//religion")
# or alternatively:
xml_find_all(my_xml, xpath = "/document/president/religion")

# Use CSS selectors to extract all religion nodes.
xml_nodes(my_xml, css = "religion")
# Extract the text from the nodes and use table() and sort() to produce a sorted table.
sort(table(xml_text(xml_find_all(my_xml, xpath = "//religion"))),
     decreasing = T)

# Use xml_find() in combination with an XPath expression to extract the 
# node for the first president
xml_find_first(myxml, xpath = "//president")
xml_find_all(myxml, xpath = "//president[1]")
# Extract the name node for all presidents after the 40th.
html_nodes(myxml, xpath = "")
# Use an XPath expression to get the nodes for Pierce, Garfield, and Taylor
html_nodes(myxml, xpath = "")
# Extract the occupation.
xml_text(xml_nodes(myxml, xpath = "//occupation"))

######### Some examples
library(rvest)
web <- "https://www.upf.edu/web/politiques/professorsupf"
myhtml <- read_html(web)
html_nodes(myhtml, xpath = '//p')
html_nodes(myhtml, xpath = '//p[@class="fitxa_persona_llistat_dato"]')
html_text(html_nodes(myhtml, xpath = '//p[@class="fitxa_persona_llistat_dato"]'))

# Only the names
html_nodes(myhtml, xpath = '//span[@class="nom"]')
html_text(html_nodes(myhtml, xpath = '//span[@class="nom"]'))
