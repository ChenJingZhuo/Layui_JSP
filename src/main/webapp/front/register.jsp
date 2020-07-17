<%--
  Created by IntelliJ IDEA.
  User: Mi
  Date: 2020-07-16
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>登录</title>
    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/sign-up-login.css">
    <link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">
    <link rel="stylesheet" href="css/inputEffect.css"/>
    <link rel="stylesheet" href="css/verifyCode.css"/>
    <link rel="stylesheet" href="css/tooltips.css"/>
    <link rel="stylesheet" href="css/spop.min.css"/>
    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
    <script src="js/snow.js"></script>
    <script src="js/jquery.pure.tooltips.js"></script>
    <script src="js/verifyCode.js"></script>
    <script src="js/verifyCode2.js"></script>
    <script src="js/spop.min.js"></script>
    <style type="text/css">

        html {
            width: 100%;
            height: 100%;
        }


        body {


            background-repeat: no-repeat;


            background-position: center center #2D0F0F;


            background-color: #00BDDC;


            background-image: url(images/snow.jpg);


            background-size: 100% 100%;


        }


        .snow-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 100001;
        }


    </style>
</head>
<body>

<div class="snow-container"></div>

<div id="login">
    <input id="tab-1" type="radio" name="tab" class="sign-in hidden"/>
    <input id="tab-2" type="radio" name="tab" class="sign-up hidden" checked/>
    <input id="tab-3" type="radio" name="tab" class="sign-out hidden"/>
    <div class="wrapper">

        <div class="login sign-in-htm">
        </div>

        <div class="login sign-out-htm">
        </div>

        <div class="login sign-up-htm">
            <form action="#" method="post" class="container offset1 loginform">

                <div id="owl-login" class="register-owl">
                    <div class="hand"></div>
                    <div class="hand hand-r"></div>
                    <div class="arms">
                        <div class="arm"></div>
                        <div class="arm arm-r"></div>
                    </div>
                </div>
                <div class="pad input-container">
                    <section class="content">
<span class="input input--hideo">
<input class="input__field input__field--hideo" type="text" id="register-username" autocomplete="off" onblur="isUsernameExist()"
       placeholder="请输入用户名" maxlength="15"/>
<label class="input__label input__label--hideo" for="register-username">
<i class="fa fa-fw fa-user icon icon--hideo"></i>
<span class="input__label-content input__label-content--hideo"></span>
</label>
</span>
                        <span class="input input--hideo">
<input class="input__field input__field--hideo" type="password" id="register-password" placeholder="请输入密码"
       maxlength="15"/>
<label class="input__label input__label--hideo" for="register-password">
<i class="fa fa-fw fa-lock icon icon--hideo"></i>
<span class="input__label-content input__label-content--hideo"></span>
</label>
</span>
                        <span class="input input--hideo">
<input class="input__field input__field--hideo" type="password" id="register-repassword" placeholder="请确认密码"
       maxlength="15"/>
<label class="input__label input__label--hideo" for="register-repassword">
<i class="fa fa-fw fa-lock icon icon--hideo"></i>
<span class="input__label-content input__label-content--hideo"></span>
</label>
</span>
                        <span class="input input--hideo input--verify_code">
<input class="input__field input__field--hideo" type="text" id="login-verify-code" autocomplete="off"
       placeholder="请输入验证码" tabindex="3" maxlength="4"/>
<label class="input__label input__label--hideo" for="login-verify-code">
<i class="fa fa-fw fa-bell-o icon icon--hideo"></i>
<span class="input__label-content input__label-content--hideo"></span>
</label>
</span>
                        <canvas class="verify-code-canvas" id="login-verify-code-canvas"></canvas>

                    </section>
                </div>
                <div class="form-actions">
                    <a class="btn pull-left btn-link text-muted" onclick="javascript:location.href='login.jsp'">返回登录</a>
                    <input class="btn btn-primary" type="button" onclick="register()" value="注册" style="color:white;"/>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
