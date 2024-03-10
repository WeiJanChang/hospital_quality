library(dplyr)
outcome_care <- read.csv('/Users/wei/Library/CloudStorage/GoogleDrive-cc9868422@gmail.com/My Drive/coursera/R programming/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv')
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

# transfer to numeric is required and then use order to find the lowest data. by default is ascending
names(select_df)
str(select_df)
select_df[,4] <- as.numeric(select_df[,4])
select_df[,5] <- as.numeric(select_df[,5])

lowest_heart_failure <- select_df[order(select_df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure),]
lowest_heart_failure <- lowest_heart_failure[1,]
lowest_heart_failure$Hospital.Name

lowest_heart_attack <-select_df[order(select_df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack),]
lowest_heart_attack <-lowest_heart_attack[1,]
lowest_heart_attack$Hospital.Name

lowest_pneumonia <-select_df[order(select_df$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia),]
lowest_pneumonia <-lowest_pneumonia[1,]
lowest_pneumonia$Hospital.Name


best <- function(state, outcome) {
  data <-read.csv('/Users/wei/Library/CloudStorage/GoogleDrive-cc9868422@gmail.com/My Drive/coursera/R programming/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv')
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
