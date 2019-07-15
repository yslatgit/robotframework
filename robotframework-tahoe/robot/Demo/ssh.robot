*** Settings ***
Resource          ../share_keywords.txt

*** Test Cases ***
connection
    [Documentation]    根据端口校验服务是否启动
    S_Connection    192.168.25.129    root    root
    Start Command    echo "" > /home/ysl/tomcat/logs/catalina.out
    SSHLibrary.Get File    /home/ysl/tomcat/logs/catalina.out    C:\\Users\\Administrator\\Desktop\\catalina.out

get_error_log
    [Tags]    smoke
    S_Connection    192.168.25.129    root    root
    get_specific_info    grep -A2 "测试" /home/ysl/tomcat/logs/catalina.out;ls;pwd
    guan    grep    -A2    测试    loc

db
    ${a}    Set Variable    100
    ${integer}    Convert To Integer    ${a}
    ${binary}    Convert To Binary    ${a}
    ${dict}    Create Dictionary    a=1    b=2
    Set To Dictionary    ${dict}    c=3
    log    ${dict}

aaaa
    S_Connection    192.168.25.131    root    root
    ${command}    S_Command    grep    "地址"    /home/ysl/tomcat/logs/catalina.out
    log    ${command}

*** Keywords ***
get_specific_info
    [Arguments]    ${command}
    Start Command    echo "" > /home/ysl/tomcat/logs/catalina.out
    Start Command    nohup /home/ysl/tomcat/bin/startup.sh
    Sleep    5
    ${data}    Execute Command    ${command}
    log    ${data}
    ${status}    Run Keyword and Return Status    Should Be Equal    ${data}    ${EMPTY}
    Run Keyword IF    ${status}    Log    服务已经正常启动
    ...    ELSE    S_R_Start_Tomcat
