*** Settings ***
Force Tags
Resource          ../share_keywords.txt

*** Test Cases ***
111
    Connect To Database Using Custom Params    pyodbc    "Driver={SQL Server};Server=10.0.104.238;Port=1433;Database=tahoe_atnd;UID=KQ;PWD=KQpassword;"
    ${var}    query    select lat from \ [tahoe_sec].[dbo].[tbm_mobiledata] where cusercode='gaoqi1'
    #LOG    ${var[0]}
    #${AA}    Get Length    ${var}
    ${res}    format_to_list    ${var}
    ${len}    get length    ${res}
    LOG    ${len}
    #${info_xls}    Get Data From Excel    D:\\测试\\员工信息2019-07-31_18-37.xls    员工信息1
    #log    ${info_xls.pop(0)}
    #Lists Should Be Equal    ${info_xls}    ${res}

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
    ${aa}    Create List    你好    啦啦
    ${bb}    Create List    你好    啦啦    哈哈
    Log    *********************
    List Should Contain Sub List    ${bb}    ${aa}

666
    : FOR    ${i}    IN RANGE    1    5
    \    log    ${i}
    \    Run keyword IF    "${i}"=="1" or "${i}"=="4"    Log    dadada
    ${res}    DB_data    ${check_daily_leave_info}
    log    ${res}

777
    ${aa}    set variable    高崎
    LOG    ${aa.split(",")}
    ${bb}    Create List    ${aa.split(",")}

888
    ${res}    DB_DATA    ${sql[4][0]}
    log    ${res[0][0]}

999
    [Setup]    G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[2]/a
    Sleep    3
    ${var}    Change_Start_Date    Xpath=//div[@placeholders="选择开始日期"]    2019-06-01

1
    ${num}    DB_Data    select dr \ from [tahoe_atnd].[dbo].[kq_user] where cusercode='cairongyao'

*** Keywords ***
Change_Start_Date
    [Arguments]    ${loc}    ${type}    ${exp_date}
    [Documentation]    改变日期（不考虑跨年的情况）
    Sleep    3
    ${current_date}    Get WebElement    ${loc}/input
    ${res}    Date Sub    ${current_date.get_attribute("value")}    ${exp_date}
    Click Element    ${loc}
    Sleep    2
    LOG    选择月份
    : FOR    ${i}    IN RANGE    ${res[0]}
    \    Sleep    1
    \    Click Element    ${loc}//span[@class="fe-datepicker-sub"]
    Sleep    2
    LOG    选择日期
    Click Element    ${loc}//table[@class="fe-calender-table"]/tr[2]/td[7]

DDD
    [Arguments]    ${type}
    [Documentation]    改变日期（不考虑跨年的情况）
    Run Keyword IF    "${type}"=="开始"    LOG    KAISHI1
    ...    ELSE IF    "${type}"=="结束"    LOG    结束
