from django.db import models

class User(models.Model):
    id = models.AutoField(primary_key=True)
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    phone = models.CharField(max_length=15)
    address = models.TextField()
    gender = models.CharField(max_length=10)
    dob = models.DateField()
    username = models.CharField(max_length=100, unique=True)
    password = models.CharField(max_length=100)  # You should hash passwords!

    def __str__(self):
        return self.username
class FileUpload(models.Model):
    file_name = models.CharField(max_length=255)  # File name
    file_path = models.FileField(upload_to='uploads/')  # File path where the file is stored
    shared_with = models.TextField()  # Comma-separated list of users the file is shared with

    def __str__(self):
        return self.file_name