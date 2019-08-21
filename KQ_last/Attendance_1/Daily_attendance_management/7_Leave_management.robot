*** Settings ***
Documentation     请假单管理
Suite Setup       G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[7]/a
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
    [Documentation]    高级搜索（姓名+请假类型）
    #Click Element    Xpath=//div[@class="fe-advanceSearch"]    #点击高级搜索
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    杜一    #输入姓名
    Sleep    1
    Click Element    Xpath=//input[@placeholder="选择"]    \    #点击选择类型
    Sleep    1
    Click Element    Xpath=//div[@x-placement="bottom-start"]//li[9]    \    #选择类型
    Sleep    1
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Wait Until Page Contains    提交人
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[4]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    公出
    [Teardown]    G_Clear_Search_Form

Advanced_search_by_name_and_status
    [Documentation]    高级搜索（姓名+审批状态）
    #Click Element    Xpath=//div[@class="fe-advanceSearch"]    #点击高级搜索
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    杜一    #输入姓名
    Sleep    0.5
    Click Element    Xpath=//input[@placeholder="选择审批状态"]    \    #点击选择审批状态
    Sleep    0.5
    Click Element    Xpath=//div[@x-placement="bottom-start"]//li[1]    \    #选择待审
    Sleep    0.5
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Wait Until Page Contains    提交人
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[7]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    待审
    [Teardown]    G_Clear_Search_Form

Advanced_search_by_gender
    [Documentation]    高级搜索（姓名+审批状态）
    #Click Element    Xpath=//div[@class="fe-advanceSearch"]    #点击高级搜索
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    杜一    #输入姓名
    Click Element    Xpath=//input[@placeholder="选择性别"]    \    #点击选择性别
    Sleep    0.5
    Click Element    Xpath=//div[@x-placement="bottom-start"]//li[1]    \    #选择男
    Sleep    0.5
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Wait Until Page Contains    提交人
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    杜一
    [Teardown]    G_Clear_Search_Form

Advanced_search_by_gender_error
    [Documentation]    高级搜索（姓名+审批状态）
    #Click Element    Xpath=//div[@class="fe-advanceSearch"]    #点击高级搜索
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    杜一    #输入姓名
    Sleep    0.5
    Click Element    Xpath=//input[@placeholder="选择性别"]    \    #点击选择性别
    Sleep    0.5
    Click Element    Xpath=//div[@x-placement="bottom-start"]//li[2]    \    #选择女
    Sleep    0.5
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Wait Until Page Contains    提交人
    Sleep    2
    Page Should Contain    暂无数据
    Sleep    2
    Click Element    Xpath=//div[@class="fe-advanceSearch"]    \    #点击高级搜索
    [Teardown]

delete_leave
    [Tags]
    [Setup]
    Create Leave
    Wait Until Page Contains    工号
    G_InputText    baixu
    Wait Until Page Contains    工号
    Sleep    2
    Click Element    Xpath=//div[@class="v-checkbox-group"]/table/tbody/tr/td[1]/div
    Sleep    1
    G_Click_Button    2    #点击删除
    Page Should Contain    确定删除请假单
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Page Should Contain    暂无数据
    [Teardown]    G_ClearName

delete_batch_leave
    [Tags]
    Create Leaves
    Wait Until Page Contains    工号
    G_InputText    baijunjie,baixu
    Sleep    1
    G_Click_Button    3    #点击删除
    Sleep    3
    Page Should Contain    是否按当前搜索条件批量删除?
    Sleep    2
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    2
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    2
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
    ${info}    Get Data From Excel    %{G_FILEPATH}    请假单1    #从导出的excel中读取数据
    ${result}    DB_data    ${sql[8][0]}
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
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    请假单1    #从导出的excel中读取数据
    ${info_len}    Get Length    ${info_xls}
    ${res}    DB_DATA    ${sql[16][0]}
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
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    请假单1    #从导出的excel中读取数据
    ${info_len}    Get Length    ${info_xls}
    Should Be Equal As Strings    ${info_len-1}    ${page_num}
    [Teardown]    G_Clear_Search_Form

create_leave
    [Documentation]    创建请假单
    [Setup]    G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[7]/a
    Clear_7_20
    Wait Until Page Contains    工号
    Sleep    3
    G_InputText    艾慧
    Wait Until Page Contains    工号
    Sleep    1
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
    Click Element    Xpath=//input[@placeholder="选择假单类型"]    #单机选择假单类型
    Sleep    0.1
    Click Element    Xpath=//div[@x-placement="bottom-start"]//li[1]    #选择类型（工伤假）
    #Input Text    Xpath=//div[@placeholders="选择假单开始时间"]/input    2019-07-30 05:25
    #Input Text    Xpath=//div[@placeholders="选择假单结束时间"]/input    2019-07-31 05:25
    Select_Date    Xpath=//div[@placeholders="选择假单开始时间"]/input    Xpath=//div[@placeholders="选择假单开始时间"]//table/tr[2]/td[2]    #选择开始日期
    Select_Date    Xpath=//div[@placeholders="选择假单结束时间"]/input    Xpath=//div[@placeholders="选择假单结束时间"]//table/tr[3]/td[3]    #选择结束日期
    Sleep    2    #等待计算时间
    G_Click_Button    5    #点击保存
    Sleep    3
    #Page Should Contain    新增成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Wait Until Page Contains    工号
    Sleep    2
    ${page_num_2}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    ${result}    Calculate Difference    ${page_num}    ${page_num_2}
    Should Be Equal As Strings    ${result}    1
    Sleep    3
    [Teardown]    GG

