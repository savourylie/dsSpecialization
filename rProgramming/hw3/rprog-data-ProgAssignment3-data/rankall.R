source("rankhospital.R")

rankall <- function(outcome, num = "best") {
        ## Read outcome data
        outcome_data_original <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available")
        outcome_data <- subset(outcome_data_original, !is.na(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack), !is.na(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)) # No need to subset for Pneumonia

        ## Check that state and outcome are valid
        states_abb <- unique(as.character(outcome_data$State))
		states_abb <- sort(states_abb)
        
		state <- toupper(state)
		outcome <- tolower(outcome)

		valid <- 0

		for (i in seq_along(states_abb)) {
			if (state == states_abb[i]) {
				valid <- valid + 1
			}
		}

		if (valid != 1) {
			stop("invalid state")
		}

		if ((outcome == "heart attack") || (outcome == "heart failure") || (outcome == "pneumonia") ) {
			valid <- valid + 1
		}

		if (valid != 2) {
			stop("invalid outcome")
		}

		## For each state, find the hospital of the given rank
		## Return a data frame with the hospital names and the				
		## (abbreviated) state name

		result <- c("hospital", "state")

		for (i in seq_along(states_abb)) {
			result <- rbind(result, c(rankhospital(states_abb[i], outcome, num), states_abb[i]))
		}

		colnames(result) <- c("hospital", "state")
		result <- result[-1, ]
		rownames(result) <- states_abb
		
		result
}
