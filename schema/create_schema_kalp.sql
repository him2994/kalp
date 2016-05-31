/*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
||					   Configuration table								||
||----------------------------------------------------------------------||
||	--Keep static data													||
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/
/*
	[config_release_log]
		--For future use. Not in use right now.
		--This table will keep the release/build information on the project.
	
*/
CREATE TABLE config_release_log (
	product_name				VARCHAR(100), 
	version_name				VARCHAR(100), 
	major_version				INT UNSIGNED, 
	minor_version				INT UNSIGNED, 
	service_pack				INT UNSIGNED, 
	hotfix_number				INT UNSIGNED,
	build_no					INT UNSIGNED, 
	build_date					DATETIME, 
	username					VARCHAR(100), 
	description					VARCHAR(4000)
)
ENGINE = InnoDB;

/*
	[config_business_domain]
		--This table will store various domains where an NGO can operate. These are very high level areas where an NGO/business can operate.
		--Some examples are child education, child trafficking, sanitation, women empowerment, political reform, elections etc.
		--One NGO or business can operate on multiple domains. Hence there will be many-to-many relation b/w an NGO and a domain.
		--These domains will help us identify appropriate objective/description for each business.
*/
CREATE TABLE config_business_domain (
	domain_id		INT UNSIGNED AUTO_INCREMENT ,
	name			VARCHAR(1000) NOT NULL,
	summary			TEXT,
	CONSTRAINT config_business_domain_pk PRIMARY KEY (domain_id)
)
ENGINE = InnoDB;

/*
	NOTE::- 
		--We are introducing a flag in most of the config tables:: 'is_verified'
		--Default value of this column will be 1 which means that this configuration key-value is verified by our support team.
		--This was done so that end user can also add some values into some config tables like config_state. But those values will be displayed with some indication that this info is under review.
		--As soon as that configuration verified by our team it will work as any other setting.
		--For example:: There is one user from the city of 'Sagar(MP)' who wants to register into our portal. As of now there is no config city with this name. So when user try to selects this city it wont appear. But there will be a option to 'other'. If he chooses to select that we will dynamically display two boxes one for city and other for state. That user can now fill his city of choice. Same information will gets stored in database tables (config_city and config_state tables) but with is_verified = 0. Later we will verify this information and if found correct make it is_verified = 1. Until then 'Sagar(MP)' city will gets displayed in our registration boxes but will some kind of indication.
*/

/*
	[config_state]
	[config_city]
		--These tables will be used in address of NGO, users etc.
	
*/
CREATE TABLE config_state (
	state_id		INT UNSIGNED AUTO_INCREMENT ,
	name			VARCHAR(1000) NOT NULL,
	state_code		VARCHAR(5)	  NOT NULL,	
	region			VARCHAR(1000) NOT NULL,
	country			VARCHAR(1000) NOT NULL,
	is_verified		TINYINT DEFAULT 1,
	CONSTRAINT config_state_pk PRIMARY KEY (state_id)
)
ENGINE = InnoDB;

CREATE TABLE config_city (
	city_id			INT UNSIGNED AUTO_INCREMENT ,
	name			VARCHAR(1000) NOT NULL,
	state_id		INT UNSIGNED,
	is_verified		TINYINT DEFAULT 1,
	CONSTRAINT config_city_pk PRIMARY KEY (city_id),
	CONSTRAINT config_city_fk1 FOREIGN KEY (state_id) REFERENCES config_state(state_id)
)
ENGINE = InnoDB;

/*
	[config_occupation_type]
	[config_occupation_sub_type]
		--These table will provide a master list of type of occupations (like govt service, IT services, armed forces, entrepreneur etc.) and more specific type of occupation i.e. sub types (like tester, DBA, architect, product manager etc. for a software job)
		--Will be used in keeping details of user (content consumer) and employees of business i.e. NGO.
*/
CREATE TABLE config_occupation_type (
	occupation_type_id		INT UNSIGNED AUTO_INCREMENT,
	occupation_name			VARCHAR(100),
	occupation_name_desc	VARCHAR(2000),
	is_verified				TINYINT DEFAULT 1,
	CONSTRAINT config_occupation_type_pk PRIMARY KEY (occupation_type_id)
)
ENGINE = InnoDB;

CREATE TABLE config_occupation_sub_type (
	occupation_type_id		INT UNSIGNED,
	occupation_sub_type_id	INT UNSIGNED,
	subtype_name			VARCHAR(100),
	subtype_name_desc		VARCHAR(2000),
	is_verified				TINYINT DEFAULT 1,
	CONSTRAINT config_occupation_sub_type_pk PRIMARY KEY (occupation_type_id,occupation_sub_type_id),
	CONSTRAINT config_occupation_sub_type_fk1 FOREIGN KEY (occupation_type_id) REFERENCES config_occupation_type(occupation_type_id)
)
ENGINE = InnoDB;

