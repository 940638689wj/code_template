def controller(param):

  text = ''
  text += 'import cn.yr.chile.common.utils.web.RenderUtils;\n'
  text += 'import org.springframework.beans.factory.annotation.Autowired;\n'
  text += 'import org.springframework.stereotype.Controller;\n'
  text += 'import org.springframework.web.bind.annotation.RequestMapping;\n'
  text += 'import javax.servlet.http.HttpServletRequest;\n'
  text += 'import javax.servlet.http.HttpServletResponse\n'
  text += '\n'
  text += '@Controller\n'
  text += '@RequestMapping("' + param['controller_url'] + '")\n'
  text += 'public class ' + param['table_name_convert_type'] + 'Controller {\n'
  text += '\n'
  text += '    @Autowired\n'
  text += '    private ' + \
      param['table_name_convert_type'] + 'Service service;\n'
  text += '\n'
  
  if param['is_admin_table']:
    text += '    /**\n'
    text += '     * 跳转列表\n'
    text += '     *\n'
    text += '     * @return\n'
    text += '     */\n'
    text += '    @RequestMapping("")\n'
    text += '    public String toList() {\n'
    text += '        return "【补充地址】/admin/sa/' + \
        param['table_name_convert'] + '";\n'
    text += '    }\n'
    text += '\n'

    if param['is_use_dto']:
      text += '    /**\n'
      text += '     * 获取列表数据\n'
      text += '     *\n'
      text += '     * @param ' + param['table_name_convert'] + 'DTO\n'
      text += '     * @param request\n'
      text += '     * @param response\n'
      text += '     */\n'
      text += '    @RequestMapping("grid_json")\n'
      text += '    public void findPageList(' + param['table_name_convert_type'] + 'DTO ' + param[
          'table_name_convert'] + 'DTO, HttpServletRequest request, HttpServletResponse response) {\n'
      text += '        RenderUtils.renderPageJson(response,\n'
      text += '            service.findPageList(new Page<' + param[
          'table_name_convert_type'] + 'DTO>(request, response),' + param['table_name_convert'] + 'DTO),\n'
      text += '            "'
    else:
      text += '    /**\n'
      text += '     * 获取列表数据\n'
      text += '     *\n'
      text += '     * @param ' + param['table_name_convert'] + '\n'
      text += '     * @param request\n'
      text += '     * @param response\n'
      text += '     */\n'
      text += '    @RequestMapping("grid_json")\n'
      text += '    public void findPageList(' + param['table_name_convert_type'] + ' ' + param[
          'table_name_convert'] + ', HttpServletRequest request, HttpServletResponse response) {\n'
      text += '        RenderUtils.renderPageJson(response,\n'
      text += '            service.findPageList(new Page<' + param[
          'table_name_convert_type'] + '>(request, response),' + param['table_name_convert'] + '),\n'
      text += '            "'

    for field in param['fields']:
      text += field['field_convert']
      if not field['field_convert'] == param['fields'][-1]['field_convert']:
        text += ','
    text += '");\n'
    text += '    }\n'
    text += '    \n'
    # 生成新增修改相关方法
    if param['options'][0]:
      # 跳转新增/修改页面的方法
      text += '    /**\n'
      text += '     * 跳转新增/修改页面\n'
      text += '     *\n'
      text += '     * @param ' + \
          param['fields'][0]['field_convert'] + ' id不存在则新增，存在则修改\n'
      text += '     * @return\n'
      text += '     */\n'
      text += '    @RequestMapping("toSave")\n'
      text += '    public String toSave(Integer ' + param['fields'][0][
          'field_convert'] + ',Model model) {\n'
      text += '        if (' + \
          param['fields'][0]['field_convert'] + ' != null) {\n'
      text += '            model.addAttribute("' + param[
          'table_name_convert'] + '", service.get(' + param['fields'][0]['field_convert'] + '));\n'
      text += '        }\n'
      text += '        return "【补充路径】/admin/sa/' + \
          param['table_name_convert'] + 'Form";\n'
      text += '    }\n'
      text += '\n'
      # 新增/修改方法
      text += '    /**\n'
      text += '     * 新增/修改\n'
      text += '     *\n'
      text += '     * @param ' + \
          param['table_name_convert'] + ' id不存在则新增，存在则修改\n'
      text += '     * @return\n'
      text += '     */\n'
      text += '    @RequestMapping("save")\n'
      text += '    public void save(' + param['table_name_convert_type'] + ' ' + param[
          'table_name_convert'] + ',HttpServletResponse response) {\n'
      text += '        try{\n'
      text += '            service.save(' + \
          param['table_name_convert'] + ');\n'
      text += '            AjaxResponseUtils.renderSuccess(response);\n'
      text += '        } catch (Exception e) {\n'
      text += '            e.printStackTrace();\n'
      text += '            AjaxResponseUtils.renderError(response,e.getMessage());\n'
      text += '        }\n'
      text += '    }\n'
      text += '\n'
    # 生成删除方法
    if param['options'][1]:
      text += '    /**\n'
      text += '     * 根据id删除\n'
      text += '     *\n'
      text += '     * @param ' + param['fields'][0]['field_convert'] + '\n'
      text += '     * @return\n'
      text += '     */\n'
      text += '    @RequestMapping("delete")\n'
      text += '    public void delete(Integer ' + param['fields'][0][
          'field_convert'] + ',HttpServletResponse response) {\n'
      text += '        try{\n'
      text += '            //todo 一般为假删除\n'
      text += '            //service.delete(' + \
          param['fields'][0]['field_convert'] + ');\n'
      text += '            AjaxResponseUtils.renderSuccess(response);\n'
      text += '        } catch (Exception e) {\n'
      text += '            e.printStackTrace();\n'
      text += '            AjaxResponseUtils.renderError(response,e.getMessage());\n'
      text += '        }\n'
      text += '    }\n'
      text += '\n'
    # 生成自定义方法
    if len(param['options']) > 2:
      for option in param['options'][2:]:
        if option[2]:
          text += '    /**\n'
          text += '     * ' + option[0] + '\n'
          text += '     *\n'
          text += '     * @param ' + param['fields'][0]['field_convert'] + '\n'
          text += '     * @return\n'
          text += '     */\n'
          text += '    @RequestMapping("' + option[1] + '")\n'
          text += '    public void ' + \
              option[1] + '(Integer ' + \
              param['fields'][0]['field_convert'] + ') {\n'
          text += '        //todo\n'
          text += '    }\n'
          text += '\n'
    text += '    \n'
    text += '    \n'
    text += '    \n'
  text += '}\n'

  with open('E:\\sublimeWorkspace\\auto_code\\impl\\template\\' + param['table_name_convert_type'] + 'Controller.java', 'wb') as f:
    f.write(text.encode('utf-8'))
