*** Settings ***
Resource          ../share_keywords.txt

*** Test Cases ***
1
    ${info}    Get Data From Excel    E:\\Data\\打卡数据导入.xls    导入数据
