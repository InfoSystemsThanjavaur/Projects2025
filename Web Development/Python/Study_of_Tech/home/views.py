from django.shortcuts import render
import mysql.connector as con
from home import SMS
mno =None
user_name=None
user_email=None
user_id =None
data = None
otp =None
def connection():
    mycon = con.connect(host="localhost", user="root", password="root", database="studyoftech",charset='utf8')
    mycur = mycon.cursor()
    return mycur, mycon


def findUser(email , password):
    sql = "SELECT id , name , email , mobile , dob FROM user_details WHERE email = '{}' and password = '{}'".format(email , password)
    mycur ,mycon = connection()
    mycur.execute(sql)
    data = mycur.fetchall()
    return data
def findMno(mno):
    sql = "SELECT id mobile from user_details WHERE mobile='{}'".format(mno)
    mycur ,mycon = connection()
    mycur.execute(sql)
    data = mycur.fetchall()
    return data
# Create your views here
def index(request):
    return render(request, 'index.html')

def login(request):
    if request.method == 'POST':
       
        global user_name,user_email ,data
        pwd = request.POST['pwd']
        email = request.POST['eml']
        row = findUser(email ,pwd)
        if row:
            print("sucess")
            data =row[0]
            user_email = email
            return render(request, 'course.html')
        else:
            print("hello-2")
            return render(request, 'login.html', {'result': 0})
    else:
        print('hello')
        return render(request, 'login.html',{})

def reg(request):
    try:
        global user_name,user_email ,data
        mycur, mycon = connection()
        if request.method == "POST":
            name = request.POST['un']
            email = request.POST['eml']
            password = request.POST['pwd']
            mno = request.POST['mno']
            dob = request.POST['dob']
            sql= "INSERT INTO user_details(name, email, mobile,password ,dob) VALUES (%s, %s,%s,%s,%s)"
            val=(name,email,mno,password,dob)
            mycur.execute(sql,val)
            mycon.commit()
            val = findUser(email ,password)
            if mycur.rowcount > 0:
                user_name = name
                user_email = email
                data =val[0]
                return render(request, 'course.html')
            else: 
                return render(request, 'sign.html' ,{'result':0})
        else:
            return render(request, 'sign.html')
    except Exception as e:
        return render(request, 'sign.html' ,{'result':e})

def home(request):
    global user_name , user_email
    if user_email != None:
        return render(request, 'home.html')
    else:
        return render(request, 'login.html')


def free(request):
    
    return render(request, 'free.html')
    

def course(request):
    global user_name , user_email
    if user_email != None:
        return render(request, 'course.html')
    else:
        return render(request, 'login.html')

def cart(request):
    global user_name , user_email
    if user_email != None:
        return render(request, 'cart.html')
    else:
        return render(request, 'login.html')

def about(request):
    return render(request, 'about.html')

def logout(request):
    global user_name , user_email
    user_email =None
    user_name =None
    return render(request, 'login.html')


def profile(request):
    global user_name , user_email
    if request.method =="GET":
        if user_email != None:
            print(data)
            id , name , email , phone , dob = data
            return render(request, 'profile.html',{'id':id,
                                                'name':name,
                                                'email':email,
                                                "phone":phone,
                                                "dob":dob})
        else:
            return render(request, 'login.html')
    else:
        user_name =None
        user_email =None
        return render(request, 'login.html')


def forgot(request):
    global mno , otp
    if request.method == "POST":
        mno = request.POST['mno']
        res = findMno(mno)
        if res :
            otp ,check = SMS.send(mno)
            if check==True:
                return render(request, 'otp.html',{})
            else:
                return render(request, 'error.html',{'result':check})
        else:
            return render(request, 'forgot.html',{'result':404})
    else:
        return render(request, 'forgot.html')

def otp(request):
    global mno ,otp
    if request.method == "POST":
        n1 = request.POST['n1']
        get_otp = n1
        if get_otp == otp:
            return render(request, 'reset.html',{})
        else:
            return render(request, 'otp.html',{})
    else:
        return render(request, 'otp.html')

def changePassword(request):
    global mno
    if request.method == "POST":
        new_password = request.POST['pwd']
        confirm_password = request.POST['cpwd']
        if new_password == confirm_password:
            sql = "update user_details set password = %s where mobile = %s"
            val =(new_password , mno)
            mycur, mycon = connection()
            mycur.execute(sql,val)
            mycon.commit()
            return render(request, 'login.html')
        else:
            return render(request, 'reset.html',{"result":0})
    else:
        return render(request, 'reset.html',{})
    

def error(request):
    return render(request, 'error.html')