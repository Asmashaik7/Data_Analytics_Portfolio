# Weather Forecast Analysis using OpenWeather API

## 📌 Project Overview
This project analyzes weather forecast data for a selected city using the OpenWeather API.  
The raw forecast data is available at 3-hour intervals, which is processed and aggregated to derive meaningful **daily minimum and maximum temperature insights**.

The goal of this project is to demonstrate:
- Working with authenticated APIs
- JSON data extraction
- Data transformation using Python and Pandas
- Aggregation of time-series data for analysis

---

## 🎯 Objective
- Fetch weather forecast data using a public API  
- Extract temperature information from nested JSON responses  
- Aggregate 3-hour interval data to daily-level metrics  
- Identify daily minimum and maximum temperatures  

---

## 🗂️ Data Source
- **API**: OpenWeather Forecast API  
- **City**: Hyderabad, India  
- **Data Type**: 3-hour interval weather forecast  

---

## 🛠️ Tools & Libraries Used
- Python  
- Requests  
- Pandas  
- Datetime  
- OpenWeather API  

---

## 🔄 Workflow
1. Authenticate and fetch weather data using the OpenWeather API  
2. Parse nested JSON response  
3. Extract date-wise minimum and maximum temperatures  
4. Convert extracted data into a Pandas DataFrame  
5. Aggregate 3-hour interval data to daily-level temperature metrics  
6. Perform basic validation and analysis  

---

## 📊 Key Analysis Performed
- Conversion of Unix timestamps to readable dates  
- Transformation of raw API data into tabular format  
- Grouping forecast data by date  
- Calculation of daily minimum and maximum temperatures  

---

## 🔍 Insights
- Weather forecast data is provided at 3-hour intervals, resulting in multiple records per day.
- Aggregating intraday data to daily level simplifies analysis and interpretation.
- Daily temperature ranges show clear variation between night-time lows and daytime highs.
- The aggregated dataset is more suitable for trend analysis and reporting.

---

## 🔐 API Key Management
API keys are managed securely using environment variables and are not included in this repository.

---

## 📁 Repository Structure
