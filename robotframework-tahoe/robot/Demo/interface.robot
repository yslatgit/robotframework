*** Settings ***
Suite Teardown
Resource          ../share_keywords.txt

*** Test Cases ***
get_request
    ${cookies}    get_current_user_cookie
    Create Session    api    http://oa.tahoecndemo.com:8080/portal/menu/allMenu    \    ${cookies}
    ${re}    Get Request    api    /
    Log    ${re.content.decode("utf8")}
    Log    ${re.headers}

post_request
    ${cookies}    get_current_user_cookie
    ${headers}    Create Dictionary    Content-Type=application/x-www-form-urlencoded    #charset=UTF-8
    ${data}    Create Dictionary    modelName=groupDynamics    methodName=page    paramJson={"fdHierarchyId":"15997392202078fbd0fbf964484ba587","pageNum":"1","pageSize":"2"}
    Create Session    api    http://oa.tahoecndemo.com:8080/portal/commonPost/getValue    ${headers}    ${cookies}
    ${re}    Post Request    api    /    ${data}
    #Log    ${re.content.decode("utf8")}
    Log    ${re}

login_interface
    ${headers}    Create Dictionary    Content-Type=application/x-www-form-urlencoded    Referer=http://ucssotest.tahoecndemo.com:9988/logout?ReturnURL=http%3A%2F%2Foa.tahoecndemo.com%3A8080%2Fportal%2Findex.html&sysId=OA
    ${cookies}    Create Dictionary    JSESSIONID=4AE6D27116C166C11B0AC8BA9390BD7B
    ${data}    Create Dictionary    username=vgaoge    password=MTIzNDU2YXMxNHU1OWcyM2I=    deCodePassword=as14u59g23b    pictureCode=    rememberPwd=0
    ...    ReturnURL=http%3A%2F%2Foa.tahoecndemo.com%3A8080%2Fportal%2Findex.html    sysId=OA
    ${auth}    Create List    vgaoge    123456
    create session    api    http://ucssotest.tahoecndemo.com:9988/loginpost    \    \    auth=${auth}
    ${re}    post request    api    /
    ${coo}    get cookies

data_from_excel
    ${data}    Get Data From Excel    %{G_RESUORCE}\\ride.xlsx    ride    1
    log    ${data[0]}
    log    ${integer}

aa
    #open browser    http://www.baidu.com/    360
    open browser    http://oa.tahoecn.com/ekp/login.jsp    360
    #Wait Until Element Is Visible    j_username    1000
    #Input Text    j_username    123
    Input Text    kw    456

*** Keywords ***
get_current_user_cookie
    G_Login    vgaoge    123456
    ${data}    Get Cookies
    ${cookies}    handle cookies    ${data}
    [Teardown]    close window
    [Return]    ${cookies}
