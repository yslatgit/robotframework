*** Settings ***
Documentation     员工班组管理
Suite Setup       G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[2]/a
Suite Teardown    G_C_A
Test Setup
Test Teardown
Force Tags
Resource          ../../share_keywords.txt

*** Test Cases ***
query_by_name
    [Documentation]    输入单一姓名查询
    [Setup]
    Wait Until Page Contains    工号
    G_InputText    杜一
    Sleep    2
    Wait Until Page Contains    工号
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[3]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    杜一
    ${Valid_time}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[5]/div/span
    Set Environment Variable    G_Valid_time    ${Valid_time[0].text[:10]}
    [Teardown]    G_Clear_Name

query_by_names
    [Documentation]    输入多个姓名查询
    [Setup]
    Wait Until Page Contains    工号
    G_InputText    白璐,艾慧
    ${exp_list}    Create List    艾慧    白璐
    ${rep_list}    Create List
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[3]/div/span
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
    ${num}    Get Webelement    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    Should Be Equal As Strings    ${num.text}    sunpeng1
    [Teardown]    G_Clear_Name

query_by_name_num
    [Documentation]    输入姓名，工号查询
    Wait Until Page Contains    工号
    G_InputText    艾慧,bailu1
    ${exp_list}    Create List    艾慧    白璐
    ${rep_list}    Create List
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[3]/div/span
    : FOR    ${i}    IN    @{names}
    \    Append To List    ${rep_list}    ${i.text}
    Lists Should Be Equal    ${exp_list}    ${rep_list}
    [Teardown]    G_Clear_Name

query_by_department
    [Documentation]    输入单一部门名称查询
    Wait Until Page Contains    工号
    G_Department    总裁办
    Wait Until Page Contains    工号
    Sleep    10
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    ${result}    DB_data    ${sql[2][0]}
    ${len}    Get Length    ${result}
    Should Be Equal As Strings    ${page_num}    ${len}
    [Teardown]    G_Clear_Department

query_by_department_and_name
    [Documentation]    输入部门名称和姓名查询
    Wait Until Page Contains    工号
    G_InputText    杜一,艾敬
    G_Department    信息流程部
    Sleep    5
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[3]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    杜一
    [Teardown]    G_ClearAll

export_all
    [Documentation]    导出所有的员工班组
    [Tags]
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    工号
    Sleep    5
    #${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    4    #点击导出
    Sleep    5
    ${info}    Get Data From Excel    %{G_FILEPATH}    员工班组1
    ${len}    Get Length    ${info}
    ${res}    DB_DATA    ${sql[12][0]}
    Should Be Equal As Strings    ${len-1}    ${res[0][0]}    \    #需要实时调整

export_one
    [Documentation]    导出个人的班组
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    工号
    G_InputText    孙鹏
    Wait Until Page Contains    工号
    G_Click_Button    4    #点击导出
    Sleep    5
    ${info}    Get Data From Excel    %{G_FILEPATH}    员工班组1
    ${result}    DB_data    ${sql[6][0]}
    Log    ${info.pop(0)}
    Lists Should Be Equal    ${result}    ${info}
    [Teardown]    G_Clear_Name

export_department
    [Documentation]    导出单一部门下人员的班组数据
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    工号
    G_Department    总裁办
    Wait Until Page Contains    工号
    Sleep    2
    G_Click_Button    4    #点击导出
    Sleep    5
    ${info}    Get Data From Excel    %{G_FILEPATH}    员工班组1
    ${res}    DB_DATA    ${sql[13][0]}
    LOG    ${info.pop(0)}
    Lists Should Be Equal    ${info}    ${res}
    [Teardown]    G_Clear_Department

export_department_and_name
    [Documentation]    导出单一部门下单人员的班组数据
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    工号
    G_Department    信息流程部
    G_InputText    孙鹏
    Wait Until Page Contains    工号
    G_Click_Button    4    #点击导出
    Sleep    5
    ${info}    Get Data From Excel    %{G_FILEPATH}    员工班组1
    ${len}    Get Length    ${info}
    Should Be Equal As Numbers    ${len-1}    3
    [Teardown]    G_ClearAll

