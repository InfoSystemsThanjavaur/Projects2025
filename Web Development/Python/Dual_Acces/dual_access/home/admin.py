from django.contrib import admin
from .models import User

admin.site.register(User)

from .models import FileUpload

admin.site.register(FileUpload)
