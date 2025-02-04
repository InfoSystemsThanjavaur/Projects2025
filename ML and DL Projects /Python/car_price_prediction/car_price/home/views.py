from django.shortcuts import render
import pickle
import numpy  as np
import sklearn
import mysql.connector
from twilio.rest import Client
from django.http import JsonResponse


def home(request):
    return render(request,'home.html',{})
def dash(request):
    return render(request,'dashboard.html',{}) 
def dashhome(request):
    return render(request,'home.html',{})
def signup(request):
    if request.method=='POST':
        
        global username
        global email
        
        f=request.POST['un']
        g=request.POST['pwd']
        h=request.POST['cpwd']
        j=request.POST['email']
        k=request.POST['no']
        

        email = j
        if g==h:
            mydb=mysql.connector.connect(host="localhost",user="root",password="root",database="car")
            mycursor=mydb.cursor()
            sql="insert into user(un,pwd,email,phno) values(%s,%s,%s,%s)"
            values=(f,g,j,k,)
            mycursor.execute(sql,values)
            mydb.commit()
            return render(request,'dashboard.html',{'status':"success"})
        else: 
            return render(request,'signup.html',{"status":"fail"})
    else:
        return render(request,'signup.html',{})
account_sid = 'AC84f620c814ea366a139aea56b79bc096'
auth_token = 'd9072c090673f370c63f9b312cf5349a'
client = Client(account_sid, auth_token)

def send_car_price_sms(user_phone, predicted_price):
    message = client.messages.create(
        body=f"Your car's predicted price is: {predicted_price}",
        from_='your_twilio_phone_number',
        to=user_phone
    )
    return message.sid

# Example of using it in your view (assuming you're using Django)
def predict_car_price(request):
    # Get the car data from the form
    year = request.POST['year']
    km = request.POST['km']
    fuel = request.POST['fuel']
    mil = request.POST['mil']
    engine = request.POST['engine']
    mp = request.POST['mp']
    seat = request.POST['seat']
    user_phone = request.POST['phone_number']  # User's phone number

    # Perform your car price prediction logic (use your model here)
    predicted_price = "₹5,00,000"  # Replace with actual logic

    # Send the SMS with the predicted price
    send_car_price_sms(user_phone, predicted_price)

    # Return response to user
    return JsonResponse({'message': 'Prediction and SMS sent successfully!'})
    
def login(request):
    if request.method=="POST":
        global username
        global email
        email=request.POST['un']
        z=request.POST['pwd'] 
        mydb=mysql.connector.connect(host="localhost",user="root",password="root",database="car")
        mycursor=mydb.cursor()
        sql = "select un, pwd from user where un = %s and pwd=%s" 
        val=(email,z)
        mycursor.execute(sql,val)
        
        res= mycursor.fetchall()
        print(email)
        print(res)
        if len(res)!=0:
            if res[0][0]==email and res[0][1]==z:
                return render(request,'dashboard.html',{})
        else:
            return render(request,'login.html',{"result":"fail"})
    else:
        return render(request,'login.html',{})
    
def profile(request):
    return render(request,'profile.html',{})

def about(request):
    return render(request,'about.html',{})

def load():
    model=None
    try:
        with open('static/lr.pkl','rb') as f:
            model = pickle.load(f)
    except Exception as e:
        print("Error loading model:", e)
        
    return model

def predict_price(request):
    prediction = None

    if request.method == 'POST':
    
        try:
            # Retrieve form data
            year =(request.POST.get('y'))
            km= float(request.POST.get('km'))
            fuel=request.POST.get('fuel')
            if fuel=="CNG":
                fuel=0
            elif fuel=="Diesel":
                fuel=1
            elif fuel=="LPG":
                fuel=2
            elif fuel=="Petrol":
                fuel=3
            mil=float(request.POST.get('mil'))
            eng=float(request.POST.get('engine'))
            mp=float(request.POST.get('mp'))
            seat=int(request.POST.get('seat'))
            user_phone = request.POST['phone_number']
            
            

            # Prepare data for model prediction
            input_data = np.array([[year,km,fuel,mil,eng,mp,seat]])
            print(input_data)
            model = load()
        
            prediction = model.predict(input_data)
            send_car_price_sms(user_phone, prediction)

    # Return response to user
            return JsonResponse({'message': 'Prediction and SMS sent successfully!'})
                
           
        except Exception as e:
            print("Error during prediction:", e)
            prediction_result = "Error occurred during prediction."
            print(e)
        
        
        return render(request, 'pred.html', {'result': prediction[0]})
    else:
        return render(request , 'pred.html')


