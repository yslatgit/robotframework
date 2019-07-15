*** Settings ***
Suite Setup
Resource          ../share_keywords.txt

*** Test Cases ***
login_template
    [Documentation]    登录oa测试
    [Template]    login
    ${EMPTY}    ${EMPTY}    请填写用户名
    yang    ${EMPTY}    请填写密码
    ${EMPTY}    123    请填写用户名
    yang    123    用户名不存在或密码错误
    yangsonglin    123456    PASS

remember_pwd
    [Documentation]    登录时记住密码操作
    Open Browser    %{G_TEST_ADDR}    %{G_BROWSER_TYPE}
    Input Text    j_username    yangsonglin
    Input Text    j_password    123456
    #勾选记住密码
    Click Element    rememberPwd
    Click Element    Xpath=//a[@id='submit']
    Click Element    Xpath=//span[@class='admin_name']
    Click Element    Xpath=//div[@class='leave']/a
    ${name_obj}    Get Webelement    j_password
    Should Be Equal As Strings    ${name_obj.get_attribute("value")}    123456
    #不勾选记住密码
    Click Element    Xpath=//a[@id='submit']
    Click Element    Xpath=//span[@class='admin_name']
    Click Element    Xpath=//div[@class='leave']/a
    ${name_obj}    Get Webelement    j_password
    Should Be Equal As Strings    ${name_obj.get_attribute("value")}    ${EMPTY}

forget_pwd
    [Documentation]    登录时忘记密码操作
    Open Browser    %{G_TEST_ADDR}    %{G_BROWSER_TYPE}
    Click Element    id=forgetPassword
    Page Should Contain    找回密码

taixin_login
    [Documentation]    登录时点击泰信登录
    Open Browser    %{G_TEST_ADDR}    %{G_BROWSER_TYPE}
    Click Button    id=taixinLogin
    Page Should Contain    泰信扫码即可登录

mb_login
    [Documentation]    登录时点击手机号登陆
    Open Browser    %{G_TEST_ADDR}    %{G_BROWSER_TYPE}
    Click Button    id=mbLogin
    Page Should Contain    发送验证码
    [Teardown]

*** Keywords ***
login
    [Arguments]    ${username}    ${password}    ${expect_info}
    Log Many    ${username}    ${password}    ${expect_info}
    #Open Browser    %{G_TEST_ADDR}    %{G_BROWSER_TYPE}
    #Input Text    j_username    ${username}
    #Input Text    j_password    ${password}
    #Click Element    Xpath=//a[@id='submit']
    G_Login    ${username}    ${password}
    ${re_info}    Run Keyword And Ignore Error    Page Should Contain    杨松林
    ${login_info}    Run Keyword If    "${re_info[0]}"=="FAIL"    Get Text    errorPrompt
    ...    ELSE IF    "${re_info[0]}"=="PASS"    Set Variable    PASS
    Should Be Equal As Strings    ${login_info}    ${expect_info}
    Close Window
