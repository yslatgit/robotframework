#coding:utf-8

import os
import time
import autoit
from xlrd import open_workbook


PATH = lambda p: os.path.abspath(
    os.path.join(os.path.dirname(__file__), p))

"""测试数据操作"""

class GetDataFromExcel:
    """读取excel中的测试数据"""
    def __init__(self, path=r"C:\Users\Administrator\Desktop\ride.xlsx", sheet_name='ride',datatype=1,num=-1):
        self.path = path
        self.sheet_name = sheet_name
        self.datatype = datatype
        self.num = num
        self.cls = []

    def get_data(self):
        """根据N的值获取测试用例默认获取全部,type:1代表返回列表，2代表返回字典"""
        file = open_workbook(self.path)
        sheet = file.sheet_by_name(self.sheet_name)
        nrows = sheet.nrows
        if self.datatype == 1:
            #返回列表格式的数据
            for i in range(nrows):
                # 去掉字段名
                if sheet.row_values(i)[0] != u'case_name':
                    if self.num == -1:
                        self.cls.append(sheet.row_values(i))
                    if self.num == i:
                        self.cls.append(sheet.row_values(i))
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
        autoit.win_activate("打开")
        # autoit.control_focus("打开","Edit1")
        autoit.win_wait("[CLASS:#32770]", 3)
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
            dict[data[0]] = data[2]
        return dict

if __name__ == '__main__':
    a = UpdataFile(path=None)
    a.updata()