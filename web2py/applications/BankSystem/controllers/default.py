# -*- coding: utf-8 -*-
# -------------------------------------------------------------------------
# This is a sample controller
# this file is released under public domain and you can use without limitations
# -------------------------------------------------------------------------

# ---- example index page ----
import utils


def index():
    return dict()


def branch():
    message = T('支行管理')
    table_name = 'branch'
    vars = dict(request.vars)
    sql = utils.build_sql(bankdb, table_name, vars)
    table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    if sql is not None:
        try:
            table_values = bankdb.executesql(sql, as_dict=True)
        except Exception as e:
            response.flash = T('操作失败，请检查参数。' + str(e))
    if not 'select' in vars:
        table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    operations = ['select', 'insert', 'update', 'delete']
    return dict(locals())


def staff():
    message = T('员工管理')
    table_name = 'staff'
    response.view = 'default/branch.html'
    vars = dict(request.vars)
    sql = utils.build_sql(bankdb, table_name, vars)
    table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    if sql is not None:
        try:
            table_values = bankdb.executesql(sql, as_dict=True)
        except Exception as e:
            response.flash = T('操作失败，请检查参数。' + str(e))
    if not 'select' in vars:
        table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    operations = ['select', 'insert', 'update', 'delete']
    return dict(locals())


def client():
    message = T('客户管理')
    table_name = 'client'
    response.view = 'default/branch.html'
    vars = dict(request.vars)
    sql = utils.build_sql(bankdb, table_name, vars)
    table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    if sql is not None:
        try:
            table_values = bankdb.executesql(sql, as_dict=True)
        except Exception as e:
            response.flash = T('操作失败，请检查参数。' + str(e))
    if not 'select' in vars:
        table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    operations = ['select', 'insert', 'update', 'delete']
    return dict(locals())


def checkingaccount():
    message = T('支票账户管理')
    table_name = 'checkingaccount'
    response.view = 'default/branch.html'
    vars = dict(request.vars)
    sql = utils.build_sql(bankdb, table_name, vars)
    table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    if sql is not None:
        try:
            table_values = bankdb.executesql(sql, as_dict=True)
        except Exception as e:
            response.flash = T('操作失败，请检查参数。' + str(e))
    if not 'select' in vars:
        table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    operations = ['select', 'insert', 'update', 'delete']
    return dict(locals())


def owncheckingaccount():
    message = T('支票账户所有权管理')
    table_name = 'owncheckingaccount'
    response.view = 'default/branch.html'
    vars = dict(request.vars)
    sql = utils.build_sql(bankdb, table_name, vars)
    table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    if sql is not None:
        try:
            table_values = bankdb.executesql(sql, as_dict=True)
        except Exception as e:
            response.flash = T('操作失败，请检查参数。' + str(e))
    if not 'select' in vars:
        table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    operations = ['select', 'insert', 'update', 'delete']
    return dict(locals())


def savingaccount():
    message = T('储蓄账户管理')
    table_name = 'savingaccount'
    response.view = 'default/branch.html'
    vars = dict(request.vars)
    sql = utils.build_sql(bankdb, table_name, vars)
    table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    if sql is not None:
        try:
            table_values = bankdb.executesql(sql, as_dict=True)
        except Exception as e:
            response.flash = T('操作失败，请检查参数。' + str(e))
    if not 'select' in vars:
        table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    operations = ['select', 'insert', 'update', 'delete']
    return dict(locals())


def ownsavingaccount():
    message = T('储蓄账户所有权管理')
    table_name = 'ownsavingaccount'
    response.view = 'default/branch.html'
    vars = dict(request.vars)
    sql = utils.build_sql(bankdb, table_name, vars)
    table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    if sql is not None:
        try:
            table_values = bankdb.executesql(sql, as_dict=True)
        except Exception as e:
            response.flash = T('操作失败，请检查参数。' + str(e))
    if not 'select' in vars:
        table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    operations = ['select', 'insert', 'update', 'delete']
    return dict(locals())


