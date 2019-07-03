#coding=utf-8

from selenium.webdriver.chrome.options import Options
from selenium import webdriver

path = r"E:\work\test\Scripts\360chromedriver"
chrome_options = webdriver.ChromeOptions()
chrome_options.binary_location=r"C:\Users\Administrator\AppData\Roaming\360se6\Application\360se.exe"
dr = webdriver.Chrome360(executable_path=path,chrome_options=chrome_options)
dr.get("http://www.baidu.com")




