*** Settings ***
Documentation     OA首页信息校验
Suite Setup
Resource          C:/Users/Administrator/Desktop/resource/RE.txt

*** Test Cases ***
case-1-login
    [Documentation]    先登录某个用户
    登录    yangsonglin    123456    杨松林
    #${lv_loc}    Get WebElements    Xpath=//ul[@class="sidebar_ul"]/li
    #: FOR    ${i}    IN    @{lv_loc}
    #${lv_one}    Get WebElement    ${i.find_element_by_xpath("//p") }
    #    LOG    ${lv_one.text}    #    ${i.find_element_by_xpath("//p") .text}
    #    Sleep    0.5

case-2-leftmenu
    [Documentation]    左侧包含的菜单项
    JS操作    跳过mov
    ${menus}    Get Element Count    Xpath=//ul[@class="sidebar_ul"]/li/p
    ${list}    Return_List    Xpath=//ul[@class="sidebar_ul"]/li/p
    : FOR    ${a}    IN RANGE    1
    \    #    练习    ${a.find_elements_by_xpath("../div/ul/li/ul/li/a")}
    \    LOG    ${list[${a}]}
    \    练习    Xpath=/html/body/div[1]/div[1]/ul/li[${a+1}]//ul[contains(@class,'sidebar_inner_list') and contains(@class,'clearfix')]/li/a

case-3-toplist
    [Documentation]    顶部包含的列表项
    ${list}    Get WebElements    Xpath=//ul[@class="top_ul"]/li/a/span
    : FOR    ${i}    IN    @{list}
    \    Log    ${i.text}

case-4-diymodule
    [Documentation]    自己添加的模块
    获取模块名称

case-5-clicknew
    [Documentation]    new标识的点击
    检测new标识

return_list
    ${a}    Return_a_List    Xpath=/html/body/div[1]/div[1]/ul/li[1]//ul[contains(@class,'sidebar_inner_list') and contains(@class,'clearfix')]/li/a
    log    ${a}

update_file
    open browser    file:///C:/Users/Administrator/Desktop/123.html    chrome