/*
	[config_designation_details]
		--keep type of designations like MD, CEO, software engineer I etc.
		--These will be used for end users as well as NGO employees.
*/
CREATE TABLE config_designation_details (
	designation_id			INT UNSIGNED AUTO_INCREMENT,
	designation_title		VARCHAR(100),
	designation_full		VARCHAR(100),
	description				VARCHAR(4000),
	is_verified				TINYINT DEFAULT 1,
	CONSTRAINT config_designation_details_pk PRIMARY KEY (designation_id)
)
ENGINE = InnoDB;

/*
	[config_contact_type]
	[config_contact_sub_type]
		--These tables will store type of contact (except address) like email, phone, skype-id etc. and their sub type like office email, home email etc.
		
*/
CREATE TABLE config_contact_type (
	contact_type_id				INT UNSIGNED AUTO_INCREMENT,
	contact_type				VARCHAR(100),
	contact_type_desc			VARCHAR(2000),
	CONSTRAINT config_contact_type_pk PRIMARY KEY (contact_type_id)
)
ENGINE = InnoDB;

CREATE TABLE config_contact_sub_type (
	contact_type_id				INT UNSIGNED,
	contact_sub_type_id			INT UNSIGNED,
	contact_sub_type			VARCHAR(100),
	contact_sub_type_desc		VARCHAR(2000),
	CONSTRAINT config_contact_sub_type_pk PRIMARY KEY (contact_type_id,contact_sub_type_id),
	CONSTRAINT config_contact_sub_type_fk FOREIGN KEY (contact_type_id) REFERENCES config_contact_type(contact_type_id)
)
ENGINE = InnoDB;

/*
	[config_address_type]
		--Type of address for end user as well as NGO offices like 'home', 'office', 'branch office'.
		
*/
CREATE TABLE config_address_type (
	address_type_id				INT UNSIGNED AUTO_INCREMENT,
	address_type				VARCHAR(100),
	address_type_desc			VARCHAR(2000),
	CONSTRAINT config_address_type_pk PRIMARY KEY (address_type_id)
)
ENGINE = InnoDB;

CREATE TABLE config_branch_type (
	branch_type_id				INT UNSIGNED AUTO_INCREMENT,
	branch_type					VARCHAR(100),
	branch_type_desc			VARCHAR(2000),
	CONSTRAINT config_branch_type_pk PRIMARY KEY (branch_type_id)
)
ENGINE = InnoDB;

/*
	[config_tx_status]
		--status or state of donation/order/transaction from initialization to completion. 
		--It will be used in donation life cycle.
		--These will be closely mapped with events. We can say that tx status will be a sub-set of events.
*/
CREATE TABLE config_tx_status(
	tx_status				INT UNSIGNED,
	tx_status_desc			VARCHAR(200)
)
ENGINE = InnoDB;

/*
	[config_donation_item_type]
		--This will be used to classify donation items like food, clothes, medicine, electric etc.
		--is_shelf_life_req:: Some items like food, drinks, medicines etc. should be consumed before an used-by-date. For these type of items we will ask user to provide expiry date(use by date).
		--is_verified as same def as others.
*/
CREATE TABLE config_donation_item_type(
	item_type				INT UNSIGNED AUTO_INCREMENT,
	type					VARCHAR(100),
	type_desc   			VARCHAR(2000),
	is_shelf_life_req		TINYINT UNSIGNED,
	is_verified				TINYINT DEFAULT 1,
	CONSTRAINT config_donation_item_type_pk PRIMARY KEY (item_type),
	CONSTRAINT config_donation_item_type_chk1 CHECK(is_shelf_life_req IN (0,1))
)
ENGINE = InnoDB;

