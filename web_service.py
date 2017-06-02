#-*- coding: UTF-8 -*-
from flask import *
import json
import zipfile
import time
import os
import shutil
import string
from werkzeug.utils import secure_filename
from datetime import datetime,timedelta
import subprocess

from auto_code import *
from mysql_service import *

app = Flask(__name__)


@app.route('/', methods=['GET'])
def form():
  # 跳转至首页
  return render_template('index.html')


@app.route('/auto_code/test_connect', methods=['POST'])
def test_connect():
  # 测试数据库连接
  return jsonify({'data': {'result': test_conn(get_database_param())}})


@app.route('/auto_code/create_connect', methods=['POST'])
def create_connect():
  # 创建数据库连接
  create_conn(get_database_param())
  return jsonify({'data': {'result': True}})


def get_database_param():
  # 获取数据库连接参数
  database_param = {}
  database_param['database_name'] = request.form['databaseName']
  database_param['ip_or_host'] = request.form['ipOrHost']
  database_param['port'] = request.form['port']
  database_param['username'] = request.form['username']
  database_param['password'] = request.form['password']
  return database_param


@app.route('/auto_code/table_list', methods=['GET'])
def table_list():
  # 查询所有数据库表
  return jsonify({'data': find_table_list()})


@app.route('/auto_code/table_struct', methods=['POST'])
def table_struts():
  return jsonify({'data': find_table_struct(request.form['tableName'])})


@app.route('/auto_code/generate_template', methods=['GET', 'POST'])
def generate_template():
  '''
  生成模板
  '''
  param = {}
  param['table_name'] = request.form['tableName']
  param['controller_url'] = request.form['controllerUrl']
  param['is_auto_increment'] = request.form[
      'isAutoIncrement'] == '1' and True or False
  param['is_update_use_if'] = request.form[
      'isUpdateUseIf'] == '1' and True or False
  param['is_admin_table'] = request.form[
      'isAdminTable'] == '1' and True or False
  param['is_use_dto'] = request.form['isUseDto'] == '1' and True or False

  param['options'] = [request.form['isSave'] == '1' and True or False,
                      request.form['isDel'] == '1' and True or False]
  param['fields'] = deal_fields()
  param['path'] = '/home/data/autoCode/code_template/impl/template/'
  auto_code(param)
  return jsonify({'data': {'result': True}})


def deal_fields():
  '''
  处理字段数组参数
  '''
  index = 0
  fields = []
  while request.form.get('fieldsForm[' + str(index) + '][fieldName]') != None:
    field = {}
    field['field_name'] = request.form[
        'fieldsForm[' + str(index) + '][fieldName]']
    field['field_cn_name'] = request.form[
        'fieldsForm[' + str(index) + '][fieldCnName]']
    field['field_type'] = request.form[
        'fieldsForm[' + str(index) + '][fieldType]']
    fields.append(field)
    index += 1
  return fields


@app.route('/auto_code/download', methods=['GET', 'POST'])
def download():
  '''
  下载模板
  '''
  download_time = str(time.strftime(
      '%Y%m%d_%H%M%S', time.localtime(time.time())))
  path = '/home/data/autoCode/code_template'
  with zipfile.ZipFile('zip_file/template_' + download_time + '.zip', 'w', zipfile.ZIP_DEFLATED) as z:
    startdir = "impl/template"
    for dirpath, dirnames, filenames in os.walk(startdir):
      for filename in filenames:
        z.write(os.path.join(dirpath, filename))
  shutil.rmtree(r'impl/template')
  os.mkdir('impl/template')
  response = make_response(
      send_file("zip_file/template_" + download_time + ".zip"))
  response.headers[
      "Content-Disposition"] = "attachment; filename=template_" + download_time + ".zip;"
  return response



'''
以下为 自动部署相关代码
'''

