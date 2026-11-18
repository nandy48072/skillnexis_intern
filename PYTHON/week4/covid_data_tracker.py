import pandas as pd
import matplotlib.pyplot as plt
import os

class CovidDataTracker:
    """
    A class to load COVID-19 data, analyze top countries by total cases, 
    and plot visual bar charts using Pandas and Matplotlib.
    """
    def __init__(self, file_path: str):
        self.file_path = file_path
        self.df = None

    def load_data(self):
        """Loads the COVID-19 CSV dataset into a Pandas DataFrame."""
        if not os.path.exists(self.file_path):
            raise FileNotFoundError(
                f"The file '{self.file_path}' was not found. "
                "Please download the dataset and place it in this folder."
            )
        
        print("Loading dataset (this may take a moment due to file size)...")
        self.df = pd.read_csv(self.file_path)
        print(f"Successfully loaded {len(self.df):,} rows of data.\n")

    def get_top_countries(self, n: int = 5) -> pd.Series:
        """Finds the top N countries with the highest total COVID-19 cases."""
        if self.df is None:
            print("Dataset not loaded.")
            return pd.Series()

        print(f"--- Top {n} Countries by Total Cases ---")
        
        # The Our World in Data dataset contains daily records per country.
        # We group by 'location' and take the maximum recorded 'total_cases' for each country.
        if 'location' in self.df.columns and 'total_cases' in self.df.columns:
            top_countries = (
                self.df.groupby('location')['total_cases']
                .max()
                .nlargest(n)
            )
            
            for country, cases in top_countries.items():
                print(f"• {country}: {cases:,.0f} cases")
            print("-" * 40 + "\n")
            return top_countries
        else:
            print("Required columns ('location' or 'total_cases') not found in dataset.")
            return pd.Series()

    def plot_bar_chart(self, top_countries: pd.Series):
        """Plots a bar chart using Matplotlib for the top countries."""
        if top_countries.empty:
            print("No data available to plot.")
            return

        plt.figure(figsize=(10, 6))
        
        # Create a bar chart
        bars = plt.bar(
            top_countries.index, 
            top_countries.values / 1e6,  # Convert to millions for easier readability
            color='#3498db', 
            edgecolor='#2980b9'
        )

        # Add titles and labels
        plt.title('Top 5 Countries by Total COVID-19 Cases', fontsize=14, fontweight='bold', pad=15)
        plt.xlabel('Country', fontsize=12, labelpad=10)
        plt.ylabel('Total Cases (in Millions)', fontsize=12, labelpad=10)
        
        # Add values on top of the bars
        for bar in bars:
            height = bar.get_height()
            plt.text(
                bar.get_x() + bar.get_width() / 2., 
                height + 0.5, 
                f'{height:.1f}M', 
                ha='center', 
                va='bottom', 
                fontsize=10
            )

        plt.grid(axis='y', linestyle='--', alpha=0.7)
        plt.tight_layout()
        
        print("Generating and displaying the bar chart window...")
        plt.show()


# ==========================================
# Example Execution
# ==========================================
if __name__ == "__main__":
    # Name of the CSV file once downloaded
    CSV_FILE_PATH = "owid-covid-data.csv"

    try:
        tracker = CovidDataTracker(CSV_FILE_PATH)
        
        # 1. Load data using Pandas
        tracker.load_data()
        
        # 2. Display top 5 countries by total cases
        top_5 = tracker.get_top_countries(n=5)
        
        # 3. Plot bar chart using Matplotlib
        tracker.plot_bar_cht = tracker.plot_bar_chart(top_5)
        
    except Exception as e:
        print(f"An error occurred: {e}")