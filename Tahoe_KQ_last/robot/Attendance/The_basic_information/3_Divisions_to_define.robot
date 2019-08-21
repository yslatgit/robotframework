*** Settings ***
Documentation     班次定义
Suite Setup       G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[5]/div[2]/div[7]/a
Suite Teardown    G_C_A
Resource          ../../share_keywords.txt

*** Test Cases ***
query_by_name
    [Documentation]    输入班组名称查询,自己创建的班组
    Wait Until Page Contains    班次名称
    Input Text    Xpath=//input[@placeholder="请输入班次名称"]    10:0a    #输入要查询的班组
    Sleep    0.5
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[2]    \    #点击搜索
    Sleep    1
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    Should Be Equal As Strings    ${page_num}    1
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[1]    \    #点击清除
    [Teardown]

export
    [Documentation]    班次的导出
    [Tags]
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    班次名称
    Sleep    2
    Sleep    1
    #${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    6    #点击导出
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    员工班次1    #从导出的excel中读取数据
    ${info_num}    Get Length    ${info_xls}    #数据条数
    ${res}    DB_DATA    ${sql[19][0]}
    Should Be Equal As Strings    ${res[0][0]}    ${info_num-1}
    [Teardown]

stop_use
    [Documentation]    禁用某个班组
    [Setup]    Initcal_Data
    Wait Until Page Contains    班次名称
    Sleep    0.5
    Input Text    Xpath=//input[@placeholder="请输入班次名称"]    测    #输入要查询的班组
    Sleep    0.5
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[2]    \    #点击搜索
    Sleep    1
    Click Element    Xpath=//input[@value="0"]    \    #选中当前条
    Sleep    0.5
    G_Click_Button    5    #点击禁用
    Sleep    0.5
    Page Should Contain    禁用成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    0.5
    Input Text    Xpath=//input[@placeholder="请输入班次名称"]    测    #输入要查询的班组
    Sleep    0.5
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[2]    \    #点击搜索
    Sleep    1
    ${page_info}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[5]/div/span
    Should Be Equal As Strings    ${page_info[0].text}    禁用
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[1]    \    #点击清除
    [Teardown]

stop_use_error
    [Documentation]    禁用正在使用的班组
    Wait Until Page Contains    班次名称
    Sleep    0.5
    Input Text    Xpath=//input[@placeholder="请输入班次名称"]    10:0a    #输入要查询的班组
    Sleep    0.5
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[2]    \    #点击搜索
    Sleep    1
    Click Element    Xpath=//input[@value="0"]    \    #选中当前条
    Sleep    0.5
    G_Click_Button    5    #点击禁用
    Sleep    0.5
    Page Should Contain    所选班次正在被使用，不能禁用！
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    0.5
    Click Element    Xpath=//input[@value="0"]    \    #取消选中当前条
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[1]    \    #点击清除
    [Teardown]

start_use
    [Documentation]    启用班组
    Wait Until Page Contains    班次名称
    Sleep    0.5
    Input Text    Xpath=//input[@placeholder="请输入班次名称"]    测    #输入要查询的班组
    Sleep    0.5
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[2]    \    #点击搜索
    Sleep    1
    Click Element    Xpath=//input[@value="0"]    \    #选中当前条
    Sleep    0.5
    G_Click_Button    4    #点击启用
    Sleep    0.5
    Page Should Contain    启用成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    0.5
    Input Text    Xpath=//input[@placeholder="请输入班次名称"]    测    #输入要查询的班组
    Sleep    0.5
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[2]    \    #点击搜索
    Sleep    1
    ${page_info}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[5]/div/span
    Should Be Equal As Strings    ${page_info[0].text}    启用
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[1]    \    #点击清除
    [Teardown]

delete_plan_error
    [Documentation]    删除正在使用的班组
    Wait Until Page Contains    班次名称
    Sleep    0.5
    Input Text    Xpath=//input[@placeholder="请输入班次名称"]    10:0a    #输入要查询的班组
    Sleep    0.5
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[2]    \    #点击搜索
    Sleep    1
    Click Element    Xpath=//input[@value="0"]    \    #选中当前条
    Sleep    0.5
    G_Click_Button    3    #点击删除
    Sleep    0.5
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    0.5
    Page Should Contain    所选班次正在被使用，不能刪除！
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[1]    \    #点击清除
    [Teardown]

delete_divisions
    [Documentation]    删除班组
    Wait Until Page Contains    班次名称
    Input Text    Xpath=//input[@placeholder="请输入班次名称"]    测    #输入要查询的班组
    Sleep    0.5
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[2]    \    #点击搜索
    Sleep    2
    Click Element    Xpath=//input[@value="check-all"]    \    #选中当前条
    Sleep    1
    G_Click_Button    3    #点击删除
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    2
    Page Should Contain    删除成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Input Text    Xpath=//input[@placeholder="请输入班次名称"]    测    #输入要查询的班组
    Sleep    0.5
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[2]    \    #点击搜索
    Sleep    2
    Page Should Contain    暂无数据    \    #校验
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[1]    \    #点击清除
    [Teardown]

