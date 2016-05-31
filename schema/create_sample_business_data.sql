/*
	Some sample NGO list.
*/
INSERT INTO config_business_info (name, full_name, establishment_date, base_city_id, headoffice_address, manager, objective)
SELECT 'Save Tree', 'Save Tree for future', '1970-01-01', c.city_id, '305, Lane No 15, Kalyani Nagar, Pune (MH)', 'Mr. Suraj Chandmal', 'Save Tree for future'
FROM config_city c
	INNER JOIN config_state s
		ON c.state_id = s.state_id
WHERE UPPER(c.name) = 'PUNE'
	AND s.state_code = 'MH';

INSERT INTO config_business_info (name, full_name, establishment_date, base_city_id, headoffice_address, manager, objective)
SELECT 'India Election Watch', 'India Election Watch', '1979-01-01', c.city_id, 'A1-305, Lane No 5, Gautam Nagar, Bhopal (MP)', 'Mr. Ajay Jain', 'A think tank for election reform and transparency.'
FROM config_city c
	INNER JOIN config_state s
		ON c.state_id = s.state_id
WHERE UPPER(c.name) = 'BHOPAL'
	AND s.state_code = 'MP';	
	
	
/*
	Some articles create by 'India Election Watch' to provide details of their operations (Kind of description).
*/	



COMMIT;

/*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
||		STEP #4																		||
||				Select Queries to display values.									||
||																					||
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/
/*
	Display list of NGO along with their base city.
*/
SELECT n.name AS ngo_name, c.name AS base_city_name, s.state_code, s.country 
FROM config_business_info n
	INNER JOIN config_city c
		ON n.base_city_id = c.city_id
	INNER JOIN config_state	s
		ON c.state_id = s.state_id;

/*
	Above query will display data in following format in console:
	
	+----------------------+----------------+------------+---------+
	| ngo_name             | base_city_name | state_code | country |
	+----------------------+----------------+------------+---------+
	| Save Tree            | Pune           | MH         | India   |
	| India Election Watch | Bhopal         | MP         | India   |
	+----------------------+----------------+------------+---------+
*/		

/*
	Create some sample articles.
*/
START TRANSACTION;
	INSERT INTO cp_business_article (business_id, topic)
	SELECT business_id, 'election, public office, india, corruption'
	FROM config_business_info
	WHERE name = 'India Election Watch';
	
	SET @v_article_id := LAST_INSERT_ID();
	
	SELECT @v_version_id := IFNULL((MAX(version_id) + 1),1)
	FROM cp_business_article_version
	WHERE article_id = @v_article_id;
	
	INSERT INTO cp_business_article_version (article_id, version_id, is_deleted, effective_date,  last_modified_date, article_state)
	VALUES ( @v_article_id, @v_version_id, 0, NOW(),NOW(),'P');
	
	SET @v_id := LAST_INSERT_ID();
	
	INSERT INTO cp_business_article_data (article_version_id, article_title, article_text, article_summary, article_keywords)
	VALUES (@v_id, 'Hello Friends','This is a first verison of sample article on politics. Author of this article is team of election watch.','First draft on election watch','politicsl, election, watch');
	
COMMIT;

/*
	Now if you want to get more details on a selected NGO use this query:
	
*/
