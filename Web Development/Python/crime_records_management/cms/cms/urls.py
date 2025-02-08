"""
URL configuration for cms project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from crime import views
from django.conf import settings
from django.conf.urls.static import static
urlpatterns = [
    path('',views.home,name=""),
    path('crime_login.html',views.crime_login,name="crime_login"),
    path('charge_login.html',views.charge_login,name="charge_login"),
    path('department_login.html',views.department_login,name="department_login"),
    path('investigation_login.html',views.investigation_login,name="investigation_login"),
    path('designation_master.html',views.designation_master,name='design_master'),
    path('department_employee_master.html',views.designation_employee_master,name='employee_master'),
    
    path('crime_nature.html',views.crime_nature,name='crime_nature'),
    path('victims.html',views.crime_victim,name='crime_victim'),
    path('victimfir.html',views.crime_victimfir,name='crime_fir'),
    
    path('crime_witness.html',views.crime_witness,name='crime_witness'),
    path('investigation_home.html',views.investigation_logout,name='investigation'),
    path('evidence_witness.html',views.evidence_witness,name='evidence'),
    
    path('chargesheet.html',views.viewTransaction,name='transfer_details'),
   path('chargesheet.html/download/',views.download,name='download'),


    
    path('home.html',views.designation_logout,name='designation_logout'),

]

urlpatterns += static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT)
urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)