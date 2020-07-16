<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>设置我的密码</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="../../../layuiadmin/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="../../../layuiadmin/style/admin.css" media="all">
</head>
<body>

  <div class="layui-fluid">
    <div class="layui-row layui-col-space15">
      <div class="layui-col-md12">
        <div class="layui-card">
          <div class="layui-card-header">修改密码</div>
          <div class="layui-card-body" pad15>
            
            <div class="layui-form" lay-filter="" id="pwd-form">
              <div class="layui-form-item">
                <label class="layui-form-label">当前密码</label>
                <div class="layui-input-inline">
                  <input id="oldPassword" type="password" name="oldPassword" lay-verify="required" lay-verType="tips" class="layui-input"
                  onblur="findPersonByNameAndPwd()">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">新密码</label>
                <div class="layui-input-inline">
                  <input type="password" name="password" lay-verify="pass" lay-verType="tips" autocomplete="off" id="LAY_password" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">6到16个字符</div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">确认新密码</label>
                <div class="layui-input-inline">
                  <input type="password" name="repassword" lay-verify="repass" lay-verType="tips" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <div class="layui-input-block">
                  <button class="layui-btn" lay-submit lay-filter="setmypass">确认修改</button>
                </div>
              </div>
            </div>
            
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="../../../layuiadmin/layui/layui.js"></script>  
  <script>
  layui.config({
    base: '../../../layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'set']);

  layui.use(['jquery', 'layer', 'form'], function () {
    var $=layui.jquery;
    var layer=layui.layer;
    var form = layui.form;

    window.findPersonByNameAndPwd = function (){
      var oldP = $("#oldPassword");
      if (oldP.val() == "")return;
      $.ajax({
        url: "${pageContext.request.contextPath}/findPersonByNameAndPwd",
        type: "POST",
        data: {
          "username": "${username}",
          "password": oldP.val()
        },
        success: function (result) {
          if (result.code != 100){
            oldP.val("");
            layer.tips("当前密码不正确！", oldP);
          }
        }
      })
    }

    //监听提交
    form.on('submit(setmypass)', function(data){
      // layer.msg(JSON.stringify(data.field));
      $.ajax({
        url: "${pageContext.request.contextPath}/updatePersonPwd",
        type: "POST",
        data: {
          "username": "${username}",
          "password": $("#password").val()
        },
        success: function (result) {
          if (result.code == 100){
            layer.msg("修改密码成功", {icon: 1});
            $("#pwd-form").reset();
            layui.form.render();
          } else {
            layer.msg("修改密码失败", {icon: 2})
          }
        }
      })
      return false;
    });

  })

  </script>
</body>
</html>