/*
	[config_event_type]
		--Provide details of each event stored in cc_tx_event_detail and other event tables.
		--event_type_id, event_desc:: event identifier. For example "event_type_id = 100" it will mean 'User placed donation order.' in event_desc.
		--event_category::	module where events generated. Not relevant as of now. But in future when we add some more functions it will help us define class/module of events. RIght now it can be hard-coded as 'user transaction(donation)'. Some other future events can be related to user creation, forums, discussion groups, NGO data managements, workflow related to orders etc.
		--event_data_map::	It will have key value pair and define meaning of each column in respective event table. For example "event_type_id = 100" belongs to 'user donation' module. This events gets stored in "cc_tx_event_detail" table. Now event_data_map will keep details of each column in cc_tx_event_detail with respect to "event_type_id = 100". 
			--This is required to define exact meaning or content of event_attr columns.
			--This is just for reference. We will never use this column in our business logic. it will be highly inefficient. If some day we had a requirement where we need to use this in our code we will alter this table.
				Sample data for "event_type_id = 100" ::
				{TABLE:: cc_tx_event_detail}!!{event_type_id::"100"}!!{user_id::"user who placed the order"}!!{business_id::"NGO against which order was placed"}!!{contact_person_id::"Contact person who is currently handling this order from NGO"}!!{event_attr1::"Some numeric attribute"}!!{event_attr2::"Some numeric attribute"}!!{event_attr3::"Some numeric attribute"}!!{event_attr4::"Some numeric attribute"}!!{event_attr5::"Some numeric attribute"}!!{event_attr6::"Some string attribute"}!!{session_id::"Session which is currently handling this order"}
			
*/
CREATE TABLE config_event_type(
	event_type_id				SMALLINT UNSIGNED,
	event_desc					VARCHAR(2000),
	event_category				VARCHAR(100),
	event_data_map				TEXT,
	CONSTRAINT config_event_type_pk PRIMARY KEY (event_type_id)
)


/*
	[config_business_info]
		--This table contains details of each business (NGO's in current scenario).
		--These details can be static like name, year of incorporation or dynamic like current manager etc.
		--This table will work as a transaction or snapshot table. i.e. it will contain details as of a time. Historic information will not present here.
		--For historic information we may have to refer other detail tables or event table.
		--It is not a traditional config table. Normally a config table would have static information. But keeping it as config as of now because data in this table will be maintained by our team and it will not be exposed in public (as of now -- will revisit this). 
		
*/
CREATE TABLE config_business_info(
	business_id				INT UNSIGNED AUTO_INCREMENT ,
	name					VARCHAR(200) NOT NULL,
	full_name				VARCHAR(4000) NOT NULL,
	establishment_date		DATE NOT NULL,
	base_city_id			INT UNSIGNED,
	headoffice_address		VARCHAR(4000),
	manager					VARCHAR(200),
	objective				TEXT,
	CONSTRAINT config_business_info_pk PRIMARY KEY (business_id),
	CONSTRAINT config_business_info_fk1 FOREIGN KEY (base_city_id) REFERENCES config_city(city_id)
)
ENGINE = InnoDB;

/*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
||					   Content provider (NGO) table 					||
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/

CREATE TABLE cp_business_branch (
	id							INT UNSIGNED AUTO_INCREMENT,
	business_id					INT UNSIGNED NOT NULL,
	branch_id					INT UNSIGNED NOT NULL,
	branch_type_id				INT UNSIGNED NOT NULL,
	type_desc					VARCHAR(100),
	is_active					TINYINT NOT NULL, 
	relocated_branch_id			INT UNSIGNED,
	start_date					DATE,
	end_date					DATE DEFAULT '9999-12-31',
	branch_description			TEXT,
	CONSTRAINT cp_business_branch_pk PRIMARY KEY (id),
	CONSTRAINT cp_business_branch_chk1 CHECK (is_active IN (0,1)),
	CONSTRAINT cp_business_branch_fk1 FOREIGN KEY (business_id) REFERENCES config_business_info(business_id),
	CONSTRAINT cp_business_branch_fk2 FOREIGN KEY (branch_type_id) REFERENCES config_branch_type(branch_type_id),
	CONSTRAINT cp_business_branch_fk3 FOREIGN KEY (relocated_branch_id) REFERENCES cp_business_branch(id)
)
ENGINE = InnoDB;


/*
	[cp_business_article]
	[cp_business_article_version]
	[cp_business_article_data]
		--These tables will keep collection of articles with respect to an NGO.
		--These articles will be used to provide NGO Description/summary/vision.
		--One NGO can have multiple articles each related to different topics and/or domains.
		--We will maintain versions of article.
		--We will map these articles with different topics (as now in same table) and business domain.
*/
CREATE TABLE cp_business_article(
	article_id				INT UNSIGNED AUTO_INCREMENT ,
	business_id				INT UNSIGNED,
	topic					VARCHAR(1000),
	CONSTRAINT cp_business_article_pk PRIMARY KEY (article_id),
	CONSTRAINT cp_business_article_fk1 FOREIGN KEY (business_id) REFERENCES config_business_info(business_id)
)
ENGINE = InnoDB;

