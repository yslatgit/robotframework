*** Settings ***
Documentation     法定假日
Suite Setup       Set_Env    Xpath=//*[@id="nav-box"]/div[5]/div[2]/div[5]/a
Suite Teardown    GG
Test Setup
Test Teardown
Force Tags
Test Timeout
Resource          ../../share_keywords.txt

*** Test Cases ***
create_holiday
    [Documentation]    创建新的假日
    ${arg}    Set Variable    测试1    #新建假期的名称
    Wait Until Page Contains    日期
    G_Click_Button    1    #点击新增
    Wait Until Page Contains    是否休息
    Input Text    Xpath=//div[@class="el-dialog__body"]/form/div[1]/div[1]/div/div/div/input    ${arg}
    Sleep    0.5
    Click Element    Xpath=//div[@class="el-dialog__body"]/form/div[1]/div[2]/div/div/label/span/span    \    #勾选是否节日
    Sleep    0.5
    Click Element    Xpath=//div[@placeholders="选择日期"]/input    \    #点击日期
    Sleep    0.5
    Click Element    Xpath=//div[@placeholders="选择日期"]//table/tr[3]/td[4]
    Sleep    0.5
    Click Element    Xpath=//div[@class="legalHolidayFormBtn" ]/button[1]    \    #点击保存
    Sleep    1
    Page Should Contain    新增成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    [Teardown]

delete_holiday
    [Documentation]    删除假日
    Wait Until Page Contains    日期
    Click Element    Xpath=//div[@role="tree"]/div[2]
    Sleep    0.5
    Click Element    Xpath=//div[@class="v-checkbox-group"]//tr[1]
    Sleep    0.5
    G_Click_Button    2    #点击删除
    Sleep    1
    Page Should Contain    确定删除法定假日?
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    1
    Page Should Contain    删除成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    [Teardown]

export_holiday
    [Documentation]    导出假日
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    日期
    G_Click_Button    3    #点击导出
    Sleep    2
    ${info}    Get Data From Excel    C:\\Users\\Administrator\\Downloads    法定假日1
    ${len}    Get Length    ${info}
    Should Be Equal As Strings    ${len-1}    33
    [Teardown]
