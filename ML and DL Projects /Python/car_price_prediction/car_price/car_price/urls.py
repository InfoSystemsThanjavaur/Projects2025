"""
URL configuration for car_price project.

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
from home import views
urlpatterns = [
    path('',views.home,name="home"),
    path('pred.html',views.predict_price,name="price"),
    path('signup.html',views.signup,name='signup'),
    path('login.html',views.login,name='login'),
    path('profile.html',views.profile,name='profile'),
    path('dashboard.html',views.dash,name='dash'),
    
    path('about.html',views.about,name='about'),
    
    
    path('home.html',views.dashhome,name="dhome"),
    
    
]
