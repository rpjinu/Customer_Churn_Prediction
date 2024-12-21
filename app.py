#app
import pandas as pd
import numpy as np
import streamlit as st
import pickle
import os

# Load the model
model_path = os.path.join("E:\\Study\\data\\Customer Churn Prediction System\\customer_churn_model.pkl")
with open(model_path, 'rb') as file:
    model = pickle.load(file)

# Define categorical encodings
categorical_encodings = {
    'gender': {'Female': 0, 'Male': 1},
    'Partner': {'No': 0, 'Yes': 1},
    'Dependents': {'No': 0, 'Yes': 1},
    'PhoneService': {'No': 0, 'Yes': 1},
    'MultipleLines': {'No phone service': 0, 'No': 1, 'Yes': 2},
    'InternetService': {'DSL': 0, 'Fiber optic': 1, 'No': 2},
    'OnlineSecurity': {'No': 0, 'Yes': 1, 'No internet service': 2},
    'OnlineBackup': {'No': 0, 'Yes': 1, 'No internet service': 2},
    'DeviceProtection': {'No': 0, 'Yes': 1, 'No internet service': 2},
    'TechSupport': {'No': 0, 'Yes': 1, 'No internet service': 2},
    'StreamingTV': {'No': 0, 'Yes': 1, 'No internet service': 2},
    'StreamingMovies': {'No': 0, 'Yes': 1, 'No internet service': 2},
    'Contract': {'Month-to-month': 0, 'One year': 1, 'Two year': 2},
    'PaperlessBilling': {'No': 0, 'Yes': 1},
    'PaymentMethod': {
        'Electronic check': 0,
        'Mailed check': 1,
        'Bank transfer (automatic)': 2,
        'Credit card (automatic)': 3,
    },
}

st.title("Customer Churn Prediction")

st.write("""
### Enter Customer Details Below:
Provide the customer information to predict whether they will churn.
""")

# User inputs for all features
gender = st.selectbox("Gender", ['Female', 'Male'])
SeniorCitizen = st.selectbox("Senior Citizen", [0, 1])
Partner = st.selectbox("Partner", ['Yes', 'No'])
Dependents = st.selectbox("Dependents", ['Yes', 'No'])
tenure = st.number_input("Tenure (Months)", min_value=0, max_value=100, step=1, value=1)
PhoneService = st.selectbox("Phone Service", ['No', 'Yes'])
MultipleLines = st.selectbox("Multiple Lines", ['No phone service', 'No', 'Yes'])
InternetService = st.selectbox("Internet Service", ['DSL', 'Fiber optic', 'No'])
OnlineSecurity = st.selectbox("Online Security", ['No', 'Yes', 'No internet service'])
OnlineBackup = st.selectbox("Online Backup", ['No', 'Yes', 'No internet service'])
DeviceProtection = st.selectbox("Device Protection", ['No', 'Yes', 'No internet service'])
TechSupport = st.selectbox("Tech Support", ['No', 'Yes', 'No internet service'])
StreamingTV = st.selectbox("Streaming TV", ['No', 'Yes', 'No internet service'])
StreamingMovies = st.selectbox("Streaming Movies", ['No', 'Yes', 'No internet service'])
Contract = st.selectbox("Contract", ['Month-to-month', 'One year', 'Two year'])
PaperlessBilling = st.selectbox("Paperless Billing", ['Yes', 'No'])
PaymentMethod = st.selectbox(
    "Payment Method", 
    ['Electronic check', 'Mailed check', 'Bank transfer (automatic)', 'Credit card (automatic)']
)
MonthlyCharges = st.number_input("Monthly Charges", min_value=0.0, step=0.1, value=0.0)
TotalCharges = st.number_input("Total Charges", min_value=0.0, step=0.1, value=0.0)

# Predict button
if st.button("Predict Churn"):
    # Encode categorical inputs
    input_data = [
        categorical_encodings['gender'][gender],
        SeniorCitizen,
        categorical_encodings['Partner'][Partner],
        categorical_encodings['Dependents'][Dependents],
        tenure,
        categorical_encodings['PhoneService'][PhoneService],
        categorical_encodings['MultipleLines'][MultipleLines],
        categorical_encodings['InternetService'][InternetService],
        categorical_encodings['OnlineSecurity'][OnlineSecurity],
        categorical_encodings['OnlineBackup'][OnlineBackup],
        categorical_encodings['DeviceProtection'][DeviceProtection],
        categorical_encodings['TechSupport'][TechSupport],
        categorical_encodings['StreamingTV'][StreamingTV],
        categorical_encodings['StreamingMovies'][StreamingMovies],
        categorical_encodings['Contract'][Contract],
        categorical_encodings['PaperlessBilling'][PaperlessBilling],
        categorical_encodings['PaymentMethod'][PaymentMethod],
        MonthlyCharges,
        TotalCharges,
    ]

    # Convert input into NumPy array and reshape for prediction
    input_array = np.array(input_data).reshape(1, -1)

    # Predict using the model
    prediction = model.predict(input_array)

    # Display prediction
    if prediction[0] == 1:
        st.success("The customer is likely to churn.")
    else:
        st.success("The customer is not likely to churn.")
