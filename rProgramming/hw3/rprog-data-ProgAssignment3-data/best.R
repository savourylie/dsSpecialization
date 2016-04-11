best <- function(state, outcome) {
    ## Read outcome data
    outcome_data <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available")

    ## Check that state and outcome are valid
	states_abb <- c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY")

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

	## Return hospital name in that state with lowest 30-day death
	## rate

	if (outcome == "heart attack") {
		order.ha <- order(outcome_data[11])
		ordered_state_data <- subset(outcome_data[order.ha, ], State == state)
		
		count <- 1

		while (ordered_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack[count] == ordered_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack[count + 1]) {
			count <- count + 1
		}

		if (count == 1) {
			result <- as.character(ordered_state_data$Hospital.Name[1])
		}

		else {
			result <- as.character(sort(ordered_state_data[1:count, "Hospital.Name"])[1])
		}

		result
		
	}

	else if (outcome == "heart failure") {
		order.hf <- order(outcome_data[17])
		ordered_state_data <- subset(outcome_data[order.hf, ], State == state)
		
		count <- 1

		while (ordered_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure[count] == ordered_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure[count + 1]) {
			count <- count + 1
		}

		if (count == 1) {
			result <- as.character(ordered_state_data$Hospital.Name[1])
		}

		else {
			result <- as.character(sort(ordered_state_data[1:count, "Hospital.Name"])[1])
		}

		result
	}

	else {
		order.pnm <- order(outcome_data[23])
		ordered_state_data <- subset(outcome_data[order.pnm, ], State == state)
		
		count <- 1

		while (ordered_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia[count] == ordered_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia[count + 1]) {
			count <- count + 1
		}

		if (count == 1) {
			result <- as.character(ordered_state_data$Hospital.Name[1])
		}

		else {
			result <- as.character(sort(ordered_state_data[1:count, "Hospital.Name"])[1])
		}
		
		result
	}
}