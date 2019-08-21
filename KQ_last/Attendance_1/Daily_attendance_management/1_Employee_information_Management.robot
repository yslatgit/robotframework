*** Settings ***
Documentation     员工信息管理模块
Suite Setup       G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[1]/a
Suite Teardown    G_C_A
Test Setup
Test Teardown
Force Tags
Test Timeout
Resource          ../../share_keywords.txt

*** Test Cases ***
export_department
    [Documentation]    导出全部员工信息
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    工号
    Sleep    3
    G_Department    总裁办
    Wait Until Page Contains    工号
    Sleep    5
    #${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    1    #点击导出
    Sleep    5
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    员工信息1    #从导出的excel中读取数据
    ${result}    DB_data    ${sql[2][0]}    #数据条数
    Log    ${info_xls.pop(0)}
    Lists Should Be Equal    ${result}    ${info_xls}
    Sleep    5
    [Teardown]    G_Clear_Department

query_by_name
    [Documentation]    根据名称查询（单一条件）
    Wait Until Page Contains    工号
    G_InputText    艾慧
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    艾慧
    LOG    ${sql[1][1]}
    [Teardown]    G_Clear_Name

query_by_vague_name
    [Documentation]    根据名称-模糊查询（单一条件）
    Wait Until Page Contains    工号
    G_InputText    慧
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Contain    ${i.text}    慧
    [Teardown]    G_Clear_Name

query_by_work_num
    [Documentation]    根据工号查询（单一条件）
    Wait Until Page Contains    工号
    G_InputText    sunpeng1
    Sleep    2
    ${num}    Get Webelement    Xpath=//tr[@class="v-table-row"]/td[1]/div/span
    Should Be Equal As Strings    ${num.text}    sunpeng1
    [Teardown]    G_Clear_Name

query_by_department
    [Documentation]    根据部门查询（输入单一部门名称）
    Wait Until Page Contains    工号
    G_Department    总裁办
    Wait Until Page Contains    工号
    Sleep    1
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    ${result}    DB_data    ${sql[2][0]}
    ${len}    Get Length    ${result}
    Should Be Equal As Strings    ${page_num}    ${len}
    [Teardown]    G_Clear_Department

query_by_names
    [Documentation]    输入多个用户名查询
    Wait Until Page Contains    工号
    G_InputText    白璐,艾慧
    ${exp_list}    Create List    艾慧    白璐
    ${rep_list}    Create List
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Append To List    ${rep_list}    ${i.text}
    Lists Should Be Equal    ${exp_list}    ${rep_list}
    [Teardown]    G_Clear_Name

query_by_name_num
    [Documentation]    输入用户名+工号查询
    Wait Until Page Contains    工号
    G_InputText    艾慧,bailu1
    ${exp_list}    Create List    艾慧    白璐
    ${rep_list}    Create List
    Sleep    2
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Append To List    ${rep_list}    ${i.text}
    Lists Should Be Equal    ${exp_list}    ${rep_list}
    [Teardown]    G_Clear_Name

query_by_department_and_name
    [Documentation]    根据部门查询（输入单一部门名称）
    Wait Until Page Contains    工号
    G_InputText    杜一,艾敬
    G_Department    信息流程部
    Sleep    5
    ${names}    Get Webelements    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    : FOR    ${i}    IN    @{names}
    \    Should Be Equal As Strings    ${i.text}    杜一
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

modify_work_num
    [Documentation]    更新用户工号
    Wait Until Page Contains    工号
    G_InputText    苑思成
    Sleep    2
    Double Click Element    Xpath=//tr[@class="v-table-row"]
    Sleep    2
    Input Text    //*[@id="personnelInfo"]/div/div[2]/div/div/div/form/div[1]/div[1]/div/div/div/input    yuansichengg
    Click Element    Xpath=//span[@class="querysBtns"]/button[2]
    Wait Until Page Contains    修改成功
    Click Button    Xpath=//button[@class="fe-message__ok"]
    Wait Until Page Contains    工号
    Sleep    2
    ${num}    Get Webelement    Xpath=//tr[@class="v-table-row"]/td[1]/div/span
    Should Be Equal As Strings    ${num.text}    yuansichengg
    [Teardown]    G_Clear_Name

