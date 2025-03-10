import pandas as pd
import matplotlib.pyplot as plt


def best_hospitals(df: pd.DataFrame, state: str, disease: str, rank: int = 3):
    """
    Find the best hospital in a state based on lowest 30-day mortality in one of heart attack, heart failure, or pneumonia
    :param df: dataframe containing hospital data
    :param state: state abbreviation ( e.g., 'NY', 'CA')
    :param disease: One of Heart Failure, Pneumonia, or Heart Attack
    :param rank: top rank sorted by mortality, by default: top 3
    :return: None (Display a bar chart of mortality rate
    """
    # dictionary mapping disease names to column names
    mortality_cols = {
        "Heart Failure": "Hospital 30-Day Death (Mortality) Rates from Heart Failure",
        "Pneumonia": "Hospital 30-Day Death (Mortality) Rates from Pneumonia",
        "Heart Attack": "Hospital 30-Day Death (Mortality) Rates from Heart Attack"}
    # check if the provided disease is valid
    if disease not in mortality_cols:
        print('Please enter a valid disease: "Heart Failure", "Pneumonia", "Heart Attack".')
        return
    # Select the relevant mortality column
    mortality_col = mortality_cols[disease]
    state_hospitals = df[df['State'] == state]

    # Drop rows with missing mortality values
    state_hospitals = state_hospitals.dropna(subset=[mortality_col])

    if state_hospitals.empty:
        print(f"No mortality data available for {disease} in {state}")
        print(f"Please enter a valid State: {df['State'].unique()}")
        return

    min_mortality = state_hospitals[mortality_col].min()
    best_hospital = state_hospitals[state_hospitals[mortality_col] == min_mortality]

    # best_hospital = df.groupby(["State", "Hospital Name"])[mortality_cols].agg(min).reset_index()
    # reset index for a df. not aMultiIndex DataFrame.
    # use .agg can take more action, such as .agg(['min', 'max', 'mean'])

    # Sort hospitals by mortality rate for better visualization
    sorted_hospitals = state_hospitals.sort_values(by=mortality_col, ascending=True)
    sorted_hospitals = sorted_hospitals[0:rank]
    # todo: remove data is Not Available

    # Create the figure and axis

    fig, ax = plt.subplots(figsize=(10, 6))  # Adjust size for better visibility

    ax.barh(sorted_hospitals["Hospital Name"], sorted_hospitals[mortality_col], color='skyblue')
    # horizontal bar chart (barh) for better readability.
    ax.set_xlabel('Mortality Rate (%)')
    ax.set_ylabel('Hospital Name')
    ax.set_title(f'30-Day Mortality Rate for {disease} in {state}')

    # Improve readability
    ax.grid(axis='x', linestyle='--', alpha=0.6)
    plt.xticks(rotation=45, ha='right')  # Handles x-axis label rotation to prevent overlap.
    plt.tight_layout()

    print(f"Best hospital(s) in {state} for {disease}:")
    print(best_hospital[['Hospital Name', mortality_col]])
    plt.show()


if __name__ == '__main__':
    df = pd.read_csv('~/code/hospital_quality/test_file/outcome-of-care-measures.csv')
    best_hospitals(df, state='DC', disease='Heart Attack')
