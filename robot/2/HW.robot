*** Settings ***
Library    AppiumLibrary

*** Keywords ***
Open Test App
    Open Application    remote_url=http://127.0.0.1:4723
    ...    deviceName=TestDevice
    ...    platfromVersion=14.0
    ...    platformName=Android
    ...    automationName=UiAutomator2
    ...    appPackage=com.material.components	
    ...    appActivity=com.material.components.activity.MainMenu
Close Popup
    Wait Until Page Contains Element    id=com.material.components:id/bt_close    30s
    Click Element    id=com.material.components:id/bt_close
click navigation 
    Wait Until Page Contains Element    xpath=//android.widget.LinearLayout[android.widget.TextView[@text='Expansion Panels']]    30s
    Click Element    xpath=//android.widget.LinearLayout[android.widget.TextView[@text='Expansion Panels']]
Select Basic btn
    Wait Until Page Contains Element    xpath=//android.widget.LinearLayout[android.widget.TextView[@text='Basic']]    30s
    Click Element    xpath=//android.widget.LinearLayout[android.widget.TextView[@text='Basic']]

Click input navigationbar
    Wait Until Page Contains Element    id=com.material.components:id/bt_toggle_input   30s
    Click Element    id=com.material.components:id/bt_toggle_input

Radio Select
    Wait Until Page Contains Element    xpath=//android.widget.RadioButton[@text="Male"]    30s            
    Click Element    xpath=//android.widget.RadioButton[@text="Male"]

click SAVE btn
    Wait Until Page Contains Element    id=com.material.components:id/bt_save_input    30s
    Click Element    id=com.material.components:id/bt_save_input
    Wait Until Page Contains    text=Data saved
    
*** Test Cases ***
HW Open Test App
    Open Test App
HW Close Popup
    Close Popup
HW click navigation
    click navigation 
HW Select Basic btn
    Select Basic btn
HW Click input navigationbar
    Click input navigationbar
HW Radio Select
    Radio Select
HW click SAVE btn
    click SAVE btn