modify_name
    [Documentation]    更新用户名称
    Wait Until Page Contains    工号
    G_InputText    苑思成
    Sleep    2
    Double Click Element    Xpath=//tr[@class="v-table-row"]
    Sleep    3
    Input Text    Xpath=//*[@id="personnelInfo"]/div/div[2]/div/div/div/form/div[2]/div[1]/div/div/div/input    苑思成改
    Click Element    Xpath=//span[@class="querysBtns"]/button[2]
    Wait Until Page Contains    修改成功
    Click Button    Xpath=//button[@class="fe-message__ok"]
    ${num}    Get Webelement    Xpath=//tr[@class="v-table-row"]/td[2]/div/span
    Should Be Equal As Strings    ${num.text}    苑思成改
    [Teardown]    G_Clear_Name

modify_entry_date
    [Documentation]    修改入职日期
    Wait Until Page Contains    工号
    G_InputText    孙鹏
    Sleep    2
    Double Click Element    Xpath=//tr[@class="v-table-row"]
    Click Element    Xpath=//div[@placeholders="选择入职日期"]/input
    Sleep    2
    Click Element    Xpath=//table[@class="fe-calender-table"]/tr[2]/td[7]    \    #修改日期
    ${page_info}    Create List
    ${input_elements}    Get Webelements    Xpath=//input[@type="text"]
    : FOR    ${element}    IN    @{input_elements}
    \    Append To List    ${page_info}    ${element.get_attribute("value")}
    Click Element    Xpath=//span[@class="querysBtns"]/button[2]
    Wait Until Page Contains    修改成功
    Click Button    Xpath=//button[@class="fe-message__ok"]
    Sleep    2
    Double Click Element    Xpath=//tr[@class="v-table-row"]    #再次进入详情页
    ${page_info_2}    Create List
    ${input_elements_2}    Get Webelements    Xpath=//input[@type="text"]
    : FOR    ${element_2}    IN    @{input_elements_2}
    \    Append To List    ${page_info_2}    ${element_2.get_attribute("value")}
    Should Be Equal As Strings    ${page_info.pop(15)}    ${page_info_2.pop(15)}    #验证入职日期是否为修改后的结果
    [Teardown]    G_Click_Cancel

modify_obtainment_date
    [Documentation]    修改转正日期
    Wait Until Page Contains    工号
    G_InputText    孙鹏
    Sleep    2
    Double Click Element    Xpath=//tr[@class="v-table-row"]
    Click Element    Xpath=//div[@placeholders="选择转正日期"]/input
    Sleep    2
    Click Element    Xpath=//table[@class="fe-calender-table"]/tr[2]/td[7]    \    #修改日期
    ${page_info}    Create List
    ${input_elements}    Get Webelements    Xpath=//input[@type="text"]
    : FOR    ${element}    IN    @{input_elements}
    \    Append To List    ${page_info}    ${element.get_attribute("value")}
    Click Element    Xpath=//span[@class="querysBtns"]/button[2]
    Wait Until Page Contains    修改成功
    Click Button    Xpath=//button[@class="fe-message__ok"]
    Sleep    2
    Double Click Element    Xpath=//tr[@class="v-table-row"]    #再次进入详情页
    ${page_info_2}    Create List
    ${input_elements_2}    Get Webelements    Xpath=//input[@type="text"]
    : FOR    ${element_2}    IN    @{input_elements_2}
    \    Append To List    ${page_info_2}    ${element_2.get_attribute("value")}
    Should Be Equal As Strings    ${page_info.pop(15)}    ${page_info_2.pop(15)}    #验证入职日期是否为修改后的结果
    [Teardown]    G_Click_Cancel

modify_departure _date
    [Documentation]    修改入职日期
    Wait Until Page Contains    工号
    G_InputText    孙鹏
    Sleep    2
    Double Click Element    Xpath=//tr[@class="v-table-row"]
    Click Element    Xpath=//div[@placeholders="选择离职日期"]/input
    Sleep    2
    Click Element    Xpath=//table[@class="fe-calender-table"]/tr[2]/td[7]    \    #修改日期
    ${page_info}    Create List
    ${input_elements}    Get Webelements    Xpath=//input[@type="text"]
    : FOR    ${element}    IN    @{input_elements}
    \    Append To List    ${page_info}    ${element.get_attribute("value")}
    Click Element    Xpath=//span[@class="querysBtns"]/button[2]
    Wait Until Page Contains    修改成功
    Click Button    Xpath=//button[@class="fe-message__ok"]
    Sleep    2
    Double Click Element    Xpath=//tr[@class="v-table-row"]    #再次进入详情页
    ${page_info_2}    Create List
    ${input_elements_2}    Get Webelements    Xpath=//input[@type="text"]
    : FOR    ${element_2}    IN    @{input_elements_2}
    \    Append To List    ${page_info_2}    ${element_2.get_attribute("value")}
    Should Be Equal As Strings    ${page_info.pop(15)}    ${page_info_2.pop(15)}    #验证入职日期是否为修改后的结果
    [Teardown]    G_Clear_CancelName

