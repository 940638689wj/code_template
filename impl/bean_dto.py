def bean_dto(param):
	
	text= '\n'
	text+='public class '+param['table_name_convert_type']+'DTO extends '+param['table_name_convert_type']+'{\n' 
	text+='\n' 
	text+='}\n'

	with open('E:\\sublimeWorkspace\\auto_code\\impl\\template\\'+param['table_name_convert_type']+'DTO.java','w') as f:
		f.write(text)
