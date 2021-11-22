
# Recursive Functions
# 11-22-2021
# David Moore


# Chris Boamah-Mensah introduced me to recursive
# functions a few years ago when he came to
# present at an R Coding Club meeting.

# Before we start, there are just a few more
# things I want to show you before we write these
# recursive functions.


# Warning Messages

# We can write warning messages into our custom
# functions.

Function_1 <- function (x) {
  if (x == 1) {
    warning ("'x' is equal to 1 and it won't change when you square it!")
  }
  x ^ 2
}
Function_1(2)
Function_1(1)


# Error Messages

# We can also write error messages into our
# custom functions.

Function_2 <- function (x) {
  if (x == 0) {
    stop ("You can't divide a number by 0!")
  }
  1 / x
}
Function_2(2)
Function_2(0)

# The difference between a warning message and an
# error message is that a warning message does
# not stop the function from running - the
# function still runs, but it tells you something
# may be fishy. With an error message, the
# function does not run.


# Quotation Marks in Character Strings

# There's one other small detail you may have
# noticed - I nested single quotation marks
# inside double quotation marks. This is how you
# get quotation marks to show up as quotation
# marks inside a character string without using
# regular expressions, which we'll talk about
# soon.

# You can also do the reverse (nest double
# quotation marks inside single quotation
# marks).

(Character_String_1 <- "My dog's name is Sally.")
(Character_String_2 <- 'Bob said, "please sit down."')

# We'll talk more about these backslashes when we
# talk about regular expressions.


# Recursive Functions

# A recursive function is a function that calls
# itself.

# Let's write a function to calculate the nth
# term of the Fibonacci sequence.

Fibonacci_Sequence_Function <- function (x) {
  if ((x %% 1 != 0) | (x < 1) | (length(x) != 1) | (!is.numeric(x))) {
    stop ("'x' is not a positive integer.")
  }
  if (x == 1) {
    return (0)
  } else if (x == 2) {
    return (1)
  } else if (x > 2) {
    return (Fibonacci_Sequence_Function(x - 1) + Fibonacci_Sequence_Function(x - 2))
  }
}

Fibonacci_Sequence_Function(1)
Fibonacci_Sequence_Function(2)
Fibonacci_Sequence_Function(3)
Fibonacci_Sequence_Function(4)
Fibonacci_Sequence_Function(5)
Fibonacci_Sequence_Function(10)

# Why would you ever use this type of function in
# practice?

# You could use recursive functions if you have
# a nested list that contains data frames and
# you're not sure exactly how nested your list
# is.

Data_Frame_1 <- data.frame(Column_1 = LETTERS[1:10], Column_2 = rnorm(10))
Data_Frame_2 <- data.frame(Column_1 = LETTERS[1:10], Column_2 = rnorm(10))
Data_Frame_3 <- data.frame(Column_1 = LETTERS[1:10], Column_2 = rnorm(10))
Data_Frame_4 <- data.frame(Column_1 = LETTERS[1:10], Column_2 = rnorm(10))
Data_Frame_5 <- data.frame(Column_1 = LETTERS[1:10], Column_2 = rnorm(10))
Data_Frame_6 <- data.frame(Column_1 = LETTERS[1:10], Column_2 = rnorm(10))
Data_Frame_7 <- data.frame(Column_1 = LETTERS[1:10], Column_2 = rnorm(10))
Data_Frame_8 <- data.frame(Column_1 = LETTERS[1:10], Column_2 = rnorm(10))
Data_Frame_9 <- data.frame(Column_1 = LETTERS[1:10], Column_2 = rnorm(10))
Nested_List_1 <- list(Data_Frame_1, Data_Frame_2, Data_Frame_3)
str(Nested_List_1)
class(Nested_List_1)
Nested_List_2 <- list(list(Data_Frame_1, Data_Frame_2, Data_Frame_3), list(Data_Frame_4, Data_Frame_5, Data_Frame_6), list(Data_Frame_7, Data_Frame_8, Data_Frame_9))
str(Nested_List_2)
class(Nested_List_2)

Recursive_Function <- function (x) {
  if (!(class(x) %in% c('data.frame', 'list'))) {
    stop ("'x' is not a data frame or a list.")
  }
  if (class(x) == 'list') {
    lapply(x, Recursive_Function)
  } else if (class(x) == 'data.frame') {
    x$Column_3 <- x$Column_2 ^ 2
    return (x)
  }
}

Recursive_Function(Nested_List_1)
Recursive_Function(Nested_List_2)
