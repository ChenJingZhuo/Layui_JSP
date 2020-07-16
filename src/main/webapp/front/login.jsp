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
    <input id="tab-1" type="radio" name="tab" class="sign-in hidden" checked/>
    <input id="tab-2" type="radio" name="tab" class="sign-up hidden"/>
    <input id="tab-3" type="radio" name="tab" class="sign-out hidden"/>
    <div class="wrapper">

        <div class="login sign-in-htm">
            <form class="container offset1 loginform">

                <div id="owl-login" class="login-owl">
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
<input class="input__field input__field--hideo" value="${login_name}" type="text" id="login-username" autocomplete="off"
       placeholder="请输入用户名" tabindex="1" maxlength="15"/>
<label class="input__label input__label--hideo" for="login-username">
<i class="fa fa-fw fa-user icon icon--hideo"></i>
<span class="input__label-content input__label-content--hideo"></span>
</label>
</span>
                        <span class="input input--hideo">
<input class="input__field input__field--hideo" type="password" id="login-password" placeholder="请输入密码" tabindex="2"
       maxlength="15"/>
<label class="input__label input__label--hideo" for="login-password">
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
                    <a tabindex="4" class="btn pull-left btn-link text-muted" onclick="javascript:location.href='forget.jsp'">忘记密码?</a>
                    <a tabindex="5" class="btn btn-link text-muted" onclick="javascipt:location.href='register.jsp'">注册</a>
                    <input class="btn btn-primary" type="button" tabindex="3" onclick="login()" value="登录"
                           style="color:white;"/>
                </div>
            </form>
        </div>

        <div class="login sign-out-htm">
        </div>

        <div class="login sign-up-htm">
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

    $("#tab-1").prop("checked",true);

    $('#login #login-password').focus(function () {
        $('.login-owl').addClass('password');
    }).blur(function () {
        $('.login-owl').removeClass('password');
    });


    function login() {//登录

        var username = $("#login-username").val(),
            password = $("#login-password").val(),
            verifycode = $("#login-verify-code").val(),
            validatecode = null;

        //判断用户名密码是否为空

        if (username == "") {
            $.pt({
                target: $("#login-username"),
                position: 'r',
                align: 't',
                width: 'auto',
                height: 'auto',
                content: "用户名不能为空"
            });
            return;
        }

        if (password == "") {
            $.pt({
                target: $("#login-password"),
                position: 'r',
                align: 't',
                width: 'auto',
                height: 'auto',
                content: "密码不能为空"
            });
            return;
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

        if (timeout_flag) {
            $.pt({
                target: $("#login-verify-code-canvas"),
                position: 'r',
                align: 't',
                width: 'auto',
                height: 'auto',
                content: "验证码已经失效"
            });
            return;
        }

        //用户名只能是15位以下的字母或数字

        var regExp = new RegExp("^[a-zA-Z0-9_]{1,15}$");

        if (!regExp.test(username)) {
            $.pt({
                target: $("#login-username"),
                position: 'r',
                align: 't',
                width: 'auto',
                height: 'auto',
                content: "用户名必须为15位以下的字母或数字"
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
            return;
        }


        //登录

        //调用后台登录验证的方法

        $.ajax({
            url: "${pageContext.request.contextPath}/login",
            type: "POST",
            data: {
                "username": username,
                "password": password
            },
            success: function (result) {
                if (result.code == 100){
                    window.location.href="${pageContext.request.contextPath}/behind/views/index.jsp"
                } else {
                    alert("登录失败！用户名或密码错误！")
                }
            }
        })

        // alert('登录成功');

        return false;

    }


</script>
