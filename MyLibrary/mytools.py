#coding:utf-8

import os,time,json
import requests


from CustomLibClass import GetDataFromExcel,UpdataFile,HandleCookies,MakeCommand

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

        path:要读取的excel文件的绝对路径

        sheet_name:要读取excel文件中的sheet表表名

        datatype:1代表返回列表，2代表返回字典默认为1

        num:返回第几行数据默认为全部
        """
        obj = GetDataFromExcel(path,sheet_name,datatype,num)
        data = obj.get_data()
        return data

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

if __name__ == "__main__":
    m = MyTools()
    # # m.login("http://oa.tahoecn.com/ekp/login.jsp","id=j_username","id=j_password","Xpath=//a[@id='submit']")
    # m.click_menu()
    # m.re_data({'parent': '员工自助', 'name': '机票预订', 'url': 'http://oa.tahoecn.com/ekp/km/corporatetravel/pc_login.jsp', 'permission': ['未开通']})
    # m.save_to_file("D:\测试\data3.txt")
    # m.download("http://im.tahoecn.com/download/tChat_pc.exe")
    # datas = "BIGipServerpool_testOA_portal=996671498.36895.0000; UCSSOID=eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI4NjE0ZmU1MTg4NDE0OTQ2YmI1YThlOTE0MzhkZDc2MyIsInRfaXAiOiIxMC4zMS4yOS4zOCIsInRfc2kiOiJPQSIsInRfdWkiOnsiZmRVc2VybmFtZSI6InZnYW9nZSIsImZkT3JnTmFtZVRyZWUiOiIv5rOw56a-6ZuG5ZuiL-mbhuWbouaAu-mDqC_kv6Hmga_mtYHnqIvpg6gv5YiG5L6b5pa557uEIiwiZmRTaWQiOiI4NjE0ZmU1MTg4NDE0OTQ2YmI1YThlOTE0MzhkZDc2MyIsImZkTmFtZSI6IumrmOmYgSIsImZkR2VuZGVyIjoxLCJmZE9yZ0lkIjoiMTVhYTI5YTRkMzNkYWI4NzEyMGZjYTY0Y2VlOTRmMmMiLCJmZE9yZ05hbWUiOiLliIbkvpvmlrnnu4QiLCJmZE9yZ0lkVHJlZSI6Ii8xNWE3ZjM1MGY0YjdiNzM4YzA5NWE4OTRkN2NiOTU2Ni8xNWE3ZjM1MGY1MDk1Yzg3NDQ4YjAwZTRjOTBhODhkNC8xNWE3ZjM1MGY5NzE5Zjg1YjNiNTk4MTQwYzU5NmU5Yi8xNWFhMjlhNGQzM2RhYjg3MTIwZmNhNjRjZWU5NGYyYyJ9LCJpc3MiOiJ2Z2FvZ2UiLCJ0X3VhIjoiZjM5MTgiLCJpYXQiOjE1NjI2MzUwMDZ9.2VC31qfjumD8M8hUDaTrJh__N9PAqD9Jl0SF2YGrr46Y9HvY3ckyuVf7Nf1O0j4ys5ghzyh2yoVOnc0e4PqS2A; LtpaToken=AAECAzVEMjNFQUZFNUZCNzE4RkV2Z2FvZ2WxSpdaGuaXD26322cG9/aKS1Qa5g==; BIGipServerpool_testOA_8080=2540175370.36895.0000; SESSION=bfd29dc1-e301-4101-9223-6ca73403405b"
    # m.handle_cookies(datas)
    print(m.create_command("ps"))