# Overview ----------------------------------------------------------------

# Assignment 1: Analysis of the protest data from Crowd Love
# For each question/prompt, write the necessary code to calculate the answer.
# For grading, it's important that you store your answers in the variable names
# listed with each question in `backtics`.
# For each prompt marked `Reflection`, please write a response
# in your `README.md` file.



# Part 1:Set up -----------------------------------------------------------

# In this section, you're loading the data and necessary packages.
# Load the `stringr` package, which you'll use later.

library(stringr)

# Load the data from https://countlove.org/data/data.csv
# into a variable called `protests`
protests <- read.csv("https://countlove.org/data/data.csv")

# How many protests are in the dataset? `num_protests`
num_protests <- length(protests$Tags)

# How much information is available about each protest? `num_features`
num_features <- ncol(protests)

# Part 2: Attendees -------------------------------------------------------

# In this section, you're exploring the number of attendees.

# Extract the `Attendees` column into a variable called `num_attendees`
num_attendees <- protests$"Attendees"

# What is the lowest number of attendees? `min_attendees`
# (hint for this and other calculations: you'll need to consider missing values)
min_attendees <- min(protests$Attendees, na.rm = TRUE)

# What is the highest number of attendees? `max_attendees`
max_attendees <- max(protests$Attendees, na.rm = TRUE)

# What is the mean number of attendees? `mean_attendees`
mean_attendees <- mean(num_attendees, na.rm = TRUE)

# What is the median number of attendees? `median_attendees`
median_attendees <- median(num_attendees, na.rm = TRUE)

# What is the difference between the mean and median
# number of attendees? `mean_median_diff`
mean_median_diff <- mean_attendees - median_attendees

# Reflection: What does the difference between the mean and the median
# tell you about the *distribution* of the data? (if you're unfamiliar with
# working with distibutions, feel free to ask your TA for clarification)

# To further assess the distribution of values, create a boxplot of the number
# of attendees using the `boxplot()` function.
# Store the plot in a variable called `attendess_distribution`
# (Note, we'll use much more refined plotting methods, and pay far
# more attention to detail later in the course)
attendess_distribution <- boxplot(num_attendees)

# Create another boxplot of the *log* of the number of attendees.
# Store the plot in a variable `log_attendees_distribution`.
# (note, you will see a warning in the console, which is expected)
log_attendees_distribution <- boxplot(log(num_attendees))

# Part 3: Locations -------------------------------------------------------

# In this section, you're exploring where protests happened.

# Extract the `Location` column into a variable called `locations`
locations <- protests$"Location"

# How many *unique* locations are in the dataset? `num_locations`
num_locations <- length(unique(locations))

# How many protests occured in Washington? `num_in_wa`
# (hint: use a function from the stringr package to detect the letters "WA")
num_in_wa <- sum(str_detect(locations, "WA"))

# What proportion of protests occured in Washington? `prop_in_wa`
prop_in_wa <- num_in_wa / num_protests

# Reflection: Does the number of protests in Washington surprise you?
# Why or why not?

# Write a function `count_in_location()` that accepts (as a parameter)
# a `location` name, and returns the sentence (note: spacing and punctuation):
# "There were N protests in LOCATION.", where N is the number of
# protests that occured in that location, and LOCATION is the parameter that
# was provided into the function.
# Note, you should count the number of locations that *match* the parameter
# put into the function, so `Seattle` should be a match for "Seattle, WA"
count_in_location <- function(location) {
  num_in_location <- sum(str_detect(locations, location))
  location_sentence <- paste("There were", num_in_location,
                             "protests in", location)
  return(location_sentence)
}

# Use your function above to describe the number of protests in "Washington, DC"
# `dc_summary`
dc_summary <- count_in_location("Washington, DC")

# Use your function above to describe the number of protests in "Minneapolis"
# `minneapolis_summary`
minneapolis_summary <- count_in_location("Minneapolis")

# Create a new vector `states` which is the last two characters of each
# value in the `locations` vector. Hint, you may want to again use the
# `stringr` package
states <- str_sub(locations, -2, -1)

# Create a vector of the unique states in your dataset. `uniq_states`
uniq_states <- unique(states)

# Create a summary sentence for each state by passing your `uniq_states`
# variable and `count_in_location` variables to the `sapply()` function.
# Store your results in `state_summary`
# (don't miss how amazing this is! Very powerful to apply your function to an
# entire vector *at once* with `sapply()`)
state_summary <- sapply(uniq_states, count_in_location)

# Create a summary table by passing your `states` variable to the `table()`
# funciton, and storing the result in a variable `state_table`.
state_table <- table(states)

# Optional: use the View() function to more easily read the table

# Reflection: Looking at the `state_table` variable, what data quality issues
# do you notice, and how would you use that to change your analysis (no need
# to actually change your analysis)?

