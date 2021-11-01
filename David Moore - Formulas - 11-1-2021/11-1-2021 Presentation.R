
# Formulas
# 11-1-2021
# David Moore


# The syntax of a formula is:

# Response variable(s) ~ predictor variable(s)

# Another way to say this is:

# Dependent variable(s) ~ independent variable(s)

# The tilde ('~') separates these two types of
# variables.

# Formulas are used in many different R functions.


# The 'lm()' Function

# Here's a basic example:

lm(mtcars$mpg ~ mtcars$cyl)

# In the console, the output show the slope for the
# 'mtcars$cyl' term as well as the intercept.


# The 'summary()' Function

# Before we start adding more terms, let's look at
# one more thing.

summary(lm(mtcars$mpg ~ mtcars$cyl))

# The 'summary()' function tells us a lot more
# information. We now have estimates, standard
# errors, t values, and p values for each term in
# the model.

# What do these p values mean?

# They tell you if the estimate (the slope or the
# intercept) are statistically significantly
# different than 0. The null hypotheses of these
# tests are that the estimate is not different
# from 0. If the p value is less than whatever
# threshhold you choose (such as 0.05), the data
# suggest that the estimate is indeed different
# from 0.

# Why do we care if a slope or an intercept is
# significantly different from 0?

# We typically care more about if a slope is
# different from 0 than if an intercept is. If a
# slope is different from 0, then there is a
# relationship between the predictor variable and
# the response variable - you can predict the
# response with that predictor variable. If the
# slope is 0, there isn't really a relationship -
# the outcome will be the same for any value of
# that predictor variable. If the slope is 0, the
# line is flat.


# Making More Complex Formulas With '+', ':', '*',
# '^', and '/'

# Now, let's add more terms to our model.

lm(mtcars$mpg ~ mtcars$cyl + mtcars$disp)

# Here, we have two slopes (one for the 'mtcars$cyl'
# term and another for the 'mtcars$disp' term) in
# addition to the intercept.

lm(mtcars$mpg ~ mtcars$cyl + mtcars$disp + mtcars$hp)

# Remember, a more efficient way to write the above
# line of code is:

with(mtcars, lm(mpg ~ cyl + disp + hp))

# There's also one more way:

lm(mpg ~ cyl + disp + hp, data = mtcars)


# The 'abline()' Function

# Let's make a plot and add a trendline.

plot(mtcars$mpg ~ mtcars$cyl)
abline(lm(mtcars$mpg ~ mtcars$cyl), col = 2)

# The 'abline()' function can take the output of the
# 'lm()' function as an input.


# Higher-Order Polynomials

# What if we suspect there is a quadratic relationship
# between these two variables?

lm(mtcars$mpg ~ mtcars$cyl + (mtcars$cyl ^ 2))

# We didn't get a second-order polynomial term in the
# output.

lm(mtcars$mpg ~ mtcars$cyl + I(mtcars$cyl ^ 2))

# Why did I have to add the 'I()' function?

# First, let's talk about interactions.

lm(mtcars$mpg ~ mtcars$cyl + mtcars$disp + mtcars$cyl:mtcars$disp)

# We use a colon (':') to specify that we want to look
# at an interaction between two terms.

# A quicker way to specify that we want to look at a
# group of main effects and all their possible
# interactions is to use an asterisk ('*').

lm(mtcars$mpg ~ mtcars$cyl * mtcars$disp)

# This line of code gives the same output as the
# previous line of code.

# Let's look at three-way interactions.

lm(mtcars$mpg ~ mtcars$cyl * mtcars$disp * mtcars$hp)

# In this output, we get slopes for the three main
# effects, slopes for the three 2-way interactions, and
# a slope for the one 3-way interaction.

# It's a lot quicker to write it out like we just did
# than to write out all the terms (including all the
# interaction terms) separately.

# What if we only want to look at 2-way interactions
# and ignore any higher-order interactions?

# We can write out each term individually, but there's a
# faster way.

lm(mtcars$mpg ~ (mtcars$cyl + mtcars$disp + mtcars$hp) ^ 2)

# Anything inside the parentheses that we raise to the
# power of two will look at all the main effects and 2-
# way interactions but not higher-order interactions.

# Here's one more example before we go back to our
# question about including a second-order polynomial.

lm(mtcars$mpg ~ (mtcars$cyl + mtcars$disp + mtcars$hp + mtcars$wt) ^ 3)

# If we have 4 predictor variables, we can raise them all
# to the power of 3. This will allow us to look at the
# main effects, all 2-way interactions, and all 3-way
# interactions. We don't see any interaction terms
# that are higher than order 3.

# Why did we have to use the 'I()' function to specify
# that we want to look at a second-order polynomial term
# when we raised a predictor variable to the power of 2?

lm(mtcars$mpg ~ mtcars$cyl + (mtcars$cyl ^ 2))

lm(mtcars$mpg ~ mtcars$cyl + I(mtcars$cyl ^ 2))

# It's because, for formulas, raising something to the
# power of a number has a special meaning - it means that
# we want to look at interactions up to that order. In
# this example, we raise an individual predictor variable
# to the power of two. There's no possible way to get a
# 2-way interaction out of one variable, so the model
# doesn't do anything with the exponent.

# We use the 'I()' function to tell R that we want to
# analyze the term as it's written ('as-is').

# Here's another example:

lm(mtcars$mpg ~ (mtcars$cyl + mtcars$disp))

lm(mtcars$mpg ~ I(mtcars$cyl + mtcars$disp))

# In this case, we have two different outputs. The first
# is what we did previously - we get a slope for both the
# 'mtcars$cyl' and the 'mtcars$disp' terms. The second is
# different - in the second case, we actually add the two
# variables together and perform linear regression on
# their sum.

