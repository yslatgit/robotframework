#!/usr/python
import re
import os

f = open(r"/home/ysl/tomcat/conf/server.xml","r")
f_new = open(r"/home/ysl/tomcat/conf/server1.xml","w+")
lines = f.readlines()
for line in lines:
    line = line.strip()
    if line.startswith("<Server"):
        pattern = r"[a-z]*(\d+)"
        old_port = re.search(pattern,line).group(1)
        new_port = str(int(old_port)+1)
        line = re.sub(old_port,new_port,line)
    f_new.write(line+"\n")
f.close()
f_new.close()

os.system("rm -rf /home/ysl/tomcat/conf/server.xml")
os.system("mv /home/ysl/tomcat/conf/server1.xml /home/ysl/tomcat/conf/server.xml")
