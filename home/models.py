from __future__ import unicode_literals
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.db import models

class Moto(models.Model):
    username = models.CharField(max_length=200)
    password = models.CharField(max_length=200)

class UserProfile(models.Model):  
    user = models.OneToOneField(User)
    name = models.CharField(max_length=200) 
    #other fields here

 


