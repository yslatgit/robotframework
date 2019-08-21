*** Settings ***
Documentation     类别设置
Suite Setup       G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[5]/div[2]/div[6]/a
Suite Teardown    G_C_A
Force Tags
Resource          ../../share_keywords.txt

*** Test Cases ***
create_Leave_the_category
    #G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[5]/div[2]/div[6]/a
    Wait Until Page Contains    类别名称
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    1    #点击新增
    Wait Until Page Contains    计量单位
    Sleep    2
    Input Text    Xpath=//div[@class="COPCol"]//form/div[1]/div[1]/div/div/div/input    111    #类别名称
    Sleep    2
    Input Text    Xpath=//div[@class="COPCol"]//form/div[2]/div[1]/div/div/div/input    0.5    #取整数值
    G_Click_Button    5    #点击保存
    Sleep    2
    Page Should Contain    新增成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    #${page_num_2}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    #${result}    Calculate Difference    ${page_num}    ${page_num_2}
    #Should Be Equal As Strings    ${result}    1

delete_Leave_the_category
    [Tags]
    Wait Until Page Contains    类别名称
    Sleep    3
    ${name_obj}    Get WebElements    Xpath=//tr[@class="v-table-row"]/td[1]/div/span
    ${name_list}    Create List
    : FOR    ${i}    IN    @{name_obj}
    \    Append To List    ${name_list}    ${i.text}
    LOG    ${name_list}
    ${num}    Set Variable    ${name_list.index("111")}
    Sleep    2
    Click Element    Xpath=//div[@class="v-checkbox-group"]//tr[${num}+1]
    Sleep    2
    G_Click_Button    2    #点击删除
    Sleep    2
    Page Should Contain    确定删除休假类别？
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    1
    Page Should Contain    删除成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮

stop_Leave_the_category
    Wait Until Page Contains    类别名称
    Click Element    Xpath=//div[@class="v-checkbox-group"]//tr[1]    #选中第一条
    Sleep    1
    G_Click_Button    4    #点击禁用
    Sleep    2
    Page Should Contain    禁用成功
    Sleep    2
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    2
    ${info}    Get Webelements    Xpath=//div[@class="v-checkbox-group"]//tr[1]/td[6]/div/span
    Should Be Equal As Strings    ${info[0].text}    禁用

start_Leave_the_category
    Wait Until Page Contains    类别名称
    Click Element    Xpath=//div[@class="v-checkbox-group"]//tr[1]    #选中第一条
    Sleep    1
    G_Click_Button    3    #点击启用
    Sleep    2
    Page Should Contain    启用成功
    Sleep    2
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    2
    ${info}    Get Webelements    Xpath=//div[@class="v-checkbox-group"]//tr[1]/td[6]/div/span
    Should Be Equal As Strings    ${info[0].text}    启用

create_Work overtime category
    Wait Until Page Contains    类别名称
    Click Element    Xpath=//div[@class="categoryts"]/span[2]
    Wait Until Page Contains    类别名称
    Sleep    2
    G_Click_Button    1    #点击新增
    Wait Until Page Contains    计量单位
    Input Text    Xpath=//div[@class="COPCol"]//form/div[1]/div[1]/div/div/div/input    测试加班类别    #类别名称
    Sleep    2
    G_Click_Button    5    #点击保存
    Sleep    2
    Page Should Contain    新增成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮

delete_Work overtime category
    [Tags]
    Wait Until Page Contains    类别名称
    ${name_obj}    Get WebElements    Xpath=//tr[@class="v-table-row"]/td[1]/div/span
    ${name_list}    Create List
    : FOR    ${i}    IN    @{name_obj}
    \    Append To List    ${name_list}    ${i.text}
    LOG    ${name_list}
    ${num}    Set Variable    ${name_list.index("测试加班类别")}
    Sleep    2
    Click Element    Xpath=//div[@class="v-checkbox-group"]//tr[${num}+1]
    Sleep    2
    G_Click_Button    2    #点击删除
    Sleep    2
    Page Should Contain    确定删除加班类别?
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    2
    Page Should Contain    删除成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮

stop_Work overtime category
    Wait Until Page Contains    类别名称
    Click Element    Xpath=//div[@class="categoryts"]/span[2]
    Sleep    2
    Click Element    Xpath=//div[@class="v-checkbox-group"]//tr[1]    #选中第一条
    Sleep    1
    G_Click_Button    4    #点击禁用
    Sleep    2
    Page Should Contain    禁用成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    2
    ${info}    Get Webelements    Xpath=//div[@class="v-checkbox-group"]//tr[1]/td[5]/div/span
    Should Be Equal As Strings    ${info[0].text}    禁用

start_Work overtime category
    Wait Until Page Contains    类别名称
    Click Element    Xpath=//div[@class="categoryts"]/span[2]
    Sleep    2
    Click Element    Xpath=//div[@class="v-checkbox-group"]//tr[1]    #选中第一条
    Sleep    1
    G_Click_Button    3    #点击启用
    Sleep    2
    Page Should Contain    启用成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    2
    ${info}    Get Webelements    Xpath=//div[@class="v-checkbox-group"]//tr[1]/td[5]/div/span
    Should Be Equal As Strings    ${info[0].text}    启用
    [Teardown]    Clear

*** Keywords ***
Clear
    DB_Connection
    Execute Sql String    delete tahoe_atnd.dbo.kq_type_define where timeitemname='111'
    Execute Sql String    delete tahoe_atnd.dbo.kq_type_define where timeitemname='测试加班类别'
