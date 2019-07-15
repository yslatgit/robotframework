*** Settings ***
Suite Setup       SET_UP
Test Teardown     Close Window
Resource          share_keywords.txt

*** Keywords ***
SET_WEB_CONF
    #Set Environment Variable    G_WEB_HOST    http://oa.tahoecn.com    #线上
    #Set Environment Variable    G_WEB_URL    /ekp/login.jsp    #线上
    Set Environment Variable    G_WEB_HOST    http://ucssotest.tahoecndemo.com:9988    #测试
    Set Environment Variable    G_WEB_URL    /logout?ReturnURL=http%3A%2F%2Foa.tahoecndemo.com%3A8080%2Fportal%2Findex.html&sysId=OA    #测试
    Set Environment Variable    G_TEST_ADDR    %{G_WEB_HOST}%{G_WEB_URL}
    Set Environment Variable    G_URL    http://www.baidu.com

SET_G_VAR
    Set Environment Variable    G_SQAROOT    D:\\robotframework    #Root Directory
    Set Environment Variable    G_LOG    %{G_SQAROOT}\\logs    #Log Directory
    Set Environment Variable    G_TOTAL_RESULT    %{G_SQAROOT}\\total_result    #Test Result
    Set Environment Variable    G_RESUORCE    %{G_SQAROOT}\\resource    #Root Resource
    #Browser
    Set Environment Variable    G_BROWSER_TYPE    gc    #Type For Browser

SET_UP
    ${time}    Evaluate    datetime.datetime.now()    datetime
    Log    test start time is ${time}
    #SERVICE_MONITOR    12306
    SET_WEB_CONF
    SET_G_VAR

SERVICE_MONITOR
    [Arguments]    ${port}
    Open Connection    192.168.25.129
    Login    root    root
    ${result}    Execute Command    lsof -i:${port}
    ${status}    Run Keyword and Return Status    Should Not Be Equal    ${result}    ${EMPTY}
    Run Keyword IF    ${status}    Log    服务已经启动继续测试
    ...    ELSE    StartCommand    nohup /home/ysl/tomcat/bin/startup.sh
