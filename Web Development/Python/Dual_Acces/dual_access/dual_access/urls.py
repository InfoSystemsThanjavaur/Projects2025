"""
URL configuration for dual_access project.

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
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
   path('',views.base,name=""),
   path('usersignup.html',views.usersignup,name="user"),
   path('userlogin.html',views.userlogin,name="userlogin"),
   path('viewersignup.html',views.viewersignup,name="viewer"),
   path('viewerlogin.html',views.viewerlogin,name="viewerlogin"),
   path('view_users.html',views.view_users,name="view_users"),
   path('delete_users.html',views.delete_user,name="delete_users"),
   path('view_viewers.html',views.view_viewers,name="view_users"),
   path('delete_viewers.html',views.delete_viewers,name="delete_users"),
 
   path('base.html',views.viewer_logout,name="viewerlogout"),
   
   path('base.html',views.user_logout,name="userlogout"),
   path('base.html',views.admin_logout,name="adminlogout"),
   path('adminsignup.html',views.adminsignup,name="admin"),
   path('adminlogin.html',views.adminlogin,name="adminlogin"),
   path('admin.html',views.admin_back,name="adminback"),
   
   path('upload_file.html',views.upload_file,name='upload'),
   path('manage_users.html',views.manage_users,name='manage_users'),
    path('edit_user/<int:user_id>/', views.edit_user, name='edit_user'),
 path('viewer.html', views.viewer_dashboard, name='viewer_dashboard'),
    path('about.html',views.about,name="about"),
   
]
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)