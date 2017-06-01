from datetime import datetime,timedelta

now = datetime.now()
month_cn_list = ['一','二','三','四','五','六','七','八','九','十','十一','十二']
now_str = month_cn_list[int(now.strftime('%m'))-1] + '月 ' + now.strftime('%d, %Y')
now = (now + timedelta(days=1))
end_str = month_cn_list[int(now.strftime('%m'))-1] + '月 ' + now.strftime('%d, %Y')
print(now_str)
print(end_str)

import subprocess
p=subprocess.Popen("dir",shell=True,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
p.wait()
print(str(p.stdout.read()).replace('\\r\\n', '<br>')[0])
# print (p.returncode)
