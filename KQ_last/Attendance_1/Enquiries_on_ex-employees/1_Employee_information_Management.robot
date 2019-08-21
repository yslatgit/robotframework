*** Settings ***
Documentation     员工信息
Suite Setup       G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[4]/div[2]/div[1]/a
Suite Teardown    G_C_A
Test Setup
Test Teardown
Force Tags
Test Timeout
Resource          ../../share_keywords.txt

*** Test Cases ***
query_by_name
    [Documentation]    根据名称查询（单一条件）
    Wait Until Page Contains    工号
    G_InputText    艾志忠
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    艾志忠
    [Teardown]    G_Clear_Name

query_by_vague_name
    [Documentation]    根据名称-模糊查询（单一条件）
    Wait Until Page Contains    工号
    G_InputText    艾
    Wait Until Page Contains    工号
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Contain    ${i.text}    艾
    [Teardown]    G_Clear_Name

query_by_work_num
    [Documentation]    根据工号查询（单一条件）
    Wait Until Page Contains    工号
    G_InputText    guolijie
    Wait Until Page Contains    工号
    Sleep    2
    ${num}    Get Webelement    Xpath=//tr[@class="v-table-row"]/td[1]/div/span
    Should Be Equal As Strings    ${num.text}    guolijie
    [Teardown]    G_Clear_Name

query_by_department
    [Documentation]    根据部门查询（输入单一部门名称）
    Wait Until Page Contains    工号
    G_Department    总裁办
    Wait Until Page Contains    工号
    Sleep    2
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    Should Be Equal As Strings    ${page_num}    6    #校验人数是否为25
    [Teardown]    G_Clear_Department

query_by_names
    [Documentation]    输入多个用户名查询
    Wait Until Page Contains    工号
    G_InputText    白朋飞,蔡小明
    ${exp_list}    Create List    白朋飞    蔡小明
    ${rep_list}    Create List
    Wait Until Page Contains    工号
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Append To List    ${rep_list}    ${i.text}
    Lists Should Be Equal    ${exp_list}    ${rep_list}
    [Teardown]    G_Clear_Name

query_by_name_num
    [Documentation]    输入用户名+工号查询
    Wait Until Page Contains    工号
    G_InputText    白朋飞,caixiaoming
    ${exp_list}    Create List    baipengfei    caixiaoming
    ${rep_list}    Create List
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[1]/div/span
    : FOR    ${i}    IN    @{names}
    \    Append To List    ${rep_list}    ${i.text}
    Lists Should Be Equal    ${exp_list}    ${rep_list}
    [Teardown]    G_Clear_Name

query_by_department_and_name
    [Documentation]    根据部门查询（输入单一部门名称）
    Wait Until Page Contains    工号
    G_InputText    郭力洁,艾敬
    G_Department    信息流程部
    Sleep    5
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    郭力洁
    [Teardown]    G_ClearAll

query_by_error
    [Documentation]    不存在用户查询
    G_InputText    笑傲江湖
    Sleep    5
    Page Should Contain    暂无数据
    [Teardown]    G_Clear_Name

page_num30_pagination
    Wait Until Page Contains    工号
    Sleep    3
    ${page_num}    Get Webelement    Xpath=//div[@id="childmsg2s"]//div[contains(@class,"paginationSes") and contains(@class,"actives")]
    Log    ${page_num.get_attribute("innerHTML")}
    ${content_lists}    Get Webelements    Xpath=//tr[@class="v-table-row"]
    ${list_count}    Get Length    ${content_lists}
    Should Be Equal As Numbers    ${list_count}    ${page_num.get_attribute("innerHTML")}
    ${info}    G_Get_PaginationText    Xpath=//span[@class="paginationText"]
    Should Be Equal As Strings    显示第 1 到第 30 条记录    ${info[0]}
    Click Element    Xpath=//ul[@class="el-pager"]//li[3]    \    #点击第三页
    Sleep    2
    ${info2}    G_Get_PaginationText    Xpath=//span[@class="paginationText"]
    Should Be Equal As Strings    显示第 61 到第 90 条记录    ${info2[0]}
    Should Be Equal As Strings    ${info[1]}    ${info2[1]}    #校验总数
    [Teardown]    G_Click_Search

