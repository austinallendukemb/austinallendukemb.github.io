#
#
#
#
#
###################################### R ######################################
library(tidyverse)
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
yi <- c(2, 3, 6, 7, 8, 9, 10, 12, 15)
xi <- c(-1, -1, 0, 0, 0, 0, 1, 1, 1)
pander::pander(t(data.frame(yi = yi, xi = xi)))
###############################################################################
#
#
#
#
#
###################################### R ######################################
# Set the data
yi <- c(2, 3, 6, 7, 8, 9, 10, 12, 15)
xi <- c(-1, -1, 0, 0, 0, 0, 1, 1, 1)

# Fit the model 
poisson_model <- glm(yi ~ xi, family = poisson(link = "log"))

# Print the model and point estimates 
table_title <- "Model: E(Y) = beta0 + beta1 X"
b_0 <- round(poisson_model$coefficients[1], 3)
b_1 <- round(poisson_model$coefficients[2], 3)
model_table <- gt::gt(
    data.frame(Parameter = c("beta0", "beta1"), Estimate = c(b_0, b_1))
)  %>% 
    gt::tab_header(title = table_title)
print(model_table)
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
####################################### R #####################################
# Define function to find w_ii 
w <- function(y_i, x_i, b_0, b_1) {
    return(exp((b_0 + b_1*x_i)))
}
# Define function to find z_i 
z <- function(y_i, x_i, b_0, b_1) {
    return(b_0 + b_1*x_i + y_i/(exp(b_0 + b_1*x_i)) - 1)

}

# Define function to estimate b_0 and b_1 
mle_estimation <- function(y_i, x_i, w, z, b_0_init, b_1_init, n_iterations) {
    # y_i: vector of outcome variable 
    # x_i: vector of 1 predictor (how could we generalize this?)
    # w: function to find w_ii from y_i, x_i, b_0, and b_1 
    # z: function to find z_i from y_i, x_i, b_0, and b_1 
    # b_0_init: initial value for b_0 estimate used in first iteration 
    # b_1_init: initial value for b_1 estimate used in first iteration 
    # n_iterations: number of cycles to run (could it be more useful to use 
    # while loop instead of for loop?)

    # Define vector of estimates 
    b <- c(b_0_init, b_1_init)

    # Define matrix to be returned 
    stored_estimates <- matrix(numeric(n_iterations*2), ncol = 2)

    # Perform IRWLS procedure to estimate the MLEs for \beta_0 and \beta_1
    for (i in 1:n_iterations) {
        b_0 <- b[1]
        b_1 <- b[2]
        x_matrix <- cbind(rep(1, length(x_i)), x_i)
        # Find w_ii and z_i 
        w_ii <- w(y_i, x_i, b_0, b_1)
        z_i  <- z(y_i, x_i, b_0, b_1)
        # For readability, think of (X^T W X)^-1 as matrix_a and (X^T W z) as 
        # matrix_b
        matrix_a <- solve(t(x_matrix) %*% diag(w_ii) %*% x_matrix)
        matrix_b <- t(x_matrix) %*% diag(w_ii) %*% z_i
        b <- matrix_a %*% matrix_b 
        stored_estimates[i, ] <- b
    }
    return(stored_estimates)
}

# Record data for analysis 
y_i <-  c(2, 3, 6, 7, 8, 9, 10, 12, 15)
x_i <- c(-1, -1, 0, 0, 0, 0, 1, 1, 1)

# Set initial values for b_0 and b_1 
b_0_init <- 5
b_1_init <- 7 

# Use IRWLS to estimate b_0 and b_1 
b <- mle_estimation(y_i, x_i, w, z, b_0_init, b_1_init, 15)

# Print results in a pretty table 
b_table <- as.data.frame(b)  %>% 
    mutate(
        Iteration = 1:15,
        Beta0 = V1,
        Beta1 = V2
    )  %>% 
    select(Iteration, Beta0, Beta1)  %>% 
    gt::gt()  %>% 
    gt::tab_header(
        title = "Results: Estimates for Beta0 and Beta1 in IRWLS Procedure"
    )
print(b_table)
###############################################################################
#
#
#
#
#
#
#
###################################### R ######################################
# Recall that I = X^T W X 

# Set parameters and calculate w_ii 
b_0 <- 1.889272
b_1 <- 0.6697856 
x_matrix <- cbind(rep(1, 9), x_i)
w_ii <- w(y_i, x_i, b_0, b_1)
 
# Calculate I 
i <- t(x_matrix) %*% diag(w_ii) %*% x_matrix 
# Calculate variance-covariance matrix 
var_cov_matrix <- solve(i)
rownames(var_cov_matrix) <- c("Beta0", "Beta1")
colnames(var_cov_matrix) <- c("Beta0", "Beta1")
var_cov_df <- as.data.frame(var_cov_matrix)  %>% 
    tibble::rownames_to_column(var = "Parameter")

# Print table 
var_cov_table <- var_cov_df  %>% 
    gt::gt()  %>% 
    gt::tab_header(title = "Variance-Covariance Matrix")
print(var_cov_table)
###############################################################################
#
#
#
#
#
#
#
###################################### R ######################################
# Create a table for the var_cov_matrix
model_var_cov_matrix <- summary(poisson_model)$cov.unscaled
rownames(model_var_cov_matrix) <- c("Beta0", "Beta1")
colnames(model_var_cov_matrix) <- c("Beta0", "Beta1")
model_var_cov_df <- as.data.frame(model_var_cov_matrix)  %>% 
    tibble::rownames_to_column(var = "Parameter") 
model_var_cov_table <- model_var_cov_df  %>% 
    gt::gt()  %>% 
    gt::tab_header(title = "Variance-Covariance Matrix")
# Print both tables 
print(model_table)
print(model_var_cov_table)
###############################################################################
#
#
#
#
#
#