# What was the maximum number of protests in a state? `max_in_state`
# (hint: use your `state_table` variable)
max_in_state <- max(state_table)

# Part 4: Dates -----------------------------------------------------------

# In this section, you're exploring *when* protests happened.

# column to the `as.Date()` function (this will process the values as dates,
# which are *luckily* already in an optimal format for parsing)
dates <- as.Date(date, "%Y-%m-%d")

# What is the most recent date in the dataset? `most_recent`
# Extract the `Date` column into a variable called `dates` by passing the
most_recent <- dates[length(dates)]

# What is the earliest date in the dataset? `earliest`
earliest <- dates[1]

# What is the length of the timespan of the dataset? `time_span`
# hint: R can do math with dates pretty well by default!
time_span <- most_recent - earliest

# Create a vector of the dates that are in 2020 `in_2020`
in_2020 <- dates[dates >= "2020-01-01" & dates <= "2020-12-31"]

# Create a vector of the dates that are in 2019. `in_2019`
in_2019 <- dates[dates >= "2019-01-01" & dates <= "2019-12-31"]

# What is the ratio of the number of protests in 2020 compared to 2019?
# `ratio_2020_2019`
ratio_2020_2019 <- length(in_2020) / length(in_2019)

# Reflection: Does the change in the number of protests from 2019 to 2020
# surprise you? Why or why not?

# Write a function `count_on_date()` that accepts as a parameter a `date`,
# and returns the sentence:
# "There were N protests on DATE.", where N is the number of protests on that
# date, and DATE is the date provided
count_on_date <- function(date) {
  num_on_date <- sum(str_detect(dates, date))
  date_sentence <- paste("There were", num_on_date, "protests on", date)
  return(date_sentence)
}

# Using your function you just wrote, how many protests were there on
# May 24th, 2020? `num_may_24`
num_may_24 <- count_on_date("2020-05-24")

# Using your function you just wrote, how many protests were there on
# May 31th, 2020? `num_on_may_31`
num_on_may_31 <- count_on_date("2020-05-31")

# For more on this timeline, see:
# https://www.nytimes.com/article/george-floyd-protests-timeline.html

# How many protests occured each month in 2020? `by_month_table`
# Hint: use the `months()` function, your `in_2020` dates, and the `table()`
# Function. If you like, you can do this in multiple different steps.
by_month_table <- table(months(in_2020))

# As a comparison, let's assess the change between July 2019 and July 2020.
# What is the *difference* in the number of protests between July 2020 and
# July 2019? You'll want to do this in multiple steps as you see fit, though
# your answer should be stored in the variable `change_july_protests`.
num_july_2019 <- dates[dates >= "2019-07-01" & dates <= "2019-07-31"]
num_july_2020 <- dates[dates >= "2020-07-01" & dates <= "2020-07-31"]
change_july_protests <- length(num_july_2020) - length(num_july_2019)

# Reflection: do a bit of research. Find at least *two specific policies* that
# have been changed as a result of protests in 2020. These may be at the
# city, state, or University level. Please provide a basic summary, as well as a
# link to each article.


# Part 5: Protest Purpose -------------------------------------------------

# In this section, you're exploring *why* protests happened
# Extract the `Event..legacy..see.tags.` column into a variable called `purpose`
purpose <- protests$"Event..legacy..see.tags."

# How many different purposes are listed in the dataset? `num_purposes`
num_purposes <- length(unique(purpose))

# That's quite a few -- if you look at -- View() -- the vector, you'll notice
# a common pattern for each purpose. It's listed as:
# SOME_PURPOSE (additiona_detail)
# To get a higher level summary, create a variable `high_level_purpse` by
# extracting *everything before the first parenthesis* in each value
# in the vector. For example, from "Civil Rights (Black Women's March)"
# you would extract "Civil Rights". You'll also have to *remove the space*
# before the first parenthasis.
# Hint: this will take a little bit of googling // trial and error. Be patient!
high_level_purpse <- sub(" \\(.*", "", purpose)

# How many "high level" purposes have you identified? `num_high_level`
num_high_level <- length(unique(high_level_purpse))

# Create a table that counts the number of protests for each high level purpose
# `high_level_table`
high_level_table <- table(high_level_purpse)

# Reflection: Take a look (`View()`) your `high_level_table` variable. What
# picture does this paint of the U.S.?


# Part 6: Independent Exploration -----------------------------------------

# As a last step, you should write your own function that allows you to
# quickly ask questions of the dataset. For example, in the above sections,
# you wrote functions to ask the same question about different months, or
# locations. If you need any guidance here, feel free to ask!

diff_cities_on_date <- function(date) {
  diff_cities <- protests[protests$Date == date, "Location"]
  num_of_cities <- length(diff_cities)
  date_sentence <- paste("There were", num_of_cities,
                         "cities that had protests on", date)
  return(date_sentence)
}
