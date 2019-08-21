#coding:utf-8

import os
import re
import json
import time
import autoit

from xlrd import open_workbook
from SSHLibrary.library import SSHLibrary


PATH = lambda p: os.path.abspath(
    os.path.join(os.path.dirname(__file__), p))

"""测试数据操作"""

class GetDataFromExcel:
    """读取excel中的测试数据"""
    def __init__(self, path=r"C:\Users\Administrator\Desktop\ride.xlsx", sheet_name='ride',datatype=1,num=-1):
        self.path = self._make_path(path)
        self.sheet_name = sheet_name
        self.datatype = datatype
        self.num = num
        self.cls = []

    def _make_path(self,path):
        res = path.find(".")
        if res != -1:
            file_path = path
        else:
            os.chdir(path=path)
            file_name = os.listdir()[1]
            file_path = path + "\\" + file_name
        return file_path

    def get_data(self):
        """根据N的值获取测试用例默认获取全部,type:1代表返回列表，2代表返回字典"""
        file = open_workbook(self.path)
        sheet = file.sheet_by_name(self.sheet_name)
        nrows = sheet.nrows
        if self.datatype == 1:
            #返回列表格式的数据
            if nrows != 0:
                for i in range(nrows):
                    # 去掉字段名
                    # if sheet.row_values(i)[0] != u'case_name':
                    if self.num == -1:
                        self.cls.append(sheet.row_values(i))
                    # if self.num == i:
                    else:
                        self.cls.append(sheet.row_values(self.num))
                        return self.cls
                return self.cls
            else:
                self.cls.append("文件为空")
                return self.cls
        if self.datatype == 2:
            #返回字典格式的数据
            dict_a = {}
            for i in range(nrows):
                title_list = sheet.row_values(0)
                if sheet.row_values(i)[0] != u'case_name':
                    if self.num == -1:
                        data_list = sheet.row_values(i)
                        num = len(data_list)
                        for a in range(num):
                            dict_a[title_list[a]]=data_list[a]
                        self.cls.append(dict_a)
                    if self.num == i:
                        data_list = sheet.row_values(i)
                        num = len(data_list)
                        for a in range(num):
                            dict_a[title_list[a]] = data_list[a]
                        self.cls.append(dict_a)
            return self.cls

"""上传下载文件"""

class UpdataFile:
    """浏览器上传文件"""
    def __init__(self,path):
        self.path = path
        # self.path = r"C:\Users\Administrator\Desktop\upload.exe"

    def updata(self):
        """上传文件程序
        第一个参数为当前弹窗的属性（title,class）
        第二个参数为要操作的元素的locator
        """
        # autoit.win_wait_active("打开",10)
        time.sleep(3)
        autoit.win_activate("打开")
        # autoit.control_focus("打开","Edit1")
        autoit.win_wait("[CLASS:#32770]", 5)
        autoit.control_set_text("[CLASS:#32770]", "Edit1",self.path)
        #r"C:\Users\Administrator\Desktop\upload.exe"
        time.sleep(2)
        autoit.control_click("[CLASS:#32770]", "Button1")

"""接口数据处理"""

class HandleCookies:
    """处理get cookies 的返回值，返回可用的cookie(字典)"""
    def __init__(self,datas):
        self.datas = datas

    def handle_cookies(self):
        dict = {}
        datas = self.datas.split(";")
        for data in datas:
            data = data.strip()
            data = data.partition("=")
            # data = data.split("=")
            dict[data[0]] = data[2]
        return dict

"""SSH操作"""

class MakeCommand:
    """通过此函数生成linux命令字符串"""
    def __init__(self,command,*args):
        self.command = command
        self.args = args
        self.msg = ""
        self.content = self._handle_args()

    def _handle_args(self):
        """处理多个参数"""
        list_args = list(self.args)
        # print(len(list_args))
        if len(list_args) != 0:
            for i in list_args:
                self.msg = self.msg + " " + i
        return self.msg

    def make_command(self):
        return self.command + self.content

"""时间相关"""
class CompareTime:
    """比较时间是否在某一区间"""
    def __init__(self,start_time,end_time,time_list):
        self.start_time = self._timestamp(start_time)
        self.end_time = self._timestamp(end_time)
        self.time_list = time_list

    def _timestamp(self,arg):
        stamp = time.mktime(time.strptime(arg, '%Y-%m-%d'))
        return int(stamp)

    def compare_time(self):
        for i in self.time_list:
            i = self._timestamp(i)
            if i >= self.start_time and i <=self.end_time:
                pass
            else:
                return "ERROR"

class TimeInListSort:
    """查看列表中的时间排序是否正确"""
    def __init__(self,list,type=0):
        self.list = list if type == 0 else self._change(list)

    def _change(self,datas):
        """转换为时间列表"""
        middle_data = []
        for data in datas:
            gg = re.findall(r"(\d{4}-\d{1,2}-\d{1,2})",data)
            middle_data.extend(gg)
        return middle_data

    def sort(self):
        list_1 = []
        for i in self.list:
            stamp = time.mktime(time.strptime(i, '%Y-%m-%d'))
            list_1.append(int(stamp))
        list_2 = list_1.copy()
        list_2.sort()
        if list_1 == list_2:
            pass
        else:
            return "ERROR"

class DateSub:
    """计算日期的差"""
    def __init__(self,cur_date,exp_date):
        self.cur_date = cur_date
        self.exp_date = exp_date
        self.result = []

    def datesub(self):
        """忽略年份，只计算月份，以及日"""
        cur_date_list = self.cur_date.split("-")
        exp_date_list = self.exp_date.split("-")
        if int(cur_date_list[1])-int(exp_date_list[1]) != 0:
            self.result.append(int(cur_date_list[1])-int(exp_date_list[1]))
            self.result.append(int(exp_date_list[2]))
            return self.result
        else:
            self.result.append(0)
            self.result.append(int(cur_date_list[2])-int(exp_date_list[2]))
            return self.result



"""字典相关"""
class CompareTwoDict:
    """比较两个字典的某些字段是否相等"""
    def __init__(self,dict_1,dict_2,key_list):
        self.dict_1 = json.loads(dict_1)
        self.dict_2 = json.loads(dict_2)
        self.key_list = eval(key_list)

    def compare_dict(self):
        for key in self.key_list:
            if self.dict_1[key] == self.dict_2[key]:
                pass
            else:
                return "False"
        return "True"

if __name__ == '__main__':
    # a = MakeCommand("grep","测试","/home/ysl")
    # print(a.make_command())
    # aa = GetDataFromExcel(path=r'C:\Users\Administrator\Downloads',sheet_name=u'员工信息1')
    # print(len(aa.get_data()))
    data = ['2019-06-09 ~ 2019-07-01', '2019-07-02 ~ 2019-07-04', '2019-07-05 ~ 无限']
    A = TimeInListSort(data,type=1)
    print(A.sort())