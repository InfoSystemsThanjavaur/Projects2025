from twilio.rest import Client
import random

# Function to generate OTP
def generate_otp(length=6):
    otp = ''.join([str(random.randint(0, 9)) for _ in range(length)])
    return otp

# Function to send SMS
def send_sms_otp(account_sid, auth_token, twilio_number, recipient_number):
    # Generate OTP
    b= True
    otp = generate_otp()
    message_body = f"Your OTP code is: {otp}. Please use this to verify your mobile number."

    # Initialize Twilio client
    client = Client(account_sid, auth_token)

    try:
        # Send SMS
        message = client.messages.create(
            body=message_body,
            from_=twilio_number,
            to=recipient_number
        )
        print(f"Message sent successfully: {message.sid}")
    except Exception as e:
        b=e
        print(f"Failed to send message: {e}")

    return otp ,b

def send(mno):
    # Replace with your Twilio credentials and phone numbers
    account_sid = "ACbd0f374e74d9edb3b8fff4d59291e318"
    auth_token = "0f03ec8dbdf9770a36f28614cae3bf6a"
    twilio_number = "+12182926646"  # Your Twilio number
    print(mno[0])
    recipient_number = "+91"+str(mno)  # Recipient's phone number
    print(recipient_number)
    otp ,b = send_sms_otp(account_sid, auth_token, twilio_number, recipient_number)
    print(otp)
    return otp ,b
