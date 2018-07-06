# RECSM Summer School 2018
# Automated data collection of web and social data
# 06/07/2018 - Day 2 - HTML, URL and APIs

# API EXERCISE
# 1) geonames
# a) Setting things up
# . Install package geonames
install.packages("geonames")
# . Load it
library(geonames)
# . Inspect the functions via ls(package:geonames)
ls(package:geonames)
# . Consult http://www.geonames.org/export/web-services.html.
# . Register an application at http://www.geonames.org/login
mytestapp
# . Use your username with options(geonamesUsername="myusernamehere") to use the geonames package
options(geonamesUsername="mytestapp")

# b) Using the API
# . Barcelona
GNsearch("Barcelona")
# - lattitude 41.390205 (north south)
lattitude <- 41.390205
# - longitude 2.154007 (east, west)
longitude <- 2.154007
# . Find cities in the vicinity of Barcelona 
GNcities(north = lattitude + .5,
         east = longitude + .5,
         south = lattitude - .5,
         west = longitude - .5,
         lang = "en",
         maxRows = 10)
# . Get today's weather for these places
weather <- GNweather(north = lattitude + .5,
         east = longitude + .5,
         south = lattitude - .5,
         west = longitude - .5)
View(weather)
# . When is the current sunset in Barcelona? (GNtimezone)
timezone <- GNtimezone(lat = lattitude, lng = longitude)

# WEB SCRAPPING EXERCISE
# Create a dataset of all the members of parliament in the European Parliament.
# Required variables: name, party group, country, party, and link to their profile.
library(rvest)
library(stringr)

urlstart <- "http://www.europarl.europa.eu/meps/en/full-list.html?filter="
for (x in LETTERS) {
  url <- paste0(urlstart, x)
  print(url)
  html <- read_html(url)
  write_xml(html, paste0("C:/Users/upf/Desktop/euparl/MEP-list-", x, ".xml"))
}

for (x in 1:length(list.files())) {
  html <- read_xml(paste0("C:/Users/upf/Desktop/euparl/MEP-list-", as.character([x]), ".xml"))
}

eulist <- read_html(url)

index <- html_nodes(eulist, xpath = '//div/a/div/ul/li/')
index <- html_nodes(eulist, css = '')
html_text(index)

mepdf <- data.frame(
  name = character(),
  id = character(),
  url = character()
)

for(i in 1:length(file_list)){
  
  i <- 1
  
  html <- read_html(str_c(FOLDER, file_list[i]))
  
  # Name
  
  name <- html_nodes(html, xpath = "//div[@class='zone_info_mep ']/div/ul/li/a")
  name <- html_nodes(html, xpath = "//div[@class='zone_info_mep ']//li[@class='mep_name']/a")
  name <- html_text(name)
  
  name <- html_nodes(html, xpath = "//div[@class='zone_info_mep ']//img")
  #attrs <- html_attrs(name)[[1]]
  name <- html_attr(name, name = "alt")
  
  # Party group
  
  # National party
  
  # Country
  
  # Link
  
  link <- html_nodes(html, xpath = "//div[@class='zone_info_mep ']/a")
  link <- html_attr(link, name = "href")
  
  # MEP ID
  
  id <- str_extract(link, "[[:digit:]]+")
  
  tmp_data <- data.frame(
    name = name,
    link = link,
    id = id
  )
  
  mep_data <- rbind(mep_data, tmp_data)
  
}

new_html <- read_html(str_c("http://www.europarl.europa.eu", link[i]))