export_one
    [Documentation]    导出一条信息
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    工号
    G_InputText    孙鹏
    Wait Until Page Contains    工号
    Sleep    1
    G_Click_Button    1    #点击导出
    Sleep    3
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    员工信息1    #从导出的excel中读取数据
    ${result}    DB_data    ${sql[1][0]}
    Log    ${info_xls.pop(0)}
    Lists Should Be Equal    ${result}    ${info_xls}
    Sleep    3
    [Teardown]    G_Clear_Name

export_all
    [Documentation]    导出全部员工信息
    [Setup]    G_Clear_FilePath
    Wait Until Page Contains    工号
    Sleep    5
    #${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    G_Click_Button    1    #点击导出
    Sleep    5    \    #增加等待时间确保文件已正常导出
    Wait Until Page Contains    工号
    ${info_xls}    Get Data From Excel    %{G_FILEPATH}    员工信息1    #从导出的excel中读取数据
    ${len}    Get Length    ${info_xls}
    ${res}    DB_DATA    ${sql[4][0]}
    Should Be Equal As Strings    ${res[0][0]}    ${len}    #因为数据问题所以少减去1
    Sleep    3
    [Teardown]

query_by_departments
    [Documentation]    根据部门查询（勾选多个部门）
    [Setup]    G_Switch_To_Action_Page    Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[1]/a    #G_Switch_To_Action_Page | Xpath=//*[@id="nav-box"]/div[2]/div[2]/div[1]/a | # GG
    Wait Until Page Contains    工号
    Sleep    2
    Click Element    Xpath=//input[@placeholder="选择部门"]    \    #点击选择部门
    Sleep    1
    Click Element    Xpath=//*[@id="vbar"]/div/div[3]/div/div[1]/div[2]/div[1]/div    \    #点击集团总部
    Sleep    1
    Click Element    Xpath=//*[@id="vbar"]/div/div[3]/div/div[1]/div[2]/div[1]/div[2]/div[1]/div/label/span/span    \    #选中集团高层
    Sleep    0.5
    Click Element    Xpath=//*[@id="vbar"]/div/div[3]/div/div[1]/div[2]/div[1]/div[2]/div[2]/div/label/span/span    \    #点击总裁办（23）
    Sleep    0.5
    Click Element    Xpath=//div[@class="fe-he-btnbox"]/button[1]    \    #点击确定
    Wait Until Page Contains    工号    30
    Sleep    5
    ${page_num}    G_Get_Page_Count    Xpath=//span[@class="paginationText"]    #获取页面信息条数
    ${len}    Query_departments
    #Should Be Equal As Strings    ${page_num}    ${len}
    [Teardown]

*** Keywords ***
Query_departments
    ${result}    DB_data    select ku.cusercode as '工号',ku.psncode 'HR编号',ku.psnname '姓名', case when ku.sex=1 then '男' when \ sex=-1 then '女' else '' end '性别' ,ku.phone '手机号码',ku.telphone '工作电话',case when ku.idtype=1 then '身份证' else '' end '证件类型',ku.id '证件号码',case when ku.pk_psncl =1 then '员工' when pk_psncl=2 then '实习生' when \ pk_psncl=3 then '合作方' when \ pk_psncl=4 then '分供方'when \ pk_psncl=5 then '系统账号' when \ pk_psncl=6 then '其他'when \ pk_psncl=7 then '实习生'when \ pk_psncl=-1 then '未分配' else '' end '员工类型',ku.positionlevel '职级',ku.pk_post'岗位',kd.deptname '部门',SUBSTRING(ku.rgnametree \ ,7 ,1000) '部门全路径',ISNULL(replace(ku.joinworkdate,' ','') \ ,'' ) '参加工作日期',ku.entrydate '入职日期',ISNULL(replace(ku.regulardate,' ','') ,'' ) \ '转正日期',ISNULL(replace(ku.quitdate,' ','') ,'' ) \ '离职日期' from tahoe_atnd.dbo.kq_user ku left join tahoe_atnd.dbo.kq_dept kd \ on ku.pk_deptdoc=kd.pk_deptdoc where (ku.orgidtreeafter LIKE '%15a7f350f7d71a1fd34fc854e32ada03%' OR ku.orgidtreeafter LIKE '%15a7f350f809fd9f1ca2ec245fdb3a25%') AND ku.dr = 0 ORDER BY cusercode
    ${len}    Get Length    ${result}
    [Return]    ${len}
