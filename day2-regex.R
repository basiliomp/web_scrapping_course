# RECSM Summer School 2018
# Automated data collection of web and social data
# 06/07/2018 - Day 2 - Regular expressions
library(stringr)

# 1) Information extraction
# a) Read the file pg345.txt into R.
corpus <- readLines(con = "Z:/teacher/Social media research - Big data 2/material/pg345.txt")
# . Count how many times the word "blood" or "Blood" is used throughout the book.
?regex
length(grep(pattern = "blood",x =  corpus, ignore.case = T))
result <- str_count(string = corpus, pattern = "blood|Blood" )
sum(result)
result <- str_count(string = corpus, pattern = "[bB]lood" )
sum(result)
#This is the better version because it takes into account only "blood" as a word and not related ones (e.g. "bloody")
result <- str_count(string = corpus, pattern = "\\b[bB]lood\\b" )
sum(result)
# . Use grep() to get an index of lines containing the word.
index <- grep(pattern = "\\b[bB]lood\\b",x =  corpus, ignore.case = T)
# . Use hist(..., n = 100000) to make a zebra-chart.
hist(index, n=100000)
# . Produce the same chart for the terms "Blood" or "Fear".
index2 <- grep(pattern = "\\b[bB]lood\\b | \\b[Ff]ear\\b",x =  corpus, ignore.case = T)
hist(index2, n=100000)

# b) Read the file pg345.txt into R.
corpus <- readLines(con = "Z:/teacher/Social media research - Big data 2/material/pg345.txt")
# . Use paste(..., collapse = "\n") to collapse the text into one string.

# . Use str_split() to split the string into distinct words.

# . Use tabulate() and sort() to get the 10 most frequent as well as the 10 least frequent words.

# c) For the files 17814-0.txt, pg11.txt, pg1661.txt, pg174.txt, pg2600.txt, pg345.txt, pg34901.txt
# . Find a way to extract
# - the title
setwd("Z://teacher/Social media research - Big data 2/material/")
book <- readLines("pg1661.txt")
title_index <- str_detect(string = book, pattern = "Title:")
book[title_index]
str_replace(string = title_index, pattern = "Title: ", replacement = "")
# - the author
str_extract(string = book, pattern = "Author:")
# - the posting date
str_extract(string = book, pattern = "Posting date:")
# . Find a way to discard information added by Project Gutenberg

# d) Read the file 2012.txt into R and build a data.frame containing the following information
# . Name
# . Number of reviews
# . Institution
