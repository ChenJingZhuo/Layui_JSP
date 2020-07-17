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
                    <label class="layui-form-label">用户名</label>
                    <div class="layui-input-block">
                        <input type="text" name="username" placeholder="请输入要查找的用户名" autocomplete="off" class="layui-input">
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
            <%--<div style="padding-bottom: 10px;">
                <button class="layui-btn layuiadmin-btn-useradmin" id="add">添加</button>
                <button class="layui-btn layuiadmin-btn-useradmin" data-type="batchdel">删除</button>
            </div>--%>

            <div style="padding-bottom: 10px;display: none" id="personToolBar">
                <button class="layui-btn layui-btn-sm" lay-event="add">添加</button>
                <button class="layui-btn layui-btn-sm" lay-event="batchDelete">删除</button>
            </div>

<%--            <table id="LAY-user-manage" lay-filter="LAY-user-manage"></table>--%>
            <table class="layui-hide" id="test" lay-filter="test"></table>
            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
                        class="layui-icon layui-icon-edit" ></i>编辑</a>
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
    layui.use(['jquery', 'layer', 'form', 'table', 'laypage'], function () {
        var $ = layui.jquery
        ,layer = layui.layer
        ,form = layui.form
        ,table = layui.table
        ,laypage = layui.laypage;



        //监听搜索
        form.on('submit(LAY-user-front-search)', function (data) {
            var field = data.field;

            // alert(field.username)

            if (field.username == ''){
                layer.msg('请输入搜索数据');
                return;
            }

            //执行重载
            table.reload('test', {
                url: '${pageContext.request.contextPath}/selectPersonByParam'
                ,method: 'POST'
                // ,data: field.username
                ,where: { //设定异步数据接口的额外参数，任意设
                    'username': field.username
                    // ,bbb: 'yyy'
                    //…
                }
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
            }); //只重载数据
        });


        table.render({
            elem: '#test'
            , url: '${pageContext.request.contextPath}/findAllPerson'
            , cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            , page: true
            , totalRow: false
            , title: '网站用户数据表'
            , toolbar: '#personToolBar'
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


        //监听头部工具栏事件
        table.on("toolbar(test)", function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'add':
                    layer.msg('添加');
                    layer.open({
                        type: 2
                        , title: '添加用户'
                        , content: 'userform.jsp'
                        , maxmin: true
                        , area: ['500px', '450px']
                        , btn: ['确定', '取消']
                        , success: function (layero, index) {
                            //找到它的子窗口的body
                            var body = layer.getChildFrame('body', index);  //巧妙的地方在这里哦
                            //为子窗口元素赋值
                            body.contents().find("#firstName").val(data.username);
                            // ......//以此类推
                        }
                        , yes: function (index, layero) {
                            var iframeWindow = window['layui-layer-iframe' + index]
                                , submitID = 'LAY-user-front-submit'
                                , submit = layero.find('iframe').contents().find('#' + submitID);

                            //监听提交
                            iframeWindow.layui.form.on('submit(' + submitID + ')', function (data) {
                                var field = data.field; //获取提交的字段

                                //提交 Ajax 成功后，静态更新表格中的数据
                                //$.ajax({});
                                $.ajax({
                                    url: '${pageContext.request.contextPath}/person',
                                    type: 'POST',
                                    data: field,
                                    success: function (result) {
                                        if (result.code = 100) {
                                            layer.msg("添加成功", {icon: 1});
                                        } else {
                                            layer.msg("添加失败", {icon: 2});
                                        }
                                    }
                                })
                                // table.reload('test'); //数据刷新
                                layer.close(index); //关闭弹层
                                window.location.reload();
                            });

                            submit.trigger('click');
                        }
                    });
                    break;
                case 'batchDelete':
                    layer.msg('删除');
                    var checkStatus = table.checkStatus('test'); //idTest 即为基础参数 id 对应的值

                    console.log(checkStatus.data) //获取选中行的数据
                    console.log(checkStatus.data.length) //获取选中行数量，可作为是否有选中行的条件
                    console.log(checkStatus.isAll ) //表格是否全选

                    //获取选中数量
                    var selectCount = checkStatus.data.length;
                    if(selectCount == 0){
                        layer.msg('批量删除至少选中一项数据',function(){});
                        return false;
                    }
                    layer.confirm('真的要删除选中的项吗？',{icon:3}, function(index){
                        // index = layer.load(1, {shade: [0.1,'#fff']});

                        var isStr="";
                        for(var i=0; i<selectCount; i++){
                            if (checkStatus.data[i].username == "${username}"){
                                layer.msg("当前用户：【${username}】不能删除");
                                return;
                            }
                            isStr = isStr + "," + checkStatus.data[i].id;
                        }
                        isStr = isStr.substring(1,isStr.length)
                        $.ajax({
                            url:"${pageContext.request.contextPath}/person/"+isStr,
                            type:'DELETE',
                            success:function(result){
                                if (result.code = 100) {
                                    layer.msg("删除成功", {icon: 1});
                                } else {
                                    layer.msg("删除失败", {icon: 2});
                                }
                            }/*,error:function(code){
                                parent.layer.msg('操作失败!',{icon: 5,time:1000});
                            }*/
                        });
                        layer.close(index);
                        window.location.reload();
                    })
                    break;
            };
        });

        //监听复选框
        table.on('checkbox(test)', function(obj){
            console.log(obj.checked); //当前是否选中状态
            console.log(obj.data); //选中行的相关数据
            console.log(obj.type); //如果触发的是全选，则为：all，如果触发的是单选，则为：one
        });

        //监听工具条
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）

            if(layEvent === 'detail'){ //查看
                //do somehing
            } else if(layEvent === 'del'){ //删除
                layer.confirm('您确定要删除【'+data.username+'】吗？',
                    {
                        icon: 3
                        // ,time: 2000 //2秒关闭（如果不配置，默认是3秒）
                    }, function(index){
                        //向服务端发送删除指令
                        $.ajax({
                            url: "${pageContext.request.contextPath}/person/" + data.id,
                            type: "DELETE",
                            success: function (result) {
                                if (result.code = 100) {
                                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                                    layer.msg("删除成功", {icon: 1});
                                } else {
                                    layer.msg("删除失败", {icon: 2});
                                }
                            }
                        });
                        layer.close(index);
                    });
            } else if(layEvent === 'edit'){ //编辑
                //do something

                //同步更新缓存对应的值
                /*obj.update({
                    username: '123'
                    ,title: 'xxx'
                });*/
                layer.open({
                    type: 2
                    , title: '编辑用户'
                    , content: 'edit.jsp'
                    , maxmin: true
                    , area: ['500px', '450px']
                    , btn: ['确定', '取消']
                    , success: function (layero, index) {
                        //找到它的子窗口的body
                        var body = layer.getChildFrame('body', index);  //巧妙的地方在这里哦
                        //为子窗口元素赋值
                        body.contents().find("#id").val(data.id);
                        body.contents().find("#firstName").val(data.username);
                        body.contents().find("#editPerson").val(data.username);
                        body.contents().find("input[name='sex']").val(data.sex);
                        body.contents().find("option[value='"+data.city+"']").attr("selected",true);
                        body.contents().find("#birthday").val(data.birthday);
                        body.contents().find("#tel").val(data.tel);
                        // ......//以此类推
                    }
                    , yes: function (index, layero) {
                        var iframeWindow = window['layui-layer-iframe' + index]
                            , submitID = 'LAY-user-front-submit'
                            , submit = layero.find('iframe').contents().find('#' + submitID);

                        //监听提交
                        iframeWindow.layui.form.on('submit(' + submitID + ')', function (data) {
                            var field = data.field; //获取提交的字段

                            //提交 Ajax 成功后，静态更新表格中的数据
                            //$.ajax({});
                            $.ajax({
                                url: '${pageContext.request.contextPath}/person',
                                type: 'PUT',
                                data: field,
                                success: function (result) {
                                    if (result.code = 100) {
                                        layer.msg("修改成功", {icon: 1});
                                    } else {
                                        layer.msg("修改失败", {icon: 2});
                                    }
                                }
                            });

                            /*table.reload('test', function () {
                                page:{
                                    curr:1
                                }
                            }); //数据刷新*/
                            window.location.reload();
                            layer.close(index); //关闭弹层
                        });

                        submit.trigger('click');
                    }
                });
            } else if(layEvent === 'LAYTABLE_TIPS'){
                layer.alert('Hi，头部工具栏扩展的右侧图标。');
            }
        });

    })

</script>
</body>
</html>
