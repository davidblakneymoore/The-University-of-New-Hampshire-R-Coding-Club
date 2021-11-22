
# Recursive Functions
# 11-22-2021
# David Moore


# Chris Boamah-Mensah introduced me to recursive
# functions a few years ago when he came to
# present at an R Coding Club meeting.

# A recursive function is a function that calls itself.

# Let's write a function to calculate the nth
# term of the Fibonacci sequence.

Fibonacci_Sequence_Function <- function (x) {
  if (x %% 1 != 0 | x < 1 | length(x) != 1 | !is.numeric(x)) {
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
