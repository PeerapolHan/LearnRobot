*** Settings ***
Library    AppiumLibrary 

*** Keywords ***
Open Test App
    Open Application    remote_url=http://127.0.0.1:4723
    ...    deviceName=Test Device	
    ...    platformVersion=14.0	
    ...    platformName=Android	
    ...    automationName=UiAutomator2
    ...    app=/Users/peeha/Desktop/learnRobot/ep2_materialandroid/ep2/com.material.components.apk
    ...    appPackage=com.material.components	
    ...    appActivity=com.material.components.activity.MainMenu
  
Close Popup
    Wait Until Page Contains Element    id=com.material.components:id/bt_close    30s
    Click Element    id=com.material.components:id/bt_close
    
Click search btn
    Wait Until Page Contains Element    //android.widget.TextView[@content-desc="Search"]    30s
    Click Element    accessibility_id=Search

Input Into Searchbox
    [Arguments]    ${kw}
    Wait Until Page Contains Element    id=com.material.components:id/search_src_text    30s
    Input Text    id=com.material.components:id/search_src_text    ${kw}

Click btn navigation 
    Wait Until Page Contains Element    xpath=//android.widget.LinearLayout[android.widget.TextView[@text='Bottom Navigation'] and android.widget.TextView[@text='Basic']]    30s
    Click Element    xpath=//android.widget.LinearLayout[android.widget.TextView[@text='Bottom Navigation'] and android.widget.TextView[@text='Basic']]
click Card
    Wait Until Page Contains Element    android=UiSelector().className("android.widget.TextView").text("Cards")    30s
    Click Element    android=UiSelector().className("android.widget.TextView").text("Cards")
*** Test Cases ***
Open Test App on Android
    Open Test App
    Close Popup
    # Click search btn
    # Input Into Searchbox    Basic
    # Click btn navigation 
    click Card





    