<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>layuiAdmin 网站用户 iframe 框</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="../../../layuiadmin/layui/css/layui.css" media="all">
</head>
<body>

  <div class="layui-form" lay-filter="layuiadmin-form-useradmin" id="layuiadmin-form-useradmin" style="padding: 20px 0 0 0;">
    <div class="layui-form-item" hidden style="display: none">
      <label class="layui-form-label">id</label>
      <div class="layui-input-inline">
        <input id="id" name="id" type="text">
      </div>
    </div>
    <div class="layui-form-item">
      <label class="layui-form-label">用户名</label>
      <div class="layui-input-inline">
        <input id="editPerson" type="text" name="username" lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
      </div>
    </div>
    <%--<div class="layui-form-item">
      <label class="layui-form-label">密码</label>
      <div class="layui-input-inline">
        <input type="text" name="password" lay-verify="password" placeholder="请输入密码" autocomplete="off" class="layui-input">
      </div>
    </div>--%>
    <div class="layui-form-item" lay-filter="sex">
      <label class="layui-form-label">选择性别</label>
      <div class="layui-input-block">
        <input type="radio" name="sex" value="1" title="男" checked>
        <input type="radio" name="sex" value="0" title="女">
      </div>
    </div>
    <div class="layui-form-item">
      <label class="layui-form-label">城市</label>
      <div class="layui-input-inline">
        <select id="city" name="city" lay-verify="required" onchange="sChange()">
          <option value="北京">北京</option>
          <option value="上海">上海</option>
          <option value="广州">广州</option>
          <option value="深圳">深圳</option>
        </select>
      </div>
    </div>
    <div class="layui-form-item">
      <label class="layui-form-label">出生年月</label>
      <div class="layui-input-inline">
        <input type="text" class="layui-input" name="birthday" id="birthday" autocomplete="off">
      </div>
      <div class="layui-form-mid layui-word-aux"></div>
    </div>
    <div class="layui-form-item">
      <label class="layui-form-label">手机号码</label>
      <div class="layui-input-inline">
        <input id="tel" type="text" name="tel" lay-verify="phone" placeholder="请输入号码" autocomplete="off" class="layui-input">
      </div>
    </div>
    <div class="layui-form-item layui-hide">
      <input type="button" lay-submit lay-filter="LAY-user-front-submit" id="LAY-user-front-submit" value="确认">
    </div>
  </div>

  <input type="text" hidden id="firstName">

  <script src="../../../layuiadmin/layui/layui.js"></script>  
  <script>
  layui.config({
    base: '../../../layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'form', 'laydate'], function(){
    var $ = layui.$
    ,form = layui.form
    ,laydate = layui.laydate ;

    //执行一个laydate实例
    laydate.render({
      elem: '#birthday', //指定元素
      format: 'yyyy-MM-dd',
      trigger: 'click'
      ,closeStop: '#birthday'
    });

  });

  layui.use(['layer', 'jquery'],function () {
    var layer = layui.layer
            , $ = layui.jquery;

    $("#editPerson").blur(function(){
      var firstName = $("#firstName").val()
      var username = $("#editPerson").val();
      if (username == firstName)return;
      $.ajax({
        url: "${pageContext.request.contextPath}/isUsernameExist",
        type: "POST",
        data: {"username": username},
        success: function (result) {
          if (result.code == 100){
            layer.tips("该用户名已存在！", $("#editPerson"));
            $("#editPerson").val("");
          }
        }
      });
    });

    /*$('#city').change(function(){
      alert($(this).children('option:selected').val());
      var p1=$(this).children('option:selected').val();//这就是selected的值
      $('#city').val(p1);
    })*/

  })

  </script>
</body>
</html>