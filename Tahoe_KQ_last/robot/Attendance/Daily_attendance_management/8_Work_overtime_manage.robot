*** Settings ***
Documentation     加班单管理
Suite Setup       G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[6]/a
Suite Teardown    G_C_A
Force Tags
Resource          ../../share_keywords.txt

*** Test Cases ***
query_by_name
    Wait Until Page Contains    工号
    G_InputText    杜一
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    杜一
    [Teardown]    G_Clear_Name

query_by_work_num
    Wait Until Page Contains    工号
    G_InputText    duyi
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    杜一
    [Teardown]    G_Clear_Name

Advanced_search_by_name_and_work_num
    [Documentation]    高级搜索（姓名+工号）
    Click Element    Xpath=//div[@class="fe-advanceSearch"]    \    #点击高级搜索
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[1]/div/div/div/input    duyi    #输入工号
    Sleep    0.5
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    杜一    #输入姓名
    Sleep    0.5
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Sleep    0.5
    Wait Until Page Contains    提交人
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    杜一
    [Teardown]    G_Clear_Search_Form

Advanced_search_by_name_and_work_num_error
    [Documentation]    高级搜索（姓名+工号,姓名和工号不是同一人）
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[1]/div/div/div/input    duyi    #输入工号
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    孙鹏    #输入姓名
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Wait Until Page Contains    提交人
    Sleep    2
    Page Should Contain    暂无数据
    [Teardown]    G_Clear_Search_Form

Advanced_search_by_name_and_department
    [Documentation]    高级搜索（姓名+部门）
    #Click Element    Xpath=//div[@class="fe-advanceSearch"]    #点击高级搜索
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    杜一    #输入姓名
    Click Element    Xpath=//div[@class="fe-heightSerBox"]/form/div[2]/div[1]/div[1]/div/div/input    \    #点击部门
    Input Text    Xpath=//div[@class="querys"]//div[2]/input[1]    信息流程部    #输入要查询的部门名称
    Sleep    1
    Click Element    Xpath=//div[@class="querys"]//div[2]/i[2]    \    #点击查询
    Sleep    1
    Click Element    Xpath=//div[@class="fe-he-btnbox"]/button[1]    \    #点击确定按钮
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Wait Until Page Contains    提交人
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    杜一
    [Teardown]    G_Clear_Search_Form

Advanced_search_by_name_and_department_error
    [Documentation]    高级搜索（姓名+部门）部门下无此人
    #Click Element    Xpath=//div[@class="fe-advanceSearch"]    #点击高级搜索
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    杜一    #输入姓名
    Click Element    Xpath=//div[@class="fe-heightSerBox"]/form/div[2]/div[1]/div[1]/div/div/input    \    #点击部门
    Input Text    Xpath=//div[@class="querys"]//div[2]/input[1]    总裁办    #输入要查询的部门名称
    Sleep    1
    Click Element    Xpath=//div[@class="querys"]//div[2]/i[2]    \    #点击查询
    Sleep    1
    Click Element    Xpath=//div[@class="fe-he-btnbox"]/button[1]    \    #点击确定按钮
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Wait Until Page Contains    提交人
    Sleep    2
    Page Should Contain    暂无数据
    [Teardown]    G_Clear_Search_Form

Advanced_search_by_name_and_type
    [Documentation]    高级搜索（姓名+加班类型）
    #Click Element    Xpath=//div[@class="fe-advanceSearch"]    #点击高级搜索
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    杜一    #输入姓名
    Sleep    1
    Click Element    Xpath=//div[@class="fe-heightSerBox"]/form/div[3]/div[1]/div/div/div/div/input    \    #点击选择类型
    Sleep    1
    Click Element    Xpath=//div[@x-placement="bottom-start"]//li[1]    \    #选择类型
    Sleep    1
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Wait Until Page Contains    提交人
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[4]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    休息日加班
    [Teardown]    G_Clear_Search_Form

Advanced_search_by_name_and_status
    [Documentation]    高级搜索（姓名+审批状态）
    #Click Element    Xpath=//div[@class="fe-advanceSearch"]    #点击高级搜索
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    杜一    #输入姓名
    Sleep    0.5
    Click Element    Xpath=//div[@class="fe-heightSerBox"]/form/div[4]/div/div/div/div/div[1]/input    \    #点击选择审批状态
    Sleep    0.5
    Click Element    Xpath=//div[@x-placement="bottom-start"]//li[1]    \    #选择待审
    Sleep    0.5
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Wait Until Page Contains    提交人
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[8]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    待审
    [Teardown]    G_Clear_Search_Form

