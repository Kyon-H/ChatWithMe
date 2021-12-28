<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head lang="zh-cn">
  <meta charset="UTF-8">
  <title>ChatWithMe注册页面</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="format-detection" content="telephone=no">
  <meta name="renderer" content="webkit">
  <meta http-equiv="Cache-Control" content="no-siteapp" />
  <link rel="alternate icon" type="image/png" href="${cp}/i/favicon.png">
  
  <link rel="stylesheet" href="${cp}/css/amazeui.min.css"/>
<%--   <link href="${cp}/css/animate.css" rel="stylesheet"/> --%>
<%--     <link href="${cp}/css/style.css" rel="stylesheet"/> --%>
<%--     <link href="${cp}/css/login.css" rel="stylesheet"/> --%>
    
  <script src="${cp}/js/jquery.js" type="text/javascript"></script>
    <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${cp}/js/layer.js" type="text/javascript"></script>
  <style>
    .header {
      text-align: center;
    }
    .header h1 {
      font-size: 200%;
      color: #333;
      margin-top: 30px;
    }
    .header p {
      font-size: 14px;
    }
  </style>
  
</head>
<body>
<script type="text/javascript" src="${cp}/js/check.js"></script>
<div class="header">
  <div class="am-g">
    <h1>ChatChat</h1>
    <div style="text-align: -webkit-right;width:300px">
      <a href="${cp}/login" class="jumpLink" style="text-align:left">
        <font size="5">登录</font>
      </a>
    </div>
  </div>
  <hr />
</div>
<div class="am-g">
  <div class="am-u-lg-6 am-u-md-8 am-u-sm-centered">
    <h1>用户注册</h1>
    <br>
    <div class="am-form">
    	<label for="username">用户名:</label>
    	<input type="text" name="username" id="username" onblur="checkusername()">
    	<font id="username_tip" color="red" size="3"></font>
    	<br>
    	<label for="nickname">昵称:</label>
    	<input type="text" name="nickname" id="nickname" onblur="checknickname()">
    	<font id="nickname_tip" color="red" size="3"></font>
    	<br>
      <label for="password">密码:</label>
      <input type="password" name="password" id="password" onblur="checkpassword()">
      <font id="password_tip" color="red" size="3"></font>
      <br>
      <label for="repassword">验证密码:</label>
      <input type="password" name="repassword" id="repassword" onblur="checkrepassword()">
      <font id="repassword_tip" color="red" size="3"></font>
      <br>
      <input type="hidden" name="sub_type" value="registtype" id="sub_type"/>
      <br />
      <div class="am-cf">
        <button class="am-btn am-btn-primary am-btn-sm am-fl" onclick="checkRegister()">注册</button>
        <button class="am-btn am-btn-primary am-btn-sm am-fr" onclick="reset()">重置</button>
      </div>
    </div>
    <hr>
    <p>© 2021 lxc lg</p>
  </div>
</div>
<script type="text/javascript">
////////////////////////////////////
function reset(){
	document.getElementById("username").innerHTML="";
	document.getElementById("nickname").innerHTML="";
	document.getElementById("password").innerHTML="";
	document.getElementById("repassword").innerHTML="";
}
//////////////////////////////////
    	function checkRegister(){
    		var user = {}; 
    		user.userName = document.getElementById("username").value;
    		user.userNickName = document.getElementById("nickname").value;
    		user.userPassword = document.getElementById("password").value;
    		var rePassword=document.getElementById("repassword").vlue;
    		if(user.userName == ''){
    			layer.msg('用户名不能为空',{icon:2});
    			return;
    		}
    		else if(user.userName.length >= 12){
    			layer.msg('用户名长度不能超过12个字符',{icon:2});
    			return;
    		}
    		if(user.userNickName == ''){
    			layer.msg('昵称不能为空',{icon:2});
    			return;
    		}
    		else if(user.userNickName.length >= 15){
    			layer.msg('用户名长度不能超过15个字符',{icon:2});
    			return;
    		}
    		else if(user.userPassword == ''){
    			layer.msg('密码不能为空',{icon:2});
    			return;
    		}
    		else if(user.userPassword.length>= 20){
    			layer.msg('密码长度不能超过20个字符',{icon:2});
    			return;
    		}
    		else if(rePassword==user.userPassword){
    			layer.msg('两次密码输入不一致',{icon:2});
    			return;
    		}
    		var registerResult = null;
    		$.ajax({
				async : false, //设置同步
				type : 'POST',
				url : '${cp}/doRegister',
				data : user,
				dataType : 'json',
				success : function(result) {
					registerResult = result.result;
				},
				error : function(result) {
					layer.alert('查询用户错误');
			}
			});
			if(registerResult == 'success'){
				layer.msg('注册成功',{icon:1});
				window.location.href="${cp}/login";
			}
			else if(registerResult == 'exist'){
				layer.msg('这个用户名已经被占用啦！',{icon:2});
			}
			else if(registerResult == 'fail'){
				layer.msg('服务器异常',{icon:2});
			}
    	}
    </script>
</body>
</html>
