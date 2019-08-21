#coding:utf-8

import os,time,json,re
import requests


from CustomLibClass import GetDataFromExcel,UpdataFile,HandleCookies,MakeCommand,CompareTime,CompareTwoDict
from CustomLibClass import TimeInListSort,DateSub
PATH = lambda p: os.path.abspath(
    os.path.join(os.path.dirname(__file__), p))

class MyTools:

    def re_data(self,data):
        """数据的初步处理，参数：数据流"""
        with open("D:\测试\data1.txt","a+") as f:
            data = json.dumps(data,ensure_ascii=False)
            f.write(data)
            f.write("ysl")

    def _action_data(self):
        dd = []
        ss = {}
        with open("D:\测试\data1.txt","r") as f:
            contents = f.read()
            f.close()
            contents = contents.split("ysl")
            contents.pop()
            for data in contents:
                con = json.loads(data)
                dd.append(con["parent"])
            dd = set(dd)
            dd = list(dd)
            for i in dd:
                yy = {}
                for data in contents:
                    zz = {}
                    data = json.loads(data)
                    if i == data["parent"]:
                        zz["url"]=data["url"]
                        zz["permission"]=data["permission"]
                        yy[data["name"]]=zz
                ss[i]=yy
            # print(ss)
        return ss


    def  save_to_file(self,path):
        """文件目录需要存在,请输入文件路径"""
        ff = self._action_data()
        with open(path,"a+") as f:
            data= json.dumps(ff,ensure_ascii=False)
            f.write(data)
            f.close()

    def download(self,url):
        """验证下载链接是否生效"""
        try:
            os.remove(r"D:\download\123.exe")
        except:
            pass
        r = requests.get(url)
        # print(type(r.status_code))
        if r.status_code == 200:
            try:
                with open(r"D:\download\123.exe",'wb') as f:
                    f.write(r.content)
                    f.close()
                return ["链接可用"]
            except:
                return ["链接不可用"]
        else:
            return ["链接不可用"]


    def handle_cookies(self,datas):
        """处理get cookies 的返回值，返回可用的cookie(字典)"""
        Coo = HandleCookies(datas=datas)
        re = Coo.handle_cookies()
        return re

    def get_data_from_excel(self,path,sheet_name,datatype=1,num=-1):
        """从excel获取测试数据，返回的数据格式为列表

        path:1.文件的目录（需要结合delete_file使用）2.excel的绝对路径

        sheet_name:要读取excel文件中的sheet表表名

        datatype:1代表返回列表，2代表返回字典默认为1

        num:返回第几行数据默认为全部
        """
        time.sleep(5)
        obj = GetDataFromExcel(path,sheet_name,datatype,num)
        msg = obj.get_data()
        return msg

    def upload_file(self,path):
        """使用AutoIt处理上传文件弹窗

        参数：path要上传文件的绝对路径
        """
        aa = UpdataFile(path=path)
        aa.updata()

    def create_command(self,command,*args):
        """生成linux命令字符串

        command:必传参数，例如：ps,grep...

        args:后面的参数值
        """
        aa = MakeCommand(command,*args)
        msg = aa.make_command()
        return msg

    def delete_file(self,path,postfix):
        """
        删除指定目录下，指定格式的文件

        :param path: 要删除文件所在的目录
        
        :param postfix: 要删除文件的格式
        """
        os.chdir(path)
        for filename in os.listdir(path):
            if filename.endswith('.'+postfix):
                os.unlink(filename)

    def compare_time(self,start_time,end_time,time_list):
        """
        比较时间结果集是否在某个范围内

        :param start_time: 指定时间范围的开始时间

        :param end_time: 指定时间范围的结束时间

        :param time_list: 要比较的时间集

        :return:通过不返回信息，出错返回错误信息
        """
        aa = CompareTime(start_time,end_time,time_list)
        msg = aa.compare_time()
        return msg

    def time_sort(self,datas,type=1):
        """
        查看列表中的时间是否排序

        :datas:数据列表

        :type:不为0时从datas中正则匹配出日期字符串

        :return: 正确时返回None
        """
        a = TimeInListSort(datas,type=1)
        msg = a.sort()
        return msg

    def Calculate_difference(self,num_one,num_two):
        """
        计算两个数的差

        :param num_one:被减数

        :param num_two: 减数

        :return: 差
        """
        one = int(num_one)
        two = int(num_two)
        return two-one

    def get_num_from_string(self,string,type="0"):
        """
        获取字符串中的数字

        :param string:传入的字符串

        :type:返回数值的规则--1代表XX:XX,默认返回数字

        :return: 返回数值列表
        """
        if type == "1":
            list = re.findall(r"\d{2}:\d{2}",string)
        else:
            list = re.findall(r"\d+",string)
        return list

    def format_to_list(self,args):
        """
        处理列表包含的元组

        :param args: 列表

        :return: [[],[]]

        """
        result = []
        #判断传入的元组是否为空，如果为空返回空列表
        if len(args) != 0:
            for i in args:
                result.append(list(i))
            return result
        else:
            return result

    def format_to_list2(self,args):
        """
        处理字符串

        :param args: 以英文,分隔的字符a,b,...

        :return: [[a],[b],[...]]

        """
        result = []
        #判断传入的元组是否为空，如果为空返回空列表
        if len(args) != 0:
            data = args.split(",")
            for i in data:
                temp = []
                temp.append(i)
                result.append(temp)
            return result
        else:
            return result

    def compare_two_dict(self,dict1,dict2,key_list):
        """
        比较两个字典的某些键的值是否相等

        :param dict1:字典1

        :param dict2:字典2

        :param key_list:需要比较的键的列表

        :return:成功返回True  失败返回False

        """
        aa = CompareTwoDict(dict1,dict2,key_list)
        msg = aa.compare_dict()
        return msg

    def date_sub(self,cur_date,exp_date):
        """
        计算日期的差值

        :param cur_date: 当前的日期

        :param exp_date: 需要跳转的日期

        :return: [月份之差，跳转的日子]或[0,日期之差]

        """
        aa = DateSub(cur_date,exp_date)
        msg = aa.datesub()
        return msg



