*** Settings ***
Documentation     打卡查询
Suite Setup       G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[4]/div[2]/div[2]/a
Suite Teardown    G_C_A
Test Setup
Test Teardown
Force Tags
Resource          ../../share_keywords.txt

*** Test Cases ***
query_by_name
    [Documentation]    输入单个姓名查询
    [Setup]
    Wait Until Page Contains    工号
    G_InputText    郭力洁
    Sleep    2
    ${names}    Get Webelements    //*[@id="dimissioncard"]/div[2]/div[2]/div[1]/div/div[1]/div[1]/div[2]/div/table/tbody/tr/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    郭力洁
    [Teardown]    G_Clear_Name

query_by_names
    [Documentation]    输入多个姓名查询
    [Setup]
    Wait Until Page Contains    工号
    G_InputText    白朋飞,蔡小明
    Sleep    2
    ${exp_list}    Create List    白朋飞    蔡小明
    ${rep_list}    Create List
    Sleep    2
    ${names}    Get Webelements    Xpath=//*[@id="dimissioncard"]/div[2]/div[2]/div[1]/div/div[1]/div[1]/div[2]/div/table/tbody/tr/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Append To List    ${rep_list}    ${i.text}
    Lists Should Be Equal    ${exp_list}    ${rep_list}
    [Teardown]    G_Clear_Name

query_by_work_num
    [Documentation]    输入工号查询
    [Setup]
    Wait Until Page Contains    工号
    G_InputText    guolijie
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[contains(@class,"v-table-row") and contains(@class,"v-table-ckbj")]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    郭力洁
    [Teardown]    G_Clear_Name

query_by_name_num
    [Documentation]    输入工号和姓名查询
    [Setup]
    Wait Until Page Contains    工号
    G_InputText    白朋飞,caixiaoming
    Sleep    2
    ${exp_list}    Create List    baipengfei    caixiaoming
    ${rep_list}    Create List
    Sleep    2
    ${names}    Get Webelements    Xpath=//*[@id="dimissioncard"]/div[2]/div[2]/div[1]/div/div[1]/div[1]/div[2]/div/table/tbody/tr/td[1]/div/span
    : FOR    ${i}    IN    @{names}
    \    Append To List    ${rep_list}    ${i.text}
    Lists Should Be Equal    ${exp_list}    ${rep_list}
    [Teardown]    G_Clear_Name

query_by_department_and_name
    [Documentation]    输入部门以及姓名查询
    [Setup]
    Wait Until Page Contains    工号
    G_InputText    郭力洁,艾敬
    G_Department    信息流程部
    Wait Until Page Contains    工号
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[contains(@class,"v-table-row") and contains(@class,"v-table-ckbj")]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    郭力洁
    [Teardown]    G_ClearAll

query_by_department_and_name_error
    [Setup]
    Wait Until Page Contains    工号
    G_InputText    艾敬
    G_Department    信息流程部
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

query_by_date_change
    [Documentation]    修改日期区间查询
    [Setup]
    Wait Until Page Contains    工号
    Select_Date    Xpath=//div[@placeholders="选择开始日期"]/input    Xpath=//div[@placeholders="选择开始日期"]//span[@class="fe-datepicker-sub"]    Xpath=//div[@placeholders="选择开始日期"]//table/tr[3]/td[2]
    Sleep    1
    Select_Date    Xpath=//div[@placeholders="选择结束日期"]/input    Xpath=//div[@placeholders="选择结束日期"]//span[@class="fe-datepicker-sub"]    Xpath=//div[@placeholders="选择结束日期"]//table/tr[3]/td[5]
    G_InputText    艾慧
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

export_date_change
    [Documentation]    导出个人打卡数据
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    工号
    G_InputText    艾慧
    Sleep    3
    G_Click_Button    1    #点击导出
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
    Sleep    5
    ${info}    Get Data From Excel    %{G_FILEPATH}    离职打卡信息1    #获取导出数据
    log    ${info}
    ${len}    Get Length    ${info}
    : FOR    ${i}    IN RANGE    1    ${len}
    \    Should Be Equal As Strings    ${info[${i}][3]}    ${date_lists[${i}]}
    \    Should Be Equal As Strings    ${info[${i}][4]}    ${date_lists_2[${i}]}
    [Teardown]    G_Clear_Name

*** Keywords ***
Select_Date
    [Arguments]    ${loc_one}    ${loc_two}    ${loc_thr}
    Click Element    ${loc_one}    #点开日历
    Sleep    0.1
    Click Element    ${loc_two}    #点击上月
    Sleep    0.1
    Click Element    ${loc_two}    #点击上月
    Sleep    0.1
    Click Element    ${loc_two}    #点击上月
    Sleep    0.1
    Click Element    ${loc_thr}    #点击具体日期