/*
	article_state	--D: Development, R: Review, P: Published, E: Expired
*/
CREATE TABLE cp_business_article_version(
	article_version_id		INT UNSIGNED AUTO_INCREMENT,
	article_id				INT UNSIGNED,
	version_id				SMALLINT UNSIGNED,
	is_deleted				TINYINT,
	effective_date			DATETIME	,
	expiry_date				DATETIME	DEFAULT '9999-12-31',
	last_modified_date		DATETIME	,
	article_state			CHAR(1),
	CONSTRAINT cp_business_article_version_pk PRIMARY KEY (article_version_id),
	CONSTRAINT cp_business_article_version_fk1 FOREIGN KEY (article_id) REFERENCES cp_business_article(article_id),
	CONSTRAINT cp_business_article_version_chk1 CHECK (article_state IN ('D', 'R', 'P', 'E')),
	CONSTRAINT cp_business_article_version_chk2 CHECK (is_deleted IN (0,1))
)
ENGINE = InnoDB;

CREATE TABLE cp_business_article_data(
	article_version_id		INT UNSIGNED,
	article_title			TEXT,
	article_text			TEXT,
	article_summary			TEXT,
	article_keywords		TEXT,
	CONSTRAINT cp_business_article_data_pk PRIMARY KEY (article_version_id),
	CONSTRAINT cp_business_article_data_fk1 FOREIGN KEY (article_version_id) REFERENCES cp_business_article_version(article_version_id)
)
ENGINE = InnoDB;

/*
	[cp_business_domain_map]
		--This table will work as a mapping b/w different businesses, their domain of operation as well as default article describing that domain with respect to that business.
		--For example one NGO 'x' can work in two domains 'child education' and 'child health care'. This business will have different vision in each domain. This table will help us identify a description (vision statement).
		--mapping of business and domain is of primary concern to us. Description of that business domain will be most suitable article version.
*/
CREATE TABLE cp_business_domain_map(
	domain_id				INT UNSIGNED,
	business_id				INT UNSIGNED,
	business_desc_id		INT UNSIGNED,
	CONSTRAINT cp_business_domain_map_fk1 FOREIGN KEY (domain_id) REFERENCES config_business_domain(domain_id),
	CONSTRAINT cp_business_domain_map_fk2 FOREIGN KEY (business_id) REFERENCES config_business_info(business_id),
	CONSTRAINT cp_business_domain_map_fk3 FOREIGN KEY (business_desc_id) REFERENCES cp_business_article(article_id)
)
ENGINE = InnoDB;

/*
	[cp_contact_person]
		--Store the contacts/users from an NGO.
		--As of now these will sever as contacts to outside public.
		--In future we will map then with users in the kalp via roles. So that they can perform some actions in the portal.
*/
CREATE TABLE cp_contact_person (
	contact_person_id			INT UNSIGNED AUTO_INCREMENT,
	business_id					INT UNSIGNED,
	branch_id					INT UNSIGNED,
	first_name					VARCHAR(100),
	last_name					VARCHAR(100),
	designation_id				INT UNSIGNED,
	manager_id					INT UNSIGNED,
	email_id					VARCHAR(100) NOT NULL,
	is_active					TINYINT,
	is_deleted					TINYINT,
	start_date					DATETIME,
	deactivation_date			DATETIME DEFAULT '9999-12-31',
	end_date					DATETIME DEFAULT '9999-12-31',
	CONSTRAINT cp_contact_person_pk PRIMARY KEY (contact_person_id),
	CONSTRAINT cp_contact_person_chk1 CHECK (is_active IN (0,1)),
	CONSTRAINT cp_contact_person_chk2 CHECK (is_deleted IN (0,1)),
	CONSTRAINT cp_contact_person_fk1 FOREIGN KEY (business_id) REFERENCES config_business_info(business_id),
	CONSTRAINT cp_contact_person_fk2 FOREIGN KEY (designation_id) REFERENCES config_designation_details(designation_id),
	CONSTRAINT cp_contact_person_fk3 FOREIGN KEY (branch_id) REFERENCES cp_business_branch(id),
	CONSTRAINT cp_contact_person_fk4 FOREIGN KEY (manager_id) REFERENCES cp_contact_person(contact_person_id)
)
ENGINE = InnoDB;

/*
	[cp_contact_details]
		--Store contact details like email, mobile no etc of contact person from an NGO.
		--contact type and sub-type will be stored in respective config tables. Here we will store their keys.
		--For quicker reference we have created a column type_desc here. So if contact is 'email' and sub-type is 'work' then type_desc will save something like 'email-work'.
*/
CREATE TABLE cp_contact_details (
	contact_id					INT UNSIGNED AUTO_INCREMENT,
	contact_person_id			INT UNSIGNED NOT NULL,
	contact_type_id				INT UNSIGNED NOT NULL,	
	contact_sub_type_id			INT UNSIGNED NOT NULL,
	type_desc					VARCHAR(200),
	contact_value				VARCHAR(100) NOT NULL,
	contact_value_type			VARCHAR(10)  NOT NULL,
	is_active					TINYINT,
	effective_date				DATETIME,
	expiry_date					DATETIME DEFAULT '9999-12-31',
	CONSTRAINT cp_contact_details_pk PRIMARY KEY (contact_id),
	CONSTRAINT cp_contact_details_chk1 CHECK (contact_value_type IN ('string', 'integer')),
	CONSTRAINT cp_contact_details_chk2 CHECK (is_active IN (0,1)),
	CONSTRAINT cp_contact_details_fk1 FOREIGN KEY (contact_person_id) REFERENCES cp_contact_person(contact_person_id),
	CONSTRAINT cp_contact_details_fk2 FOREIGN KEY (contact_type_id,contact_sub_type_id) REFERENCES config_contact_sub_type(contact_type_id,contact_sub_type_id)
)
ENGINE = InnoDB;

