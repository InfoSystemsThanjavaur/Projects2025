from django.shortcuts import render
from django.http import HttpResponse,Http404
from django.conf import settings
from django.http import JsonResponse
from .database_functions import get_all_users, delete_user, update_user
from django.shortcuts import render, get_object_or_404, redirect
from .models import User  
from .models import FileUpload 

import os
import mysql.connector as mys
from django.core.files.storage import FileSystemStorage
# Create your views here.
def base(request):
    return render(request,'base.html',{})

def usersignup(request):
    if request.method=='POST':
        
        global username
        global email
        a=request.POST['fn']
        b=request.POST['ln']
        c=request.POST['email'] 
        d=request.POST['phone']
        e=request.POST['add']
        f=request.POST['gender']
        g=request.POST['dob']
        h=request.POST['un']
        i=request.POST['pwd']
        j=request.POST['cpwd']
         
        
        if i==j:
            mydb=mys.connect(host="localhost",user="root",password="root",database="dual_server")
            mycursor=mydb.cursor()
            sql="insert into users(first_name,last_name,email,phone,address,gender,dob,username,password) values(%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            values=(a,b,c,d,e,f,g,h,i)
            mycursor.execute(sql,values)
            mydb.commit()
            return render(request,'user.html',{'status':"success"})
        else: 
            return render(request,'usersignup.html',{"status":"fail"})
    else:
        return render(request,'usersignup.html',{})
def userlogin(request):
    if request.method=="POST":
       
        un=request.POST['un']
        pwd=request.POST['pwd'] 
        mydb=mys.connect(host="localhost",user="root",password="root",database="dual_server")
        mycursor=mydb.cursor()
        sql = "select username, password from users where username = %s and password=%s" 
        val=(un,pwd)
        mycursor.execute(sql,val)
        
        res= mycursor.fetchall()
        
        print(res)
        if len(res)!=0:
            if res[0][0]==un and res[0][1]==pwd:
                return render(request,'user.html',{})
        else:
            return render(request,'userlogin.html',{"result":"fail"})
    else:
        return render(request,'userlogin.html',{})
def adminsignup(request):
    if request.method=='POST':
        
        a=request.POST['fn']
        b=request.POST['ln']
        c=request.POST['email'] 
        d=request.POST['phone']
        e=request.POST['admin_id']
        f=request.POST['pwd']
        g=request.POST['cpwd']
       
        
        if f==g:
            mydb=mys.connect(host="localhost",user="root",password="root",database="dual_server")
            mycursor=mydb.cursor()
            sql="insert into admin(firstname,lastname,email,phone,admin_username,password) values(%s,%s,%s,%s,%s,%s)"
            values=(a,b,c,d,e,f)
            mycursor.execute(sql,values)
            mydb.commit()
            return render(request,'admin.html',{'status':"success"})
        else: 
            return render(request,'adminsignup.html',{"status":"fail"})
    else:
        return render(request,'adminsignup.html',{})
    
def adminlogin(request):
    if request.method=="POST":
       
        un=request.POST['un']
        pwd=request.POST['pwd'] 
        mydb=mys.connect(host="localhost",user="root",password="root",database="dual_server")
        mycursor=mydb.cursor()
        sql = "select admin_username, password from admin where admin_username = %s and password=%s" 
        val=(un,pwd)
        mycursor.execute(sql,val)
        
        res= mycursor.fetchall()
        
        print(res)
        if len(res)!=0:
            if res[0][0]==un and res[0][1]==pwd:
                return render(request,'admin.html',{})
        else:
            return render(request,'adminlogin.html',{"result":"fail"})
    else:
        return render(request,'adminlogin.html',{})
    
def viewersignup(request):
    if request.method=='POST':
        
        a=request.POST['viewer_name']
        b=request.POST['email']
        c=request.POST['viewer_id'] 
        d=request.POST['pwd']
        e=request.POST['cpwd']
       
        
        if d==e:
            mydb=mys.connect(host="localhost",user="root",password="root",database="dual_server")
            mycursor=mydb.cursor()
            sql="insert into viewer(viewer_name,email,username,password) values(%s,%s,%s,%s)"
            values=(a,b,c,d)
            mycursor.execute(sql,values)
            mydb.commit()
            return render(request,'viewer.html',{'status':"success"})
        else: 
            return render(request,'viewersignup.html',{"status":"fail"})
    else:
        return render(request,'viewersignup.html',{})
    
def viewerlogin(request):
    if request.method=="POST":
       
        un=request.POST['un']
        pwd=request.POST['pwd'] 
        mydb=mys.connect(host="localhost",user="root",password="root",database="dual_server")
        mycursor=mydb.cursor()
        sql = "select username, password from viewer where username = %s and password=%s" 
        val=(un,pwd)
        mycursor.execute(sql,val)
        
        res= mycursor.fetchall()
        
        print(res)
        if len(res)!=0:
            if res[0][0]==un and res[0][1]==pwd:
                return render(request,'viewer.html',{})
        else:
            return render(request,'viewerlogin.html',{"result":"fail"})
    else:
        return render(request,'viewerlogin.html',{})
    

