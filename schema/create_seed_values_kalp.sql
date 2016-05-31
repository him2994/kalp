/*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
||		STEP #3 																	||
||				Database seed data creation.										||
||				In future we have to create interface to seed some configurations.	||
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/
/*
	Create some pre-defined NGO domains.
*/
INSERT INTO config_business_domain(name, summary)
VALUES ('Child Education', null);

INSERT INTO config_business_domain(name, summary)
VALUES ('Women Empowerment', null);

INSERT INTO config_business_domain(name, summary)
VALUES ('Rural Development', null);

INSERT INTO config_business_domain(name, summary)
VALUES ('Child Health care', null);

INSERT INTO config_business_domain(name, summary)
VALUES ('Politics', null);

INSERT INTO config_business_domain(name, summary)
VALUES ('Election reform', null);

INSERT INTO config_business_domain(name, summary)
VALUES ('Governance transparency and accountability', null);

/*
	Seed values for states.
*/
INSERT INTO config_state(name, state_code,region,country)
VALUES ('Maharashtra', 'MH', 'West', 'India');

INSERT INTO config_state(name, state_code,region,country)
VALUES ('Madhya Pradesh', 'MP', 'Central', 'India');

INSERT INTO config_state(name, state_code,region,country)
VALUES ('Utter Pradesh', 'UP', 'North', 'India');

INSERT INTO config_state(name, state_code,region,country)
VALUES ('West Bengal', 'WB', 'East', 'India');

INSERT INTO config_state(name, state_code,region,country)
VALUES ('Andhra Pradesh', 'AP', 'South', 'India');

/*
	Seed value for cities.
*/
INSERT INTO config_city (name, state_id)
SELECT 'Pune', state_id
FROM config_state
WHERE state_code = 'MH';

INSERT INTO config_city (name, state_id)
SELECT 'Bhopal', state_id
FROM config_state
WHERE state_code = 'MP';

/*
	[config_occupation_type]
	[config_occupation_sub_type]
		--We should have some kind of mechanism to populate 'Others' as occupation sub type against each occupation type (try using triggers). 
*/
INSERT INTO config_occupation_type(occupation_name, occupation_name_desc)
VALUES ('IT', 'Information Technology');
	
	INSERT INTO config_occupation_sub_type(occupation_type_id, occupation_sub_type_id, subtype_name, subtype_name_desc)
	SELECT  LAST_INSERT_ID(), 1, 'DB Dev', 'Database developer'
	UNION 
	SELECT  LAST_INSERT_ID(), 2, 'DBA', 'Database administrator'
	UNION 
	SELECT  LAST_INSERT_ID(), 3, 'Network admin', 'Network admin'
	UNION 
	SELECT  LAST_INSERT_ID(), 4, 'UI designer', 'UI designer';
	
INSERT INTO config_occupation_type(occupation_name, occupation_name_desc)
VALUES ('Armed Foreces', 'Indian armed forces');

	INSERT INTO config_occupation_sub_type(occupation_type_id, occupation_sub_type_id, subtype_name, subtype_name_desc)
	SELECT  LAST_INSERT_ID(), 1, 'Air force', 'Air force'
	UNION 
	SELECT  LAST_INSERT_ID(), 2, 'Cost guard', 'Cost guard'
	UNION 
	SELECT  LAST_INSERT_ID(), 3, 'BSF', 'Border security forecs';
	
INSERT INTO config_occupation_type(occupation_name, occupation_name_desc)
VALUES ('Govt Service', 'Indian central and state government services');

INSERT INTO config_occupation_type(occupation_name, occupation_name_desc)
VALUES ('Private Service', 'Working in private sector');

INSERT INTO config_occupation_type(occupation_name, occupation_name_desc)
VALUES ('Doctor', 'Doctor');

INSERT INTO config_occupation_type(occupation_name, occupation_name_desc)
VALUES ('Businessman', 'Working on own company or establishment');

