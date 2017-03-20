def dao(param):

  text = 'import cn.yr.chile.common.persistence.CrudDao;\n'
  text += 'import cn.yr.chile.common.persistence.annotation.MyBatisDao;\n'
  text += '\n'
  text += '@MyBatisDao\n'
  text += 'public interface ' + param['table_name_convert_type'] + \
      'Dao extends CrudDao<' + param['table_name_convert_type'] + '> {\n'
  text += '\n'
  if param['is_admin_table'] and param['is_use_dto']:
    text += '    /**\n'
    text += '     * 获取列表数据\n'
    text += '     *\n'
    text += '     * @param map\n'
    text += '     * @return\n'
    text += '     */\n'
    text += '    List<' + param['table_name_convert'] + \
        '> findPageList(Map<String, Object> map);\n'
    text += '\n'
  text += '}\n'

  with open('E:\\sublimeWorkspace\\auto_code\\impl\\template\\' + param['table_name_convert_type'] + 'Dao.java', 'wb') as f:
    f.write(text.encode('utf-8'))
