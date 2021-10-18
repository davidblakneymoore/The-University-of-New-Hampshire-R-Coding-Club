
# The 'ggplot2' Package
# Dani Blumstein
# 10-16-2021


# Look at the 'ggplot2' Cheat Sheet

# Click 'Help', then click 'Cheatsheets', then
# click 'Data Visualization with ggplot2'.


# Install Packages

if(!require (ggplot2)) {
  install.packages('ggplot2')
}
if(!require (ggpubr)) {
  install.packages('ggpubr')
}
if(!require (patchwork)) {
  install.packages('patchwork')
}
if(!require (Cairo)) {
  install.packages('Cairo')
}

# Using this syntax, we first look to see if
# the package has already been installed, and
# we only install it if it hasn't already
# been installed.


# Load Packages

require (ggplot2)
require (ggpubr)
require (patchwork)
require (Cairo)


# Let's Create Some Plots

# A Blank Plot

ggplot(data = mtcars, aes(x = mpg, y = disp, color = as.factor(gear)))


# Add Points

ggplot(data = mtcars, aes(x = mpg, y = disp, color = as.factor(gear))) +
  geom_point()


# Change the Color of the Points and the Legend Text

ggplot(data = mtcars, aes(x = mpg, y = disp, color = as.factor(gear))) +
  geom_point() +
  scale_color_manual(values = c("blue", "green", "grey"), labels = c("Three", "Four", "Five")) +
  labs(color = "Number of Gears")


# Add Some Smoothing Lines

ggplot(data = mtcars, aes(x = mpg, y = disp, color = as.factor(gear))) +
  geom_point() +
  scale_color_manual(values = c("blue", "green", "grey"), labels = c("Three", "Four", "Five")) +
  labs(color = "Number of Gears") +
  geom_smooth()


# Get Rid of the Default Gray Background

ggplot(data = mtcars, aes(x = mpg, y = disp, color = as.factor(gear))) +
  geom_point() +
  scale_color_manual(values = c("blue", "green", "grey"), labels = c("Three", "Four", "Five")) +
  labs(color = "Number of Gears") +
  geom_smooth() +
  theme_classic()


# Change the Axis Labels and the Plot Title

ggplot(data = mtcars, aes(x = mpg, y = disp, color = as.factor(gear))) +
  geom_point() +
  scale_color_manual(values = c("blue", "green", "grey"), labels = c("Three", "Four", "Five")) +
  labs(color = "Number of Gears") +
  geom_smooth() +
  theme_classic() +
  labs(x = "Miles per Gallon", y = "Displacement", title = "Plot Title")


# Center the Plot Title

ggplot(data = mtcars, aes(x = mpg, y = disp, color = as.factor(gear))) +
  geom_point() +
  scale_color_manual(values = c("blue", "green", "grey"), labels = c("Three", "Four", "Five")) +
  labs(color = "Number of Gears") +
  geom_smooth() +
  theme_classic() +
  labs(x = "Miles per Gallon", y = "Displacement", title = "Plot Title") +
  theme(plot.title = element_text(hjust = 0.5))


# Create Separate Plots by Another Factor

ggplot(data = mtcars, aes(x = mpg, y = disp, color = as.factor(gear))) +
  geom_point() +
  scale_color_manual(values = c("blue", "green", "grey"), labels = c("Three", "Four", "Five")) +
  labs(color = "Number of Gears") +
  geom_smooth() +
  theme_classic() +
  labs(x = "Miles per Gallon", y = "Displacement", title = "Plot Title") +
  theme(plot.title = element_text(hjust = 0.5)) +
  facet_wrap(~am)


# Rescale an Axis

ggplot(data = mtcars, aes(x = mpg, y = disp, color = as.factor(gear))) +
  geom_point() +
  scale_color_manual(values = c("blue", "green", "grey"), labels = c("Three", "Four", "Five")) +
  labs(color = "Number of Gears") +
  geom_smooth() +
  theme_classic() +
  labs(x = "Miles per Gallon", y = "Displacement", title = "Plot Title") +
  theme(plot.title = element_text(hjust = 0.5)) +
  facet_wrap(~am) +
  scale_x_continuous(breaks = seq(10, 40, 10))


# Save the Plot as an Object

# You can't save 'base' plots as objects, but
# you can save 'ggplot2' plots as objects

plot1 <- ggplot(data = mtcars, aes(x = mpg, y = disp, color = as.factor(gear))) +
  geom_point() +
  scale_color_manual(values = c("blue", "green", "grey"), labels = c("Three", "Four", "Five")) +
  labs(color = "Number of Gears") +
  geom_smooth() +
  theme_classic() +
  labs(x = "Miles per Gallon", y = "Displacement", title = "Plot Title") +
  theme(plot.title = element_text(hjust = 0.5)) +
  facet_wrap(~am) +
  scale_x_continuous(breaks = seq(10, 40, 10))
plot1


# Create Another Plot

# Our first example was a scatterplot. Now,
# let's create a boxplot.

# We'll use the 'stat_compare_means()' function
# from the 'ggbubr' package to perform t tests
# to compare the two levels of the 'am' factor
# (automatic and manual transmissions) for each
# number of cylinders separately.

plot2 <- ggplot(data = mtcars, aes(x = as.factor(cyl), y = mpg, fill = as.factor(am))) +
  geom_boxplot() +
  labs(x = "Number of Cylinders", y = "Miles per Gallon", title = "Comparing the Gas Mileage of Cars\nWith Automatic and Manual Transmissions\nfor Engines With Different Numbers of Cylinders Separately", fill = "Manual or Automatic\nTransmission") +
  scale_fill_manual(values = c('red', 'green'), labels = c("Automatic", "Manual")) +
  stat_compare_means(aes(group = am), label = 'p.signif', method = 't.test', na.rm = F, label.y = 33)
plot2


# Use the 'patchwork' Package to Easily
# Arrange Our Plots on the Same Figure

final_plot <- plot1 / plot2
final_plot


# Use the 'Cairo' Package to Save Our Plot

Cairo(width = 10, height = 10, file = "Example_Graph.png", type = "png", bg = 'transparent', dpi = 400, units = 'cm')
final_plot
dev.off()


# Final Notes

# With 'ggplot2', you can arrange your code line-by-
# line, adding new elements on each line. Thus, it's
# really easy to comment out an element and see how
# your plot changes.

# Unlike 'base' plots, which add elements to an
# existing plot each time you run a new line of code,
# 'ggplot2' plots recreate the entire plot each time
# you run the chunk of code containing all the plot
# elements.
