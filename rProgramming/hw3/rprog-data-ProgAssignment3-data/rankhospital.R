rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data
        outcome_data_original <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available")
        # outcome_data <- subset(outcome_data_original, !is.na(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack), !is.na(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)) # No need to subset for Pneumonia

        if (is.numeric(num) && num > length(outcome_data$Hospital.Name)) {
        	return(NA)
        }

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
		
		## Return hospital name in that state with the given rank
		## 30-day death rate

		## Converting num

		if (class(num) == "character") {
			num <- tolower(num)
		}

		if (outcome == "heart attack") {
			outcome_data <- subset(outcome_data_original, !is.na(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
			order.ha.name <- order(outcome_data[11], outcome_data$Hospital.Name)
			ordered_outcome_data <- outcome_data[order.ha.name, ]
		}

		else if (outcome == "heart failure") {
			outcome_data <- subset(outcome_data_original, !is.na(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
			order.hf.name <- order(outcome_data[17], outcome_data$Hospital.Name)
			ordered_outcome_data <- outcome_data[order.hf.name, ]
		}

		else {
			outcome_data <- subset(outcome_data_original, !is.na(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
			order.pnm.name <- order(outcome_data[23], outcome_data$Hospital.Name)
			ordered_outcome_data <- outcome_data[order.pnm.name, ]
		}

		if (num == "best") {
				num <- 1
			}

		else if (num == "worst") {

				ordered_state_data <- subset(ordered_outcome_data, State == state)
				num <- length(ordered_state_data$Hospital.Name)
		}

		ordered_state_data <- subset(ordered_outcome_data, State == state)	
		
		result <- as.character(ordered_state_data$Hospital.Name[num])

		result		
}

