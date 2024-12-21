# Customer_Churn_Prediction
"A machine learning project to predict customer churn, analyze contributing factors, and provide actionable insights for retention."

<img src="https://github.com/rpjinu/Customer_Churn_Prediction/blob/main/image%20_customer_churn.jpg" width=800>

## Overview

This project predicts customer churn using machine learning techniques. Churn occurs when a customer stops using a company's product or service. Predicting churn helps businesses retain customers, optimize resources, and improve customer satisfaction.

This repository contains the code, data, and documentation for building and deploying a churn prediction model. The project leverages data preprocessing, feature engineering, exploratory data analysis (EDA), and machine learning models to achieve accurate predictions.

## Project Objectives

*   **Understand Customer Behavior:** Analyze the patterns and factors contributing to churn.
*   **Predict Churn:** Build a machine learning model to predict whether a customer will churn.
*   **Actionable Insights:** Provide insights for targeted interventions to reduce churn rates.
*   **Deployment:** Create a user-friendly interface for model predictions using a web application.

## Features

The dataset includes the following features:

*   **Demographics:** `gender`, `SeniorCitizen`, `Partner`, `Dependents`
*   **Account Information:** `tenure`, `Contract`, `PaymentMethod`, `PaperlessBilling`
*   **Services Used:** `PhoneService`, `MultipleLines`, `InternetService`, `OnlineSecurity`, `OnlineBackup`, `DeviceProtection`, `TechSupport`, `StreamingTV`, `StreamingMovies`
*   **Charges:** `MonthlyCharges`, `TotalCharges`

The target variable is `Churn`, indicating whether a customer churned (1) or not (0).

## Workflow

1.  **Data Preprocessing:**
    *   Handle missing values, outliers, and inconsistent data.
    *   Encode categorical variables using label encoding and one-hot encoding.
    *   Scale numerical variables for uniformity.

2.  **Exploratory Data Analysis (EDA):**
    *   Analyze customer churn trends and patterns.
    *   Visualize correlations between features and churn.

3.  **Model Development:**
    *   Split the data into training and testing sets.
    *   Train multiple machine learning models such as Logistic Regression, Random Forest, Gradient Boosting, and XGBoost.
    *   Evaluate model performance using metrics like accuracy, precision, recall, F1-score, and AUC-ROC.

4.  **Deployment:**
    *   Create an API for model inference.
    *   Develop a web interface using tools like Streamlit for real-time churn prediction.

## Results

*   **Best-performing model:** [Insert Model Name]
*   **Accuracy:** [Insert Accuracy]
