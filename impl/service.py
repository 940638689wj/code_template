#-*- coding: UTF-8 -*-
def service(param):

  text = '\n'
  text += 'public interface ' + \
      param['table_name_convert_type'] + 'Service {\n'
  text += '\n'
  
  if param['is_admin_table']:
    if param['is_use_dto']:
      text += '    /**\n'
      text += '     * 获取列表数据\n'
      text += '     *\n'
      text += '     * @param page\n'
      text += '     * @param ' + param['table_name_convert'] + 'DTO\n'
      text += '     */\n'
      text += '    Page<' + param['table_name_convert_type'] + 'DTO> findPageList(Page<' + param['table_name_convert_type'] + 'DTO> page,' + param[
          'table_name_convert_type'] + 'DTO ' + param['table_name_convert'] + 'DTO);\n'
      text += '\n'
    else:
      text += '    /**\n'
      text += '     * 获取列表数据\n'
      text += '     *\n'
      text += '     * @param page\n'
      text += '     * @param ' + param['table_name_convert'] + '\n'
      text += '     */\n'
      text += '    Page<' + param['table_name_convert_type'] + '> findPageList(Page<' + param['table_name_convert_type'] + '> page,' + param[
          'table_name_convert_type'] + ' ' + param['table_name_convert'] + ');\n'
      text += '\n'

  if param['options'][0]:
    text += '    /**\n'
    text += '     * 新增/修改\n'
    text += '     *\n'
    text += '     * @param ' + \
        param['table_name_convert'] + ' id不存在则新增，存在则修改\n'
    text += '     */\n'
    text += '    void save(' + param['table_name_convert_type'] + \
        ' ' + param['table_name_convert'] + ');\n'
    text += '\n'
  text += '    void insert(' + param['table_name_convert_type'] + ' ' + param['table_name_convert'] + ');\n'
  text += '\n'
  text += '    void delete(Integer id);\n'
  text += '\n'
  text += '    void update(' + param['table_name_convert_type'] + \
      ' ' + param['table_name_convert'] + ');\n'
  text += '\n'
  text += '    ' + param['table_name_convert_type'] + ' get(Integer id);\n'
  text += '\n'
  text += '}\n'

  with open(param['path'] + param['table_name_convert_type'] + 'Service.java', 'wb') as f:
    f.write(text.encode('utf-8'))
