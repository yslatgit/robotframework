*** Settings ***
Documentation     打卡数据查询模块
Suite Setup       Set_Env    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[5]/a
Suite Teardown    GG
Test Setup
Test Teardown
Force Tags
Resource          ../../share_keywords.txt

*** Test Cases ***
query_by_name
    [Documentation]    输入单个姓名查询
    [Setup]
    Wait Until Page Contains    工号
    G_InputText    孙鹏
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[contains(@class,"v-table-row") and contains(@class,"v-table-ckbj")]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    孙鹏
    [Teardown]    G_Clear_Name

query_by_names
    [Documentation]    输入多个姓名查询
    [Setup]
    Wait Until Page Contains    工号
    G_InputText    孙鹏,艾敬
    Sleep    2
    ${exp_list}    Create List    艾敬    孙鹏
    ${rep_list}    Create List
    Sleep    2
    ${names}    Get Webelements    Xpath=//*[@id="mobileDataAcquisit"]/div[2]/div[2]/div[1]/div/div[1]/div[1]/div[2]/div/table/tbody/tr/td[2]/div
    : FOR    ${i}    IN    @{names}
    \    Append To List    ${rep_list}    ${i.text}
    Lists Should Be Equal    ${exp_list}    ${rep_list}
    [Teardown]    G_Clear_Name

query_by_work_num
    [Documentation]    输入工号查询
    [Setup]
    Wait Until Page Contains    工号
    G_InputText    sunpeng1
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[contains(@class,"v-table-row") and contains(@class,"v-table-ckbj")]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    孙鹏
    [Teardown]    G_Clear_Name

query_by_name_num
    [Documentation]    输入工号和姓名查询
    [Setup]
    Wait Until Page Contains    工号
    G_InputText    sunpeng1,艾敬
    Sleep    2
    ${exp_list}    Create List    艾敬    孙鹏
    ${rep_list}    Create List
    Sleep    2
    ${names}    Get Webelements    Xpath=//*[@id="mobileDataAcquisit"]/div[2]/div[2]/div[1]/div/div[1]/div[1]/div[2]/div/table/tbody/tr/td[2]/div
    : FOR    ${i}    IN    @{names}
    \    Append To List    ${rep_list}    ${i.text}
    Lists Should Be Equal    ${exp_list}    ${rep_list}
    [Teardown]    G_Clear_Name

query_by_department_and_name
    [Documentation]    输入部门以及姓名查询
    [Setup]
    Wait Until Page Contains    工号
    G_InputText    杜一,艾敬
    G_Department_Q    信息流程部
    Wait Until Page Contains    工号
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[contains(@class,"v-table-row") and contains(@class,"v-table-ckbj")]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    杜一
    [Teardown]    G_ClearAll

query_by_department_and_name_error
    [Setup]
    Wait Until Page Contains    工号
    G_InputText    艾敬
    G_Department_Q    信息流程部
    Wait Until Page Contains    工号
    Sleep    2
    Page Should Contain    暂无数据
    [Teardown]    G_ClearAll

click_page_num
    [Documentation]    点击分页（第3页）
    [Setup]
    Wait Until Page Contains    部门
    Sleep    3
    Click Element    Xpath=//ul[@class="el-pager"]/li[3]    \    #点击第三页
    [Teardown]    G_Click_Search

import_data
    [Documentation]    导入打卡数据
    Click Element    Xpath=//span[@class="querysBtns"]/button[1]    \    #点击导入
    Wait Until Page Contains    打卡数据
    Click Element    Xpath=//div[@class="upload-demo"]/div/button    \    #点击选择文件
    Sleep    1
    Upload File    E:\\Data\\打卡数据导入.xls
    Sleep    1
    Click Element    Xpath=//div[@class="upload-demo"]/button    \    #点击导入
    Sleep    2
    Click Button    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    G_InputText    anhuidong
    Wait Until Page Contains    工号
    Sleep    5
    ${date_lists}    Create List    \    #创建列表用来存放日期
    ${dates}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[1]/div/span
    ${aa}    Get Length    ${dates}
    : FOR    ${i}    IN    @{dates}
    \    Append To List    ${date_lists}    ${i.text}
    log    ${date_lists}
    ${info}    Get Data From Excel    E:\\Data\\打卡数据导入.xls    导入数据
    ${len}    Get Length    ${info}
    : FOR    ${i}    IN RANGE    1    ${len}
    \    Should Be Equal As Strings    ${info[${i}][1]}    ${date_lists[${i}]}
    [Teardown]    G_Clear_Name

query_by_date_default
    [Documentation]    默认日期区间查询
    [Setup]
    Wait Until Page Contains    工号
    G_InputText    孙鹏
    Sleep    3
    ${start_end_date}    Create List    \    #创建列表用来获取默认日期
    ${date_lists}    Create List    \    #创建列表用来存放日期
    ${dates}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[1]/div/span
    : FOR    ${i}    IN    @{dates}
    \    Append To List    ${date_lists}    ${i.text[:10]}
    log    ${date_lists}
    ${input_info}    Get Webelements    Xpath=//input[@type="text"]
    : FOR    ${info}    IN    @{input_info}
    \    Append To List    ${start_end_date}    ${info.get_attribute("value")}
    log    ${start_end_date[4]}
    ${return_info}    Compare Time    ${start_end_date[4]}    ${start_end_date[5]}    ${date_lists[1:]}
    Should Be Equal As Strings    ${return_info}    None
    [Teardown]    G_Clear_Name

