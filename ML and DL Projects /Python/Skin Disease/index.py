import streamlit as st
from PIL import Image
from Model import ImageModel

def main_page():
    st.title("Image-to-Diagnosis:Skin Disease Detection System Bot")
    st.subheader(f"Welcome, {st.session_state.username}!")

    # Load the model
    model = ImageModel()

    # Add disclaimer
    with st.expander("Disclaimer"):
        st.warning(
            """
            **Important:**  
            - This system is for informational purposes only and should not be used as a substitute for professional medical advice, diagnosis, or treatment.  
            - Always consult a qualified healthcare provider with any questions or concerns about your health.  
            - The predictions provided are based on machine learning algorithms and may not be 100% accurate.  
            """
        )

    # File uploader
    uploaded_file = st.file_uploader("Choose an image...", type=["png", "jpg", "jpeg"])

    if uploaded_file is not None:
        try:
            # Display the uploaded image
            image = Image.open(uploaded_file)
            st.image(image, caption="Uploaded Image", use_column_width=True)
            st.write("Processing the image...")

            # Add a spinner while processing
            with st.spinner("Analyzing the image..."):
                extracted_text = model.execute(image)
            
            # Display results
            st.success("Here is the Analysis Result:")
            st.write(extracted_text)
        except Exception as e:
            st.error(f"An error occurred: {e}")
    else:
        st.info("Please upload an image to start the diagnosis.")
