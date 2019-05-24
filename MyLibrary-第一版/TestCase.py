#coding:utf-8

from robot.api import TestSuite
from robot.api import ResultWriter
from SeleniumLibrary import SeleniumLibrary


class Base:
    def __init__(self):
        self.suite = TestSuite()
        librarys = ["Selenium2Library"]
        for lib in librarys:
            self.suite.resource.imports.library(lib)


class TahoeLoginOA(Base):
    """登录OA系统的基础类"""
    def __init__(self,url,browser,username,password):
        """初始化时需要的参数url,browser,username,password"""
        self.url = url
        self.browser = browser
        self.username = username
        self.password = password
        super().__init__()

    def create_variables(self):
        variables = {
            "${username_location}":"id=j_username",
            "${password_location}":"id=j_password",
            "${login_btn_location}":"Xpath=//a[@id='submit']",
        }
        for k, v in variables.items():
            self.suite.resource.variables.create(k, v)

    def open_browsers(self):
        test_01 = self.suite.tests.create("启动浏览器")
        test_01.keywords.create("Open Browser",args=[self.url, self.browser])
        test_01.keywords.create("Title Should Be",args=["泰禾办公平台"])
        test_01.keywords.create("Sleep",args=["2s"])

    def login(self):
        test_04 = self.suite.tests.create("登录泰禾办公系统")
        test_04.keywords.create("Input Text",args=["${username_location}",self.username])
        test_04.keywords.create("Input Password",args=["${password_location}",self.password])
        test_04.keywords.create("Sleep",args=["1s"])
        test_04.keywords.create("Click Element",args=["${login_btn_location}"])


    def close_browsers(self):
        test_03 = self.suite.tests.create("关闭浏览器")
        test_03.keywords.create("Close All Browsers")

    def run(self):
        self.create_variables()
        self.open_browsers()
        self.login()
        self.close_browsers()
        self.suite.run()


class PageClick(Base):
    """页面上的点击事件"""
    def __init__(self,type,location,verify_text):
        self.type = type.lower()
        self.location = location
        self.verify_text = verify_text
        super().__init__()

    def pageclick(self):
        """点击页面上的元素"""
        tc = self.suite.tests.create("点击元素")
        # 调试代码
        # tc.keywords.create("Open Browser",args=["http://www.baidu.com","Chrome"])

        if self.type == "button":
            tc.keywords.create("Click Button",args=[self.location])
        elif self.type == "element":
            tc.keywords.create("Click Element", args=[self.location])
        elif self.type == "link":
            tc.keywords.create("Click Link", args=[self.location])
        elif self.type == "image":
            tc.keywords.create("Click Image", args=[self.location])

        tc.keywords.create("Title Should Be",args=[self.verify_text])

    def run(self):
        self.pageclick()
        self.suite.run()


class PageInput(Base):
    """页面上的输入事件"""
    def __init__(self,type,location,value):
        self.type = type.lower()
        self.location = location
        self.value = value
        super().__init__()

    def pageinput(self):
        """点击页面上的输入框"""
        tc = self.suite.tests.create("点击输入框")
        #调试代码
        # tc.keywords.create("Open Browser", args=["http://oa.tahoecn.com/ekp/login.jsp", "Chrome"])
        if self.type == "text":
            tc.keywords.create("Input Text",args=[self.location,self.value])
        elif self.type == "password":
            tc.keywords.create("Input Password", args=[self.location, self.value])

    def run(self):
        self.pageinput()
        self.suite.run()


if __name__ == '__main__':
    # suite = TahoeLoginOA("http://oa.tahoecn.com/ekp/login.jsp","Chrome","ysl","123456")
    # suite = PageClick("LINK","地图","百度地图")
    # suite = PageInput("TEXT","id=j_username","YSL")
    # suite.run()
    s = SeleniumLibrary()
    s.open_browser("http://www.baidu.com","Chrome")