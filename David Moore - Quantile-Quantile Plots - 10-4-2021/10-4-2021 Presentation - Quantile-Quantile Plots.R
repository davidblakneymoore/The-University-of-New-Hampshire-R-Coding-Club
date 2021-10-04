
# Quantile-Quantile Plots
# David Moore
# October 4th, 2021

# We recorded 10 measurements that had a mean of 16
# and a standard deviation of 4. We want to know if
# they are from a normal distribution with a mean
# of 16 and a standard deviation of 4.

(Observations <- rnorm(10, 16, 4))

# We'll need to compare these measurements with
# 10 theoretical measurements from a normal
# distribution with a mean of 16 and a standard
# deviation of 4.

# First, let's figure out what these 10 theoretical
# values are.

x <- seq(0, 32, 0.01)
y <- dnorm(x, 16, 4)
plot(y ~ x, main = "A Normal Distribution\nWith a Mean of 16\nAnd a Standard Deviation of 4", ylab = "Density", xlab = "Quantile", type = 'l', lwd = 2)

Probability_Cutoffs <- seq(0, 1, length.out = 11)
Probability_Cutoff_Midpoints <- Probability_Cutoffs[-length(Probability_Cutoffs)] + (diff(Probability_Cutoffs) / 2)

for (i in seq_len(length(Probability_Cutoffs))) {
  segments(qnorm(Probability_Cutoffs[i], 16, 4), 0, qnorm(Probability_Cutoffs[i], 16, 4), dnorm(qnorm(Probability_Cutoffs[i], 16, 4), 16, 4))
}

for (i in seq_len(length(Probability_Cutoff_Midpoints))) {
  points(qnorm(Probability_Cutoff_Midpoints[i], 16, 4), dnorm(qnorm(Probability_Cutoff_Midpoints[i], 16, 4), 16, 4), col = "red", pch = 19)
  segments(qnorm(Probability_Cutoff_Midpoints[i], 16, 4), dnorm(qnorm(Probability_Cutoff_Midpoints[i], 16, 4), 16, 4), qnorm(Probability_Cutoff_Midpoints[i], 16, 4), 0, col = "red", lty = 2)
}

# How do our observed values compare with these?

points(Observations, dnorm(Observations, 16, 4), pch = 19, col = "blue")

# Do these observations seem to fit this distribution,
# or is there any skewness or kurtosis?

# Quantile-Quantile Plots

# A quantile-quantile plot helps to asses normality
# by regressing the theoretical values with the
# observed ones.

# First, let's order the observed values from least
# to greatest.

Observations <- Observations[order(Observations)]

# Let's also grab those theoretical values (which
# are already in order) from my previous code.

(Theoretical_Values <- qnorm(Probability_Cutoff_Midpoints, 16, 4))

# Now we can create our quantile-quantile plot.

plot(Observations ~ Theoretical_Values, main = "Quantile-Quantile Plot", xlab = "Theoretical Values")

# Let's add a 1-to-1 line to see how well our data
# line up with it.

abline(coef = c(0, 1), col = 'red', lty = 2)

# Can you make inferences about skewness and
# kurtosis just by looking at this plot?


# Can you make quantile-quantile plots for
# other distributions?

# Yes!

# Here's a quick example for an F distribution
# with 10 and 12 degrees of freedom.

Observations <- rf(10, 10, 12)

x <- seq(0, 6, 0.01)
y <- df(x, 10, 12)
plot(y ~ x, main = "An F Distribution\nWith 10 and 12 Degrees of Freedom", ylab = "Density", xlab = "Quantile", type = 'l', lwd = 2)

Probability_Cutoffs <- seq(0, 1, length.out = 11)
Probability_Cutoff_Midpoints <- Probability_Cutoffs[-length(Probability_Cutoffs)] + (diff(Probability_Cutoffs) / 2)

for (i in seq_len(length(Probability_Cutoffs))) {
  segments(qf(Probability_Cutoffs[i], 10, 12), 0, qf(Probability_Cutoffs[i], 10, 12), df(qf(Probability_Cutoffs[i], 10, 12), 10, 12))
}

for (i in seq_len(length(Probability_Cutoff_Midpoints))) {
  points(qf(Probability_Cutoff_Midpoints[i], 10, 12), df(qf(Probability_Cutoff_Midpoints[i], 10, 12), 10, 12), col = "red", pch = 19)
  segments(qf(Probability_Cutoff_Midpoints[i], 10, 12), df(qf(Probability_Cutoff_Midpoints[i], 10, 12), 10, 12), qf(Probability_Cutoff_Midpoints[i], 10, 12), 0, col = "red", lty = 2)
}

points(Observations, df(Observations, 10, 12), pch = 19, col = "blue")

Observations <- Observations[order(Observations)]

Theoretical_Values <- qf(Probability_Cutoff_Midpoints, 10, 12)

plot(Observations ~ Theoretical_Values, main = "Quantile-Quantile Plot\nfor an F Distribution\nWith 10 and 12 Degrees of Freedom", xlab = "Theoretical Values")

abline(coef = c(0, 1), col = 'red', lty = 2)