query_by_date_change
    [Documentation]    默认日期区间查询
    [Setup]
    Click Element    Xpath=//div[@placeholders="选择开始日期"]/input
    Sleep    1
    Click Element    Xpath=//table[@class="fe-calender-table"]/tr[3]/td[1]
    Wait Until Page Contains    工号
    G_InputText    孙鹏
    Sleep    3
    Wait Until Page Contains    工号
    ${start_end_date}    Create List    \    #创建列表用来获取默认日期
    ${date_lists}    Create List    \    #创建列表用来存放日期
    ${dates}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[1]/div/span
    : FOR    ${i}    IN    @{dates}
    \    Append To List    ${date_lists}    ${i.text[:10]}
    log    ${date_lists}
    ${input_info}    Get Webelements    Xpath=//input[@type="text"]
    : FOR    ${info}    IN    @{input_info}
    \    Append To List    ${start_end_date}    ${info.get_attribute("value")}
    log    ${start_end_date[4]}
    ${return_info}    Compare Time    ${start_end_date[4]}    ${start_end_date[5]}    ${date_lists[1:]}
    Should Be Equal As Strings    ${return_info}    None
    [Teardown]    G_Clear_Name

export_date_default
    [Documentation]    导出个人打卡数据
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    工号
    G_InputText    孙鹏
    Sleep    3
    G_Click_Button    2    #点击导出
    Sleep    2
    ${info}    Get Data From Excel    C:\\Users\\Administrator\\Downloads    打卡信息1    #获取导出数据
    ${result}    DB_data    ${employee_clock_one}
    Log    ${info.pop(0)}
    Lists Should Be Equal    ${result}    ${info}
    [Teardown]    G_Clear_Name

export_date_change
    [Documentation]    导出个人打卡数据
    [Setup]    G_Clear_FilePath
    Click Element    Xpath=//div[@placeholders="选择开始日期"]/input
    Sleep    1
    Click Element    Xpath=//table[@class="fe-calender-table"]/tr[3]/td[1]
    Wait Until Page Contains    工号
    G_InputText    孙鹏
    Sleep    3
    G_Click_Button    2    #点击导出
    ${date_lists}    Create List    \    #创建列表用来存放日期
    ${date_lists_2}    Create List    \    #创建列表用来存放部门
    ${dates}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[1]/div/span
    : FOR    ${i}    IN    @{dates}
    \    Append To List    ${date_lists}    ${i.text}
    log    ${date_lists}
    ${dates_2}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{dates_2}
    \    Append To List    ${date_lists_2}    ${i.text}
    log    ${date_lists_2}
    ${info}    Get Data From Excel    C:\\Users\\Administrator\\Downloads    打卡信息1    #获取导出数据
    log    ${info}
    ${len}    Get Length    ${info}
    : FOR    ${i}    IN RANGE    1    ${len}
    \    Should Be Equal As Strings    ${info[${i}][3]}    ${date_lists[${i}]}
    \    Should Be Equal As Strings    ${info[${i}][4]}    ${date_lists_2[${i}]}
    [Teardown]    G_Clear_Name

export_date_change_s
    [Documentation]    导出多人数据其中一人为空
    [Setup]    G_Clear_FilePath
    Click Element    Xpath=//div[@placeholders="选择开始日期"]/input
    Sleep    1
    Click Element    Xpath=//table[@class="fe-calender-table"]/tr[3]/td[1]
    Wait Until Page Contains    工号
    G_InputText    孙鹏,白玉
    Sleep    1
    G_Click_Button    2    #点击导出
    Sleep    2
    Page Should Contain    暂无数据
    Click Element    //*[@id="mobileDataAcquisit"]/div[2]/div[2]/div[1]/div/div[1]/div[1]/div[2]/div/table/tbody/tr[2]
    Sleep    3
    ${date_lists}    Create List    \    #创建列表用来存放日期
    ${dates}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[1]/div/span
    : FOR    ${i}    IN    @{dates}
    \    Append To List    ${date_lists}    ${i.text}
    log    ${date_lists}
    ${info}    Get Data From Excel    C:\\Users\\Administrator\\Downloads    打卡信息1    #获取导出数据
    log    ${info}
    ${len}    Get Length    ${info}
    ${len_2}    Get Length    ${date_lists}
    Should Be Equal As Numbers    ${len}    ${len_2-1}
    [Teardown]    G_Clear_Name

query_by_departments
    [Documentation]    勾选多个部门查询
    [Setup]
    Wait Until Page Contains    工号
    Sleep    2
    Click Element    Xpath=//input[@placeholder="请选择部门"]    \    #点击选择部门
    Sleep    0.5
    Click Element    Xpath=//*[@id="vbar"]/div/div[3]/div/div[1]/div[2]/div[2]/div/span[2]    \    #点击集团总部
    Sleep    0.5
    Click Element    Xpath=//*[@id="vbar"]/div/div[3]/div/div[1]/div[2]/div[2]/div[2]/div[1]/div/label/span/span    \    #选中集团高层
    Sleep    0.5
    Click Element    Xpath=//*[@id="vbar"]/div/div[3]/div/div[1]/div[2]/div[2]/div/span[2]    \    #点击集团总部（22）
    Sleep    0.5
    Click Element    Xpath=//*[@id="vbar"]/div/div[3]/div/div[1]/div[2]/div[3]/div[1]/span[2]    \    #选择商业板块
    Sleep    0.5
    Click Element    Xpath=//*[@id="vbar"]/div/div[3]/div/div[1]/div[2]/div[3]/div[2]/div[1]/div/label/span/span    \    #点击总经办（4）
    Sleep    0.5
    Click Element    Xpath=//div[@class="fe-he-btnbox"]/button[1]    \    #点击确定
    [Teardown]    G_Clear_Department
