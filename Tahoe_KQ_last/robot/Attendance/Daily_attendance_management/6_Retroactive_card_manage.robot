*** Settings ***
Documentation     补签卡管理
Suite Setup       G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[8]/a
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
    [Documentation]    高级搜索（姓名+补签类型）
    #Click Element    Xpath=//div[@class="fe-advanceSearch"]    #点击高级搜索
    Sleep    1
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    杜一    #输入姓名
    Sleep    1
    Click Element    Xpath=//input[@placeholder="选择"]    \    #点击选择类型
    Sleep    1
    Click Element    Xpath=//div[@x-placement="bottom-start"]//li[1]    \    #选择类型（因公）
    Sleep    1
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Wait Until Page Contains    提交人
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[4]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    因公
    Click Element    Xpath=//div[@class="fe-advanceSearch"]    #点击高级搜索
    [Teardown]

export_one
    [Tags]    a
    [Setup]    G_Clear_Filepath
    Wait Until Page Contains    工号
    G_InputText    杜一
    Sleep    2
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    4    #点击导出
    Sleep    5
    ${info}    Get Data From Excel    %{G_FILEPATH}    补签卡1    #从导出的excel中读取数据
    ${result}    DB_data    ${sql[9][0]}
    Log    ${info.pop(0)}
    Lists Should Be Equal    ${result}    ${info}
    [Teardown]    G_Clear_Name

export_all
    [Tags]    a
    [Setup]    G_Clear_Filepath
    Wait Until Page Contains    工号
    Sleep    2
    #${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    4    #点击导出
    Sleep    5
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    补签卡1    #从导出的excel中读取数据
    ${info_len}    Get Length    ${info_xls}
    ${res}    DB_DATA    ${sql[15][0]}
    Should Be Equal As Strings    ${info_len-1}    ${res[0][0]}
    [Teardown]

export_name_and_department
    [Documentation]    高级搜索（姓名+部门）
    [Tags]    a
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
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    补签卡1    #从导出的excel中读取数据
    ${info_len}    Get Length    ${info_xls}
    Should Be Equal As Strings    ${info_len-1}    ${page_num}
    Sleep    2
    Click Element    Xpath=//div[@class="fe-advanceSearch"]    \    #点击高级搜索
    [Teardown]

delete_retroactive_card
    [Tags]
    [Setup]
    Create Card
    Wait Until Page Contains    工号
    G_InputText    baixu
    Wait Until Page Contains    工号
    Sleep    2
    Click Element    Xpath=//div[@class="v-checkbox-group"]/table/tbody/tr/td[1]/div
    Sleep    1
    G_Click_Button    2    #点击删除
    Page Should Contain    确定删除补签？
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Page Should Contain    暂无数据
    Sleep    2
    [Teardown]    G_ClearName

delete_batch_retroactive_card
    [Tags]
    Create_Cards
    Wait Until Page Contains    工号
    G_InputText    baiyu,baixu
    Sleep    1
    G_Click_Button    3    #点击删除
    Page Should Contain    是否按当前搜索条件批量删除?
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Page Should Contain    暂无数据
    Sleep    10
    [Teardown]    G_ClearName

create_retroactive_card_satrt
    [Setup]    G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[8]/a
    Clear    #恢复数据
    Wait Until Page Contains    工号
    G_InputText    艾慧
    Wait Until Page Contains    工号
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
    Click Element    Xpath=//div[@placeholders="选择补签时间"]/input    \    #点击时间
    Sleep    0.5
    Click Element    Xpath=//div[@placeholders="选择补签时间"]//table/tr[4]/td[7]    \    #选择日期（7月20）
    Sleep    0.5
    Click Element    Xpath=//div[@placeholders="选择补签时间"]//table/tr[3]/td[1]    \    #选择几时（8:00）
    Sleep    0.5
    Click Element    Xpath=//div[@placeholders="选择补签时间"]//table/tr[3]/td[1]    \    #选择几分（8：40）
    Sleep    2    #等待计算时间
    G_Click_Button    5    #点击保存
    Sleep    1
    Page Should Contain    新增成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Wait Until Page Contains    工号
    Sleep    2
    ${page_num_2}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    ${result}    Calculate Difference    ${page_num}    ${page_num_2}
    Should Be Equal As Strings    ${result}    1
    [Teardown]    GG