def hasaccount():
    message = T('开户情况')
    table_name = 'hasaccount'
    response.view = 'default/branch.html'
    vars = dict(request.vars)
    sql = utils.build_sql(bankdb, table_name, vars)
    table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    if sql is not None:
        try:
            table_values = bankdb.executesql(sql, as_dict=True)
        except Exception as e:
            response.flash = T('操作失败，请检查参数。' + str(e))
    if not 'select' in vars:
        table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    operations = ['select']
    return dict(locals())


def loan():
    message = T('贷款管理')
    table_name = 'loan'
    response.view = 'default/branch.html'
    vars = dict(request.vars)
    sql = utils.build_sql(bankdb, table_name, vars)
    table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    if sql is not None:
        try:
            table_values = bankdb.executesql(sql, as_dict=True)
        except Exception as e:
            response.flash = T('操作失败，请检查参数。' + str(e))
    if not 'select' in vars:
        table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    operations = ['select', 'insert', 'delete']
    return dict(locals())


def loaninfo():
    message = T('贷款状态查询')
    table_name = 'loaninfo'
    response.view = 'default/branch.html'
    vars = dict(request.vars)
    sql = utils.build_sql(bankdb, table_name, vars)
    table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    if sql is not None:
        try:
            table_values = bankdb.executesql(sql, as_dict=True)
        except Exception as e:
            response.flash = T('操作失败，请检查参数。' + str(e))
    if not 'select' in vars:
        table_values, column_name_list, primary_key_list, column_type_list = utils.get_table_info(bankdb, table_name)
    operations = ['select']
    return dict(locals())

def summary():
    message = '数据统计'
    vars = dict(request.vars)
    labels = []
    sizes = []
    try:
        if 'submit' in vars:
            table_name = vars['table_name']
            data_type = vars['data_type']
            start_date = vars['start']
            end_date = vars['end']
            sql = f'select branch_name, {data_type} from {table_name} where open_date between "{start_date}" and "{end_date}" group by branch_name;'
            table_values = bankdb.executesql(sql)
            labels = [row[0] for row in table_values]
            sizes = [float(row[1]) for row in table_values]
            utils.plot(labels, sizes)
    except Exception as e:
        response.flash = sql + str(e)
        massage = sql
    return dict(locals())

# ---- API (example) -----
@auth.requires_login()
def api_get_user_email():
    if not request.env.request_method == 'GET': raise HTTP(403)
    return response.json({'status':'success', 'email':auth.user.email})

# ---- Smart Grid (example) -----
@auth.requires_membership('admin') # can only be accessed by members of admin groupd
def grid():
    response.view = 'generic.html' # use a generic view
    tablename = request.args(0)
    if not tablename in db.tables: raise HTTP(403)
    grid = SQLFORM.smartgrid(db[tablename], args=[tablename], deletable=False, editable=False)
    return dict(grid=grid)

# ---- Embedded wiki (example) ----
def wiki():
    auth.wikimenu() # add the wiki to the menu
    return auth.wiki() 

# ---- Action for login/register/etc (required for auth) -----
def user():
    """
    exposes:
    http://..../[app]/default/user/login
    http://..../[app]/default/user/logout
    http://..../[app]/default/user/register
    http://..../[app]/default/user/profile
    http://..../[app]/default/user/retrieve_password
    http://..../[app]/default/user/change_password
    http://..../[app]/default/user/bulk_register
    use @auth.requires_login()
        @auth.requires_membership('group name')
        @auth.requires_permission('read','table name',record_id)
    to decorate functions that need access control
    also notice there is http://..../[app]/appadmin/manage/auth to allow administrator to manage users
    """
    return dict(form=auth())

# ---- action to server uploaded static content (required) ---
@cache.action()
def download():
    """
    allows downloading of uploaded files
    http://..../[app]/default/download/[filename]
    """
    return response.download(request, db)
