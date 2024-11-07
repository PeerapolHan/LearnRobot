***Settings***
Library     SeleniumLibrary

***Variables***
${url}      file:///c%3A/Users/peeha/Desktop/learnRobot/ep01/ep01_small_excercise.html
${browser}      chrome
${options}      add_experimental_option("detach",True)

***Keywords***

***Test Cases***
TC-input text
    Open Browser    ${url}      ${browser}      options=${options}
    
    Input Text      id=username-box       input username
    Input Text      //div[@v="password"]/input      input password
    Input Text      //input[@doppio="nickname"]     input nickname

TC-Dropdown
    select from list by label       company     Doppio  

TC-Checkbox
    select checkbox     id=op1
    checkbox should be selected     id=op1

TC-clickbutton
    Click element       id=use-me