INSERT INTO config_occupation_type(occupation_name, occupation_name_desc)
VALUES ('Others', 'Others');
	INSERT INTO config_occupation_sub_type(occupation_type_id, occupation_sub_type_id, subtype_name, subtype_name_desc)
	SELECT  LAST_INSERT_ID(), 1, 'Others', 'Others';
	
/*
	[config_designation_details]
*/
INSERT INTO config_designation_details(designation_title, designation_full, description)
SELECT 'CEO', 'chief executive officer', null
UNION
SELECT 'MD', 'managing director', null
UNION
SELECT 'Branch Manager', 'branch manager', null
UNION
SELECT 'SE', 'software engineer', null
UNION
SELECT 'SSE', 'senior software engineer', null
UNION
SELECT 'Delivery boy', 'Delivery boy', null;

/*
	[config_contact_type]
	[config_contact_sub_type]
*/
INSERT INTO config_contact_type(contact_type, contact_type_desc)
VALUES ('email','email-id');
	
	INSERT INTO config_contact_sub_type(contact_type_id, contact_sub_type_id, contact_sub_type, contact_sub_type_desc)
	SELECT LAST_INSERT_ID(), 1, 'office-email', 'office-email'
	UNION
	SELECT LAST_INSERT_ID(), 2, 'personal-email', 'personal-email'
	UNION
	SELECT LAST_INSERT_ID(), 3, 'other', 'other';
	
INSERT INTO config_contact_type(contact_type, contact_type_desc)
VALUES ('phone no','phone number');
	
	INSERT INTO config_contact_sub_type(contact_type_id, contact_sub_type_id, contact_sub_type, contact_sub_type_desc)
	SELECT LAST_INSERT_ID(), 1, 'office landline', 'office landline'
	UNION
	SELECT LAST_INSERT_ID(), 2, 'home landline', 'home landline'
	UNION
	SELECT LAST_INSERT_ID(), 3, 'work mobile', 'work mobile'
	UNION
	SELECT LAST_INSERT_ID(), 4, 'personal mobile', 'personal mobile';
	
INSERT INTO config_contact_type(contact_type, contact_type_desc)
VALUES ('messenger','messenger');
	
INSERT INTO config_contact_type(contact_type, contact_type_desc)
VALUES ('social media','social media');

INSERT INTO config_contact_type(contact_type, contact_type_desc)
VALUES ('other','other');

/*
	[config_address_type]
*/
INSERT INTO config_address_type (address_type, address_type_desc)
SELECT 'user home', 'user home'
UNION
SELECT 'user office', 'user office'
UNION
SELECT 'user permanent', 'user permanent address'
UNION
SELECT 'HQ', 'head office'
UNION
SELECT 'regional office', 'regional office'
UNION
SELECT 'branch office', 'branch office';

/*
	[config_tx_status]
*/
INSERT INTO config_tx_status (tx_status, tx_status_desc)
VALUES (100, 'User placed donation order.');

INSERT INTO config_tx_status (tx_status, tx_status_desc)
VALUES (200, 'NGO assigned a contact person.');

INSERT INTO config_tx_status (tx_status, tx_status_desc)
VALUES (300, 'NGO contact received donation order.');

INSERT INTO config_tx_status (tx_status, tx_status_desc)
VALUES (400, 'Donation order complete.');

/*
	[config_donation_item_type]
*/
INSERT INTO config_donation_item_type (type, type_desc, is_shelf_life_req)
SELECT 'Appliances', 'Appliances', 0
UNION
SELECT 'Furniture', 'Furniture', 0
UNION
SELECT 'Books', 'Books', 0
UNION
SELECT 'Medicine', 'Medicine', 1
UNION
SELECT 'Toys', 'Toys', 0
UNION
SELECT 'Clothing', 'Clothing', 0
UNION
SELECT 'Household Goods', 'Household Goods', 0
UNION
SELECT 'Food-processed', 'Food', 1
UNION
SELECT 'Food-grain', 'Food', 1;

COMMIT;