@app.route('/update_server/upload_war', methods=['GET', 'POST'])
def upload_war():
  '''
  上传war包接口
  '''
  f = request.files['file']
  fname = secure_filename(f.filename) #获取一个安全的文件名，且仅仅支持ascii字符；
  f.save(os.path.join('war', fname)) #保存到本地
  return 'true'

@app.route('/update_server/validate_password', methods=['POST'])
def validate_password():
  '''
  验证密码
  '''
  password = '8963991'
  if password == request.form['password']:
    return 'true'
  return 'false'

@app.route('/update_server/start_update', methods=['GET', 'POST'])
def update_server():
  '''
  执行更新操作
  '''
  fname = request.form['fileName']
  fpath = '/home/data/' + request.form['dir']
  os.system('cp /home/data/autoCode/code_template/war/' + fname + ' ' + fpath + '/code/') #保存到本地
  os.system('cd '+fpath+'/tomcat7/bin && ./shutdown.sh') #关闭服务器
  time.sleep(10)
  # 关闭服务器后进程仍存在则关闭进程
  server_pid = str(os.popen('ps -ef | grep \'' + fpath + '/\' | grep -v \'grep\' | awk \'{print $2}\'').read())
  if server_pid.strip():
    os.system('kill -9 ' + server_pid)
  os.system('cd '+fpath+'/code && rm -rf META-INF static WEB-INF') #删除原项目
  os.system('cd '+fpath+'/code && jar -xvf '+fname) #解压新项目
  os.system('cp '+fpath+'/code/jdbc.properties '+fpath+'/code/WEB-INF/classes') #覆盖jdbc
  os.system('cd '+fpath+'/tomcat7/bin && ./startup.sh') #启动服务器
  return 'true'

@app.route('/update_server/read_logs', methods=['GET', 'POST'])
def read_logs():
  '''
  获取日志
  '''
  fpath = '/home/data/' + request.args.get('dir') + '/tomcat7/logs'
  now = datetime.now()
  month_cn_list = ['一','二','三','四','五','六','七','八','九','十','十一','十二']
  now_str = month_cn_list[int(now.strftime('%m'))-1] + '月' + now.strftime(' %d, %Y')
  now = (now + timedelta(days=1))
  end_str = month_cn_list[int(now.strftime('%m'))-1] + '月' + now.strftime(' %d, %Y')

  os.system('cd ' + fpath + ' && sed -n \'/^' + now_str + '/,/^' + end_str + '/p\' catalina.out > catalina_today.out')
  result = os.popen('cd ' + fpath + ' && cat catalina_today.out').read()
  return str(result)


'''
以下为 编辑nginx配置文件相关代码
'''
nginx_head_path = '/usr/local/nginx'
nginx_file_path = nginx_head_path + '/conf/nginx.conf'

@app.route('/edit_nginx/get_nginx', methods=['GET', 'POST'])
def get_nginx():
  '''
  获取nginx配置
  '''
  with open (nginx_file_path, 'r', encoding= 'utf8') as f:
    return f.read()
  return ''

@app.route('/edit_nginx/save_nginx', methods=['GET', 'POST'])
def save_nginx():
  '''
  保存nginx配置
  '''
  with open (nginx_file_path, 'wb') as f:
    f.write(request.form['nginxProperties'].encode('utf-8'))
    return 'true'
  return 'false'

@app.route('/edit_nginx/validate_nginx', methods=['GET', 'POST'])
def validate_nginx():
  '''
  检查nginx配置文件语法
  '''
  result = subprocess.Popen(nginx_head_path + '/sbin/nginx -t -c ' + nginx_file_path ,shell=True,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  result.wait()
  return str(result.stdout.read()).replace('\\n','<br>')[2:-1]

@app.route('/edit_nginx/reload_nginx', methods=['GET', 'POST'])
def reload_nginx():
  '''
  重启nginx
  '''
  os.system(nginx_head_path + '/sbin/nginx -s reload')
  return 'true'

if __name__ == '__main__':
  # app.run(port=8125)
  app.run(host='192.168.10.232',port=8125)

