#-*- coding: UTF-8 -*-
def ftl_list(param):

	url_convert = param['controller_url']
	if not param['controller_url'] == '':
		if param['controller_url'][0] == '/':
			param['controller_url'] = param['controller_url'][1:]	
		if param['controller_url'].find('admin/sa') == 1:
			url_convert = url_convert[9:]
	text = '<#assign ctx = request.contextPath>\n'
	text+= '<!DOCTYPE HTML>\n'
	text+= '<html>\n'
	text+= '<head>\n'
	text+= '<#include "${ctx}/includes/sa/header.ftl"/>\n'
	text+= '</head>\n'
	text+= '<body>\n'
	text+= '<div class="container">\n'

	text+= tab(1)+'<div class="title-bar">\n'
	text+= tab(2)+'<div class="title-bar">\n'
	text+= tab(3)+'<div id="tab"></div>\n'
	text+= tab(2)+'</div>\n'

	text+= tab(2)+'<div class="content-top">\n'
	text+= tab(3)+'<div class="title-bar-side">\n'
	text+= tab(4)+'<div class="search-bar">\n'
	text+= tab(4)+'</div>\n'
	text+= tab(4)+'<div class="search-content">\n'
	text+= tab(5)+'<form id="searchForm" class="form-horizontal span24">\n'
	text+= tab(5)+'</form>\n'
	text+= tab(4)+'</div>\n'
	text+= tab(3)+'</div>\n'
	text+= tab(2)+'</div>\n'
	text+= tab(2)+'<div class="content-body">\n'
	text+= tab(3)+'<div id="grid"></div>\n'
	text+= tab(2)+'</div>\n'
	text+= tab(1)+'</div>\n'
	text+= '</div>\n'
	text+= '\n'

	text+= '<script type="text/javascript">\n'
	text+= tab(1)+'var Tab = BUI.Tab;\n'
	text+= tab(1)+'var search;\n'
	text+= tab(1)+'var grid;\n'
	text+= tab(1)+'var tab = new Tab.Tab({\n'
	text+= tab(2)+'render: "#tab",\n'
	text+= tab(2)+'elCls: "nav-tabs"\n'
	text+= tab(2)+'autoRender: true,\n'
	text+= tab(2)+'children: [\n'
	for top_tab in param['top_tabs']:
		text+= tab(3)+'{text: "'+top_tab[0]+'", value: "'+top_tab[1]+'"}'
		if not top_tab == param['top_tabs'][-1]:
			text+= ','
		text+= '\n'
	text+= tab(2)+']\n'
	text+= tab(1)+'});\n'
	text+= '\n'
	text+= tab(1)+'BUI.use(["common/search", "common/page"], function (Search) {\n'
	text+= tab(2)+'var columns = [\n'
	#表格字段
	for field in param['fields']:
		text+= tab(3)+'{title: "'+field['field_cn_name']+'", dataIndex: "'+field['field_convert']+'", width: '+get_width_by_type(field['field_type'])
		if field['field_type'] == 'Date':
			text += ',renderer: BUI.Grid.Format.datetimeRenderer'
		text+= '},\n'
	#操作栏
	text+= tab(3)+'{title: "操作", dataIndex: "", width: 100, renderer: function (value, rowObj) {\n'
	text+= tab(4)+'var str = "";\n'
	if param['options'][0]:
		text+= tab(4)+'str += \'&nbsp;&nbsp;<a href=\\\'javascript:edit(\\\"\' + rowObj.'+param['fields'][0]['field_convert']+' + \'\\\")\\\'>编辑</a>\';\n'
	if param['options'][1]:
		text+= tab(4)+'str += \'&nbsp;&nbsp;<a href=\\\'javascript:del(\\\"\' + rowObj.'+param['fields'][0]['field_convert']+' + \'\\\")\\\'>删除</a>\';\n'
	if len(param['options']) > 2:
		for option in param['options'][2:]:
			text+= tab(4)+'str += \'&nbsp;&nbsp;<a href=\\\'javascript:'+option[1]+'(\\\"\' + rowObj.'+param['fields'][0]['field_convert']+' + \'\\\")\\\'>'+option[0]+'</a>\';\n'
	text+= tab(4)+'return str;\n'
	text+= tab(3)+'}}\n'
	text+= tab(2)+'];\n'
	text+= tab(2)+'var store = Search.createStore("'+url_convert+'/grid_json");\n'
	text+= tab(2)+'var gridCfg = Search.createGridCfg(columns, {\n'
	text+= tab(3)+'plugins: [BUI.Grid.Plugins.ColumnResize],\n'
	text+= tab(3)+'stripeRows: false,\n'
	text+= tab(3)+'width: "100%",\n'
	text+= tab(3)+'height: getContentHeight(),\n'
	text+= tab(3)+'render: "#grid",\n'
	text+= tab(3)+'columns: columns\n'
	text+= tab(3)+', tbar: {\n'
	text+= tab(4)+'items: [\n'
	if param['options'][0]:
		text+= tab(5)+'{text: "添加", btnCls: "button button-small button-primary", handler: add}\n'
	text+= tab(4)+']\n'
	text+= tab(3)+'}\n'
	text+= tab(2)+'});\n'
	text+= '\n'
	text+= tab(2)+'search = new Search({\n'
	text+= tab(3)+'store: store,\n'
	text+= tab(3)+'gridCfg: gridCfg\n'
	text+= tab(2)+'});\n'
	text+= tab(2)+'grid = search.get("grid");\n'
	text+= tab(2)+'grid.render();\n'
	text+= '\n'
	text+= tab(2)+'tab.setSelected(tab.getItemAt(0));\n'
	text+= '\n'
	text+= tab(2)+'tab.on("selectedchange", function (ev) {\n'
	text+= tab(3)+'//todo\n'
	text+= tab(3)+'search.load();\n'
	text+= tab(2)+'}\n'
	text+= '\n'
	text+= tab(1)+'});\n'
	text+= '\n'
	if param['options'][0]:
		text+= tab(1)+'function add() {\n'
		text+= tab(2)+'window.location.href = "${ctx}/'+param['controller_url']+'/toSave";\n'
		text+= tab(1)+'}\n'
		text+= '\n'
	if param['options'][0]:
		text+= tab(1)+'function edit('+param['fields'][0]['field_convert']+') {\n'
		text+= tab(2)+'window.location.href = "${ctx}/'+param['controller_url']+'/toSave?'+param['fields'][0]['field_convert']+'="+'+param['fields'][0]['field_convert']+';\n'
		text+= tab(1)+'}\n'
		text+= '\n'
	if param['options'][1]:
		text+= tab(1)+'function del('+param['fields'][0]['field_convert']+') {\n'
		text+= tab(2)+'window.location.href = "${ctx}/'+param['controller_url']+'/delete?'+param['fields'][0]['field_convert']+'="+'+param['fields'][0]['field_convert']+';\n'
		text+= tab(1)+'}\n'
		text+= '\n'
	if len(param['options']) > 2:
		for option in param['options'][2:]:
			text+= tab(1)+'//导出\n'
			text+= tab(1)+'function '+option[1]+'('+param['fields'][0]['field_convert']+') {\n'
			if option[2]:
				text+= tab(2)+'window.location.href = "${ctx}/'+param['controller_url']+'/'+option[1]+'?'+param['fields'][0]['field_convert']+'="+'+param['fields'][0]['field_convert']+';\n'
			text+= tab(1)+'}\n'
			text+= '\n'
	text+= '</script>\n'

	with open(param['path'] + param['table_name_convert']+'.ftl','wb') as f:
		f.write(text.encode('utf-8'))

def tab(tab_num):
	'''
	生成四倍数的空格
	'''
	space_str = ''
	for x in range(tab_num):
		space_str += '    '
	return space_str

def get_width_by_type(type):
	'''
	获取列表字段
	'''
	if type == 'Integer':
		return '80'
	if type == 'Date':
		return '160'
	return '100'