# There's actually an easier way to code for polynomials.

lm(mtcars$mpg ~ poly(mtcars$cyl, degree = 2))

# The 'poly()' function will report higher-order terms
# for all integer powers from the degree you specify down
# to 1.

plot(mtcars$mpg ~ mtcars$cyl)
abline(lm(mtcars$mpg ~ mtcars$cyl), col = 2)
abline(lm(mtcars$mpg ~ poly(mtcars$cyl, degree = 2)), col = 3)

# I was hoping to show the 2nd-order polynomial trendline
# on the plot but it didn't work. We'll have to try
# something else.

Second_Order_Model <- lm(mpg ~ poly(cyl, degree = 2), data = mtcars)

Sequence_of_Points <- with(mtcars, seq(min(cyl), max(cyl), by = 0.01))
Predicted_Values <- predict(Second_Order_Model,
                            newdata = data.frame(cyl = Sequence_of_Points))

plot(mpg ~ cyl, data = mtcars)
abline(lm(mpg ~ cyl, data = mtcars), col = 2)
lines(Sequence_of_Points, Predicted_Values, col = 3)

# What did we do?

# We first created a vector of points from 4 to 8 by 0.01.
# Then, we used the second-degree-polynomial model to
# predict 'mpg' from 'cyl' using the polynomial that's in
# the form y = a * x ^ 2 + b * x + c, where 'y' is 'mpg'
# and 'x' is 'cyl'.


# The 'predict()' Function

# The 'predict()' function can be used to generate
# predicted values from a model using new input values.

# Here's an example:

Predictor_Variable <- 1:100 + rnorm(100, 0, 0.5)
Response_Variable <- rnorm(100, 0, 0.5) + log(1:100)

# What do these points look like?

plot(Response_Variable ~ Predictor_Variable)
abline(lm(Response_Variable ~ Predictor_Variable), col = 2)

# Let's create the linear model.

(My_Model <- lm(Response_Variable ~ Predictor_Variable))

# If we have a predictor variable that's 55.5, what will
# the response be based on this model?

# We could extract the terms from the model, plug them
# into the equation y = m * x + b, and figure it out
# that way:

Slope <- My_Model$coefficients["Predictor_Variable"]
Intercept <- My_Model$coefficients["(Intercept)"]
(Response <- Slope * 55.5 + Intercept)

# We could also use the 'predict()' function:

predict(My_Model, newdata = data.frame(Predictor_Variable = 55.5))

# When we use the 'predict()' function, it's
# important that we put our new predictor variable
# (55.5) into a data frame and call it the same thing
# we called the predictor variable in the original
# model. In our case, the predictor variable in the
# original model was called 'Predictor_Variable'.

# What if we had a model with two or more terms we
# wanted to use to predict new responses with?

My_New_Model <- lm(mtcars$mpg ~ mtcars$cyl + mtcars$disp)

# We could use the formula y = m1 * x1 + m2 * x2 + b,
# but it's starting to get a little cumbersome to
# plug in all these values. Let's use the 'predict()'
# function.

# Let's say we want to predict a car's miles per gallon
# if we know a car has 6 cylinders and a displacement
# of 225 in ^ 3.

predict(My_New_Model, newdata = data.frame(cyl = 6, disp = 225))

# This is a weird thing about R. We need to re-code the
# model to avoid getting a warning message and to get
# the right answer.

My_New_Model <- lm(mpg ~ cyl + disp, data = mtcars)
predict(My_New_Model, newdata = data.frame(cyl = 6, disp = 225))

# It's confusing but it has to do with how variables are
# named in the linear model. They need to match the names
# of the variables we use in the  'predict()' function.
# The first time we created this linear model, we called
# the variables 'mtcars$cyl' and 'mtcars$disp', and those
# names didn't exactly match the 'cyl' and 'disp' names
# we provided to the 'newdata' argument of the
# 'predict()' function. The second time, we named them
# 'cyl' and 'disp', and they matched.

# There's one more special symbol we can use with
# formulas.

lm(mtcars$mpg ~ mtcars$cyl / mtcars$disp)

# My example doesn't really make sense, but it
# illustrates the point.

# You can use the '/' symbol to indicate you want to look
# at only one of the main effects, but you also want to
# look at the interaction of these two effects. You can
# see that the output provides us with slopes for
# 'mtcars$cyl' and 'mtcars$cyl:mtcars$disp' but not for
# 'mtcars$disp'.

# This is generally used for nested experimental designs.
# For example, if we assign participants to different
# treatments, but each participant does not experience
# each treatment, then participant and treatment are not
# crossed - participant is nested within treatment since
# each participant is not present in each treatment
# level.

# In our example, 'disp' would be nested within 'cyl',
# which isn't the case - I just used it as an example.

# We'll talk more about experimental designs and how to
# analyze them next week.


# Interactions

# I mentioned interactions earlier, but what are they?

Nitrogen_Rate <- rep(c(0, 50, 100, 150, 200), 3)
Phosphorus_Rate <- rep(c(0, 50, 100), each = 5)
Corn_Yield <- c(44, 54, 55, 54, 52, 45, 67, 72, 75, 98, 33, 89, 91, 93, 88)
interaction.plot(Nitrogen_Rate, Phosphorus_Rate, Corn_Yield)

# If 'Corn_Yield' does not respond similarly to
# 'Nitrogen_Rate' across different 'Phosphorus_Rate'
# treatments, we'd say there is a significant
# interaction between 'Nitrogen_Rate' and
# 'Phosphorus_Rate'.

# We can look at this interaction another way too:

interaction.plot(Phosphorus_Rate, Nitrogen_Rate, Corn_Yield)