Advanced_search_by_subsidies_type
    [Documentation]    高级搜索（姓名+补贴方式）
    #Click Element    Xpath=//div[@class="fe-advanceSearch"]    #点击高级搜索
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    杜一    #输入姓名
    Sleep    0.5
    Click Element    Xpath=//div[@class="fe-heightSerBox"]/form/div[3]/div[2]/div/div/div/div[1]/input    \    #点击选择补贴方式
    Sleep    0.5
    Click Element    Xpath=//div[@x-placement="bottom-start"]//li[2]    \    #选择转存休
    Sleep    0.5
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Wait Until Page Contains    提交人
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[5]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    转存休
    Click Element    Xpath=//div[@class="fe-advanceSearch"]    #点击高级搜索
    [Teardown]

delete_work_overtime
    [Tags]
    [Setup]
    Create Work
    Wait Until Page Contains    工号
    G_InputText    baixu
    Wait Until Page Contains    工号
    Sleep    2
    Click Element    Xpath=//div[@class="v-checkbox-group"]/table/tbody/tr/td[1]/div
    Sleep    1
    G_Click_Button    2    #点击删除
    Page Should Contain    确定删除加班单?
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Page Should Contain    暂无数据
    Sleep    10
    [Teardown]    G_ClearName

delete_batch_work_overtime
    [Tags]
    Create Works
    Wait Until Page Contains    工号
    G_InputText    baijunjie,baixu
    Sleep    1
    G_Click_Button    3    #点击删除
    Page Should Contain    是否按当前搜索条件批量删除?
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Page Should Contain    暂无数据
    Sleep    10
    [Teardown]    G_ClearName

export_one
    [Setup]    G_Clear_Filepath
    Wait Until Page Contains    工号
    G_InputText    杜一
    Sleep    2
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    4    #点击导出
    Sleep    5
    ${info}    Get Data From Excel    %{G_FILEPATH}    加班单1    #从导出的excel中读取数据
    ${result}    DB_data    ${sql[7][0]}
    Log    ${info.pop(0)}
    Lists Should Be Equal    ${result}    ${info}
    [Teardown]    G_Clear_Name

export_all
    [Setup]    G_Clear_Filepath
    Wait Until Page Contains    工号
    Sleep    2
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    4    #点击导出
    Sleep    5
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    加班单1    #从导出的excel中读取数据
    ${info_len}    Get Length    ${info_xls}
    ${res}    DB_DATA    ${sql[14][0]}
    Should Be Equal As Strings    ${info_len-1}    ${res[0][0]}
    [Teardown]

export_name_and_department
    [Documentation]    高级搜索（姓名+部门）
    [Setup]    G_Clear_Filepath
    Click Element    Xpath=//div[@class="fe-advanceSearch"]    \    #点击高级搜索
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    杜一    #输入姓名
    Click Element    Xpath=//div[@class="fe-heightSerBox"]/form/div[2]/div[1]/div[1]/div/div/input    \    #点击部门
    Input Text    Xpath=//div[@class="querys"]//div[2]/input[1]    信息流程部    #输入要查询的部门名称
    Sleep    1
    Click Element    Xpath=//div[@class="querys"]//div[2]/i[2]    \    #点击查询
    Sleep    1
    Click Element    Xpath=//div[@class="fe-he-btnbox"]/button[1]    \    #点击确定按钮
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Wait Until Page Contains    提交人
    Sleep    2
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    4    #点击导出
    Sleep    5
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    加班单1    #从导出的excel中读取数据
    ${info_len}    Get Length    ${info_xls}
    Should Be Equal As Strings    ${info_len-1}    ${page_num}
    [Teardown]    G_Clear_Search_Form

create_work_overtime
    [Documentation]    创建加班单
    ...    新增全局变量：G_WORK_TYPE(加班类型)
    [Setup]    G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[6]/a
    Clear_7_20
    Wait Until Page Contains    工号    30
    Sleep    1
    G_InputText    艾慧
    Sleep    5
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    1    #点击新增
    Wait Until Page Contains    工号
    Sleep    5
    Input Text    Xpath=//div[@class="el-dialog__header"]/div[2]/input    艾慧
    Sleep    1
    Click Element    Xpath=//div[@class="el-dialog__header"]//div[2]/i[2]
    Sleep    2
    Double Click Element    Xpath=//div[@class="el-dialog__body"]//table[@class="v-table-btable"]/tbody/tr[1]    #双击第一个人
    Wait Until Page Contains    保存
    Sleep    2
    #Select_Date    Xpath=//div[@placeholders="选择加班开始时间"]/input    Xpath=//div[@placeholders="选择加班开始时间"]//table/tr[6]/td[3]    Xpath=//div[@placeholders="选择加班开始时间"]//table/tr[1]/td[1]    #选择开始日期
    #Select_Date    Xpath=//div[@placeholders="选择加班结束时间"]/input    Xpath=//div[@placeholders="选择加班结束时间"]//table/tr[6]/td[3]    Xpath=//div[@placeholders="选择加班结束时间"]//table/tr[1]/td[3]    #选择结束日期
    Work_Start_Time
    Work_End_Time
    Sleep    2    #等待计算时间
    G_Click_Button    5    #点击保存
    Sleep    1
    #Page Should Contain    新增成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Wait Until Page Contains    工号
    Sleep    2
    ${page_num_2}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    ${result}    Calculate Difference    ${page_num}    ${page_num_2}
    Should Be Equal As Strings    ${result}    1
    ${type_list}    Create List
    ${type_info}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[4]/div/span
    #: FOR    ${i}    IN    @{type_info}
    #    Append To List    ${type_list}    ${i.text}
    Set Environment Variable    G_WORK_TYPE    ${type_info[0].text}
    [Teardown]    GG

