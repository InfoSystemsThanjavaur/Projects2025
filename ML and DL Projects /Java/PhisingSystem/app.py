import requests
from bs4 import BeautifulSoup
import pickle as pkl
import sys
import warnings

warnings.filterwarnings("ignore")

model = None
vectorizer = None

def load_model():
    global model, vectorizer
    try:
        with open('Models/model.pkl', 'rb') as f:
            model = pkl.load(f)

        with open("Models/vectorizer.pkl", "rb") as f:
            vectorizer = pkl.load(f)

    except FileNotFoundError:
        print("Error: Model or vectorizer file not found.")
        sys.exit(1)

def predict(test_url):
    global model, vectorizer
    
    if model is None or vectorizer is None:
        print("Error: Model not loaded.")
        return

    test_vector = vectorizer.transform([test_url])
    result = "Phishing" if model.predict(test_vector) else "Safe"

    # Save the result to result.txt
    with open("result.txt", "w") as f:
        f.write(result)

    print(f"Prediction saved to result.txt: {result}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py <URL>")
        sys.exit(1)
    
    load_model()
    url = sys.argv[1]
    predict(url)
