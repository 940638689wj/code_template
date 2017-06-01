#-*- coding: UTF-8 -*-
def bean(param):

    text = 'import cn.yr.chile.common.persistence.BaseEntity;\n'
    text += '\n'
    text += 'public class ' + param['table_name_convert_type'] + \
        ' extends BaseEntity<' + param['table_name_convert_type'] + '>{\n'
    text += '\n'
    for field in param['fields']:
        text += '    private ' + field['field_type'] + ' ' + \
            field['field_convert'] + '; //' + field['field_cn_name'] + '\n'
    text += '\n'
    for field in param['fields']:
        text += '    /**\n'
        text += '      * 获取 '+field['field_cn_name']+'\n'
        text += '      */\n'
        text += '    public ' + field['field_type'] + \
            ' get' + field['field_convert_type'] + '(){\n'
        text += '        return this.' + field['field_convert'] + ';\n'
        text += '    }\n'
        text += '    \n'
        text += '    /**\n'
        text += '      * 设置 '+field['field_cn_name']+'\n'
        text += '      */\n'
        text += '    public void set' + field['field_convert_type'] + \
            '(' + field['field_type'] + ' ' + field['field_convert'] + '){\n'
        text += '        this.' + field['field_convert'] + ' = ' + field['field_convert'] + ';\n'
        text += '    }\n'
        text += '    \n'
    text += '}\n'

    with open(param['path'] + param['table_name_convert_type'] + '.java', 'wb') as f:
        f.write(text.encode('utf-8'))
