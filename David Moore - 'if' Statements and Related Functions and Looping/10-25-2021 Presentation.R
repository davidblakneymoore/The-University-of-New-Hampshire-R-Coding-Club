
# 'if' Statements and Related Functions
# and Looping

# David Moore

# October 25th, 2021


# 'if' Statements

# Let's try an 'if' statement and talk about syntax.

x <- 5

if (x > 4) {
  print("'x' is greater than 4.")
}

# In the parenthesis there is a logical expression.
# In the curly brackets is the body of the 'if'
# statement. The code inside the curly brackets is
# ran if the logical expression evaluates to 'TRUE'.

# What if 'x' is less than 4?

x <- 3

if (x > 4) {
  print("'x' is greater than 4.")
}

# Nothing happens.

# We can get more complex as well.


# Nesting 'if' Statements

if (x > 4) {
  if (x < 8) {
    print("'x' is between 4 and 8.")
  }
}

# Remembering logical 'and' and logical 'or', we know
# we can also write the above chunk of code like this
# too.

if (x > 4 & x < 8) {
  print("'x' is between 4 and 8.")
}


# 'else' Statements

x <- 4.5

if (x > 4) {
  print("'x' is greater than 4.")
} else if (x <= 4 & x > 2) {
  print("'x' is less than or equal to 4 and greater than 2.")
} else if (x <= 2) {
  print("'x' is less than or equal to 2.")
}

# If the first logical expression is evaluated
# to 'FALSE', an 'if' statement followed by an
# 'else' will continue on to the next 'if'
# statement. If the first logical expression is
# evaluated to 'TRUE', the operation will stop
# and it will not continue on to the next 'if'
# statement regardless of whether the condition
# in the next 'if' statement is 'TRUE'.

# For example, look at the next chunk of code.
# If 'x' is 4.5, the conditions for both the
# first and the second 'if' statements will be
# evaluated to 'TRUE', but only the first 'if'
# statement will run.

if (x > 4) {
  print("'x' is greater than 4.")
} else if (x <= 5 & x > 2) {
  print("'x' is less than or equal to 4 and greater than 2.")
} else if (x <= 2) {
  print("'x' is less than or equal to 2.")
}

# Alternatively, if the 'if' statements from
# above aren't separated by 'else's, they will
# run independently. Both the first and second
# 'if' statements will run.

if (x > 4) {
  print("'x' is greater than 4.")
}
if (x <= 5 & x > 2) {
  print("'x' is less than or equal to 4 and greater than 2.")
}
if (x <= 2) {
  print("'x' is less than or equal to 2.")
}

# Again, without separating 'if' statements
# by 'else' statements, each 'if' statement
# is run independently.

# With 'else' statements, you don't need to
# provide a conditional statement to be
# evaluated if there aren't any other options.

x <- 3

if (x > 4) {
  print("'x' is greater than 4.")
} else {
  print("'x' is not greater than 4.")
}

# We can do other operations inside 'if'
# statements too.

if (x > 4) {
  x ^ 2
} else {
  x ^ 3
}

# Let's try something a little more complex.

x <- 1:10

if (x > 4) {
  print("'x' is greater than 4.")
} else if (x <= 4 & x > 2) {
  print("'x' is less than or equal to 4 and greater than 2.")
} else if (x <= 2) {
  print("'x' is less than or equal to 2.")
}

# Why didn't this work?

# 'if' statements are not vectorized.

# What can we do?

# Let's use the 'ifelse()' function.

help(ifelse)
?ifelse

(our_data <- data.frame(x = 1:10))

our_data$new_column <- ifelse(our_data$x > 5, "'x' is greater than 5", "'x' is not greater than 5")
our_data

# What if we want there to be multiple outputs
# depending on different conditions like we coded
# for in our second 'if' statement above?

# We can accomplish this by nesting 'ifelse()'
# functions.

our_data$another_new_column <- ifelse(our_data$x > 8, "'x' is greater than 8", ifelse(our_data$x <= 8 & our_data$x > 4, "'x' is less than or equal to 8 and greater than 4", ifelse(our_data$x <= 4 & x > 2, "'x' is less than or equal to 4 and greater than 2", "'x' is less than or equal to 2")))
our_data

# There has to be a better way. Let's try to use
# the 'cut()' function.

?cut

our_data$one_last_column <- cut(our_data$x, c(-Inf, 2, 4, 6, 8, Inf), c('Very small', 'Small', 'Medium', 'Large', 'Very large'))
our_data


# Looping

# 'for' Loops

# There are two ways to do loops. We can loop through
# the elements of a vector or we can loop through
# the positions of a vector.

# Let's start looping through elements and not
# positions.

LETTERS

for (i in LETTERS) {
  print(paste("The letter", i))
}

# Notice how the syntax is similar to that of
# functions and of 'if' statements.

# What does 'i' represent?

# 'i' represents all the elements in the 'LETTERS'
# vector. Each time it goes through the loop, the
# value of 'i' is a different element of this
# vector.

# Let's try to use positions now.

# Remember that colons can be used to generate
# a sequence of integers.

1:10

for (i in 1:length(LETTERS)) {
  print(paste("The letter", LETTERS[i]))
}

# In this case, 'i' no longer represents elements
# of the 'LETTERS' vector. Now, it represents
# positions along the vector. Notice how I used
# square brackets containing 'i' to tell R where
# along the vector we are.

