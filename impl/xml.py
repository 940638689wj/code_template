def xml(param):
  fields = param['fields']
  text = '<?xml version="1.0" encoding="UTF-8"?>\n'
  text += '<!DOCTYPE mapper PUBLIC "-//ibatis.apache.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">\n'
  text += '<mapper namespace="【补充地址】.dao.' + \
      param['table_name_convert_type'] + 'Dao">\n'
  text += '\n'

  text += '    <!-- 用于select查询公用抽取的列 -->\n'
  text += '    <sql id="allColumns">\n'
  text += connect_fields(fields, 'field_name', 'a.')
  text += '    </sql>\n'
  text += '\n'

  if param['is_admin_table']:
    text += '    <!-- 获取列表数据 -->\n'
    if param['is_use_dto']:
      text += '    <select id="findPageList" resultType="' + \
          param['table_name_convert_type'] + \
          'DTO" parameterType="java.util.Map">\n'
    else:
      text += '    <select id="findList" resultType="' + \
          param['table_name_convert_type'] + '" parameterType="' + \
          param['table_name_convert_type'] + '">\n'

    text += '        SELECT\n'
    text += '        <include refid="allColumns"/>\n'
    text += '        FROM ' + param['table_name'] + ' a\n'
    text += '        WHERE 1=1\n'
    for field in fields:
      if field['field_type'] == 'String' or field['field_type'] == 'Integer':
        text += '        <if test="' + field['field_convert'] + ' != null'
        if field['field_type'] == 'String':
          text += ' and ' + field['field_convert'] + ' != \'\''
        text += '">AND a.' + field['field_name'] + \
            ' = #{' + field['field_convert'] + '}</if>\n'
    text += '    </select>\n'
    text += '\n'

  text += '    <!-- 新增 -->\n'
  text += '    <insert id="insert" parameterType="' + \
      param['table_name_convert_type'] + '"'
  if param['is_auto_increment']:
    text += ' useGeneratedKeys="true" keyProperty="' + \
        fields[0]['field_convert'] + '"'
  text += '>\n'
  text += '        INSERT INTO ' + param['table_name'] + '(\n'
  if not param['is_auto_increment']:
    text += '            ' + fields[0]['field_name'] + ',\n'
  text += connect_fields(fields[1:], 'field_name')
  text += '        ) VALUES (\n'
  if not param['is_auto_increment']:
    text += '            #{' + fields[0]['field_name_convert'] + '}\n'
  text += connect_fields(fields[1:], 'field_convert', '#{', '}')
  text += '        )\n'
  text += '    </insert>\n'
  text += '\n'

  text += '    <!-- 删除 -->\n'
  text += '    <delete id="delete" parameterType="java.lang.Integer">\n'
  text += '        DELETE FROM ' + param['table_name'] + '\n'
  text += '        WHERE ' + fields[0]['field_name'] + ' = #{id}\n'
  text += '    </delete>\n'
  text += '\n'

  text += '    <!-- 更新 -->\n'
  text += '    <update id="update" parameterType="' + \
      param['table_name_convert_type'] + '">\n'
  text += '        UPDATE ' + param['table_name'] + ' SET\n'
  if param['is_update_use_if']:
    text += connect_fields_update_for_if(fields[1:])
  else:
    text += connect_fields_update(fields[1:])
  text += '        WHERE\n'
  text += '        ' + fields[0]['field_name'] + \
      ' = #{' + fields[0]['field_convert'] + '}\n'
  text += '    </update>\n'
  text += '    \n'

  text += '    <!-- 根据主键获取 -->\n'
  text += '    <select id="get" resultType="' + \
      param['table_name_convert_type'] + \
      '" parameterType="java.lang.Integer">\n'
  text += '        SELECT\n'
  text += '        <include refid="allColumns"/>\n'
  text += '        FROM ' + param['table_name'] + ' a\n'
  text += '        WHERE ' + fields[0]['field_name'] + '=#{id}\n'
  text += '    </select>\n'
  text += '\n'

  text += '</mapper>\n'

  with open('E:\\sublimeWorkspace\\auto_code\\impl\\template\\' + param['table_name_convert_type'] + 'Dao.xml', 'wb') as f:
    f.write(text.encode('utf-8'))


def connect_fields(fields: '字段信息', fields_type: '要生成的字段名', before_field: '字段前拼接字符串'='', after_field: '字段后拼接字符串'=''):
  '''
  生成字段列表
  '''
  text = ''
  for field in fields:
    text += '        ' + before_field + field[fields_type] + after_field
    if not field[fields_type] == fields[-1][fields_type]:
      text += ','
    text += '\n'
  return text


def connect_fields_update(fields):
  '''
  拼接更新方法的字段列表
  '''
  text = ''
  for field in fields:

    text += '        ' + field['field_name'] + \
        ' = #{' + field['field_convert'] + '}'
    if not field['field_name'] == fields[-1]['field_name']:
      text += ','
    text += '\n'
  return text


def connect_fields_update_for_if(fields):
  '''
  拼接更新方法的字段列表（使用if判断更新）
  '''
  text = ''
  for field in fields[:-1]:
    text += '        <if test="' + field['field_convert'] + ' != null'
    if field['field_type'] == 'String':
      text += ' and ' + field['field_convert'] + ' != \'\''
    text += '">\n'
    text += '            ' + field['field_name'] + \
        ' = #{' + field['field_convert'] + '},\n'
    text += '        </if>\n'
  text += '            ' + fields[-1]['field_name'] + \
      ' = #{' + fields[-1]['field_convert'] + '}\n'
  return text
