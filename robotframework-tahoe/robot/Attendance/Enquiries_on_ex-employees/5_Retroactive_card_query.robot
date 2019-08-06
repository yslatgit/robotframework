*** Settings ***
Documentation     补卡查询
Suite Setup       Set_Env    Xpath=//*[@id="nav-box"]/div[4]/div[2]/div[5]/a
Suite Teardown    GG
Force Tags
Resource          ../../share_keywords.txt

*** Test Cases ***
query_by_name
    Wait Until Page Contains    工号
    G_InputText    宗芸芸
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    宗芸芸
    [Teardown]    G_Clear_Name

query_by_work_num
    Wait Until Page Contains    工号
    G_InputText    zongyunyun
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[1]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    zongyunyun
    [Teardown]    G_Clear_Name

Advanced_search_by_name_and_work_num
    [Documentation]    高级搜索（姓名+工号）
    Click Element    Xpath=//div[@class="fe-advanceSearch"]    \    #点击高级搜索
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[1]/div/div/div/input    zongyunyun    #输入工号
    Sleep    0.5
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    宗芸芸    #输入姓名
    Sleep    0.5
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Sleep    0.5
    Wait Until Page Contains    提交人
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    宗芸芸
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
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    宗芸芸    #输入姓名
    Click Element    Xpath=//div[@class="fe-heightSerBox"]/form/div[2]/div[1]/div[1]/div/div/input    \    #点击部门
    Input Text    Xpath=//div[@class="querys"]//div[2]/input[1]    财务成本部    #输入要查询的部门名称
    Sleep    1
    Click Element    Xpath=//div[@class="querys"]//div[2]/i[2]    \    #点击查询
    Sleep    1
    Click Element    Xpath=//div[@class="fe-he-btnbox"]/button[1]    \    #点击确定按钮
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Wait Until Page Contains    提交人
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    宗芸芸
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
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    宗芸芸    #输入姓名
    Sleep    1
    Click Element    Xpath=//input[@placeholder="选择"]    \    #点击选择类型
    Sleep    1
    Click Element    Xpath=//div[@x-placement="bottom-start"]//li[2]    \    #选择类型（因私）
    Sleep    1
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Wait Until Page Contains    提交人
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[4]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    因私
    Click Element    Xpath=//div[@class="fe-advanceSearch"]    #点击高级搜索
    [Teardown]

export_one
    [Setup]    G_Clear_Filepath
    Wait Until Page Contains    工号
    G_InputText    宗芸芸
    Sleep    2
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    1    #点击导出
    ${info_xls}    Get Data From Excel    C:\\Users\\Administrator\\Downloads    离职补签卡1    #从导出的excel中读取数据
    ${info_len}    Get Length    ${info_xls}
    Should Be Equal As Strings    ${info_len-1}    ${page_num}
    [Teardown]    G_Clear_Name

export_all
    [Setup]    G_Clear_Filepath
    Wait Until Page Contains    工号
    Sleep    2
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    1    #点击导出
    ${info_xls}    Get Data From Excel    C:\\Users\\Administrator\\Downloads    离职补签卡1    #从导出的excel中读取数据
    ${info_len}    Get Length    ${info_xls}
    Should Be Equal As Strings    ${info_len-1}    ${page_num}
    [Teardown]

export_name_and_department
    [Documentation]    高级搜索（姓名+部门）
    [Setup]    G_Clear_Filepath
    Click Element    Xpath=//div[@class="fe-advanceSearch"]    \    #点击高级搜索
    Input Text    Xpath=//div[@class="fe-heightSerBox"]/form/div[1]/div[2]/div/div/div/input    宗芸芸    #输入姓名
    Click Element    Xpath=//div[@class="fe-heightSerBox"]/form/div[2]/div[1]/div[1]/div/div/input    \    #点击部门
    Input Text    Xpath=//div[@class="querys"]//div[2]/input[1]    财务成本部    #输入要查询的部门名称
    Sleep    1
    Click Element    Xpath=//div[@class="querys"]//div[2]/i[2]    \    #点击查询
    Sleep    1
    Click Element    Xpath=//div[@class="fe-he-btnbox"]/button[1]    \    #点击确定按钮
    Click Button    Xpath=//div[@class="fe-heightSerBox"]/div/button[1]    \    #点击确定
    Wait Until Page Contains    提交人
    Sleep    2
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    1    #点击导出
    ${info_xls}    Get Data From Excel    C:\\Users\\Administrator\\Downloads    离职补签卡1    #从导出的excel中读取数据
    ${info_len}    Get Length    ${info_xls}
    Should Be Equal As Strings    ${info_len-1}    ${page_num}
    [Teardown]    G_Clear_Search_Form

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