# Let's do one more example.

(vector_1 <- round(rnorm(10), 2))

for (i in 1:length(vector_1)) {
  print(paste("The ", i, "th element of vector_1 is ", vector_1[i], sep = ""))
}

# Here's a tip. It's better to use the 'seq_len()'
# function than to use the '1:length()' syntax
# because of what happens if the length of a vector
# is '0'.

1:10
seq_len(10)

1:0
seq_len(0)

(vector_2 <- NULL)

for (i in 1:length(vector_2)) {
  print(paste("The ", i, "th element of vector_2 is ", vector_2[i], sep = ""))
}

for (i in seq_len(length(vector_2))) {
  print(paste("The ", i, "th element of vector_2 is ", vector_2[i], sep = ""))
}

# In most cases, you won't have this problem, but
# who knows what you'll run into.

# Let's look at some more complex loops.

# Can we loop through multiple things at once?

(American_League_East_Teams <- c("Boston Red Sox", "Toronto Blue Jays", "Tampa Bay Rays", "Baltimore Orioles", "New York Yankees"))

All_Possible_Matchups <- NULL
k <- 1

for (i in 1:(length(American_League_East_Teams) - 1)) {
  for (j in (i + 1):length(American_League_East_Teams)) {
    All_Possible_Matchups[k] <- paste(American_League_East_Teams[i], "versus", American_League_East_Teams[j])
    k <- k + 1
  }
}

All_Possible_Matchups

# Let's take a minute to break this down.

# First, we initialized a vector we would create
# with the 'for' loop.

# The inner 'for' loop runs through all its
# values while the outer 'for' loop stays on one
# value. When the inner for loop has gone through
# all its values, the outer for loop goes on to
# its next value and the inner loop starts again.

# You'll notice we had to use different variables for
# each of the loops - I used 'i' for the outer loop
# and 'j' for the inner loop.

# Since we're looping through two things, we can't
# use 'i' or 'j' to index since things will get
# overwritten. We use a new indexing variable ('k')
# that we have to specify increases by 1 each time
# the inner loop runs.

# What specifically will happen if, instead of using
# 'k', we use either 'i' or 'j' to index the output
# vector 'All_Possible_Matchups'?

# If 'i' is used to index, the output vector,
# All_Possible_Matchups, will only contain
# (length(American_League_East_Teams) - 1) elements
# since that's how many 'i's there were. When the
# inner 'for' loop is running, only the last value
# from it will be stored in the vector before the
# outer 'for' loop advances to the next value of 'i'.

# If 'j' is used to index, each time the inner 'for'
# loop runs, it will overwrite values in the output
# vector, All_Possible_Matchups, each time the outer
# 'for' loop advances to a new value of 'i'.

# You'll also notice that the values the inner loop
# looped through depended on the value that the outer
# loop was on. For the inner loop, I said that we'd
# start at 'i + 1' and go to the end.

# Finally, you'll notice that the outer loop only went
# up to the second-to-last position.

# What else can we do with loops?

# We can use the 'break' command.

for (i in 1:10) {
  print(paste("I love the number", i))
  if (i > 5) {
    break
  }
}

# What if we reordered what's in the body of this loop?

for (i in 1:10) {
  if (i > 5) {
    break
  }
  print(paste("I love the number", i))
}

# Why are these different?

# Are there other types of loops?

# There are 2 other types of loops. Be careful when
# using these, though, since if you make a mistake
# in your code, your computer will run it indefinitely
# and it might crash.

# There are 'while' loops.

q <- 1
while (q < 5) {
  print(paste("The loop is still going; we're only at the value ", q))
  q <- q + 1
}

# If you don't specify how 'q' increases each time in
# this above example, you risk running the loop
# indefinitely.

# There are also 'repeat' loops. Here's an example with
# perfect squares.

Number_of_Terms <- 100
x <- 1
repeat {
  print(x ^ 2)
  x <- x + 1
  if (x >= Number_of_Terms) {
    break
  }
}

# Note that by increasing 'x' by 1 each time and by
# including a 'break' statement there is no risk of
# running the loop indefinitely.

# In addition to 'break' statements, there are also
# 'next' statements. If we want to skip over a
# particular iteration of a loop, we can use a 'next'
# statement.

for (i in 1:10) {
  print(i)
  if (i == 5) {
    next
  }
}

# That didn't work because it printed the value before
# it evaluated the 'if' statement.

for (i in 1:10) {
  if (i == 5) {
    next
  }
  print(i)
}

# When you have a loop that takes a ridiculously long
# time to run, you could use 'print()' and 'Sys.time()'
# to print the time at which it reaches a certain step.
# This may be helpful for diagnosing which steps are
# taking the longest.

Sys.time()

for (i in seq_len(length(state.abb))) {
  # Perhaps you are doing some long operation here
  print("Step 1")
  print(Sys.time())
  # Perhaps you are doing another long operation here
  print("Step 2")
  print(Sys.time())
  # Perhaps you're doing yet another long operation here
  print("Step 3")
  print(Sys.time())
}

# As a final comment, looping is more computationally
# intensive than using functions in the apply family
# like 'apply()', 'lapply()', and 'mapply()'. I'd
# suggest becoming comfortable with both but using
# functions in the apply family preferentially.
