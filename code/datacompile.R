# Data file

library(rvest)
library(stringr)
library(httr)
library(dplyr)

# Read ProPublica CSV file
setwd("~/MomVote")
candidates <- read.csv(file="~/MomVote/data/candidates_2018_0921.csv", header=TRUE, sep=",")

# Get gender data: Center for American Women and Politics
url <- "http://cawp.rutgers.edu/2018-women-candidates-us-congress-and-statewide-elected-executive"

webpage <- read_html(url)
name = html_nodes(webpage, 'td:nth-child(4)') %>%
  html_text()  %>%
  str_replace_all("\\s\\(\\w\\)\\*?$", "")

# Load name vector (all female presumably)
female_candidate <- data_frame(name) %>%
  filter(name != " ")

# Add Gender if names match
candidates$gender <- match(candidates$clean_name, female_candidate$name, nomatch = 0)

candidates %>% filter(gender != 0) %>% count()
# Only 161 candidates matched as female........

candidates$gender[candidates$gender != 0] <- "F"

# Do some work in Excel to match by hand
write.csv(candidates, file = "~/MomVote/data/femalestart.csv", row.names=FALSE)

# Re-import: match by hand names from CAWP
candidates <- read.csv(file="~/MomVote/data/femalestart.csv", header=TRUE, sep=",", stringsAsFactors = FALSE)
candidates$gender[candidates$gender != "F"] <- "M"
candidates$gender <- as.factor(candidates$gender)

# Check work
summary(candidates$gender)
# About right

# Dataset cleanup
candidates$party <- as.factor(candidates$party)
