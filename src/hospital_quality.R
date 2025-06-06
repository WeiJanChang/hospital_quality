library(dplyr)
library(tidyr)
outcome_care <- read.csv('~/code/hospital_quality/test_file/outcome-of-care-measures.csv')
dim(outcome_care) # how many rows and cols
str(outcome_care) # most common to see the data col, type, and value in cells
names(outcome_care) # view col names

#Plot the 30-day mortality rates for heart attack
outcome_care[11]
typeof(outcome_care[,11])
outcome_care[,11] # the eleventh col
outcome_care[,11] <- as.numeric(outcome_care[,11])
hist(outcome_care[, 11])

# Finding the best hospital in a state based on
# lowest 30-day mortality in one of heart attack”, “heart failure”, or “pneumonia”
select_df <-outcome_care[
  c("Hospital.Name","State","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
    "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
    "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")]
select_df[,4] <- as.numeric(select_df[,4])
select_df[,5] <- as.numeric(select_df[,5])
names(select_df)
str(select_df)
unique(select_df$State) # 54 states

# transfer to numeric is required and then use order to find the lowest data. by default is ascending

lowest_heart_failure <- select_df[order(select_df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure),]
lowest_heart_failure <- lowest_heart_failure[1,]

# lowest mortality in each state
lowest_heart_failure <- select_df %>% group_by(State) %>%
  arrange(State, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure) %>% slice(1)

lowest_heart_attack <- select_df %>% group_by(State) %>%
  arrange(State, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack) %>% slice(1)

lowest_pneumonia <- select_df %>% group_by(State) %>%
  arrange(State, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia) %>% slice(1)

# TODO write a function

best <- function(state, outcome) {
  data <-read.csv('outcome-of-care-measures.csv')
  states <-unique(data$State)
  outcome_disease <-c("heart_attack","heart_failure","pneumonia")

  heart_attack <- data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack
  heart_failure <- data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure
  pneumonia <- data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia
  if  (state %in% states& outcome %in% outcome_disease){subset(data, Hospital.Name ,heart_attack,heart_failure,pneumonia)
  }
  return

  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
}

# Ranking hospitals by outcome in a state

rank_pneumonia <- select_df %>% group_by(State) %>%
  arrange(State, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia) %>% slice(1:5)

rank_heart_attack <- select_df %>% group_by(State) %>%
  arrange(State, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)

rank_heart_failure <- select_df %>% group_by(State) %>%
  arrange(State, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure) %>% slice(1:5)

# find a hospital based on states and the worst heart attack mortality
# even there is no NA in df but some process might generate NA, so use na.omit
worst_heart_attack <- na.omit(rank_heart_attack[rank_heart_attack$State == 'MD' & rank_heart_attack$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,])
worst_heart_attack <- tail(worst_heart_attack,1)
worst_heart_attack

# find a hospital based on states and the fourth heart failure mortality
rank_heart_failure[rank_heart_attack$State == 'TX' & rank_heart_attack$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,][4,]

# TODO write a function

rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
}
## Check that state and outcome are valid
## Return hospital name in that state with the given rank
## 30-day death rate

# Ranking hospitals in all states

# TODO write a function

rankall <- function(outcome, num = "best") {
  ## Read outcome data
## Check that state and outcome are valid
## For each state, find the hospital of the given rank
## Return a data frame with the hospital names and the
## (abbreviated) state name
  }