modify_divisions
    [Documentation]    删除班组
    Wait Until Page Contains    班次名称
    Input Text    Xpath=//input[@placeholder="请输入班次名称"]    10:0a    #输入要查询的班组
    Sleep    0.5
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[2]    \    #点击搜索
    Sleep    2
    Click Element    Xpath=//input[@value="0"]    \    #选中当前条
    Sleep    1
    G_Click_Button    2    #点击修改
    Sleep    0.5
    Input Text    Xpath=//div[@class="el-row"]//form/div[1]/div[1]/div/div/div/input    10:0a改    #改名
    G_Click_Button    7    #点击保存
    Sleep    1
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Sleep    2
    Input Text    Xpath=//input[@placeholder="请输入班次名称"]    10:0a改    #输入要查询的班组
    Sleep    0.5
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[2]    \    #点击搜索
    Sleep    2
    Page Should Not Contain    暂无数据    \    #校验
    [Teardown]

create_divisions
    [Documentation]    新建班组
    [Tags]
    ${plan_name}    Set Variable    测试2
    Wait Until Page Contains    班次名称
    G_Click_Button    1    #点击新增
    Sleep    1
    Wait Until Page Contains    状态
    Input Text    Xpath=//div[@class="el-row"]//form/div[1]/div[1]/div/div/div/input    测班次    #班次名称
    Sleep    2
    Click Element    Xpath=//input[@placeholder="请选择刷卡开始时间"]    \    #选择刷卡开始时间
    Sleep    0.5
    Click Element    Xpath=//div[@class="el-picker-panel__body"]/div[1]/span[10]    \    #点击选9:00
    Sleep    0.5
    Click Element    Xpath=//div[@class="el-picker-panel__body"]/div[2]/span[1]    \    #点击选9:00
    Sleep    2
    Click Element    Xpath=//input[@placeholder="请选择上班时间"]    \    #选择上班开始时间
    Sleep    0.5
    Click Element    Xpath=//input[@placeholder="请选择上班时间"]/following-sibling::div/div/div/div/span[10]    \    #点击选9:00
    Sleep    0.5
    Click Element    Xpath=//input[@placeholder="请选择上班时间"]/following-sibling::div/div/div/div[2]/span[1]    \    #点击选9:00
    Sleep    0.5
    Input Text    Xpath=//div[@class="el-row"]//form/div[6]/div[1]/div/div/div/div/input    5    #输入迟到时间范围
    Sleep    0.5
    Click Element    Xpath=//input[@placeholder="请选择刷卡结束时间"]    \    #选择刷卡结束时间
    Sleep    1
    Click Element    Xpath=//input[@placeholder="请选择刷卡结束时间"]/following-sibling::div/div/div/div/span[19]    \    #点击选18:00
    Sleep    0.5
    Click Element    Xpath=//input[@placeholder="请选择刷卡结束时间"]/following-sibling::div/div/div/div[2]/span[1]    \    #点击选18:00
    Sleep    0.5
    Click Element    Xpath=//input[@placeholder="请选择下班时间"]    \    #选择下班开始时间
    Sleep    1
    Click Element    Xpath=//input[@placeholder="请选择下班时间"]/following-sibling::div/div/div/div/span[19]    \    #点击选18:00
    Sleep    0.5
    Click Element    Xpath=//input[@placeholder="请选择下班时间"]/following-sibling::div/div/div/div[2]/span[1]    \    #点击选18:00
    Sleep    0.5
    Input Text    Xpath=//div[@class="el-row"]//form/div[6]/div[2]/div/div/div/div/input    5    #输入迟到时间范围
    G_Click_Button    7    #点击保存
    Sleep    0.5
    Page Should Contain    新增成功
    Click Element    Xpath=//button[@class="fe-message__ok"]    \    #点击确定按钮
    Wait Until Page Contains    班次名称
    Input Text    Xpath=//input[@placeholder="请输入班次名称"]    测班次    #输入要查询的班组
    Sleep    0.5
    Click Element    Xpath=//div[@class="querys"]/div[2]/i[2]    \    #点击搜索
    Sleep    1
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    Should Be Equal As Strings    ${page_num}    1    #校验
    [Teardown]

*** Keywords ***
Initcal_Data
    DB_Connection
    Execute Sql String    UPDATE tahoe_atnd.dbo.kq_shift_define SET enablestate = 0 WHERE shiftname='测班次' AND dr = 0