/*
	[cp_address_details]
		--Store address details of an NGO. There can be more than one addresses associated with an NGO.
		--This tables will also work kind of a branch locator.
			
*/
CREATE TABLE cp_address_details (
	address_id					INT UNSIGNED AUTO_INCREMENT,
	business_id					INT UNSIGNED,
	branch_id					INT UNSIGNED,
	address_type_id				INT UNSIGNED,
	address_type_desc			VARCHAR(100),
	is_collection_address		TINYINT,
	address_line1				VARCHAR(1000),
	address_line2				VARCHAR(1000),
	landmark					VARCHAR(1000),
	street						VARCHAR(1000),
	city_id						INT UNSIGNED,
	pin_code					MEDIUMINT UNSIGNED,
	state_id					INT UNSIGNED,
	effective_date				DATETIME	,
	expiry_date					DATETIME	DEFAULT '9999-12-31',
	last_modified_date			DATETIME	,
	is_deleted					TINYINT,
	CONSTRAINT cp_address_details_pk PRIMARY KEY (address_id),
	CONSTRAINT cp_address_details_fk1 FOREIGN KEY (business_id) REFERENCES config_business_info(business_id),
	CONSTRAINT cp_address_details_fk2 FOREIGN KEY (city_id) REFERENCES config_city(city_id),
	CONSTRAINT cp_address_details_fk3 FOREIGN KEY (state_id) REFERENCES config_state(state_id),
	CONSTRAINT cp_address_details_fk4 FOREIGN KEY (address_type_id) REFERENCES config_address_type(address_type_id),
	CONSTRAINT cp_address_details_fk5 FOREIGN KEY (branch_id) REFERENCES cp_business_branch(id),
	CONSTRAINT cp_address_details_chk1 CHECK (is_collection_address IN (0,1)),
	CONSTRAINT cp_address_details_chk2 CHECK (is_deleted IN (0,1))
)
ENGINE = InnoDB;



/*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
||					   Content consumer (User) table 					||
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/
/*
	[cc_user_info]
		--This table will store transaction information of user.
		--Do not keep historic information. That will be part of detail table.
		--Password will be encrypted.
		--Username can be email id. And its a must.
		--Username/email and password are the only two mandatory requirements. Other user can choose to ignore during registration and will have option to update then later.
		--Address will be mandatory if user wants to donate something and choose pick-up as a option. User can drop the donation at NGO office if he wishes that or if it convenient to him/her.
		--is_active flag will be zero for all the deactivated/deleted users.
*/
CREATE TABLE cc_user_info (
	user_id						INT UNSIGNED AUTO_INCREMENT ,
	first_name					VARCHAR(100),
	last_name					VARCHAR(100),
	username					VARCHAR(100) NOT NULL,
	Date_of_birth				DATETIME,
	base_city_id				INT UNSIGNED,
	occupation					VARCHAR(100),
	email_id					VARCHAR(100) NOT NULL,
	password					VARCHAR(4000) NOT NULL,
	is_active					TINYINT,
	is_deleted					TINYINT,
	create_date					DATETIME,
	last_activity_date			DATETIME,
	deactivation_date			DATETIME DEFAULT '9999-12-31',
	deletion_date				DATETIME DEFAULT '9999-12-31',
	CONSTRAINT cc_user_info_pk PRIMARY KEY (user_id),
	CONSTRAINT cc_user_info_chk1 CHECK (is_active IN (0,1)),
	CONSTRAINT cc_user_info_chk2 CHECK (is_deleted IN (0,1)),
	CONSTRAINT cc_user_info_fk1 FOREIGN KEY (base_city_id) REFERENCES config_city(city_id)
)
ENGINE = InnoDB;

