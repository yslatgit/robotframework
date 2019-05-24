#coding:utf-8

from TestCase import TahoeLoginOA,PageClick,PageInput

class MyTools:
    def __init__(self):
        pass

    def compare_a_b(self,a,b):
        """比较两个数的大小"""
        flag = False
        if a>b:
            return flag
        else:
            flag = True
            return flag

    def sum_a_b(self,a,b):
        """计算两个数的和"""
        a = int(a)
        b = int(b)
        return a+b

    def login_oa(self,url,browser,username,password):
        """登录泰禾OA系统"""
        suite = TahoeLoginOA(url,browser,username,password)
        suite.run()

    def page_click(self,type,location,verify_text):
        """页面元素的点击事件
        type点击的元素类型：button,link,image,element*
        location点击元素的定位器*
        verify_text点击元素后页面的title
        """
        suite = PageClick(type,location,verify_text)
        suite.run()

    def page_input(self,type,location,value):
        """页面元素的input事件
        type输入内容的类型：text,password*
        location输入框的定位器*
        value要输入的内容
        """
        suite = PageInput(type,location,value)
        suite.run()


if __name__ == "__main__":
    m = MyTools()
    m.login_oa(url="http://oa.tahoecn.com/ekp/login.jsp",browser="Chrome",username="ysl",password="123456")