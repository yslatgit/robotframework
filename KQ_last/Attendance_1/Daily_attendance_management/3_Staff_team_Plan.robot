*** Settings ***
Documentation     班组规律排班模块
Suite Setup       G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[3]/a
Suite Teardown    G_C_A
Force Tags
Resource          ../../share_keywords.txt

*** Test Cases ***
query_by_name
    [Documentation]    输入班组名称查询,自己创建的班组
    Wait Until Page Contains    班组名称
    Input Text    Xpath=//input[@placeholder="请输入班组名称"]    测试    #输入要查询的班组
    Sleep    1
    Click Element    Xpath=//div[@class="simpleChoice"]/i[2]    \    #点击搜索
    Sleep    1
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    Should Be Equal As Strings    ${page_num}    1
    [Teardown]    G_Clear_Name

query_by_name_o
    [Documentation]    输入班组名称查询
    Wait Until Page Contains    班组名称
    Input Text    Xpath=//input[@placeholder="请输入班组名称"]    8:00f-12:00周日周一休息    #输入要查询的班组
    Sleep    1
    Click Element    Xpath=//div[@class="simpleChoice"]/i[2]    \    #点击搜索
    Sleep    1
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    Should Be Equal As Strings    ${page_num}    1
    [Teardown]    G_Clear_Name

stop_use
    [Documentation]    禁用某个班组
    [Setup]    Initcal_Data
    Wait Until Page Contains    班组名称
    Input Text    Xpath=//input[@placeholder="请输入班组名称"]    测试    #输入要查询的班组
    Sleep    1
    Click Element    Xpath=//div[@class="simpleChoice"]/i[2]    \    #点击搜索
    Sleep    1
    Click Element    Xpath=//div[@class="v-checkbox-group"]/table/tbody/tr/td[1]/div    \    #选中当前条
    Sleep    1
    Click Element    Xpath=//span[@class="querysBtns"]/button[4]    \    #点击禁用
    Sleep    2
    Page Should Contain    禁用成功
    Sleep    2
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    1
    Input Text    Xpath=//input[@placeholder="请输入班组名称"]    测试    #输入要查询的班组
    Sleep    1
    Click Element    Xpath=//div[@class="simpleChoice"]/i[2]    \    #点击搜索
    Sleep    1
    ${page_info}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[5]/div/span
    Should Be Equal As Strings    ${page_info[0].text}    禁用
    [Teardown]    G_Clear_Name

stop_use_error
    [Documentation]    禁用正在使用的班组
    Wait Until Page Contains    班组名称
    Input Text    Xpath=//input[@placeholder="请输入班组名称"]    8:00f-12:00六日法定休息    #输入要查询的班组
    Sleep    0.5
    Click Element    Xpath=//div[@class="simpleChoice"]/i[2]    \    #点击搜索
    Sleep    2
    Click Element    Xpath=//input[@value="0"]    \    #选中当前条
    Sleep    2
    Click Element    Xpath=//span[@class="querysBtns"]/button[4]    \    #点击禁用
    Sleep    2
    Page Should Contain    不能禁用！
    Sleep    2
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    [Teardown]    G_Clear_Name

start_use
    [Documentation]    启用班组
    Wait Until Page Contains    班组名称
    Input Text    Xpath=//input[@placeholder="请输入班组名称"]    测试    #输入要查询的班组
    Sleep    2
    Click Element    Xpath=//div[@class="simpleChoice"]/i[2]    \    #点击搜索
    Sleep    2
    Click Element    Xpath=//div[@class="v-checkbox-group"]/table/tbody/tr/td[1]/div    \    #选中当前条
    Sleep    0.5
    Click Element    Xpath=//span[@class="querysBtns"]/button[3]    \    #点击禁用
    Sleep    2
    Page Should Contain    启用成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    0.5
    Input Text    Xpath=//input[@placeholder="请输入班组名称"]    测试    #输入要查询的班组
    Sleep    0.5
    Click Element    Xpath=//div[@class="simpleChoice"]/i[2]    \    #点击搜索
    Sleep    1
    ${page_info}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[5]/div/span
    Should Be Equal As Strings    ${page_info[0].text}    启用    #校验
    [Teardown]    G_Clear_Name

delete_plan_error
    [Documentation]    删除正在使用的班组
    Wait Until Page Contains    班组名称
    Input Text    Xpath=//input[@placeholder="请输入班组名称"]    8:00f-12:00六日法定休息    #输入要查询的班组
    Sleep    0.5
    Click Element    Xpath=//div[@class="simpleChoice"]/i[2]    \    #点击搜索
    Sleep    2
    Click Element    Xpath=//div[@class="v-checkbox-group"]/table/tbody/tr/td[1]/div    \    #选中当前条
    Sleep    0.5
    Click Element    Xpath=//span[@class="querysBtns"]/button[2]    \    #点击删除
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    2
    Page Should Contain    不能刪除！    \    #校验
    Sleep    2
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    [Teardown]    G_Clear_Name

create_plan
    [Documentation]    新建班组
    ${plan_name}    Set Variable    测试2
    Wait Until Page Contains    班组名称
    Click Element    Xpath=//span[@class="querysBtns"]/button[1]    \    #点击新增
    Sleep    1
    Input Text    Xpath=//input[contains(@autocomplete,"off") and contains(@class,"el-input__inner")]    ${plan_name}
    Click Element    Xpath=//div[@placeholders="选择结束日期"]/input
    Sleep    1
    Click Element    Xpath=//table[@class="fe-calender-table"]/tr[6]/td[4]    \    #修改日期
    Sleep    1
    Click Element    Xpath=//div[@class="team-table"]/table/tr[3]//input    \    #点击选择框
    Sleep    3
    Click Element    Xpath=/html/body/div[2]/div[1]/div[1]/ul/li[2]
    Sleep    1
    Click Element    Xpath=//span[@class="querysBtns"]/button[5]    \    #点击保存
    Sleep    1
    Page Should Contain    新增成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Wait Until Page Contains    班组名称
    Input Text    Xpath=//input[@placeholder="请输入班组名称"]    ${plan_name}    #输入要查询的班组
    Sleep    1
    Click Element    Xpath=//div[@class="simpleChoice"]/i[2]    \    #点击搜索
    Sleep    1
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    Should Be Equal As Strings    ${page_num}    1    #校验
    [Teardown]    G_Clear_Name

delete_plan
    [Documentation]    删除班组
    ${plan_name}    Set Variable    测试2
    Wait Until Page Contains    班组名称
    Input Text    Xpath=//input[@placeholder="请输入班组名称"]    ${plan_name}    #输入要查询的班组
    Sleep    0.5
    Click Element    Xpath=//div[@class="simpleChoice"]/i[2]    \    #点击搜索
    Sleep    2
    Click Element    Xpath=//div[@class="v-checkbox-group"]/table/tbody/tr/td[1]/div    \    #选中当前条
    Sleep    1
    G_Click_Button    2    #点击删除
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    2
    Page Should Contain    删除成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Wait Until Page Contains    班组名称
    Input Text    Xpath=//input[@placeholder="请输入班组名称"]    ${plan_name}    #输入要查询的班组
    Sleep    1
    Click Element    Xpath=//div[@class="simpleChoice"]/i[2]    \    #点击搜索
    Sleep    2
    Page Should Contain    暂无数据    \    #校验
    [Teardown]    G_Clear_Name

*** Keywords ***
Initcal_Data
    DB_Connection
    Execute Sql String    UPDATE tahoe_atnd.dbo.kq_shiftgroup SET enablestate = 0 WHERE teamname='测试' AND dr = 0
