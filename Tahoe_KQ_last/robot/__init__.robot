*** Settings ***
Suite Setup       SET_UP
Test Teardown
Resource          share_keywords.txt

*** Keywords ***
SET_WEB_CONF
    #Set Environment Variable    G_WEB_HOST    http://oa.tahoecn.com    #线上
    #Set Environment Variable    G_WEB_URL    /ekp/login.jsp    #线上
    Set Environment Variable    G_WEB_HOST    http://ucssotest.tahoecndemo.com:9988    #测试
    Set Environment Variable    G_WEB_URL    /logout?ReturnURL=http%3A%2F%2Foa.tahoecndemo.com%3A8080%2Fportal%2Findex.html&sysId=OA    #测试
    Set Environment Variable    G_TEST_ADDR    %{G_WEB_HOST}%{G_WEB_URL}
    Set Environment Variable    G_URL    http://www.baidu.com
    #${list}    Create List    2019-07-20 08:40    2019-07-20 19:00
    #Set Environment Variable    G_START_END_TIME    ${list}

SET_G_VAR
    Set Environment Variable    G_SQAROOT    D:\\泰禾    #Root Directory
    Set Environment Variable    G_RESUORCE    %{G_SQAROOT}\\Data    #Root Resource
    Set Environment Variable    G_BROWSER_TYPE    gc    #Type For Browser
    Set Environment Variable    G_FILEPATH    C:\\Users\\Administrator\\Downloads
    ${sql}    Get Data From Excel    %{G_RESUORCE}\\sql.xls    sql    #读取sqlw文件
    Set Global Variable    ${sql}

SET_UP
    #${time}    Evaluate    datetime.datetime.now()    datetime
    #Log    test start time is ${time}
    #SERVICE_MONITOR    12306
    S_Connection    10.0.104.61    root    THopss_2018
    ${dd}    Execute Command    timedatectl set-time "2019-07-31 09:00:00"
    #log    ${dd}
    #Initcal_Data
    SET_WEB_CONF
    SET_G_VAR

Initcal_Data
    DB_Connection
    ${cookies}    Get_GaoQi1_Cookies
    POST_REQ    http://testkq.tahoecndemo.com:8800/taiheattendance/attdataproc/analysisAttdataproc    {"starttime":"2019-07-01","endtime":"2019-07-30","nameandcode":"xiaoduoduo","pk_deptdoc":[],"deptname":null,"person":[{"dr":0,"checked":false,"source":0,"pk_psndoc":"161e88b5f20581df850b11e4fdea4ce4","psncode":"DF-00920","psnname":"肖朵朵","cusercode":"xiaoduoduo","password":null,"synsystem":"101010011100000100000111","porder":0,"phone":"15859062377","telphone":"86305975（2348）","email":"xiaoduoduo@tahoecn.com","enablestate":1,"islock":1,"autostoptime":"0","updatesign":2,"messagesid":"495790","phoneurl":"group1/M00/00/91/CgBm21s8UJaACfsgAADn3DW016Y063.jpg","smallphoneurl":"group1/M00/00/91/CgBm2ls8UJaACO7YAAALZTmmCwI667.jpg","idtype":1,"id":"420606199511293547","sex":-1,"nation":0,"birthdate":null,"addr":"","politics":0,"marstatus":0,"edu":0,"joinworkdate":"2018-07-02","joinbeforeworklongmonth":0,"joinbeforeworklongage":0,"pk_psncl":1,"orgidtree":"/15a7f350f4b7b738c095a894d7cb9566/15a7f350f4c2580ea1df1bd49d3b0287/161c47df673ec1df034951e46b4a4590/161c47df6835fb72c615dc84f10838fa/03f1b0fdc0cb4475971a27656c6146ff","rgnametree":"/泰禾集团/地产板块/福州区域/福州城市公司/人力行政部","pk_deptdoc":"03f1b0fdc0cb4475971a27656c6146ff","deptname":"人力行政部","pk_post":"人事专员","positionlevel":"P4","entrydate":"2018-07-02","quitdate":null,"jobduty":"","regulardate":"2018-10-01","regularstate":0,"orgidtreeafter":null,"rgnametreeafter":null,"accountcreatetime":null,"accountupdatetime":null,"annualleave":0,"bdDeptdocVO":null,"_checked":true}],"isquit":false,"code":"99999","username":"duyi"}    ${cookies}
    Execute Sql String    truncate table [tahoe_atnd].[dbo].[kq_user];insert into [tahoe_atnd].[dbo].[kq_user] select * from \ [tahoe_atnd].[dbo].[kq_user_BAK]    #初始化用户数据
    Sleep    5
    Execute Sql String    truncate table [tahoe_atnd].[dbo].[kq_dept];insert into [tahoe_atnd].[dbo].[kq_dept] select * from [tahoe_atnd].[dbo].[kq_dept_BAK_0817]    #初始化组织架构
    Sleep    5
    Execute Sql String    truncate table [tahoe_atnd].[dbo].[kq_shift_define];insert into [tahoe_atnd].[dbo].[kq_shift_define] select * from [tahoe_atnd].[dbo].[kq_shift_define_BAK_0819]    #初始化班次
    Sleep    5
    Execute Sql String    truncate table \ [tahoe_atnd].[dbo].[sheet_leave];insert into [tahoe_atnd].[dbo].[sheet_leave] select * from [tahoe_atnd].[dbo].[sheet_leave_BAK_0819]    #初始化请假数据
    Sleep    60
    Execute Sql String    truncate table \ [tahoe_atnd].[dbo].[sheet_sign];insert into [tahoe_atnd].[dbo].[sheet_sign] select * from [tahoe_atnd].[dbo].[sheet_sign_BAK_0819]    #初始化补签数据
    Sleep    20
    Execute Sql String    truncate table [tahoe_atnd].[dbo].[sheet_ot];insert into [tahoe_atnd].[dbo].[sheet_ot] select * from [tahoe_atnd].[dbo].[sheet_ot_BAK_0819]    #初始化加班数据
    Sleep    20
    Execute Sql String    truncate table [tahoe_atnd].[dbo].[kq_vacation_ledger];insert into [tahoe_atnd].[dbo].[kq_vacation_ledger] select * from [tahoe_atnd].[dbo].[kq_vacation_ledger_BAK_0820]    #初始化年假存休
    Sleep    60