/*
	[cc_address_details]
		--Store address details of a user.
		--Maintain version of addresses. Version will be with respect to address type.
		--old version does not mean that address is expired or not useful. It is possible that an user maintains two home address and both are active. 
		--While placing pick up order we will display last address where we have picked up using is_pickup_address flag. 
			--if user wishes to see other address we will display him last three address. He can choose any one of them or create a new one.
		--If user delete an address then its expiry date will be updated as well as is_deleted flag will become 1.	
			
*/
CREATE TABLE cc_address_details (
	address_id					INT UNSIGNED AUTO_INCREMENT,
	user_id						INT UNSIGNED,
	address_type_id				INT UNSIGNED,
	address_type_desc			VARCHAR(100),
	version_id					SMALLINT UNSIGNED,
	is_pickup_address			TINYINT,
	address_line1				VARCHAR(1000),
	address_line2				VARCHAR(1000),
	landmark					VARCHAR(1000),
	street						VARCHAR(1000),
	city_id						INT UNSIGNED,
	pin_code					MEDIUMINT UNSIGNED,
	state_id					INT UNSIGNED,
	effective_date				DATETIME	,
	expiry_date					DATETIME	DEFAULT '9999-12-31',
	last_modified_date			DATETIME	,
	is_deleted					TINYINT,
	CONSTRAINT cc_address_details_pk PRIMARY KEY (address_id),
	CONSTRAINT cc_address_details_fk1 FOREIGN KEY (user_id) REFERENCES cc_user_info(user_id),
	CONSTRAINT cc_address_details_fk2 FOREIGN KEY (city_id) REFERENCES config_city(city_id),
	CONSTRAINT cc_address_details_fk3 FOREIGN KEY (state_id) REFERENCES config_state(state_id),
	CONSTRAINT cc_address_details_fk4 FOREIGN KEY (address_type_id) REFERENCES config_address_type(address_type_id),
	CONSTRAINT cc_address_details_chk2 CHECK (is_pickup_address IN (0,1)),
	CONSTRAINT cc_address_details_chk3 CHECK (is_deleted IN (0,1))
)
ENGINE = InnoDB;

/*
	[cc_contact_details]
		--Store contact details like email, mobile no etc.
		--contact type and sub-type will be stored in respective config tables. Here we will store their keys.
		--For quicker reference we have created a column type_desc here. So if contact is 'email' and sub-type is 'work' then type_desc will save something like 'email-work'.
*/
CREATE TABLE cc_contact_details (
	contact_id					INT UNSIGNED AUTO_INCREMENT,
	user_id						INT UNSIGNED NOT NULL,
	contact_type_id				INT UNSIGNED NOT NULL,	
	contact_sub_type_id			INT UNSIGNED NOT NULL,
	type_desc					VARCHAR(200),
	contact_value				VARCHAR(100) NOT NULL,
	contact_value_type			VARCHAR(10)  NOT NULL,
	is_active					TINYINT,
	effective_date				DATETIME,
	expiry_date					DATETIME DEFAULT '9999-12-31',
	CONSTRAINT cc_contact_details_pk PRIMARY KEY (contact_id),
	CONSTRAINT cc_contact_details_chk1 CHECK (contact_value_type IN ('string', 'integer')),
	CONSTRAINT cc_contact_details_chk2 CHECK (is_active IN (0,1)),
	CONSTRAINT cc_contact_details_fk1 FOREIGN KEY (user_id) REFERENCES cc_user_info(user_id),
	CONSTRAINT cc_contact_details_fk2 FOREIGN KEY (contact_type_id,contact_sub_type_id) REFERENCES config_contact_sub_type(contact_type_id,contact_sub_type_id)
)
ENGINE = InnoDB;


/*
	[cc_occupation_details]
		--Store information related to employment/work/occupation of user.
		--occupation type and sub-type will be stored in respective config tables. Here we will store their keys.
		--For quicker reference we have created a column type_desc here. So if occupation is 'IT' and sub-type is 'DBA' then type_desc will save something like 'IT-DBA'.
*/
CREATE TABLE cc_occupation_details (
	id						INT UNSIGNED AUTO_INCREMENT,
	user_id					INT UNSIGNED NOT NULL,
	occupation_type_id		INT UNSIGNED,
	occupation_sub_type_id	INT UNSIGNED,
	type_desc				VARCHAR(200),
	is_current				TINYINT	 NOT NULL,
	designation_id			INT UNSIGNED,
	employer_name			VARCHAR(100),
	employer_full_name		VARCHAR(2000),
	location_id				INT UNSIGNED NOT NULL,
	office_address_id		INT UNSIGNED NOT NULL,
	start_date				DATETIME,
	end_date				DATETIME DEFAULT '9999-12-31',
	CONSTRAINT cc_occupation_details_pk PRIMARY KEY (id),
	CONSTRAINT cc_occupation_details_chk1 CHECK (is_current IN (0,1)),
	CONSTRAINT cc_occupation_details_fk1 FOREIGN KEY (user_id) REFERENCES cc_user_info(user_id),
	CONSTRAINT cc_occupation_details_fk2 FOREIGN KEY (occupation_type_id,occupation_sub_type_id) REFERENCES config_occupation_sub_type(occupation_type_id,occupation_sub_type_id),
	CONSTRAINT cc_occupation_details_fk3 FOREIGN KEY (designation_id) REFERENCES config_designation_details(designation_id),
	CONSTRAINT cc_occupation_details_fk4 FOREIGN KEY (location_id) REFERENCES config_city(city_id),
	CONSTRAINT cc_occupation_details_fk5 FOREIGN KEY (office_address_id) REFERENCES cc_address_details(address_id)
)
ENGINE = InnoDB;