delete_team_middle
    [Documentation]    删除中间的班组
    Wait Until Page Contains    工号
    G_InputText    孙鹏
    Sleep    3
    Click Element    Xpath=//div[@class="include-container"]//table[@class="v-table-btable"]/tbody/tr[2]    \    #选择班组
    Sleep    1
    G_Click_Button    2    #点击删除
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    1
    Page Should Contain    删除失败
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    [Teardown]    G_Clear_Name

delete_team_end
    [Documentation]    删除最后的班组
    Wait Until Page Contains    工号
    G_InputText    孙鹏
    Sleep    3
    Click Element    Xpath=//div[@class="include-container"]//table[@class="v-table-btable"]/tbody/tr[3]    \    #选择班组
    Sleep    1
    G_Click_Button    2    #点击删除
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    1
    Page Should Contain    删除失败
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    [Teardown]    G_Clear_Name

date_sort
    [Documentation]    检验班组是否按照时间排序
    Wait Until Page Contains    工号
    G_InputText    孙鹏
    Wait Until Page Contains    工号
    ${rep_list}    Create List
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[5]/div/span
    : FOR    ${i}    IN    @{names}
    \    Append To List    ${rep_list}    ${i.text}
    log    ${rep_list}
    ${result_info}    Time Sort    ${rep_list}
    Should Be Equal As Strings    ${result_info}    None
    [Teardown]    G_Clear_Name

create_team
    [Documentation]    创建新的班组
    Wait Until Page Contains    工号
    G_Click_Button    1    #点击新增
    Wait Until Page Contains    工号
    #Input Text    Xpath=//div[@class="include-container"]//input[@placeholder="请输入姓名/工号"]    艾敬    #给谁添加班组信息
    Sleep    1
    #Click Element    Xpath=//div[@class="include-container"]//div[@class="simpleChoice"]/i[2]    #点击查询
    Sleep    2
    Double Click Element    Xpath=//div[@class="include-container"]//table[@class="v-table-btable"]/tbody/tr[2]    #双击第一个人
    Wait Until Page Contains    保存
    Sleep    2
    Click Element    Xpath=//input[@placeholder="请选择"]    \    #点击班组
    Sleep    1
    Click Element    //div[@class="el-scrollbar"]/div[1]/ul/li[1]    \    #选择第一个班组
    Sleep    3
    Click Element    Xpath=//div[@placeholders="选择开始日期"]
    Click Element    Xpath=//table[@class="fe-calender-table"]/tr[2]/td[7]
    Sleep    1
    Click Element    Xpath=//span[@class="querysBtns"]/button[5]    \    #点击保存
    Sleep    1
    Page Should Contain    新增成功
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    [Teardown]

import_data
    [Documentation]    导入班组
    Wait Until Page Contains    工号
    G_InputText    艾敬
    Wait Until Page Contains    工号
    Sleep    3
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    ${init_num}    Set Variable    ${page_num}    #导入前条数
    G_Import_File    3    %{G_RESUORCE}\\员工班组数据导入.xls    文件已导入，正在处理

query_by_departments
    [Documentation]    勾选多个部门名称查询
    [Setup]    G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[2]/a
    Wait Until Page Contains    工号
    Sleep    3
    Click Element    Xpath=//input[@placeholder="选择部门"]    \    #点击选择部门
    Sleep    1
    Click Element    Xpath=//*[@id="vbar"]/div/div[3]/div/div[1]/div[2]/div[1]/div    \    #点击集团总部
    Sleep    1
    Click Element    Xpath=//*[@id="vbar"]/div/div[3]/div/div[1]/div[2]/div[1]/div[2]/div[1]/div/label/span/span    \    #选中集团高层
    Sleep    0.5
    Click Element    Xpath=//*[@id="vbar"]/div/div[3]/div/div[1]/div[2]/div[1]/div[2]/div[2]/div/label/span/span    \    #点击总裁办（23）
    Sleep    0.5
    Click Element    Xpath=//div[@class="fe-he-btnbox"]/button[1]    \    #点击确定
    Wait Until Page Contains    工号    30
    Wait Until Page Contains    工号    30
    Sleep    5
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    #Should Be Equal As Strings    ${page_num}    45
    [Teardown]
