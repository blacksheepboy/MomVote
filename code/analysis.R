# Analysis

library(dplyr)

# Rule 1: vote for the woman
# Rule 2: vote for the POC
# Rule 3: vote for the Democrat

# Rule 1: vote for the woman

test <- candidates %>%
  group_by(office_state, branch, district) %>%
  mutate(rule1 = ifelse(gender == "F" & lag(gender) == "M" | gender == "F" & lead(gender) == "M", 1, 0))
test$rule1 <- as.factor(test$rule1)

summary(test$rule1)

# Determine need for race stats
test <- test %>%
  group_by(office_state, branch, district) %>%
  mutate(needrace = ifelse(all(rule1 == 0) | is.na(rule1), 1, 0))
test$needrace <- as.factor(test$needrace)
summary(test$needrace)
# Need race stats for 713 people... 

# Rule 2: vote for the POC


# Rule 3: vote for the Democrat

test <- test %>%
  group_by(office_state, branch, district) %>%
  mutate(rule3 = ifelse(party == "DEM" & lag(party) != "DEM" | party == "DEM" & lead(party) != "DEM", 1, 0))
test$rule3 <- as.factor(test$rule3)

##
## TEST CODE
##

candidates %>%
  if(branch = "S") {
    for(i in seq_along(unique(office_state))) {
    }
  }
