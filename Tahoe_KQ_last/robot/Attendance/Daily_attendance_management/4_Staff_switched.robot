*** Settings ***
Documentation     员工调班
Suite Setup       G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[4]/a
Suite Teardown    G_C_A
Resource          ../../share_keywords.txt

*** Test Cases ***
query_by_name
    [Documentation]    根据名称查询
    Wait Until Page Contains    工号
    G_InputText    杜一
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[3]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    杜一
    [Teardown]    G_Clear_Name

query_by_work_num
    [Documentation]    根据工号查询
    Wait Until Page Contains    工号
    G_InputText    duyi
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[3]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    杜一
    [Teardown]    G_Clear_Name

query_by_names
    [Documentation]    根据多个姓名查询
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

query_by_department_and_name
    [Documentation]    根据姓名，部门查询
    Wait Until Page Contains    工号
    G_InputText    杜一,艾敬
    G_Department    信息流程部
    Sleep    5
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[3]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    杜一
    [Teardown]    G_ClearAll

query_by_department
    [Documentation]    根据部门查询
    Wait Until Page Contains    工号
    G_Department    信息流程部
    Sleep    5
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[4]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    信息流程部
    [Teardown]    G_Clear_Department

query_by_departments
    [Documentation]    勾选多个部门查询
    Wait Until Page Contains    工号
    Sleep    2
    Click Element    Xpath=//input[@placeholder="选择部门"]    \    #点击选择部门
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

query_by_error
    [Documentation]    根据名称查询（输入不存在的名称）
    Wait Until Page Contains    工号
    G_InputText    哒哒哒
    Sleep    2
    Page Should Contain    暂无数据
    [Teardown]    G_Clear_Name

export_one
    [Documentation]    导出个人调班表，检验条数
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    工号
    G_InputText    杜一
    Sleep    2
    G_Click_Button    3    #点击导出
    Sleep    5
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    员工调班1    #从导出的excel中读取数据
    ${info_len}    Get Length    ${info_xls}
    Should Be Equal As Strings    ${info_len-1}    1
    [Teardown]    G_Clear_Name

export_department
    [Documentation]    导出部门调班表，校验条数
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    工号
    G_Department    总裁办
    Sleep    2
    G_Click_Button    3    #点击导出
    Sleep    5
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    员工调班1    #从导出的excel中读取数据
    ${result}    DB_data    ${sql[2][0]}
    ${len}    Get Length    ${result}
    ${info_len}    Get Length    ${info_xls}
    Should Be Equal As Strings    ${info_len-1}    ${len}
    [Teardown]    G_Clear_Department

export_all
    [Documentation]    导出所有调班数据
    [Tags]    skip
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    工号
    Sleep    2
    G_Click_Button    3    #点击导出
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定
    Sleep    5
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    员工调班1    #从导出的excel中读取数据
    ${info_len}    Get Length    ${info_xls}
    Should Be Equal As Strings    ${info_len-1}    8060
    [Teardown]

staff_switch_one
    [Documentation]    根据某人某一天的班（排班-->休息）
    ${arg}    Set Variable    12
    ${list}    Create List
    Wait Until Page Contains    工号
    G_InputText    安铮
    Sleep    2
    Click Element    Xpath=//ul[@class="staff-days"]/li[${arg}]    \    #调当月第一周周四的班
    Sleep    0.5
    Click Element    Xpath=/html/body/div[2]/div[1]/div[1]/ul/li[1]
    Sleep    0.5
    Click Element    Xpath=//span[@class="querysBtns"]/button[1]    \    #点击调班
    Sleep    0.5
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定
    Wait Until Page Contains    工号
    Click Element    Xpath=//div[@class="simpleChoice"]/i[2]    \    #点击搜索
    Sleep    5
    ${page_info}    Get Webelements    Xpath=//ul[@class="staff-days"]/li[${arg}]//span[@class="dailyStaff"]
    Should Be Equal As Strings    ${page_info[0].text}    调
    ${result}    DB_data    ${sql[17][0]}
    Should Be Equal As Strings    ${result[0][0]}    0
    [Teardown]    G_Clear_Name

