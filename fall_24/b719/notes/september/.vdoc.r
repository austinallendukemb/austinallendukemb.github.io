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
# Count of cyclones distributed as Y_i \sim POI(\theta)
season <- 1:13
cyclone_count <- c(6, 5, 4, 6, 6, 3, 12, 7, 4, 2, 6, 7, 4)

# Function to find U and dU of Poisson distribution
poisson_function <- function(y, theta) {
    # y: vector of sample values
    # theta: arbitrary value of theta for log-liklihood input
    n <- length(y)
    u <- sum(y) * (1 / theta) - n
    du <- -sum(y) * (1 / theta^2)
    return(list(u = u, du = du))
}

theta0 <- 3.5
tmp.iter <- NULL
for (i in 1:10) {
    one <- poisson_function(cyclone_count, theta0)
    tmp.iter <- rbind(tmp.iter, c(theta   = theta0, u = one$u, du = one$du))
    theta0 <- theta0 - one$u   / one$du
}

# Function to find MLE through the Newton-Raphson algorithm
newton_raphson_algorithm <- function(f, y, theta_0) {
    # f: function returning u and du of given PDF
    # y: vector of sample values
    # theta_0: initial value for theta

    # Set theta_m for algorithm
    theta_m <- theta_0 + 1
    # Set return matrix to null
    return_matrix <- NULL
    # Set counter to protect against endless looping
    loop_counter <- 0
    while (theta_m - theta_0 > 0.0000001 & loop_counter < 1000) {
        if (loop_counter > 0) {
            theta_0 <- theta_m
        }
        function_list <- f(y, theta_0)
        u <- function_list$u
        du <- function_list$du
        return_matrix <- rbind(
            return_matrix, c(theta = theta_0, u = u, du = du)
        )
        theta_m <- theta_0 - u / du
        loop_counter <- loop_counter + 1
    }

    # Return the matrix
    return(return_matrix)
}

# Let's test it out!
my_matrix <- newton_raphson_algorithm(
    poisson_function, cyclone_count, 3.5
)
print(paste("The mean of the Cyclone Counts is", mean(cyclone_count)))
print("Matrix of Algorithm Iterations:")
print(my_matrix)
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
