import streamlit as st
from Model import Model

def call():
    st.title("Credit Card Fraud Detection System 💳")

    # Intro message in an expandable container
    with st.expander("Welcome! Click here for instructions"):
        st.write("This system allows you to check credit card transactions for potential fraud. "
                 "Please enter the required information below and click 'Check for Fraud' to see the results.")
    
    # Set up columns for a responsive design
    check_credit_card = st.checkbox("Do you want to check a credit card?")
    if check_credit_card:
        col1, col2 = st.columns(2)

        # Left column for card number and decline information
        with col1:
            card_number = st.text_input("Credit Card Number")
            is_declined_option = st.radio("Transaction Declined?", ("Yes", "No"))
            h_dec = 0
            is_declined = 1 if is_declined_option == 'Yes' else 0
            if is_declined == 1:
                h_dec = st.number_input("Number of Declined Transactions", min_value=0, step=1)

        # Right column for foreign transaction and amount
        with col2:
            is_foreign_option = st.radio("Is this a Foreign Transaction?", ("Yes", "No"))
            is_foreign = 1 if is_foreign_option == 'Yes' else 0
            amount = st.number_input("Transaction Amount", min_value=0)

        # Prepare data for model prediction
        data = [int(card_number), int(amount), int(is_declined),int( h_dec), int(is_foreign)]

        # Button for fraud check
        st.markdown("<hr>", unsafe_allow_html=True)  # Horizontal line for separation
        if st.button("Check for Fraud"):
            model_pred(data)
            

def model_pred(data):
    # Initialize the model and make predictions
    model = Model()
    res = model.predict(data)
    
    # Display the prediction result
    if res == 0:
        st.success("The transaction is NOT flagged as fraud.")
    else:
        st.error("Warning: The transaction is flagged as FRAUD.")

call()
