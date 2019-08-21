*** Settings ***
Documentation     数据校验
Suite Teardown    G_C_A
Resource          ../../share_keywords.txt

*** Test Cases ***
Team management daily start time
    [Documentation]    员工班组管理--日报生效开始日期以员工班组开始时间为准
    G_Login    duyi    123456
    G_OverAndClick    Xpath=//ul[@class="sidebar_ul"]/li[2]    Xpath=/html/body/div[1]/div[1]/ul/li[2]/div/ul/li[2]/ul/li[4]/a    #点击协同办公中的考勤管理
    Sleep    1
    ${handles}    Get Window Handles    #获取页面的handle
    Select Window    ${handles[1]}    #切换到考勤页面
    Wait Until Page Contains    考勤系统    30
    G_OverAndClick    Xpath=//div[@id="nav-box"]/div[3]    //*[@id="nav-box"]/div[3]/div[2]/div[4]/a
    Wait Until Page Contains    工号
    Sleep    5
    Input Text    Xpath=//input[@placeholder="请输入姓名/工号"]    杜一
    Sleep    0.5
    Click Element    Xpath=//*[@id="holidayCalculate"]/div/div/div[1]/div[1]/i[2]
    Wait Until Page Contains    工号
    Sleep    10
    ${date}    Get Webelements    Xpath=//div[@class="v-checkbox-group"]/table/tbody/tr[1]/td[4]//span
    LOG    ${date[0].text}
    Should Be Equal As Strings    %{G_Valid_time}    ${date[0].text}

check_jiabandan
    G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[3]/div[2]/div[4]/a
    Sleep    2
    Input Text    Xpath=//input[@placeholder="请输入姓名/工号"]    艾慧
    Sleep    0.5
    Click Element    Xpath=//div[@class="holidayCalculatess"]/div[1]/div[1]/i[2]
    Wait Until Page Contains    工号
    Sleep    2
    Click Element    Xpath=//div[@placeholders="选择开始日期"]/input
    Sleep    1
    Click Element    Xpath=//div[@placeholders="选择开始日期"]//table/tr[4]/td[7]    \    #选择日期（7月20）
    Sleep    1
    Click Element    Xpath=//div[@placeholders="选择结束日期"]/input
    Sleep    1
    Click Element    Xpath=//div[@placeholders="选择结束日期"]//table/tr[4]/td[7]    \    #选择日期（7月20）
    Sleep    5
    Page Should Contain    %{G_WORK_TYPE}    #校验类型
    ${infos}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[6]
    ${check_time}    Get Num From String    ${infos[0].text}    1
    Should Be Equal As Strings    ${check_time}    %{G_START_END_TIME}

*** Keywords ***
Clear_Data
    ${cookies}    Get_GaoQi1_Cookies
    POST_REQ    http://testkq.tahoecndemo.com:8800/taiheattendance/sign/deletesignbatch    {"pk_deptdoc":[],"deptname":null,"psnname":null,"signtype":null,"cusercode":null,"starttime":"2019-07-01","endtime":"2019-07-31","nameandcode":"艾慧"}    ${cookies}
