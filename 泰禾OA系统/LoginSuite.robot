*** Settings ***
Resource          C:/Users/Administrator/Desktop/resource/RE.txt
Variables         C:/Users/Administrator/Desktop/resource/var.py

*** Test Cases ***
logincase
    :FOR    ${i}    IN    @{login_data}
    \    登录    ${i}[0]    ${i}[1]    ${i}[2]
