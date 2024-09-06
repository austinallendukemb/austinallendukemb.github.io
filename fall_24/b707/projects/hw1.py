"""This is the Python code for my first HW assignment."""

import pandas as pd

# Import data
data_url = "https://causeweb.org/tshs/datasets/Surgery%20Timing.xlsx"
surgery_dataset = pd.read_excel(data_url)

# Specify variables for table 1
baseline_vars = [
    "age",
    "gender",
    "race",
    "asa_status",
    "bmi",
    "baseline_cancer",
    "baseline_cvd",
    "baseline_dementia",
    "baseline_diabetes",
    "baseline_osteoart",
    "baseline_psych",
    "baseline_pulmonary",
    "baseline_charlson",
    "mortality_rsi",
    "complication_rsi",
]

continuous_vars = [
    "age",
    "bmi",
    "baseline_charlson",
    "mortality_rsi",
    "complication_rsi",
]
categorical_vars = [
    "gender",
    "race",
    "asa_status",
    "baseline_cancer",
    "baseline_cvd",
    "baseline_dementia",
    "baseline_diabetes",
    "baseline_osteoart",
    "baseline_psych",
    "baseline_pulmonary",
]

# Create the first table
summary_table = pd.DataFrame(["Factor", "Statistic"])

# Summary for continuous variables
continuous_summary = (
    surgery_dataset[continuous_vars].agg(["mean", "std"]).transpose()
)
continuous_summary = continuous_summary.rename(
    columns={"mean": "Mean", "std": "Std. Dev"}
)


# Summary for categorical variables
all_cat_summaries: dict[str, dict[str, list[any]]] = {}

for var in categorical_vars:
    counts = surgery_dataset[var].value_counts()
    percentages = surgery_dataset[var].value_counts(normalize=True) * 100
    cat_summary = {
        "Level": counts.index,
        "Count": counts.values,
        "Percentage": percentages.values,
    }
    all_cat_summaries[var] = cat_summary

table_index = 0
# Create a new table with formatted values
for var in baseline_vars:
    if var in continuous_vars:
        # If continuous, add the mean and std deviation as summary stats
        var_mean = round(continuous_summary.loc[var].iloc[0], 2)
        var_std_dev = round(continuous_summary.loc[var].iloc[0], 3)
        summary_table.iloc[table_index] = [var, f"{var_mean} +- {var_std_dev}"]
        table_index += 1
    elif var in categorical_vars:
        # If categorical, add the count and percentage for each level as
        # summary stats
        var_info = all_cat_summaries[var]
        var_levels = var_info["Level"]
        var_counts = var_info["Count"]
        var_percents = var_info["Percentage"]
        summary_table.iloc[table_index] = [var, ""]
        table_index += 1
        # Iterate over each level
        for i in range(len(var_levels)):
            level = var_levels[i]
            lvl_count = var_counts[i]
            lvl_pct = var_percents[i]
            summary_table.iloc[table_index] = [
                f" {level}",
                f"{lvl_count} ({round(lvl_pct, 1)})",
            ]
            table_index += 1
    else:
        raise Exception(f"Variable {var} was not included\n")

if __name__ == "__main__":
    print(summary_table)
