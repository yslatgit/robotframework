*** Settings ***
Suite Setup       SET_UP
Test Teardown
Resource          share_keywords.txt

*** Keywords ***
SET_WEB_CONF
    #Set Environment Variable    G_WEB_HOST    http://oa.tahoecn.com    #线上
    #Set Environment Variable    G_WEB_URL    /ekp/login.jsp    #线上
    Set Environment Variable    G_WEB_HOST    http://ucssotest.tahoecndemo.com:9988    #测试
    Set Environment Variable    G_WEB_URL    /logout?ReturnURL=http%3A%2F%2Foa.tahoecndemo.com%3A8080%2Fportal%2Findex.html&sysId=OA    #测试
    Set Environment Variable    G_TEST_ADDR    %{G_WEB_HOST}%{G_WEB_URL}
    Set Environment Variable    G_URL    http://www.baidu.com
    #${list}    Create List    2019-07-20 08:40    2019-07-20 19:00
    #Set Environment Variable    G_START_END_TIME    ${list}

SET_G_VAR
    Set Environment Variable    G_SQAROOT    D:\\robotframework-tahoe    #Root Directory
    Set Environment Variable    G_FILE    %{G_SQAROOT}\\file    #Log Directory
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
