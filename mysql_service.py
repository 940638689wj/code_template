from sqlalchemy import Column, String, create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

global engine 
engine = create_engine('mysql+mysqlconnector://root:Aa123456@dev.xmyr.cn:9875/ico_test')
global DBSession
global database_name

def test_conn(database_param):
  create_conn(database_param)
  session = DBSession()
  sql = 'select 1'
  try:
    session.execute(sql).fetchall()
    return True
  except Exception as e:
    return False


def create_conn(database_param):
  global engine
  global DBSession
  global database_name
  database_str = 'mysql+mysqlconnector://' + database_param['username'] + ':'
  database_str += database_param['password'] + '@'
  database_str += database_param['ip_or_host'] + ':'
  database_str += database_param['port'] + '/'
  database_str += database_param['database_name']

  engine = create_engine(database_str)
  DBSession = sessionmaker(bind=engine)
  database_name = database_param['database_name']


def find_table_list():
  # 查询所有表
  # 创建session对象:
  session = DBSession()
  sql = 'select TABLE_NAME,TABLE_COMMENT from information_schema.`TABLES` where TABLE_SCHEMA=\''+database_name+'\''
  result = list(session.execute(sql).fetchall())
  result_list = []
  for r in result:
    result_list.append({'value': r[0], 'label': r[0] + ' ' + r[1]})
  session.close()
  return result_list


def find_table_struct(table_name):
  # 查询表结构
  # 创建session对象:
  session = DBSession()
  sql = 'select t2.table_schema,t2.table_name,t1.table_comment,t2.column_name,t2.column_comment,'
  sql += 't2.column_type,cast(t2.ordinal_position as char) as position,'
  sql += 't2.column_default,t2.is_nullable,(case when column_key=\'PRI\' then \'T\' else \'F\' end) as is_Pri_Key '
  sql += ',(case when t3.referenced_column_name is not null then \'T\' else \'F\' end) as is_FK,'
  sql += 'referenced_table_schema,referenced_table_name as referenced_table,referenced_column_name as referenced_column '
  sql += ' ,t2.ordinal_position  from information_schema.columns T2 inner join information_schema.tables T1 '
  sql += ' on t1.table_name=t2.table_name'
  sql += ' and t1.table_schema=t2.table_schema '
  sql += ' left join information_schema.KEY_COLUMN_USAGE T3 on t3.table_name=t2.table_name '
  sql += ' and t3.table_schema=t2.table_schema and t2.column_name=t3.column_name and referenced_column_name is not null '
  sql += ' where upper(t2.table_schema)=upper(\'mallxiahang\') '
  sql += ' and t2.table_name = \'' + table_name + \
      '\' order by table_name,ordinal_position'
  result = list(session.execute(sql).fetchall())
  result_list = []
  for r in result:
    result_list.append({'fieldName': r[3], 'fieldCnName': r[
                       4], 'fieldType': get_java_type(str(r[5]))})
  session.close()
  return result_list


def get_java_type(type_name):
  if 'int' in type_name:
    return 'Integer'
  if 'varchar' in type_name:
    return 'String'
  if 'date' in type_name:
    return 'Date'
  if 'decimal' in type_name:
    return 'BigDecimal'

'''
# 初始化数据库连接:
engine = create_engine(
    'mysql+mysqlconnector://root:Aa123456@dev.xmyr.cn:9875/mallxiahang')
# 创建DBSession类型:
DBSession = sessionmaker(bind=engine)
# 创建对象的基类:
Base = declarative_base()
# 定义User对象:
class User(Base):
  # 表的名字:
  __tablename__ = 'user'

  # 表的结构:
  id = Column(String(20), primary_key=True)
  name = Column(String(20))
# 创建新User对象:
new_user = User(id='6', name='Cc')
# 添加到session:
session.add(new_user)
# 提交即保存到数据库:
session.commit()
# 关闭session:
session.close()

# 创建Session:
session = DBSession()
# 创建Query查询，filter是where条件，最后调用one()返回唯一行，如果调用all()则返回所有行:
user = session.query(User).filter(User.id == '5').one()
# 打印类型和对象的name属性:
print('type:', type(user))
print('name:', user.name)
# 关闭Session:
session.close()
'''
