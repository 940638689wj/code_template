import string
from impl.controller import *
from impl.service import *
from impl.service_impl import *
from impl.dao import *
from impl.xml import *
from impl.bean import *
from impl.bean_dto import *
from impl.ftl_list import *


def auto_code(param):
    '''
    入口方法
    简单的参数加工及调用各个模板生成方法
    '''

    # 表名 转 首字母小写的实体名
    param['table_name_convert'] = convert(param['table_name'])
    # 实体名 转 首字母大写的实体类型（不可能就一个字母吧= =不判断了）
    param['table_name_convert_type'] = param['table_name_convert'][
        0].upper() + param['table_name_convert'][1:]

    # 生成后台模板所需字段
    for field in param['fields']:
        field_convert = convert(field['field_name'])
        field['field_convert'] = field_convert
        field['field_convert_type'] = field_convert[
            0].upper() + field_convert[1:]

    controller(param)
    service(param)
    service_impl(param)
    dao(param)
    xml(param)
    bean(param)
    bean_dto(param)
    if param['is_admin_table']:
        param['top_tabs'] = []
        ftl_list(param)


def convert(field):
    '''
    下划线转驼峰
    '''

    field_split = field.split('_')
    resule_field_name = field_split[0].lower()
    if len(field_split) > 1:
        for fs in field_split[1:]:
            resule_field_name += fs.capitalize()
    return resule_field_name