page_num10_pagination
    Wait Until Page Contains    工号
    Sleep    2
    Mouse Over    Xpath=//div[@id="childmsg2s"]/div[1]
    Click Element    Xpath=//div[@id="childmsg2s"]/div[2]/div[1]
    Sleep    2
    ${page_num}    Get Webelement    Xpath=//div[@id="childmsg2s"]//div[contains(@class,"paginationSes") and contains(@class,"actives")]
    Log    ${page_num.get_attribute("innerHTML")}
    Sleep    2
    ${content_lists}    Get Webelements    Xpath=//tr[@class="v-table-row"]
    ${list_count}    Get Length    ${content_lists}
    Should Be Equal As Numbers    ${list_count}    ${page_num.get_attribute("innerHTML")}    #验证查询出来的条数
    ${info}    G_Get_PaginationText    Xpath=//span[@class="paginationText"]
    Should Be Equal As Strings    显示第 1 到第 10 条记录    ${info[0]}
    Click Element    Xpath=//ul[@class="el-pager"]//li[3]    \    #点击第三页
    Sleep    2
    ${info2}    G_Get_PaginationText    Xpath=//span[@class="paginationText"]
    Should Be Equal As Strings    显示第 21 到第 30 条记录    ${info2[0]}
    Should Be Equal As Strings    ${info[1]}    ${info2[1]}    #校验总数
    [Teardown]    G_Click_Search

page_num50_pagination
    Wait Until Page Contains    员工信息管理
    Sleep    2
    Mouse Over    Xpath=//div[@id="childmsg2s"]/div[1]
    Click Element    Xpath=//div[@id="childmsg2s"]/div[2]/div[3]
    Sleep    2
    ${page_num}    Get Webelement    Xpath=//div[@id="childmsg2s"]//div[contains(@class,"paginationSes") and contains(@class,"actives")]
    Log    ${page_num.get_attribute("innerHTML")}
    Sleep    1
    ${content_lists}    Get Webelements    Xpath=//tr[@class="v-table-row"]
    ${list_count}    Get Length    ${content_lists}
    Should Be Equal As Numbers    ${list_count}    ${page_num.get_attribute("innerHTML")}
    ${info}    G_Get_PaginationText    Xpath=//span[@class="paginationText"]
    Should Be Equal As Strings    显示第 1 到第 50 条记录    ${info[0]}
    Click Element    Xpath=//ul[@class="el-pager"]//li[3]    \    #点击第三页
    Sleep    2
    ${info2}    G_Get_PaginationText    Xpath=//span[@class="paginationText"]
    Should Be Equal As Strings    显示第 101 到第 150 条记录    ${info2[0]}
    Should Be Equal As Strings    ${info[1]}    ${info2[1]}    #校验总数
    [Teardown]    G_Click_Search

export_all
    [Documentation]    导出全部员工信息
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    工号
    Sleep    5
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    1    #点击导出
    Sleep    5    \    #增加等待时间确保文件已正常导出
    Wait Until Page Contains    工号
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    离职员工信息1    #从导出的excel中读取数据
    ${info_num}    Get Length    ${info_xls}    #数据条数
    Should Be Equal As Strings    ${page_num}    ${info_num-1}
    [Teardown]

export_department
    [Documentation]    导出全部员工信息
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    工号
    G_Department    信息流程部
    Sleep    5
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    1    #点击导出
    Sleep    2
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    离职员工信息1    #从导出的excel中读取数据
    ${info_num}    Get Length    ${info_xls}    #数据条数
    Should Be Equal As Strings    ${page_num}    ${info_num-1}
    [Teardown]    G_Clear_Department

export_one
    [Documentation]    导出一条信息
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    工号
    G_InputText    baipengfei
    Sleep    1
    G_Click_Button    1    #点击导出
    Sleep    5
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    离职员工信息1    #从导出的excel中读取数据
    ${info_len}    Get Length    ${info_xls}
    Should Be Equal As Strings    ${info_len-1}    1    \    #验证数据是否一致
    [Teardown]    G_Clear_Name

turn_in
    [Documentation]    根据名称查询（单一条件）
    [Tags]
    Wait Until Page Contains    工号
    G_InputText    caisijie
    Sleep    2
    Click Element    Xpath=//tr[@class="v-table-row"]
	Sleep    2
    G_Click_Button    2    #点击转在职按钮
    Sleep    15
    ${num}    DB_Data    select dr \ from [tahoe_atnd].[dbo].[kq_user] where cusercode='caisijie'    #转在职后dr为0
    Should Be Equal As Strings    ${num[0][0]}    0
    [Teardown]

*** Keywords ***
query_person
