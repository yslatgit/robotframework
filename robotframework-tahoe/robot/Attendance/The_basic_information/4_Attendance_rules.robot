*** Settings ***
Documentation     考勤规则
Suite Setup       Set_Env    Xpath=//*[@id="nav-box"]/div[5]/div[2]/div[4]/a
Resource          ../../share_keywords.txt

*** Test Cases ***
Leave rules
    [Documentation]    请假单规则
    Wait Until Page Contains    员工自助
    Input Text    Xpath=//div[@class="part-box"]/div[1]//input    -360
    Sleep    1
    G_Click_Button    1    #点击保存
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]
    Sleep    1
    ${cookies}    Get_GaoQi1_Cookies
    ${api_list}    Get Data From Excel    E:\\Data\\接口.xlsx    考勤规则-请假单
    ${len}    Get Length    ${api_list}
    :FOR    ${i}    IN RANGE    1    ${len}
    \    LOG    ${i+1}
    \    ${response_dict}    POST_REQ    ${api_list[${i}][0]}    ${api_list[${i}][1]}    ${cookies}
    \    ${res}    Compare Two Dict    ${api_list[${i}][2]}    ${response_dict}    ${api_list[${i}][3]}
    \    Should Be Equal As Strings    ${res}    True
    Input Text    Xpath=//div[@class="part-box"]/div[1]//input    -365    #恢复数据
    Sleep    1
    G_Click_Button    1    #点击保存
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]

Overtime rules
    [Documentation]    加班单规则
    Wait Until Page Contains    员工自助
    Input Text    Xpath=//div[@class="part-box"]/div[3]//input    -35
    Sleep    1
    G_Click_Button    1    #点击保存
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]
    Sleep    1
    ${cookies}    Get_GaoQi1_Cookies
    ${api_list}    Get Data From Excel    E:\\Data\\接口.xlsx    考勤规则-加班单
    ${len}    Get Length    ${api_list}
    :FOR    ${i}    IN RANGE    1    ${len}
    \    LOG    ${i+1}
    \    ${response_dict}    POST_REQ    ${api_list[${i}][0]}    ${api_list[${i}][1]}    ${cookies}
    \    ${res}    Compare Two Dict    ${api_list[${i}][2]}    ${response_dict}    ${api_list[${i}][3]}
    \    Should Be Equal As Strings    ${res}    True
    Input Text    Xpath=//div[@class="part-box"]/div[3]//input    -37    #恢复数据
    Sleep    1
    G_Click_Button    1    #点击保存
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]

replacement card rules
    [Documentation]    补签卡规则
    Wait Until Page Contains    员工自助
    Input Text    Xpath=//div[@class="part-box"]/div[5]//input    -360
    Sleep    1
    G_Click_Button    1    #点击保存
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]
    Sleep    1
    ${cookies}    Get_GaoQi1_Cookies
    ${api_list}    Get Data From Excel    E:\\Data\\接口.xlsx    考勤规则-补签卡
    ${len}    Get Length    ${api_list}
    :FOR    ${i}    IN RANGE    1    ${len}
    \    LOG    ${i+1}
    \    ${response_dict}    POST_REQ    ${api_list[${i}][0]}    ${api_list[${i}][1]}    ${cookies}
    \    ${res}    Compare Two Dict    ${api_list[${i}][2]}    ${response_dict}    ${api_list[${i}][3]}
    \    Should Be Equal As Strings    ${res}    True
    Input Text    Xpath=//div[@class="part-box"]/div[5]//input    -365    #恢复数据
    Sleep    1
    G_Click_Button    1    #点击保存
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]
