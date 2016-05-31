/*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
||						Objective										||
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/
	Prepare a alpha release of our product having following high level minimum stable functionalities:
	1. User registration.
	2. Complete donation order.
	3. Feedback and suggestions by user.

/*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
||						Release Information								||
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/
	1. These files contains database related files. This include files to create database, tables, initialization values.
	2. Seed values as well as sample data are just for testing. During alpha release we will have to create some significant amount of data. 

/*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
||						Steps of Execution								||
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/

This file contains number of files. Please execute them in following order:
	1.	create_database_kalp.sql		:: This file will create a sample database and one admin user.
	2.	create_schema_kalp.sql			:: This file will create configuration tables, tables related to NGO and user. 
	3.	create_seed_values_kalp.sql 	:: This file will create some seed values in configuration tables.
	4.  create_sample_business_data.sql	:: This file will create some sample data.
	
/*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
||						Next Step										||
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/
	1. Further refine these tables based on business logic and internal testing.
	2. Publish schema diagram.
	3. Create API for data validations.
	4. Easy way to seed values.