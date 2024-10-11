#
#
#
#
#
#
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
treatment <- c(0, 0, 0, 1, 1, 1)
disease_severity <- c(0, 1, 2, 0, 1, 2)
y <- c(51, 67, 42, 143, 97, 40)
n <- c(200, 158, 89, 315, 263, 75)
df <- data.frame(Y = y, N = n, Treatment = treatment, DiseaseSeverity = disease_severity)

# Print the df
pander::pander(df)
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
###################################### R ######################################
# Specify data
treatment <- c(0, 0, 0, 1, 1, 1)
disease_severity <- c(0, 1, 2, 0, 1, 2)
y <- c(51, 67, 42, 143, 97, 40)
n <- c(200, 158, 89, 315, 263, 75)
# Combine into a dataframe
hospitalizations <- data.frame(
    Y = y, N = n, Treatment = treatment, DiseaseSeverity = disease_severity
)

# Fit the model
model_1_fit <- glm(
    cbind(Y, N - Y) ~ Treatment,
    family = binomial(link = "logit"),
    data = hospitalizations
)
###############################################################################
#
#
#
#
#
###################################### R ######################################
summary(model_1_fit)
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
###################################### R ######################################
# Fit the model
model_2_fit <- glm(
    cbind(Y, N - Y) ~ DiseaseSeverity,
    family = binomial(link = "logit"),
    data = hospitalizations
)
###############################################################################
#
#
#
#
#
###################################### R ######################################
summary(model_2_fit)
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
###################################### R ######################################
# Fit the model
model_3_fit <- glm(
    cbind(Y, N - Y) ~ Treatment * DiseaseSeverity,
    family = binomial(link = "logit"),
    data = hospitalizations
)
###############################################################################
#
#
#
#
#
###################################### R ######################################
summary(model_3_fit)
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
###################################### R ######################################
# Extract variance-covariance matrix
var_cov <- summary(model_3_fit)$cov.unscaled

# Specify L
l <- t(c(0, -1, -1, -2))

# Estimate variance and standard error
or_var <- l %*% var_cov %*% t(l)
or_stderr <- sqrt(or_var)

# Print standard error
print(
    paste0("Standard Error = ", round(or_stderr, 3))
)
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
###################################### R ######################################
treatment <- c(
    "Control", "Control", "Control", "Treatment", "Treatment", "Treatment"
)
force <- c(40, 150, 350, 40, 150, 350)
y <- c(55, 52, 57, 55, 50, 50)
n <- c(102, 99, 108, 76, 81, 90)
df <- data.frame(Y = y, N = n, NewStorage = treatment, Force = force)
pander::pander(df)
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
###################################### R ######################################
# Specify data
treatment <- c(
    0, 0, 0, 1, 1, 1
)
force <- c(40, 150, 350, 40, 150, 350)
y <- c(55, 52, 57, 55, 50, 50)
n <- c(102, 99, 108, 76, 81, 90)
embryogenic <- data.frame(y = y, n = n, newstor = treatment, force = force)

# Fit model
model_1_fit <- glm(
    cbind(y, n - y) ~ newstor,
    family = binomial(link = "logit"),
    data = embryogenic
)
###############################################################################
#
#
#
#
#
###################################### R ######################################
summary(model_1_fit)
###############################################################################
#
#
#
#
#
#
#
#
###################################### R ######################################
# Fit model
model_2_fit <- glm(
    cbind(y, n - y) ~ newstor * force,
    family = binomial(link = "logit"),
    data = embryogenic
)
###############################################################################
#
#
#
#
###################################### R ######################################
summary(model_2_fit)
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
###################################### R ######################################
# Ungroup the data
newstor_2 <- c(
    rep(0, sum(n[1:3])),
    rep(1, sum(n[4:6]))
)
force_2 <- c(
    rep(40, n[1]),
    rep(150, n[2]),
    rep(350, n[3]),
    rep(40, n[4]),
    rep(150, n[5]),
    rep(350, n[6])
)
y_2 <- c(
    rep(1, y[1]),
    rep(0, n[1] - y[1]),
    rep(1, y[2]),
    rep(0, n[2] - y[2]),
    rep(1, y[3]),
    rep(0, n[3] - y[3]),
    rep(1, y[4]),
    rep(0, n[4] - y[4]),
    rep(1, y[5]),
    rep(0, n[5] - y[5]),
    rep(1, y[6]),
    rep(0, n[6] - y[6])
)
embryogenic_ungrouped <- data.frame(
    y = y_2, newstor = newstor_2, force = force_2
)


# Fit model
model_1_fit <- glm(
    y ~ newstor,
    family = binomial(link = "logit"),
    data = embryogenic_ungrouped
)
###############################################################################
#
#
#
#
###################################### R ######################################
summary(model_1_fit)
###############################################################################
#
#
#
#
#
#
#
#
###################################### R ######################################
# Fit model
model_2_fit <- glm(
    y ~ newstor * force,
    family = binomial(link = "logit"),
    data = embryogenic_ungrouped
)
###############################################################################
#
#
#
#
###################################### R ######################################
summary(model_2_fit)
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
###################################### R ######################################
# Fit models to make sure we're doing the correct test
model_1_fit <- glm(
    cbind(y, n - y) ~ newstor,
    family = binomial(link = "logit"),
    data = embryogenic
)
model_2_fit <- glm(
    cbind(y, n - y) ~ newstor * force,
    family = binomial(link = "logit"),
    data = embryogenic
)

# Calculate the p-value for the Hosmer-Lemeshow test
t1 <- ResourceSelection::hoslem.test(
    model_1_fit$y, model_1_fit$fitted.values,
    g = 3
)
t2 <- ResourceSelection::hoslem.test(
    model_2_fit$y, model_2_fit$fitted.values,
    g = 3
)
###############################################################################
#
#
#
#
#
#
#
###################################### R ######################################
# Run LRT test
deviance_1 <- model_1_fit$deviance
deviance_2 <- model_2_fit$deviance
delta <- deviance_1 - deviance_2
q <- 2
p <- 4
pval <- 1 - pchisq(delta, p - q)
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
###################################### R ######################################
# Fit models to make sure we're doing the correct test
model_1_fit <- glm(
    y ~ newstor,
    family = binomial(link = "logit"),
    data = embryogenic_ungrouped
)
model_2_fit <- glm(
    y ~ newstor * force,
    family = binomial(link = "logit"),
    data = embryogenic_ungrouped
)

# Calculate the p-value for the Hosmer-Lemeshow test
t1 <- ResourceSelection::hoslem.test(
    model_1_fit$y, model_1_fit$fitted.values,
    g = 3
)
t2 <- ResourceSelection::hoslem.test(
    model_2_fit$y, model_2_fit$fitted.values,
    g = 3
)
###############################################################################
#
#
#
#
#
#
#
###################################### R ######################################
# Run LRT test
deviance_1 <- model_1_fit$deviance
deviance_2 <- model_2_fit$deviance
delta <- deviance_1 - deviance_2
q <- 2
p <- 4
pval <- 1 - pchisq(delta, p - q)
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