*** Keywords ***
Select_Date
    [Arguments]    ${loc_one}    ${loc_two}    ${loc_thr}
    Click Element    ${loc_one}    #点开日历
    Sleep    0.1
    Click Element    ${loc_two}    #选择日期
    Sleep    0.1
    Click Element    ${loc_two}    #选择小时
    Sleep    0.1
    Click Element    ${loc_thr}    #选择分钟
    Sleep    0.1

Work_Start_Time
    [Documentation]    开始加班时间
    Sleep    2
    Click Element    Xpath=//div[@placeholders="选择加班开始时间"]/input    \    #点击时间
    Sleep    0.5
    Click Element    Xpath=//div[@placeholders="选择加班开始时间"]//table/tr[4]/td[7]    \    #选择日期（7月20）
    Sleep    0.5
    Click Element    Xpath=//div[@placeholders="选择加班开始时间"]//table/tr[3]/td[1]    \    #选择几时（8:00）
    Sleep    0.5
    Click Element    Xpath=//div[@placeholders="选择加班开始时间"]//table/tr[3]/td[1]    \    #选择几分（8：40）

Work_End_Time
    [Documentation]    结束加班时间
    Sleep    2
    Click Element    Xpath=//div[@placeholders="选择加班结束时间"]/input    \    #点击时间
    Sleep    0.5
    Click Element    Xpath=//div[@placeholders="选择加班结束时间"]//table/tr[4]/td[7]    \    #选择日期（7月20）
    Sleep    0.5
    Click Element    Xpath=//div[@placeholders="选择加班结束时间"]//table/tr[5]/td[4]    \    #选择几时（19:00）
    Sleep    0.5
    Click Element    Xpath=//div[@placeholders="选择加班结束时间"]//table/tr[1]/td[1]    \    #选择几分（19：00）

Create Work
    ${cookies}    Get_GaoQi1_Cookies
    POST_REQ    http://testkq.tahoecn.com:8800/taiheattendance/overtime/buildOverTimeBill    {"otApply":{"employeeID": "baixu","leaveID": 0,"beginDateTime": "2019-07-11 08:00","endDateTime": "2019-07-11 12:00","timeLong":"4","leaveTitle": "平常加班","reasons": "工作需要","applyID": 0 ,"applyStatus": 9 }}    ${cookies}
    Sleep    3

Create Works
    ${cookies}    Get_GaoQi1_Cookies
    POST_REQ    http://testkq.tahoecn.com:8800/taiheattendance/overtime/buildOverTimeBill    {"otApply":{"employeeID": "baijunjie","leaveID": 0,"beginDateTime": "2019-07-11 08:00","endDateTime": "2019-07-11 12:00","timeLong":"4","leaveTitle": "平常加班","reasons": "工作需要","applyID": 0 ,"applyStatus": 9 }}    ${cookies}
    Sleep    1
    POST_REQ    http://testkq.tahoecn.com:8800/taiheattendance/overtime/buildOverTimeBill    {"otApply":{"employeeID": "baixu","leaveID": 0,"beginDateTime": "2019-07-11 08:00","endDateTime": "2019-07-11 12:00","timeLong":"4","leaveTitle": "平常加班","reasons": "工作需要","applyID": 0 ,"applyStatus": 9 }}    ${cookies}
    Sleep    2

Clear_7_20
    ${cookies}    Get_GaoQi1_Cookies
    POST_REQ    http://testkq.tahoecn.com:8800/taiheattendance/overtime/buildOverTimeBill    {"otApply":{"employeeID": "aihui","leaveID": 0,"beginDateTime": "2019-07-20 05:00","endDateTime": "2019-07-20 23:00","timeLong":"4","leaveTitle": "平常加班","reasons": "工作需要","applyID": 0 ,"applyStatus": 0 }}    ${cookies}
    Sleep    3
