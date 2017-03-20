def service_impl(param):

  text = 'import org.springframework.beans.factory.annotation.Autowired;\n'
  text += 'import org.springframework.stereotype.Service;\n'
  text += 'import org.springframework.transaction.annotation.Transactional;\n'
  text += '\n'
  text += '@Service("' + param['table_name_convert'] + 'Service")\n'
  text += 'public class ' + param['table_name_convert_type'] + \
      'ServiceImpl implements ' + \
      param['table_name_convert_type'] + 'Service {\n'
  text += '    @Autowired\n'
  text += '    private ' + param['table_name_convert_type'] + 'Dao dao;\n'
  text += '\n'

  if param['is_admin_table']:
    if param['is_use_dto']:
      text += '    /**\n'
      text += '     * 获取列表数据\n'
      text += '     *\n'
      text += '     * @param page\n'
      text += '     * @param ' + param['table_name_convert'] + 'DTO\n'
      text += '     */\n'
      text += '    public Page<' + param['table_name_convert_type'] + 'DTO> findPageList(Page<' + param['table_name_convert_type'] + 'DTO> page,' + param[
          'table_name_convert_type'] + 'DTO ' + param['table_name_convert'] + 'DTO){\n'
      text += '        Map<String,Object> map = Maps.newHashMap();\n'
      text += '        map.put("page",page);\n'
      # text+='        map.put("'+param['table_name_convert']+'",'+param['table_name_convert']+');\n'
      text += '        page.setContent(dao.findPageList(map));\n'
      text += '        return page;\n'
      text += '    }\n'
      text += '\n'
    else:
      text += '    /**\n'
      text += '     * 获取列表数据\n'
      text += '     *\n'
      text += '     * @param page\n'
      text += '     * @param ' + param['table_name_convert'] + '\n'
      text += '     */\n'
      text += '    public Page<' + param['table_name_convert_type'] + '> findPageList(Page<' + param[
          'table_name_convert_type'] + '> page,' + param['table_name_convert_type'] + ' ' + param['table_name_convert'] + '){\n'
      text += '        ' + param['table_name_convert'] + '.setPage(page);\n'
      text += '        page.setContent(dao.findList(' + \
          param['table_name_convert'] + '));\n'
      text += '        return page;\n'
      text += '    }\n'
      text += '\n'

  if param['options'][0]:
    text += '    /**\n'
    text += '     * 新增/修改\n'
    text += '     *\n'
    text += '     * @param ' + \
        param['table_name_convert'] + ' id不存在则新增，存在则修改\n'
    text += '     */\n'
    text += '    public void save(' + param['table_name_convert_type'] + ' ' + param[
        'table_name_convert'] + '){\n'
    text += '        if (' + param['table_name_convert'] + '.get' + \
        param['fields'][0]['field_convert_type'] + '() == null) {\n'
    text += '            //todo\n'
    text += '            this.insert(' + param['table_name_convert'] + ');\n'
    text += '        } else {\n'
    text += '            //todo\n'
    text += '            this.update(' + param['table_name_convert'] + ');\n'
    text += '        }\n'
    text += '    }\n'
    text += '\n'

  text += '    public void insert(Integer id){\n'
  text += '        dao.insert(id);\n'
  text += '    }\n'
  text += '\n'
  text += '    public void delete(Integer id){\n'
  text += '        dao.delete(id);\n'
  text += '    }\n'
  text += '\n'
  text += '    public void update(' + param['table_name_convert_type'] + ' ' + param[
      'table_name_convert'] + '){\n'
  text += '        dao.update(' + param['table_name_convert'] + ');\n'
  text += '    }\n'
  text += '\n'
  text += '    public ' + \
      param['table_name_convert_type'] + ' get(Integer id){\n'
  text += '        return dao.get(id);\n'
  text += '    }\n'
  text += '\n'
  text += '}\n'

  with open('E:\\sublimeWorkspace\\auto_code\\impl\\template\\' + param['table_name_convert_type'] + 'ServiceImpl.java', 'wb') as f:
    f.write(text.encode('utf-8'))