if __name__ == "__main__":
    m = MyTools()
    # # m.login("http://oa.tahoecn.com/ekp/login.jsp","id=j_username","id=j_password","Xpath=//a[@id='submit']")
    # m.click_menu()
    # m.re_data({'parent': '员工自助', 'name': '机票预订', 'url': 'http://oa.tahoecn.com/ekp/km/corporatetravel/pc_login.jsp', 'permission': ['未开通']})
    # m.save_to_file("D:\测试\data3.txt")
    # m.download("http://im.tahoecn.com/download/tChat_pc.exe")
    # datas = "BIGipServerpool_testOA_portal=996671498.36895.0000; UCSSOID=eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI4NjE0ZmU1MTg4NDE0OTQ2YmI1YThlOTE0MzhkZDc2MyIsInRfaXAiOiIxMC4zMS4yOS4zOCIsInRfc2kiOiJPQSIsInRfdWkiOnsiZmRVc2VybmFtZSI6InZnYW9nZSIsImZkT3JnTmFtZVRyZWUiOiIv5rOw56a-6ZuG5ZuiL-mbhuWbouaAu-mDqC_kv6Hmga_mtYHnqIvpg6gv5YiG5L6b5pa557uEIiwiZmRTaWQiOiI4NjE0ZmU1MTg4NDE0OTQ2YmI1YThlOTE0MzhkZDc2MyIsImZkTmFtZSI6IumrmOmYgSIsImZkR2VuZGVyIjoxLCJmZE9yZ0lkIjoiMTVhYTI5YTRkMzNkYWI4NzEyMGZjYTY0Y2VlOTRmMmMiLCJmZE9yZ05hbWUiOiLliIbkvpvmlrnnu4QiLCJmZE9yZ0lkVHJlZSI6Ii8xNWE3ZjM1MGY0YjdiNzM4YzA5NWE4OTRkN2NiOTU2Ni8xNWE3ZjM1MGY1MDk1Yzg3NDQ4YjAwZTRjOTBhODhkNC8xNWE3ZjM1MGY5NzE5Zjg1YjNiNTk4MTQwYzU5NmU5Yi8xNWFhMjlhNGQzM2RhYjg3MTIwZmNhNjRjZWU5NGYyYyJ9LCJpc3MiOiJ2Z2FvZ2UiLCJ0X3VhIjoiZjM5MTgiLCJpYXQiOjE1NjI2MzUwMDZ9.2VC31qfjumD8M8hUDaTrJh__N9PAqD9Jl0SF2YGrr46Y9HvY3ckyuVf7Nf1O0j4ys5ghzyh2yoVOnc0e4PqS2A; LtpaToken=AAECAzVEMjNFQUZFNUZCNzE4RkV2Z2FvZ2WxSpdaGuaXD26322cG9/aKS1Qa5g==; BIGipServerpool_testOA_8080=2540175370.36895.0000; SESSION=bfd29dc1-e301-4101-9223-6ca73403405b"
    # m.handle_cookies(datas)
    # print(m.create_command("ps"))
    # print(m.compare_time("2019-07-01","2019-07-05",["2019-07-02","2019-07-03","2019-07-07"]))
    # d_1 = '{"applyID":1,"code":1,"description":"调班成功：","oppDate":"2018-10-30 14:14:13"}'
    # d_2 = '{"applyID":1,"code":1,"description":"调班成功；","oppDate":"2019-07-30 09:15:10"}'
    # key = ['applyID', 'code', 'description']
    # print(m.compare_two_dict(d_1,d_2,key))
    # aa = m.get_data_from_excel(r'E:\Data\接口.xlsx',"请假单数据接收接口")
    # aa = m.get_data_from_excel(r'E:\Data\打卡数据导入.xls',"导入数据")
    # print(aa)
    # aa = [('节假日加班', '加班费'), ('节假日加班', '加班费'), ('节假日加班', '加班费')]
    # print(m.format_to_list(aa))
    # print(m.format_to_list2("平常加班(加班费),休息日加班(加班费)"))
    # print(type(m.date_sub("2019-08-31","2019-07-31")))
    m.delete_file(r'C:\Users\Administrator\Desktop\logout3','crdownload')