create_leaves
    [Documentation]    创建请假单
    [Setup]    G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[7]/a    # GG
    Change_Person_1
    Wait Until Page Contains    工号
    Sleep    3
    G_Click_Button    1    #点击新增
    Wait Until Page Contains    工号
    Sleep    5
    Click Element    Xpath=//div[@class="el-dialog__header"]//input[@placeholder="选择性别"]
    Sleep    1
    Click Element    Xpath=//div[@x-placement="bottom-start"]/div[1]/div[1]//li[2]
    Sleep    1
    Click Element    Xpath=//div[@class="el-dialog__header"]//span[@class="el-checkbox__inner"]
    Sleep    2
    Double Click Element    Xpath=//div[@class="el-dialog__body"]//table[@class="v-table-btable"]/tbody/tr[1]    #双击第一个人
    Wait Until Page Contains    保存
    Sleep    2
    Click Element    Xpath=//input[@placeholder="选择假单类型"]    #单机选择假单类型
    Sleep    0.1
    Click Element    Xpath=//div[@x-placement="bottom-start"]//li[4]    #选择类型（妇女节假）
    #Input Text    Xpath=//div[@placeholders="选择假单开始时间"]/input    2019-07-30 05:25
    #Input Text    Xpath=//div[@placeholders="选择假单结束时间"]/input    2019-07-31 05:25
    Select_Date    Xpath=//div[@placeholders="选择假单开始时间"]/input    Xpath=//div[@placeholders="选择假单开始时间"]//table/tr[2]/td[2]    #选择开始日期
    Select_Date    Xpath=//div[@placeholders="选择假单结束时间"]/input    Xpath=//div[@placeholders="选择假单结束时间"]//table/tr[3]/td[3]    #选择结束日期
    Sleep    5    #等待计算时间
    G_Click_Button    5    #点击保存
    Sleep    3
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Wait Until Page Contains    工号
    ${res}    DB_DATA    ${sql[22][0]}
    Should Be Equal As Strings    ${res[0][0]}    8
    Execute Sql String    ${sql[23][0]}
    Change_Person_2
    [Teardown]    GG

*** Keywords ***
Select_Date
    [Arguments]    ${loc_one}    ${loc_two}
    Click Element    ${loc_one}    #点开日历
    Sleep    0.1
    Click Element    ${loc_two}    #选择日期
    Sleep    0.1
    Click Element    ${loc_two}    #选择小时
    Sleep    0.1
    Click Element    ${loc_two}    #选择分钟
    Sleep    0.1

Create Leave
    ${cookies}    Get_GaoQi1_Cookies
    POST_REQ    http://testkq.tahoecn.com:8800/taiheattendance/leave/buildLeaveBill    {"leaveApply":{"employeeID": "baixu","leaveID": "D7E5A634-1C6F-47D1-8A55-7BE3AC4F00F6","beginDateTime": "2019-07-19 08:00","endDateTime": "2019-07-19 12:00","leaveTitle":"请事假","reasons": "家里有事","applyID": 23123 ,"applyStatus": 9 }}    ${cookies}
    Sleep    3

Create Leaves
    ${cookies}    Get_GaoQi1_Cookies
    POST_REQ    http://testkq.tahoecn.com:8800/taiheattendance/leave/buildLeaveBill    {"leaveApply":{"employeeID": "baijunjie","leaveID": "D7E5A634-1C6F-47D1-8A55-7BE3AC4F00F6","beginDateTime": "2019-07-19 08:00","endDateTime": "2019-07-19 12:00","leaveTitle":"请事假","reasons": "家里有事","applyID": 23123 ,"applyStatus": 9 }}    ${cookies}
    Sleep    1
    POST_REQ    http://testkq.tahoecn.com:8800/taiheattendance/leave/buildLeaveBill    {"leaveApply":{"employeeID": "baixu","leaveID": "D7E5A634-1C6F-47D1-8A55-7BE3AC4F00F6","beginDateTime": "2019-07-19 08:00","endDateTime": "2019-07-19 12:00","leaveTitle":"请事假","reasons": "家里有事","applyID": 23123 ,"applyStatus": 9 }}    ${cookies}
    Sleep    2

Clear_7_20
    [Documentation]    清除7月20日艾慧的请假单
    ${cookies}    Get_GaoQi1_Cookies
    POST_REQ    http://testkq.tahoecn.com:8800/taiheattendance/leave/buildLeaveBill    {"leaveApply":{"employeeID": "aihui","leaveID": "D7E5A634-1C6F-47D1-8A55-7BE3AC4F00F6","beginDateTime": "2019-07-01 01:00","endDateTime": "2019-07-10 20:00","leaveTitle":"请事假","reasons": "家里有事","applyID": 23123 ,"applyStatus": 0 }}    ${cookies}
    Sleep    3

Change_Person_1
    DB_Connection
    Execute Sql String    update tahoe_atnd.dbo.kq_user set dr=1 \ where pk_psndoc not in (select pk_psndoc from tahoe_atnd.dbo.kq_user where pk_deptdoc='15a7f350f9719f85b3b598140c596e9b' and dr=0)

Change_Person_2
    DB_Connection
    Execute Sql String    truncate table tahoe_atnd.dbo.kq_user
    Execute Sql String    insert into tahoe_atnd.dbo.kq_user select * from \ tahoe_atnd.dbo.kq_user_BAK
