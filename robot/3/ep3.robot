*** Settings ***
Library         RequestsLibrary
Library         String
Library         Collections


*** Test Case ***
TC01-worng username or password return error
                           #nameSession
        Create Session      assetSession        http://localhost:8082
        ${req_body}=        Create Dictionary   username=doppio     password=12345
        ${resp}     POST On Session     assetSession        /login      json=${req_body}        expected_status=401
        Should Be Equal     ${resp.json()["status"]}        error
        Should Be Equal     ${resp.json()["message"]}       invalid username or password

TC02-Get Asset List From GET API correctly
        #call API to login   
        Create Session      assetSession             http://localhost:8082
        ${req_body}=    Create Dictionary   username=doppio  password=weBuildBestQa
        ${resp}=    POST On Session     assetSession    /login      json=${req_body}
        #get token
        ${token}=       Set Variable    ${resp.json()["message"]}
        ${headers}=     Create Dictionary       token=${token}
        # #call Get API to get asset (with token) and verify status code is 200
        ${get_resp}=    GET On Session          assetSession    /assets          headers=${headers}
        #check response contains at least 1 assets
        ${count}=       Get Length      ${get_resp.json()}
        ${morethanone}=    Evaluate        ${count}>1
        Should Be True          ${morethanone}
        
TC-003 Verify that get asset API always require valid token
        #call asset API with invalid token or with no token 
        Create Session         assetSession              http://localhost:8082
        ${req_body}=    Create Dictionary       username=doppio         password=weBuildBestQa
        ${resp}=        POST On Session         assetSession    /login          json=${req_body}        
        # check response code = 401 
        ${get_resp}=    GET On Session          assetSession    /assets         expected_status=401
        # check error message 
        Should Be Equal         ${get_resp.json()["message"]}           you do not have access to this resource          

TC-004 Verify that create asset API can work correctly 
        #call create asset API (POST /assets) with valid token 
        Create Session          assetSession            http://localhost:8082
        ${req_body}=    Create Dictionary       username=doppio         password=weBuildBestQa
        ${resp}=        POST On Session         assetSession    /login          json=${req_body}   

        ${token}=       Set Variable    ${resp.json()["message"]}   
        ${token_key}=   Create Dictionary       token=${token}
        ${random_id}=           Generate Random String          7       [LETTERS][NUMBERS]
        ${req_json_dic}=    Create Dictionary       assetId=${random_id}  assetName=MacBook     assetType=9     inUse=false
        ${resp_json_dic}=   POST On Session         assetSession    /assets      json=${req_json_dic}           headers=${token_key}

        # check response code = 200     
        ${status_code}=       convert to string         ${resp_json_dic.status_code}        
        Should Be Equal         ${status_code}          200
        # check status message = success
        Should Be Equal         ${resp_json_dic.json()["status"]}           success

        # check that created asset can be returned from GET /assets
        ${get_resp}=    GET On Session          assetSession    /assets         headers=${token_key}

TC-005 Verify that cannot create asset with duplicated ID 
        #call create asset with valid token but use duplicate asset ID 
        Create Session          assetSession            http://localhost:8082
        ${req_body}=            Create Dictionary       username=doppio         password=weBuildBestQa     
        ${resp}=                POST On Session         assetSession    /login          json=${req_body}   
        ${token}=               Set Variable    ${resp.json()["message"]}
        ${token_key}=           Create Dictionary               token=${token}

        ${req_json_dic}=        Create Dictionary       assetId=zPdZ8Do  assetName=MacBook     assetType=9     inUse=false
        ${resp_json_dic}=       POST On Session         assetSession    /assets         json=${req_json_dic}            headers=${token_key}        
        # check status message 
        Should Be Equal         ${resp_json_dic.json()["status"]}       failed
        # check error message 
        ${get_assetId}=       Set Variable               ${req_json_dic}[assetId]  
        Should Be Equal         ${resp_json_dic.json()["message"]}              id : ${get_assetId} is already exists , please try with another id
        # check that no duplicated asset returned from GET /assets
        ${get_resp}=   GET On Session    assetSession   /assets         headers=${token_key}
        ${unique_items}=    Remove Duplicates    ${get_resp.json()}
        # Log To Console    Original List: ${get_resp.json()}
        # Log To Console    Unique Items: ${unique_items}
        Should Be Equal    ${get_resp.json()}    ${unique_items}
        # ${count_Original}=       Get Length      ${get_resp.json()}
        # ${count_Unique}=        Get Length      ${unique_items}
        # log to Console          count_Original : ${count_Original}
        # log to Console          count_Unique : ${count_Unique}
        
        # FOR    ${item}  IN    @{get_resp.json()}
        #         ${asset_id}=  Set Variable  ${item["assetId"]}
        #         # Log To Console  ${asset_id}
        # END

TC-006 Verify that modify asset API can work correctly 
        #call modify asset with valid token and try to change name of some asset 
        Create Session          assetSession            http://localhost:8082
        ${req_body}=    Create Dictionary       username=doppio         password=weBuildBestQa
        ${resp}=        POST On Session         assetSession    /login          json=${req_body}   

        ${token}=       Set Variable    ${resp.json()["message"]}   
        ${token_key}=   Create Dictionary       token=${token}

        #${random_Name}=           Generate Random String          10       [LETTERS]
        ${req_json_dic}=    Create Dictionary       assetId=a005  assetName=TestnewNameAgain4    assetType=100     inUse=true
        ${resp_json_dic}=   PUT On Session         assetSession    /assets      json=${req_json_dic}           headers=${token_key}
        
        #check status message = success 
        should be equal         ${resp_json_dic.json()["status"]}       success
        #call get api to check that asset Name has been changed 
        ${get_resp}=            GET On Session          assetSession    /assets         headers=${token_key}
        ${value}=       Get From Dictionary     ${req_json_dic}      assetName
        Should Be Equal         ${get_resp.json()[2]['assetName']}     ${value}
        #log to console          ${get_resp.json()[0]['assetName']},${req_json_dic}[assetName]

TC-007 Verify that delete asset API can work correctly
        #call delete asset 
        Create Session          assetSession            http://localhost:8082
        ${req_body}=    Create Dictionary       username=doppio         password=weBuildBestQa
        ${resp}=        POST On Session         assetSession    /login          json=${req_body}   

        ${token}=       Set Variable    ${resp.json()["message"]}   
        ${token_key}=   Create Dictionary       token=${token}
        ${Del_resp}=            DELETE On Session          assetSession    /assets/T9a1Srx         headers=${token_key}
        #call GET to check that asset has been deleted 
        ${get_resp}=            GET On Session          assetSession    /assets         headers=${token_key}
        # ${value}=       Get From Dictionary     ${get_resp.json()[3]}     ${get_resp.json()[3]}
        log to console          ${get_resp.json()[4]}
        Should Not Be Equal         ${get_resp.json()[4]["assetId"]}            T9a1Srx
        
TC-008 Verify that cannot delete asset which ID does not exists 
        #call delete asset with non-existing id 
        Create Session          assetSession            http://localhost:8082
        ${req_body}=    Create Dictionary       username=doppio         password=weBuildBestQa
        ${resp}=        POST On Session         assetSession    /login          json=${req_body}   

        ${token}=       Set Variable    ${resp.json()["message"]}   
        ${token_key}=   Create Dictionary       token=${token}
        ${Del_resp}=            DELETE On Session          assetSession    /assets/a001         headers=${token_key}
        #check error message 
        Should Be Equal         ${Del_resp.json()["message"]}           cannot find this id in database