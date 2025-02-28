# BigQuery Analysis Project

## 📌 Overview

This project utilizes Google BigQuery to analyze datasets from **public BigQuery databases**. The queries focus on:

- **Education spending** across different countries 📚
- **Taxi trip analysis** in Chicago 🚖
- **Stack Overflow trends**, including top answerers and fastest-growing programming languages 💻

## 📂 Project Structure

- **`run_queries.ipynb`** → Jupyter Notebook to run the queries with SQL queries and results.
- **`queries.py`** → Python script with a for loop for displaying SQL queries in a Jupyter Notebook.
- **`queries.sql`** → SQL file containing all the queries.
- **`README.md`** → Documentation for the project.

## 🚀 How to Run

### 1️⃣ **Set up Google Cloud Authentication**

Ensure you have Google Cloud SDK installed and authenticated:

```bash
 gcloud auth application-default login
```

### 2️⃣ **Install dependencies**

```bash
pip install pandas google-cloud-bigquery
```

### 3️⃣ **Run the script**

Open Jupyter Notebook and run **`run_queries.ipynb`** to execute the queries interactively.

## 📊 Queries Overview

### **1️⃣ Countries Spending the Most on Education**

Analyzes education spending as a percentage of GDP from the **World Bank dataset**.

### **2️⃣ Busiest Taxi Pickup Locations in Chicago**

Finds the most frequent pickup locations using the **Chicago Taxi Trips dataset**.

### **3️⃣ Average Taxi Speed Per Hour**

Calculates average speed of taxis for different hours of the day.

### **4️⃣ Top Stack Overflow Answerers for BigQuery**

Finds users who have answered the most questions tagged `bigquery`.

### **5️⃣ Fastest-Growing Programming Languages**

Analyzes the **growth trends** of programming languages based on Stack Overflow questions.

## 🔗 References

- [Google BigQuery Public Datasets](https://console.cloud.google.com/marketplace/browse?filter=solution-type\:dataset)
- [Google Cloud BigQuery Documentation](https://cloud.google.com/bigquery/docs)

📩 **Feel free to contribute or suggest improvements!**

