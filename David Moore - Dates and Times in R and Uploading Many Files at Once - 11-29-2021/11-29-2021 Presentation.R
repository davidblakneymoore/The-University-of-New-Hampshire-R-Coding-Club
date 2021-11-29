
# Dates and Times in R and Uploading Many Files
# at Once

# David Moore

# 11-29-2021


# Dates

# You may work with dataloggers that store dates
# a certain way.

# Here's an example.

Date_1 <- "04-05-2010"
str(Date_1)

# This date is a character string and it is
# structured in a specific way: month is first,
# then day, and the four-digit year is last.

# R has a way to think about dates numerically.
# It's helpful to think about dates numerically
# since we may want to plot or do other similar
# things with them.

# There's a class called 'Date'. Let's convert
# this character string to a 'Date' object.

as.Date(Date_1)

# That makes no sense. Here's why: in R, dates
# are always stored as four-digit years
# followed by the month (as a number) followed
# by the day of the month (as a number), and
# these three things are always separated by
# dashes.

as.Date(Date_1, format = "%m-%d-%Y")

# I had to tell R how our date was structured in
# order for R to know how to convert it to a
# 'Date' object. '%m' means month (in the
# numeric form), '%d' means day of the month, and
# '%Y' means four-digit year. You can also see
# that I separated them by dashes because that
# matches the syntax of the character string we
# started with.

# What if you have a dates like these?

Date_2 <- "10-4-20"
Date_3 <- "Oct. 4, 2020"

# The first contains month as a three-letter
# abbreviation, followed by a period, followed by
# a space, followed by the day of the month,
# followed by a comma, followed by another space,
# followed by the 4-digit year.

# The second contains the month as a number,
# follower by a dash, followed by the day of the
# month, followed by a dash, followed by the two-
# digit year.

# How can we convert these to dates?

?strptime

# We can see all the different possible ways to
# store dates.

# See if you can convert these two dates, which
# are currently character strings, into 'Date'
# objects.

as.Date(Date_2, format = "%m-%d-%y")
as.Date(Date_3, format = "%b. %d, %Y")

# The 'as.Date' function is vectorized, so you
# can convert vectors of dates all at once if
# they are all structured the same way.


# Times

# There is also a class called 'POSIXct' which
# is used for times.

# You may record data that store times like this:

Time_1 <- "4-4-2010, 22:15:00"

# How can we convert this character string into a
# 'POSIXct' object so that we can plot it and
# work with it as if it were a numeric variable?

as.POSIXct(Time_1)

# That didn't work either. We have to tell the
# 'as.POSIXct' function how our dates are
# formatted.

as.POSIXct(Time_1, format = "%d-%m-%Y, %H:%M:%S")
as.POSIXct(Time_1, format = "%d-%m-%Y, %X")

# These are both equivalent since '%X' just
# represents '%H:%M:%S'.

# Can you convert the following character strings
# into times?

Time_2 <- "10-3-2013 3:00:00 PM"
Time_3 <- "5:15 PM on Oct. 4th, 2020"

# Get help on the 'strptime' function again to
# figure it out.

as.POSIXct(Time_2, format = "%m-%d-%Y %I:%M:%S %p")
as.POSIXct(Time_3, format = "%I:%M %p on %b. %dth, %Y")

# You know that 'th' doesn't always follow day of
# the month - sometimes it's 'st', sometimes it's
# 'nd', and sometimes it's 'rd'. When we talk
# about regular expressions, we'll learn how to
# take care of all these cases at once.

as.POSIXct(Time_3, format = "%I:%M %p on %b. %d[:lower:]{2}, %Y")
as.POSIXct(Time_3, format = "%I:%M %p on %b. %d[:alpha:]{2}, %Y")


# Uploading Files

# We can search our hard drive for files and
# upload them easily from within R.

list.files("/Users/davidblakneymoore/Downloads", full.names = T)
Files <- file.info(list.files("/Users/davidblakneymoore/Downloads", full.names = T))
View(Files)
?file.info

# The 'mtime', 'ctime', and 'atime' columns are
# conveniently already in 'POSIXct' format.

str(Files)

# At one point, I had to upload files that
# contained data for different species of trees.
# I had to upload the most recent file that
# contained the word "Maple", the most recent
# file that contained the word "Birch", and the
# most recent file that contained the word
# "Walnut". How would I do this efficiently?

# First, let me introduce some new functions.

Vector_1 <- c("cat", "dog", "catdog", "horse")
grep("cat", Vector_1)
grepl("cat", Vector_1)

Vector_2 <- c(5, 6, 3, 4, 2)
max(Vector_2)
which.max(Vector_2)
min(Vector_2)
which.min(Vector_2)

# Let's use some of these new functions to help.

Species <- c("Maple", "Birch", "Walnut")
All_Files <- file.info(list.files("C:/David Moore/Documents", pattern = ".csv", full.names = T))
Files_by_Species <- lapply(Species, function (x) {
  grep(x, rownames(All_Files))
})
List_of_Files_to_Upload <- lapply(Files_by_Species, function (x) {
  All_Files[x, ]
})
List_of_Most_Recent_Files <- lapply(List_of_Files_to_Upload, function (x) {
  x[which.max(x$mtime), ]
})
Data_List <- lapply(List_of_Most_Recent_Files, function (x) {
  read.csv(rownames(x))
})
names(Data_List) <- Species
