# from flask import Flask, request, render_template
from flask import *
import json
import zipfile
import time
import os
import shutil
import string

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

if __name__ == '__main__':
  app.run(port=8125)
