#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
###################################### R ######################################
# Create function for running mean:
running_mean <- function(x, y, h) {
    # Arrange the data from lowest x_i to sample max
    dat <- dplyr::arrange(data.frame(x = x, y = y), x)
    x_sorted <- dat$x
    running_means <- numeric(nrow(dat))
    # For each x_i, calculate the mean y value within the window (+- h)
    for (i in 1:nrow(dat)) {
        running_mean <- mean(dat[abs(dat$x - x_sorted[i]) <= h, "y"])
        running_means[i] <- running_mean
    }
    return(running_means)
}

# Test the function with dummy data
set.seed(42)
n <- 250
h <- 10
x <- seq(0, 100, length.out = n)
y <- 10 + 2.5 * x + rnorm(n, 0, 55) # simulate a regression model
r_means <- running_mean(x, y, h)
dat <- data.frame(x = x, y = y, r_means = r_means)

# Build the plot
r_means_example <- ggplot2::ggplot(dat) +
    ggplot2::geom_point(ggplot2::aes(x = x, y = y), col = "skyblue", size = 1) +
    ggplot2::geom_line(
        ggplot2::aes(x = x, y = r_means),
        col = "firebrick", lty = 2
    ) +
    ggplot2::labs(x = "X", y = "Y", title = "Running Means Example") +
    ggplot2::theme_bw() +
    ggplot2::theme(
        text = ggplot2::element_text(family = "serif"),
        plot.title = ggplot2::element_text(hjust = .5, face = "bold")
    )
###############################################################################
#
#
#
#
#
###################################### R ######################################
r_means_example
###############################################################################
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
