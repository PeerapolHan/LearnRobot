*** settings ***
Library 			SeleniumLibrary

*** Variables ***
${message}			My Message

*** Keywords ***
Say Hello
	Log To Console 			ThisIsSayHello

*** Test cases ***
TC-001 Verify that when input correct username and password then user can login
	Open Browser 	file:///C:/Users/peeha/Desktop/learnRobot/ep01/ex06.html 		browser=chrome		options=add_experimental_option("detach", True)
	# Input Text		id = username-box		testusername
	# Input Text		id = password-box		textpassword
	
	# Input Text		xpath = //input[@v="user"]		input username using xpath
	# Input Text		xpath = //input[@v="password"]		input password using xpath
	
	# Input Text		xpath = //div[@v="username"]/input		input username
	# Input Text		xpath = //div[@v="password"]/input		input password
	
	# Input Text		xpath = //div[contains(@v,"username")]/input		input by contain
	# Input Text		xpath = //div[contains(@v,"password")]/input		input password by contains

	# Input Text		xpath = //div[span[@c="Username"]]/input		input span c
	# Input Text		xpath = //div[span[@c="Password"]]/input		input span c password
	
	# Input Text		xpath = //div[span[text()="User:"]]/input		span text input 
	# Input Text		xpath = //div[span[text()="Pass:"]]/input		span text input pass

	Input Text		xpath = //div[@p="xyz" and @k="abc"]/input		input and
	Input Text		xpath = //div[2][@k="abc"]/input        input xyz
	Input Text		xpath = //div[3][@p="xyz"]/input		input nickname by index

	# Input Text 		xpath=//div[@p='xyz' and @k='abc']/input 		example06666,
	# Input Text 		xpath=//input[@v='password'] 		TestPassword
	
	



