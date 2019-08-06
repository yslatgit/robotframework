*** Settings ***
Documentation     类别设置
Suite Setup       Set_Env    Xpath=//*[@id="nav-box"]/div[5]/div[2]/div[6]/a
Suite Teardown    GG
Resource          ../../share_keywords.txt

*** Test Cases ***
create_Leave_the_category
    Wait Until Page Contains    类别名称
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    1    #点击新增
    Wait Until Page Contains    计量单位
    Input Text    Xpath=//div[@class="COPCol"]//form/div[1]/div[1]/div/div/div/input    测试假    #类别名称
    Sleep    0.1
    Input Text    Xpath=//div[@class="COPCol"]//form/div[2]/div[1]/div/div/div/input    0.5    #取整数值
    G_Click_Button    5    #点击保存
    Sleep    2
    Page Should Contain    新增成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    ${page_num_2}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    ${result}    Calculate Difference    ${page_num}    ${page_num_2}
    Should Be Equal As Strings    ${result}    1
    Sleep    3

delete_Leave_the_category
    Wait Until Page Contains    类别名称
    Click Element    Xpath=//div[@class="v-checkbox-group"]//tr[11]
    Sleep    1
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
    Sleep    0.1
    G_Click_Button    5    #点击保存
    Sleep    2
    Page Should Contain    新增成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮

delete_Work overtime category
    Wait Until Page Contains    类别名称
    Click Element    Xpath=//div[@class="categoryts"]/span[2]
    Sleep    2
    Click Element    Xpath=//div[@class="v-checkbox-group"]//tr[4]
    Sleep    1
    G_Click_Button    2    #点击删除
    Sleep    2
    Page Should Contain    确定删除加班类别?
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    1
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
