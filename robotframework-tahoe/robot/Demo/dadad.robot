*** Settings ***
Force Tags        test
Resource          ../share_keywords.txt
Variables         ../sql.py

*** Test Cases ***
111
    Connect To Database Using Custom Params    pyodbc    "Driver={SQL Server};Server=10.0.104.238;Port=1433;Database=tahoe_atnd;UID=KQ;PWD=KQpassword;"
    ${var}    query    ${daochu_one}
    #LOG    ${var[0]}
    #${AA}    Get Length    ${var}
    ${res}    format_to_list    ${var}
    LOG    ${res}
    ${info_xls}    Get Data From Excel    D:\\测试\\员工信息2019-07-31_18-37.xls    员工信息1
    log    ${info_xls.pop(0)}
    Lists Should Be Equal    ${info_xls}    ${res}

222
    Select_Date    Xpath=//div[@placeholders="选择开始日期"]/input    Xpath=//div[@placeholders="选择开始日期"]//span[@class="fe-datepicker-sub"]    Xpath=//div[@placeholders="选择开始日期"]//table/tr[3]/td[2]
    Sleep    1
    Select_Date    Xpath=//div[@placeholders="选择结束日期"]/input    Xpath=//div[@placeholders="选择结束日期"]//span[@class="fe-datepicker-sub"]    Xpath=//div[@placeholders="选择结束日期"]//table/tr[3]/td[5]

333
    log    ***************************************************************************************8
    #log    %{G_START_END_TIME}
    #log    %{G_WORK_TYPE}
    ${dd}    Create List    %{G_START_END_TIME}
    : FOR    ${i}    IN    @{dd}
    \    log    ${i}

444
    [Tags]
    ${aa}    Get Num From String    2019-07-04 09:00    1
    LOG    ${aa}

555
    Log    *********************
    Lists Should Be Equal    ${aa}    ${bb}