<script>

    (function () {

        // trim polyfill : https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/Trim

        if (!String.prototype.trim) {

            (function () {

                // Make sure we trim BOM and NBSP

                var rtrim = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g;

                String.prototype.trim = function () {

                    return this.replace(rtrim, '');

                };

            })();

        }


        [].slice.call(document.querySelectorAll('input.input__field')).forEach(function (inputEl) {

            // in case the input is already filled..

            if (inputEl.value.trim() !== '') {

                classie.add(inputEl.parentNode, 'input--filled');

            }


            // events:

            inputEl.addEventListener('focus', onInputFocus);

            inputEl.addEventListener('blur', onInputBlur);

        });


        function onInputFocus(ev) {

            classie.add(ev.target.parentNode, 'input--filled');

        }


        function onInputBlur(ev) {

            if (ev.target.value.trim() === '') {

                classie.remove(ev.target.parentNode, 'input--filled');

            }

        }

    })();

    $("#tab-2").prop("checked",true);

    $('#login #register-repassword').focus(function () {

        $('.register-owl').addClass('password');

    }).blur(function () {

        $('.register-owl').removeClass('password');

    });


    //注册

    function register() {

        var username = $("#register-username").val(),
            password = $("#register-password").val(),
            repassword = $("#register-repassword").val(),
            // code = $("#register-code").val(),
            verifycode = $("#login-verify-code").val(),
            flag = false,
            validatecode = null;

        //判断用户名密码是否为空
        if (username == "") {
            $.pt({
                target: $("#register-username"),
                position: 'r',
                align: 't',
                width: 'auto',
                height: 'auto',
                content: "用户名不能为空"
            });
            flag = true;
        }

        if (password == "") {
            $.pt({
                target: $("#register-password"),
                position: 'r',
                align: 't',
                width: 'auto',
                height: 'auto',
                content: "密码不能为空"
            });
            flag = true;
        } else {
            if (password != repassword) {
                $.pt({
                    target: $("#register-repassword"),
                    position: 'r',
                    align: 't',
                    width: 'auto',
                    height: 'auto',
                    content: "两次输入的密码不一致"
                });
                flag = true;
            }
        }

        //用户名只能是15位以下的字母或数字
        var regExp = new RegExp("^[a-zA-Z0-9_]{1,15}$");
        if (!regExp.test(username)) {
            $.pt({
                target: $("#register-username"),
                position: 'r',
                align: 't',
                width: 'auto',
                height: 'auto',
                content: "用户名必须为15位以下的字母或数字"
            });
            flag = true;
        }

        if (verifycode == "") {
            $.pt({
                target: $("#login-verify-code-canvas"),
                position: 'r',
                align: 't',
                width: 'auto',
                height: 'auto',
                content: "验证码不能为空"
            });
            return;
        }

        //判断验证码是否正确
        if (verifycode != show_num.join("")) {
            $.pt({
                target: $("#login-verify-code-canvas"),
                position: 'r',
                align: 't',
                width: 'auto',
                height: 'auto',
                content: "验证码不正确"
            });
            flag = true;
        }

        if (flag) {
            return false;
        } else {//注册
            $.ajax({
                url: "${pageContext.request.contextPath}/register",
                type: "POST",
                data: {
                  "username": username,
                  "password": password
                },
                success: function (result) {
                    if (result.code == 100) {
                        spop({
                            template: '<h4 class="spop-title">注册成功</h4>即将于3秒后返回登录',
                            position: 'top-center',
                            style: 'success',
                            autoclose: 3000,
                            onOpen: function () {
                                var second = 2;
                                var showPop = setInterval(function () {
                                    if (second == 0) {
                                        clearInterval(showPop);
                                    }
                                    $('.spop-body').html('<h4 class="spop-title">注册成功</h4>即将于' + second + '秒后返回登录');
                                    second--;
                                }, 1000);
                            },
                            onClose: function () {
                                window.location.href="login.jsp"
                            }
                        });
                    } else {
                        alert("注册失败！")
                    }
                }
            });
            return false;
        }
    }

    function isUsernameExist() {
        var username = $("#register-username").val();
        $.ajax({
            url: "${pageContext.request.contextPath}/isUsernameExist",
            type: "POST",
            data: {"username": username},
            success: function (result) {
                if (result.code == 100){
                    alert("该用户名已存在！");
                    $("#register-username").val("");
                }
            }
        })
    }

</script>