/*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
||					   Interaction/Order/Event table. 					||
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/

/*
	[cc_transaction_details]
		--details of order/donation placed by user. Not storing items here. 
*/
CREATE TABLE cc_transaction_details(
	transaction_id			BIGINT	UNSIGNED AUTO_INCREMENT,
	user_id					INT UNSIGNED,
	business_id				INT UNSIGNED,
	tx_status				TINYINT UNSIGNED,
	due_date				DATETIME,
	when_created			DATETIME,
	assigned_contact_id		INT UNSIGNED,
	when_modified			DATETIME,
	contact_last_worked		INT UNSIGNED,
	tx_priority				TINYINT UNSIGNED,
	tx_mode					VARCHAR(10),
	pickup_date				DATETIME,
	pickup_location_id		INT UNSIGNED,
	delivery_date			DATETIME,
	delivery_location_id	INT UNSIGNED,
	estimated_value			BIGINT	UNSIGNED,
	description				VARCHAR(4000),
	CONSTRAINT cc_transaction_details_pk PRIMARY KEY (transaction_id),
	CONSTRAINT cc_transaction_details_fk1 FOREIGN KEY (user_id) REFERENCES cc_user_info(user_id),
	CONSTRAINT cc_transaction_details_fk2 FOREIGN KEY (business_id) REFERENCES config_business_info(business_id),
	CONSTRAINT cc_transaction_details_fk3 FOREIGN KEY (pickup_location_id) REFERENCES cc_address_details(address_id),
	CONSTRAINT cc_transaction_details_fk4 FOREIGN KEY (delivery_location_id) REFERENCES cp_address_details(address_id),
	CONSTRAINT cc_transaction_details_fk5 FOREIGN KEY (tx_status) REFERENCES config_tx_status(tx_status),
	CONSTRAINT cc_transaction_details_fk6 FOREIGN KEY (assigned_contact_id) REFERENCES cp_contact_person(contact_person_id),
	CONSTRAINT cc_transaction_details_fk7 FOREIGN KEY (contact_last_worked) REFERENCES cp_contact_person(contact_person_id),
	CONSTRAINT cc_transaction_details_chk1 CHECK(tx_mode IN ('pickup', 'delivery'))
)
ENGINE = InnoDB;

/*
	[cc_transaction_items]
		--Item details of order/donation placed by user.
*/
CREATE TABLE cc_transaction_items(
	transaction_id				BIGINT	UNSIGNED,
	item_id						SMALLINT UNSIGNED,
	item_type					INT UNSIGNED,
	name						VARCHAR(2000),
	quantity					INT UNSIGNED,
	is_special_arrangement_req	TINYINT,
	use_by_date					DATETIME,
	approx_value				BIGINT	UNSIGNED,
	CONSTRAINT cc_transaction_items_pk PRIMARY KEY (transaction_id, item_id),
	CONSTRAINT cc_transaction_items_fk1 FOREIGN KEY (transaction_id) REFERENCES cc_transaction_details(transaction_id),
	CONSTRAINT cc_transaction_items_fk2 FOREIGN KEY (item_type) REFERENCES config_donation_item_type(item_type)
	
)
ENGINE = InnoDB;


/*
	[cc_tx_event_detail]
		--Store user/business events related to donation order/transaction.
		--This is for future use. In first release we can skip this.
		--Will be useful in analytics/reporting.
		--Not adding any foreign key constraints as of now. We will consider to impact of performance before adding any constraints.
			--But data in this table should come via some API so that it will have correct values like user, contact, event etc.
		--Event type will be referred from config_event_type table.	
		--event_date:: datetime when that event occured.
		--elapsed_time:: number of milli-seconds elapsed since epoch (1-Jan-1970) and event_date.
*/
CREATE TABLE cc_tx_event_detail(
	event_id					BIGINT UNSIGNED AUTO_INCREMENT,
	event_date					DATETIME,
	elapsed_time				BIGINT UNSIGNED,
	event_type_id				SMALLINT UNSIGNED,
	user_id						INT UNSIGNED,
	business_id					INT UNSIGNED,
	contact_person_id			INT UNSIGNED,
	event_attr1					SMALLINT UNSIGNED,
	event_attr2 				SMALLINT UNSIGNED,
	event_attr3					SMALLINT UNSIGNED,
	event_attr4					SMALLINT UNSIGNED,
	event_attr5					SMALLINT UNSIGNED,
	event_attr6					VARCHAR(4000),
	session_id					VARCHAR(4000),
	CONSTRAINT cc_event_detail_pk PRIMARY KEY (event_id)
)
ENGINE = InnoDB;

