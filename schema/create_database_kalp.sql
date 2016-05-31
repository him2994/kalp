/*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
||				Database infrastructure creation.						||
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/

/*
	Create a sample database. We call it 'kalp'.
	As of now it will have minimal syntax.
	
	Also create a user 'admin_user'.
	Execute these commands on MySQL console using root login.
	
*/

CREATE DATABASE kalp1;

GRANT ALL ON kalp.* TO 'admin_user'@localhost IDENTIFIED BY 'kalp123';

EXIT;

/*
	Now login using admin_user and select 'kalp' database for schema creation.
*/
mysql -u admin_user -pkalp123

USE kalp;