def upload_file(request):
    if request.method == 'POST' and request.FILES['file']:
        
        # Get form data
        file_name = request.POST.get('fn')
        file = request.FILES['file']
        shared_with = request.POST.get('shared_with')
        
        # Split the shared_with string by commas and store in a list
        shared_users = [user_id.strip() for user_id in shared_with.split(',')]
        
        # Save the file to the media directory
        fs = FileSystemStorage(location=settings.MEDIA_ROOT)
        file_path = fs.save(file.name, file)
        
        # Insert the data into MySQL
        try:
            conn = mys.connect(
                host='localhost',
                user='root',
                password='root',
                database='dual_server'
            )
            cursor = conn.cursor()

            # Insert file details into the database
            cursor.execute("INSERT INTO file_uploads (file_name, file_path, shared_with) VALUES (%s, %s, %s)", 
                           (file_name, os.path.join(settings.MEDIA_URL, file_path), ','.join(shared_users)))

            conn.commit()
            cursor.close()
            conn.close()
            
            return HttpResponse('File uploaded successfully!')
        except mys.Error as err:
            return HttpResponse(f"Error: {err}")
    return render(request,'upload_file.html')
        


    
def about(request):
    return render(request,'about.html',{})
def viewer_logout(request):
    return render(request,'base.html',{})

def user_logout(request):
    return render(request,'base.html',{})

def admin_logout(request):
    return render(request,'base.html',{})



def manage_users(request):
    if request.method == "GET":
        users = get_all_users()
        return render(request, "manage_users.html", {"users": users})
    
    elif request.method == "POST":
        action = request.POST.get("action")
        user_id = request.POST.get("user_id")
        
        if action == "delete":
            result = delete_user(user_id)
            return JsonResponse({"message": result})
        
        elif action == "update":
            # Get new user details from POST request
            first_name = request.POST.get("first_name")
            last_name = request.POST.get("last_name")
            email = request.POST.get("email")
            phone = request.POST.get("phone")
            address = request.POST.get("address")
            gender = request.POST.get("gender")
            dob = request.POST.get("dob")
            username = request.POST.get("username")
            
            result = update_user(user_id, first_name, last_name, email, phone, address, gender, dob, username)
            return JsonResponse({"message": result})

def edit_user(request, user_id):
   
    print("Requested user ID:", user_id)  # Debugging
    user = get_object_or_404(User, id=user_id)


    if request.method == "POST":
        user.first_name = request.POST["first_name"]
        user.last_name = request.POST["last_name"]
        user.email = request.POST["email"]
        user.phone = request.POST["phone"]
        user.save()
        return redirect("manage_users")  # Redirect back to Manage Users page

    return render(request, "edit_users.html", {"user": user})

from django.shortcuts import render
import mysql.connector as mys
from django.conf import settings

def viewer_dashboard(request):
    try:
        # Connect to the database
        conn = mys.connect(
            host='localhost',
            user='root',
            password='root',
            database='dual_server'
        )
        cursor = conn.cursor()

        # Query to get file details from the database (file_name, file_path, shared_with)
        cursor.execute("SELECT file_name, file_path, shared_with FROM file_uploads")
        files = cursor.fetchall()  # Get all the files from the database

        cursor.close()
        conn.close()

        # Return the files to the template
        return render(request, 'viewer.html', {'files': files})

    except mys.Error as err:
        return HttpResponse(f"Error: {err}")


def view_users(request):
   
    if request.method == "GET":

         
        mydb=mys.connect(host="localhost",user="root",password="root",database="dual_server")
        mycur=mydb.cursor()
        mycur.execute("SELECT first_name,last_name,email,phone,address,gender,dob FROM users")
        data = mycur.fetchall()
        print(data)
        return render(request,'view_users.html',{'result':data})

    else:
        return render(request,'view_users.html',{})
def delete_user(request):
    if request.method == "POST":
        un = request.POST['un']
        mydb=mys.connect(host="localhost",user="root",password="root",database="dual_server")
        mycur=mydb.cursor()
      
        mycur.execute("DELETE FROM users WHERE username = %s", (un,))
        mydb.commit()
        return render(request,"admin.html",{})
    else:
        return render(request,"delete_users.html",{})

def view_viewers(request):
   
    if request.method == "GET":

         
        mydb=mys.connect(host="localhost",user="root",password="root",database="dual_server")
        mycur=mydb.cursor()
        mycur.execute("SELECT viewer_name,email FROM viewer")
        data = mycur.fetchall()
        print(data)
        return render(request,'view_viewers.html',{'result':data})

    else:
        return render(request,'view_viewers.html',{})
def delete_viewers(request):
    if request.method == "POST":
        un = request.POST['un']
        mydb=mys.connect(host="localhost",user="root",password="root",database="dual_server")
        mycur=mydb.cursor()
      
        mycur.execute("DELETE FROM viewer WHERE username = %s", (un,))
        mydb.commit()
        return render(request,"admin.html",{})
    else:
        return render(request,"delete_users.html",{})
    
    
def admin_back(request):
    return render(request,'admin.html',{})