/*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
||					   Survey/Feedback tables. 							||
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/

/*
	[config_survey_questions]
	[config_survey_question_options]
		--Store questions and their details here.
		--Questions can be related to experience an user had while using the website which does not have a fixed right answer or they can be questions having a specific answer.
		--is_fixed_answer:: 0 if question does not have a right answer (most of the questions will be of this type), 1 if question as a correct answer.
			--If this column is 1 then is_right_answer column of config_survey_question_options table will indicate correct answer.
*/
CREATE TABLE config_survey_questions(
	question_id					INT UNSIGNED AUTO_INCREMENT,
	qyestion_type				VARCHAR(100),
	question					VARCHAR(2000),
	is_fixed_answer				TINYINT UNSIGNED,
	CONSTRAINT config_survey_questions_pk PRIMARY KEY (question_id),
	CONSTRAINT config_survey_questions_chk1 CHECK (qyestion_type IN ('multiple choice question', 'radio button', 'check box', 'text answer')),
	CONSTRAINT config_survey_questions_chk2 CHECK (is_fixed_answer IN (0, 1))
)
ENGINE = InnoDB;

CREATE TABLE config_survey_question_options(
	question_id					INT UNSIGNED,
	option_id					INT UNSIGNED,
	option_text					VARCHAR(1000),
	is_right_answer				TINYINT UNSIGNED,
	CONSTRAINT config_survey_question_options_pk PRIMARY KEY (question_id, option_id),
	CONSTRAINT config_survey_question_options_chk1 CHECK (is_right_answer IN (0, 1)),
	CONSTRAINT config_survey_question_options_fk FOREIGN KEY (question_id) REFERENCES config_survey_questions(question_id)
)
ENGINE = InnoDB;

/*
	[cc_survey_details]
	[cc_survey_questions]
	[cc_survey_text]
		--Store user question, their responses, other feedback (in text column).
		--business_id, transaction_id:: If survey being conducted post donation then reference of that NGO and donation else null. Hidden field (user does not require to fill this).
		--Keeping some redundant information  (user_name, email etc) here. This is in case a user chooses not to register but sill wises to give feedback. In this case user_id will be null.
		
*/
CREATE TABLE cc_survey_details(
	survey_id					BIGINT UNSIGNED AUTO_INCREMENT,
	user_id						INT UNSIGNED,
	user_name					VARCHAR(100),
	email_id					VARCHAR(100),
	type						VARCHAR(100),
	business_id					INT UNSIGNED,
	transaction_id				INT UNSIGNED,
	CONSTRAINT cc_survey_details_pk PRIMARY KEY (survey_id),
	CONSTRAINT cc_survey_details_fk1 FOREIGN KEY (user_id) REFERENCES cc_user_info(user_id),
	CONSTRAINT cc_survey_details_fk2 FOREIGN KEY (business_id) REFERENCES config_business_info(business_id),
	CONSTRAINT cc_survey_details_fk3 FOREIGN KEY (transaction_id) REFERENCES cc_transaction_details(transaction_id),
	CONSTRAINT cc_survey_details_chk CHECK (type IN ('post donation completion', 'feedback and suggestions', 'post website visit', 'general'))
)
ENGINE = InnoDB;

CREATE TABLE cc_survey_questions(
	survey_id					BIGINT UNSIGNED,
	question_id					INT UNSIGNED,
	selected_option				INT UNSIGNED,
	CONSTRAINT cc_survey_questions_pk PRIMARY KEY (survey_id, question_id),
	CONSTRAINT cc_survey_questions_fk1 FOREIGN KEY (survey_id) REFERENCES cc_survey_details(survey_id),
	CONSTRAINT cc_survey_questions_fk2 FOREIGN KEY (question_id) REFERENCES config_survey_questions(question_id)
)
ENGINE = InnoDB;

CREATE TABLE cc_survey_text(
	survey_id					BIGINT UNSIGNED,
	survey_message				TEXT,
	CONSTRAINT cc_survey_text_pk PRIMARY KEY (survey_id),
	CONSTRAINT cc_survey_text_fk1 FOREIGN KEY (survey_id) REFERENCES cc_survey_details(survey_id)
)
ENGINE = InnoDB;
