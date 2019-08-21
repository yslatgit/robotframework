#coding=utf-8

from selenium.webdriver.chrome.options import Options
from selenium import webdriver
import re
import pyodbc
import requests

# path = r"E:\work\test\Scripts\360chromedriver"
# chrome_options = webdriver.ChromeOptions()
# chrome_options.binary_location=r"C:\Users\Administrator\AppData\Roaming\360se6\Application\360se.exe"
# dr = webdriver.Chrome360(executable_path=path,chrome_options=chrome_options)
# dr.get("http://ucssotest.tahoecndemo.com:9988/logout?ReturnURL=http%3A%2F%2Foa.tahoecndemo.com%3A8080%2Fportal%2Findex.html&sysId=OA")
# dr.find_element_by_id("j_username").input_text("vgaoge")
# f = open(r"E:\share\server.xml","r")
# f_new = open(r"E:\share\server1.xml","w+")
# lines = f.readlines()
# for line in lines:
#     line = line.strip()
#     if line.startswith("<Server"):
#         pattern = r"[a-z]*(\d+)"
#         old_port = re.search(pattern,line).group(1)
#         new_port = str(int(old_port)+1)
#         line = re.sub(old_port,new_port,line)
#     f_new.write(line+"\n")
# f.close()
# f_new.close()
# cnxn = pyodbc.connect("Driver={SQL Server};Server=10.0.104.62;Port=1433;Database=tahoe_atnd;UID=kqtest;PWD=KQpassword;")
# cursor = cnxn.cursor()
# cursor.execute("select  cusercode as '工号' ,psncode 'HR编号',psnname '姓名',case when sex=1 then '男' when  sex=-1 then '女' else '' end '性别' ,phone '手机号码',telphone '工作电话',case when idtype=1 then '身份证' else '' end '证件类型',id '证件号码',case when pk_psncl =1 then '员工' when pk_psncl=2 then '实习生' when  pk_psncl=3 then '合作方' when  pk_psncl=4 then '分供方'when  pk_psncl=5 then '系统账号' when  pk_psncl=6 then '其他'when  pk_psncl=7 then '实习生'when  pk_psncl=-1 then '未分配' else '' end '员工类型',positionlevel '职级',pk_post'岗位',deptname '部门',rgnametree '部门全路径',joinworkdate '参加工作日期',entrydate '入职日期',regulardate '转正日期',quitdate'离职日期' from kq_user where  cusercode='sunpeng1'")
# list = cursor.fetchall()
# print(list)
url = "http://testkq.tahoecn.com:8800/taiheattendance/shift/oashiftall"
res = requests.post(url=url)
print(len(res.json()))


