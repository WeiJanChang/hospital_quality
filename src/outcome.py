import pandas as pd
import matplotlib.pyplot as plt

def best_hospitals(df:pd.DataFrame, state:str, disease: str):
    """
    Finding the best hospital in a state based on lowest 30-day mortality in one of "heart attack”, “heart failure”, or “pneumonia”
    :param df: df
    :param state: state
    :param disease: Heart Failure, Pneumonia, or Heart Attack
    :return:
    """
    mortality_cols = [
        "Hospital 30-Day Death (Mortality) Rates from Heart Failure",
        "Hospital 30-Day Death (Mortality) Rates from Pneumonia",
        "Hospital 30-Day Death (Mortality) Rates from Heart Attack"]

    best_hospital = df.groupby(["State", "Hospital Name"])[mortality_cols].agg(min).reset_index()
    # reset index for a df. not aMultiIndex DataFrame.
    # use .agg can take more action, such as .agg(['min', 'max', 'mean'])

    # Create the figure and axis
    best_hospital = best_hospital[best_hospital['State'] == state]
    if disease in ['Heart Attack','Heart Failure',' Pneumonia']:
        fig, ax = plt.subplots(figsize=(10, 6))  # Adjust size for better visibility
        ax.bar(best_hospital["Hospital Name"], best_hospital[f"Hospital 30-Day Death (Mortality) Rates from {disease}"])
        ax.set_ylabel('Mortality Rate')
        ax.set_title(f'Mortality of {disease} in each Hospital')
        plt.show()
    else:
        print('Please enter Heart Attack, Heart Failure or Pneumonia')

