# Week 1 Data Engineering Assignment - by Shaik Faizan Ahmed

## Summary

In this assignment, I worked with an Shopping dataset using Python and Pandas. The primary goal of this task was to understand how to work with data, which included loading the data, exploring the data, cleaning it, and carrying out some simple operations on the data.

### Question 1: Load a CSV Dataset into a Pandas DataFrame

In order to accomplish this, I first imported the CSV file into a Pandas DataFrame by using the function `read_csv()`. Once the file had been imported into the Pandas DataFrame successfully, I then viewed a few samples of this data to ensure that it had been imported successfully.

---

### Question 2: Explore the Dataset

In this step, I explored the dataset using functions such as `head()`, `tail()`, `shape`, `columns`, `dtypes`, and `info()`.

From my analysis, I have seen that the number of rows is 1000 while the number of columns is 24. Another observation was made during the analysis and that was the presence of data related to the products in the dataset such as title, category, rating, price, sellers, offers, and specs.

---

### Question 3: Handle Missing Values

After exploring the dataset, I checked for missing values using `isnull().sum()`.

I found missing values in the following columns:

* discount
* what_customers_said
* seller_name
* videos
* seller_information
* variations

Rather than deleting rows, the missing values were handled using appropriate assumptions. The discount column was substituted with zero, the review column was substituted with “No Reviews”, the seller column was substituted with “Unknown”, the video column was substituted with “No Video”, the seller details column was substituted with “Not Available”, and the variations column was substituted with “No Variations”.

After these substitutions, there were no missing values in the dataset.

---

### Question 4: Perform Basic Operations

In the first place, I have selected important columns like title, category, rating, number of ratings, price, and discount for analysis.

Later, I have filtered the data where the rating is greater than or equal to 4.5. Further, I have filtered data where there is discount more than 0%.

The results obtained were:

* Highly rated products: 165
* Discounted products: 879
* Highly rated and discounted products: 143

These operations helped in identifying products that are both popular and available at discounted prices.

---

### Question 5: Remove Duplicates

To ensure data quality, I checked the dataset for duplicate records using the `duplicated()` function.

Later, I applied the duplicate removal operation using `drop_duplicates()`. However, the dataset did not contain any duplicate entries in the first place. As a result, no rows were removed and the dataset size remained unchanged after the operation.

This confirmed that the dataset was already free from duplicate records.

---

### Question 6: Create a Derived Column

The assignment required creating a derived column using the formula:

`total_amount = price × quantity`

Since the dataset did not contain direct price and quantity columns, I derived them from the available data.

I created a new `price` column by extracting the numeric value from the `final_price` column and removing the currency symbols. I then created a `quantity` column using the number of size options available in the `sizes` column.

Using these two derived columns, I created a new column called `total_amount`.

This step demonstrated how new features can be generated from existing data for further analysis.

---

### Question 7: Save the Cleaned Dataset

After completing all cleaning and transformation tasks, I exported the final dataset into a new CSV file named `cleaned_dataset_Faizan.csv`.

The exported file contains all original columns along with the newly created columns:

* price
* quantity
* total_amount

This cleaned dataset can now be used for further analysis and processing.

---

## Conclusion

Through this assignment, I learned how to work with datasets using Pandas. I gained practical experience in loading data, exploring dataset structures, handling missing values, filtering records, checking data quality, creating derived features, and exporting cleaned data. These are some of the fundamental steps involved in data preprocessing and data engineering workflows.
