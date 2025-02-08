from django.shortcuts import render
import mysql.connector as mys


# Create your views here.
def home(request):
    return render(request,'home.html',{})

def department_login(request):
    if request.method=='POST':
        un=request.POST['un']
        pwd=request.POST['pwd']
        if un=='department' and pwd=='1234':
            return render(request,'department_home.html',{})
    else:
        return render(request,'department_login.html',{})

def designation_master(request):
    if request.method=='POST':
        d_id=request.POST['id']
        d_name=request.POST['name']
        d_desc=request.POST['desc']
        con=mys.connect(host="localhost",user='root',password='root',database='crime')
        res=con.cursor()
        sql="insert into designation_master(designation_id,designation_name,designation_description) values(%s,%s,%s)"
        val=(d_id,d_name,d_desc)
        res.execute(sql,val)
        con.commit()
        return render(request,'department_home.html',{})
    else:
        return render(request,'designation_master.html',{})

def designation_employee_master(request):
    if request.method=='POST':
        d_id=request.POST['id']
        d_name=request.POST['name']
        d_desc=request.POST['designation']
        dpt=request.POST['department']
        dob=request.POST['dob']
        doj=request.POST['dateofjoining']
        add=request.POST['add']
        email=request.POST['email']
        phone=request.POST['phoneno']        
        
        con=mys.connect(host="localhost",user='root',password='root',database='crime')
        res=con.cursor()
        sql="insert into department_employee_master(employee_id,name,designation,department,dob,date_of_joining,address,email,phone_no) values(%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        val=(d_id,d_name,d_desc,dpt,dob,doj,add,email,phone)
        res.execute(sql,val)
        con.commit()
        return render(request,'department_home.html',{})
    else:
        return render(request,'department_employee_master.html',{})

def designation_logout(request):
    return render(request,'home.html',{})


def crime_login(request):
    if request.method=='POST':
        un=request.POST['un']
        pwd=request.POST['pwd']
        if un=='crime' and pwd=='1234':
            return render(request,'crime_home.html',{})
    else:
        return render(request,'crime_login.html',{})
    
def crime_nature(request):
    if request.method=='POST':
        id=request.POST['nid']
        nid=request.POST['cid']
        name=request.POST['name']
        con=mys.connect(host="localhost",user='root',password='root',database='crime')
        res=con.cursor()
        sql="insert into crime_category_nature_master(nature_id,category_id,nature_name) values(%s,%s,%s)"
        val=(id,nid,name)
        res.execute(sql,val)
        con.commit()
        return render(request,'crime_home.html',{})
    else:
        return render(request,'crime_nature.html',{})

def crime_victim(request):
    if request.method=='POST':
        id=request.POST['victimid']
        name=request.POST['victimname']
        dob=request.POST['dob']
        email=request.POST['email']
        add=request.POST['add']       
        phone=request.POST['phoneno']        
        
        con=mys.connect(host="localhost",user='root',password='root',database='crime')
        res=con.cursor()
        sql="insert into victim_master(victim_id,victim_name,dob,email,address,phone_no) values(%s,%s,%s,%s,%s,%s)"
        val=(id,name,dob,email,add,phone)
        res.execute(sql,val)
        con.commit()
        return render(request,'crime_home.html',{})
    else:
        return render(request,'victims.html',{})

def crime_victimfir(request):
    if request.method=='POST':
        id=request.POST['firid']
        nid=request.POST['crimenatureid']
        add=request.POST['address']
        ld=request.POST['locationdetails']
        vid=request.POST['victimid']       
        invesid=request.POST['investigationofficerid']        
        date=request.POST['crimedate']  
        con=mys.connect(host="localhost",user='root',password='root',database='crime')
        res=con.cursor()
        sql="insert into victim_fir_master(victim_fir_id,crime_nature_id,address,location_details,victim_id,investigation_officer_id,crime_date) values(%s,%s,%s,%s,%s,%s,%s)"
        val=(id,nid,add,ld,vid,invesid,date)
        res.execute(sql,val)
        con.commit()
        return render(request,'crime_home.html',{})
    else:
        return render(request,'victimfir.html',{})

def charge_login(request):
    if request.method=='POST':
        un=request.POST['un']
        pwd=request.POST['pwd']
        if un=='charge' and pwd=='1234':
            return render(request,'charge_home.html',{})
    else:
        return render(request,'charge_login.html',{})
       


def investigation_login(request):
    if request.method=='POST':
        un=request.POST['un']
        pwd=request.POST['pwd']
        if un=='inves' and pwd=='1234':
            return render(request,'investigation_home.html',{})
    else:
        return render(request,'investigation_login.html',{})
    
    
def crime_witness(request):
   
    if request.method == "GET":

         
        mydb=mys.connect(host="localhost",user="root",password="root",database="crime")
        mycur=mydb.cursor()
        mycur.execute("SELECT category_id,nature_name FROM crime_category_nature_master")
        data = mycur.fetchall()
        print(data)
        return render(request,'crime_witness.html',{'result':data})

    else:
        return render(request,'crime_witness.html',{})

def evidence_witness(request):
   
    if request.method == "GET":

         
        mydb=mys.connect(host="localhost",user="root",password="root",database="crime")
        mycur=mydb.cursor()
        mycur.execute("SELECT victim_id,victim_name,dob,email,address,phone_no FROM victim_master")
        data = mycur.fetchall()
        print(data)
        return render(request,'evidence_witness.html',{'result':data})

    else:
        return render(request,'evidence_witness.html',{})


def investigation_logout(request):
    return render(request,'investigation_home.html',{})

from django.http import HttpResponse
def download(request):
    content="Victim_ID ,victime_name,dob,email,address,phone_no\n"
    datas = DownloadTransaction()
    print(datas)
    for data in datas:
        content += str(data[0]) + "," + str(data[1]) + "," + str(data[2])+ ","+str(data[3]) + "," + str(data[4]) +  "," + str(data[5]) +"\n"
    
    response = HttpResponse(content, content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename="victimfir.csv"'

    return response

def viewTransaction(request):

    if request.method=="GET":
       
        
        data = DownloadTransaction()
        if data:
            return render(request,'chargesheet.html',{'result':data})
        else:
            return render(request,'chargesheet.html',{'result':0})

    else:
        return render(request,'chargesheet.html',{})
    

def DownloadTransaction():
    con=mys.connect(host="localhost",user="root",password="root",database="crime")
    mycur=con.cursor()
    mycur.execute("SELECT victim_id,victim_name,dob,email,address,phone_no FROM victim_master")
    

    transaction = mycur.fetchall()
    if  transaction:
        return transaction 
    else:
        return 0