import_one
    [Documentation]    导入调班信息
    Wait Until Page Contains    工号
    G_Import_File    2    %{G_RESUORCE}\\员工调班数据导入.xls    文件已导入，正在处理
    Sleep    10
    #G_InputText    安铮
    #Wait Until Page Contains    工号
    #Sleep    2
    #${page_info}    Get Webelements    Xpath=//ul[@class="staff-days"]/li[2]//span[@class="dailyStaff"]    #li为取第几天的
    #Should Be Equal As Strings    ${page_info[0].text}    调
    ${info}    Format To List2    8:30i,GG1,10:0k
    ${res}    DB_Data    ${sql[11][0]}
    #List Should Contain Value    ${res}    ${info}
    List Should Contain Sub List    ${res}    ${info}
    [Teardown]

staff_switch_one_re
    [Documentation]    根据某人某一天的班（休息-->排班）
    [Setup]    G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[4]/a
    Wait Until Page Contains    工号
    G_InputText    安铮
    Sleep    2
    Click Element    Xpath=//ul[@class="staff-days"]/li[7]    \    #调当月第一周周四的班
    Sleep    0.5
    Click Element    Xpath=/html/body/div[2]/div[1]/div[1]/ul/li[2]
    Sleep    0.5
    Click Element    Xpath=//span[@class="querysBtns"]/button[1]    \    #点击调班
    Sleep    0.5
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定
    Sleep    2
    ${page_info}    Get Webelements    Xpath=//ul[@class="staff-days"]/li[7]//span[@class="dailyStaff"]
    Should Be Equal As Strings    ${page_info[0].text}    调
    ${result}    DB_data    ${sql[18][0]}
    ${info}    Create List    10:0a改
    List Should Contain Value    ${result}    ${info}
    [Teardown]    GG

download_template
    [Documentation]    查看模板是否为当前月模板
    [Tags]
    [Setup]    G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[4]/a
    G_Clear_Filepath    #清除文件路径
    Wait Until Page Contains    工号
    Click Element    Xpath=//span[@class="querysBtns"]/button[2]    \    #点击导入
    Sleep    2
    Click Element    Xpath=//p[@class="importP"]/span    \    #点击下载模板
    Sleep    5
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    导入数据    #从导出的excel中读取数据
    #${date}    G_Return_Date
    Should Be Equal As Strings    2019-07-01    ${info_xls[0][1]}

staff_switch_batch
    [Documentation]    批量调班
    [Setup]    G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[4]/a
    ${arg}    Set Variable    19
    Wait Until Page Contains    工号
    G_InputText    艾慧,艾敬
    Sleep    2
    Click Element    Xpath=//input[@value="1"]    \    #点击全选
    Sleep    0.5
    Click Element    Xpath=//ul[@class="staff-days"]/li[${arg}]    \    #调某一天的班
    Sleep    2
    Click Element    Xpath=/html/body/div[2]/div[1]/div[1]/ul/li[1]
    Sleep    0.5
    Click Element    Xpath=//span[@class="querysBtns"]/button[1]    \    #点击调班
    Sleep    0.5
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定
    Sleep    1
    ${page_info}    Get Webelements    Xpath=//ul[@class="staff-days"]/li[${arg}]//span[@class="dailyStaff"]    #校验艾慧的排班
    Should Be Equal As Strings    ${page_info[0].text}    调
    Sleep    1
    Click Element    Xpath=//input[@value="0"]    #取消选中
    Click Element    Xpath=//input[@value="1"]
    Sleep    1
    ${page_info_2}    Get Webelements    Xpath=//ul[@class="staff-days"]/li[${arg}]//span[@class="dailyStaff"]
    Should Be Equal As Strings    ${page_info_2[0].text}    调
    [Teardown]    GG
