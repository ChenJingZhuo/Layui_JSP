<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>网站用户</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="../../../layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="../../../layuiadmin/style/admin.css" media="all">
</head>
<body>

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">ID</label>
                    <div class="layui-input-block">
                        <input type="text" name="id" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">用户名</label>
                    <div class="layui-input-block">
                        <input type="text" name="username" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">性别</label>
                    <div class="layui-input-block">
                        <select name="sex">
                            <option value="0">不限</option>
                            <option value="1">男</option>
                            <option value="2">女</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-useradmin" lay-submit lay-filter="LAY-user-front-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="layui-card-body">
            <div style="padding-bottom: 10px;">
                <button class="layui-btn layuiadmin-btn-useradmin" data-type="batchdel">删除</button>
                <button class="layui-btn layuiadmin-btn-useradmin" id="add">添加</button>
            </div>

<%--            <table id="LAY-user-manage" lay-filter="LAY-user-manage"></table>--%>
            <table class="layui-hide" id="test"></table>
            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-normal layui-btn-xs" onclick="edit()"><i
                        class="layui-icon layui-icon-edit"></i>编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
                        class="layui-icon layui-icon-delete"></i>删除</a>
            </script>
        </div>
    </div>
    <div class="layui-col-md12">
        <!-- 底部固定区域 -->
        <b>Version</b> 1.0.0
        <strong>Copyright &copy; 2020-2021 编程要快乐 <a href="http://beian.miit.gov.cn/">粤ICP备20056073号</a>.</strong> All rights
        reserved.
    </div>
</div>

<script src="../../../layuiadmin/layui/layui.js"></script>
<script>
    /*layui.config({
        base: '../../../layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'useradmin', 'table'], function () {
        var $ = layui.$
            , form = layui.form
            , table = layui.table;

        //监听搜索
        form.on('submit(LAY-user-front-search)', function (data) {
            var field = data.field;

            //执行重载
            table.reload('LAY-user-manage', {
                where: field
            });
        });

        //事件
        var active = {
            batchdel: function () {
                var checkStatus = table.checkStatus('LAY-user-manage')
                    , checkData = checkStatus.data; //得到选中的数据

                if (checkData.length === 0) {
                    return layer.msg('请选择数据');
                }

                layer.prompt({
                    formType: 1
                    , title: '敏感操作，请验证口令'
                }, function (value, index) {
                    layer.close(index);

                    layer.confirm('确定删除吗？', function (index) {

                        //执行 Ajax 后重载
                        /!*
                        admin.req({
                          url: 'xxx'
                          //,……
                        });
                        *!/
                        table.reload('LAY-user-manage');
                        layer.msg('已删除');
                    });
                });
            }
        };

        $('.layui-btn.layuiadmin-btn-useradmin').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });*/

    layui.use(['jquery', 'layer', 'form', 'table'], function () {
        var $ = layui.jquery
        ,layer = layui.layer
        ,form = layui.form
        ,table = layui.table;


        //监听搜索
        form.on('submit(LAY-user-front-search)', function (data) {
            var field = data.field;

            //执行重载
            table.reload('LAY-user-manage', {
                where: field
            });
        });

        //事件
        var active = {
            batchdel: function () {
                var checkStatus = table.checkStatus('LAY-user-manage')
                    , checkData = checkStatus.data; //得到选中的数据

                if (checkData.length === 0) {
                    return layer.msg('请选择数据');
                }

                layer.prompt({
                    formType: 1
                    , title: '敏感操作，请验证口令'
                }, function (value, index) {
                    layer.close(index);

                    layer.confirm('确定删除吗？', function (index) {

                        //执行 Ajax 后重载
                        /*
                        admin.req({
                          url: 'xxx'
                          //,……
                        });
                        */
                        table.reload('LAY-user-manage');
                        layer.msg('已删除');
                    });
                });
            }
        };

        $('.layui-btn.layuiadmin-btn-useradmin').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        table.render({
            elem: '#test'
            , url: '${pageContext.request.contextPath}/findAllPerson'
            , cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            , page: true
            , totalRow: false
            , title: '网站用户数据表'
            , cols: [[
                {type:'checkbox'}
                , {field: 'id', width: 80, title: 'ID', align: 'center', sort: true}
                , {field: 'username', width: 80, title: '用户名', align: 'center'}
                , {field: 'sex', width: 80, title: '性别', width: '15%', minWidth: 100, align: 'center', sort: true,
                    templet: function (d) {
                        return d.sex == "1" ? "男" : "女";
                    }} //templet: '<div>{{d.sex == "1" ? "男" : "女"}}</div>'
                , {field: 'city', width: 80, title: '城市', width: '10%', minWidth: 100, align: 'center'}
                , {field: 'birthday', title: '出生日期', width: '20%', minWidth: 100, align: 'center'} //minWidth：局部定义当前单元格的最小宽度，layui 2.2.1 新增
                , {field: 'tel', title: '手机号码', width: '20%', minWidth: 100, align: 'center'}, //minWidth：局部定义当前单元格的最小宽度，layui 2.2.1 新增
                , {fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
            ]]
        });


        $("#add").click(function () {
            layer.open({
                type: 2
                , title: '添加用户'
                , content: 'userform.jsp'
                , maxmin: true
                , area: ['500px', '450px']
                , btn: ['确定', '取消']
                , yes: function (index, layero) {
                    var iframeWindow = window['layui-layer-iframe' + index]
                        , submitID = 'LAY-user-front-submit'
                        , submit = layero.find('iframe').contents().find('#' + submitID);

                    //监听提交
                    iframeWindow.layui.form.on('submit(' + submitID + ')', function (data) {
                        var field = data.field; //获取提交的字段

                        //提交 Ajax 成功后，静态更新表格中的数据
                        //$.ajax({});
                        table.reload('LAY-user-front-submit'); //数据刷新
                        layer.close(index); //关闭弹层
                    });

                    submit.trigger('click');
                }
            });
        });


        window.edit = function(){
            layer.open({
                type: 2
                , title: '编辑用户'
                , content: 'userform.jsp'
                , maxmin: true
                , area: ['500px', '450px']
                , btn: ['确定', '取消']
                , yes: function (index, layero) {
                    var iframeWindow = window['layui-layer-iframe' + index]
                        , submitID = 'LAY-user-front-submit'
                        , submit = layero.find('iframe').contents().find('#' + submitID);

                    //监听提交
                    iframeWindow.layui.form.on('submit(' + submitID + ')', function (data) {
                        var field = data.field; //获取提交的字段

                        //提交 Ajax 成功后，静态更新表格中的数据
                        //$.ajax({});
                        table.reload('LAY-user-front-submit'); //数据刷新
                        layer.close(index); //关闭弹层
                    });

                    submit.trigger('click');
                }
            });
        }

    })

</script>
</body>
</html>
