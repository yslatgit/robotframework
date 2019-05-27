#coding:utf-8

import time
from SeleniumLibrary import SeleniumLibrary


class Base:
    def __init__(self):
        self.sly = SeleniumLibrary()


class PageClick(Base):
    """页面上的点击事件"""
    def __init__(self,type,locator,verify_text):
        self.type = type.lower()
        self.locator = locator
        self.verify_text = verify_text
        super().__init__()

    def pageclick(self):
        """点击页面上的元素"""
        # 调试代码
        self.sly.open_browser("http://www.baidu.com","Chrome")

        if self.type == "button":
            self.sly.click_button(self.locator)
        elif self.type == "element":
            self.sly.click_element(self.locator)
        elif self.type == "link":
            self.sly.click_link(self.locator)
        elif self.type == "image":
            self.sly.click_image(self.locator)

        self.sly.title_should_be(self.verify_text)

    def run(self):
        self.pageclick()


class PageInput(Base):
    """页面上的输入事件"""
    def __init__(self,type,locator,value):
        self.type = type.lower()
        self.locator = locator
        self.value = value
        super().__init__()

    def pageinput(self):
        """点击页面上的输入框"""
        #调试代码
        # self.sly.open_browser("http://oa.tahoecn.com/ekp/login.jsp", "Chrome")
        time.sleep(5)
        if self.type == "text":
            self.sly.input_text(self.locator,self.value)
        elif self.type == "password":
            self.sly.input_password(self.locator, self.value)

    def run(self):
        self.pageinput()


class Openbr(Base):
    """打开浏览器"""
    def __init__(self,url,br_name):
        self.url = url
        self.br_name = br_name
        super().__init__()

    def openbr(self):
        self.sly.open_browser(self.url,self.br_name)

    def run(self):
        self.openbr()


if __name__ == '__main__':
    # suite = TahoeLoginOA("http://oa.tahoecn.com/ekp/login.jsp","Chrome","ysl","123456")
    # suite = PageClick("LINK","地图","百度地图")
    suite = PageInput("TEXT","id=j_username","YSL")
    suite.run()