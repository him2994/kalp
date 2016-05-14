from django.shortcuts import render

from django.contrib.auth import authenticate,login as login_user,logout as logout_user
from django.contrib.auth.models import User
from django.core.urlresolvers import reverse
from django.core.mail import send_mail,BadHeaderError
from django.core.mail import EmailMessage
from django.contrib.auth.decorators import login_required
from django.views.decorators.csrf import *
from django.http import *

@csrf_exempt
def index(request):
	if request.method == 'GET':
		return render(request,"index.html",{})

	# if request.method == 'POST':
	# 	try:
	# 		username = request.POST['username']
	# 		password = request.POST['password']
	# 		print username, password
	# 	except:
	# 		print "here"

@csrf_exempt
def login(request):
	if request.method == 'GET':
		return render(request,"login.html",{})

	if request.method == 'POST':
		username = request.POST['username']
		password = request.POST['password']
		print username
		print password
		try:
			user = authenticate(username=username,password=password)
			print "asd"

			if user:
				print "zxc"
				try:
					login_user(request,user)
					print "cvb"
					return render(request,"index.html",{'status':'Welcome to Kalp.'})
				except:
					return render(request,"login.html",{'status':'Some error occured.'})
			else:
				return render(request,"login.html",{'status':'Invalid credentials'})
		except:
			return render(request,"login.html",{'status':'Invalid credentials'})


@csrf_exempt
@login_required
def logout(request):
	#print request.user.username
	logout_user(request)
	return render(request,"index.html",{'status':'Good Bye '+request.user.username+'.'})