create_retroactive_card_end
    [Documentation]    创建补签卡当日结束时间
    ...    声明全局变量：G_START_END_TIME
    [Setup]    G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[8]/a
    Wait Until Page Contains    工号
    G_InputText    艾慧
    Wait Until Page Contains    工号
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
    Click Element    Xpath=//div[@placeholders="选择补签时间"]/input    \    #点击时间
    Sleep    0.5
    Click Element    Xpath=//div[@placeholders="选择补签时间"]//table/tr[4]/td[7]    \    #选择日期（7月20）
    Sleep    0.5
    Click Element    Xpath=//div[@placeholders="选择补签时间"]//table/tr[5]/td[4]    \    #选择几时（19:00）
    Sleep    0.5
    Click Element    Xpath=//div[@placeholders="选择补签时间"]//table/tr[1]/td[1]    \    #选择几分（19：00）
    Sleep    2    #等待计算时间
    G_Click_Button    5    #点击保存
    Sleep    1
    Page Should Contain    新增成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Wait Until Page Contains    工号
    Sleep    2
    ${page_num_2}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    ${result}    Calculate Difference    ${page_num}    ${page_num_2}
    Should Be Equal As Strings    ${result}    1
    ${start_end_time}    Create List
    ${info}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[5]/div/span
    : FOR    ${i}    IN    @{info}
    \    Append To List    ${start_end_time}    ${i.text}
    ${time_s}    Get Num From String    ${start_end_time[0]}    1
    ${time_e}    Get Num From String    ${start_end_time[1]}    1
    ${time_info}    Create List    ${time_s[0]}    ${time_e[0]}
    Set Environment Variable    G_START_END_TIME    ${time_info}
    [Teardown]    GG

*** Keywords ***
Select_Date
    [Arguments]    ${loc_one}    ${loc_two}
    [Documentation]    选择日期
    Click Element    ${loc_one}    #点开日历
    Sleep    0.1
    Click Element    ${loc_two}    #选择日期
    Sleep    0.1
    Click Element    ${loc_two}    #选择小时
    Sleep    0.1
    Click Element    ${loc_two}    #选择分钟
    Sleep    0.1

Create_Card
    [Documentation]    创建补签卡信息
    ${cookies}    Get_GaoQi1_Cookies
    POST_REQ    http://testkq.tahoecn.com:8800/taiheattendance/sign/buildSignBill    {"employeeID": "baixu","absenceDate": "2019-07-03 08:00","affairType": 1}    ${cookies}
    Sleep    3

Create_Cards
    [Documentation]    创建补签卡信息（多人）
    ${cookies}    Get_GaoQi1_Cookies
    POST_REQ    http://testkq.tahoecn.com:8800/taiheattendance/sign/buildSignBill    {"employeeID": "baixu","absenceDate": "2019-07-03 08:00","affairType": 1}    ${cookies}
    Sleep    1
    POST_REQ    http://testkq.tahoecn.com:8800/taiheattendance/sign/buildSignBill    {"employeeID": "baiyu","absenceDate": "2019-07-03 08:00","affairType": 1}    ${cookies}
    Sleep    2

Clear
    [Documentation]    清除艾慧的补签卡信息
    ${cookies}    Get_GaoQi1_Cookies
    POST_REQ    http://testkq.tahoecndemo.com:8800/taiheattendance/sign/deletesignbatch    {"pk_deptdoc":[],"deptname":null,"psnname":null,"signtype":null,"cusercode":null,"starttime":"2019-07-01","endtime":"2019-07-31","nameandcode":"艾慧"}    ${cookies}
    Sleep    3
