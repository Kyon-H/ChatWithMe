<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head lang="zh-cn">
<meta charset="UTF-8">
<title>ChatWithMe登陆界面</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="format-detection" content="telephone=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="alternate icon" type="image/png" href="${cp}/i/favicon.png">
<link rel="stylesheet" href="${cp}/css/amazeui.min.css" />

<script src="${cp}/js/check.js" type="text/javascript"></script>
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
	
	<div class="header">
		<div class="am-g">
			<h1>ChatWithMe</h1>
		</div>
		<hr />
	</div>
	<div class="am-g">
		<div class="am-u-lg-6 am-u-md-8 am-u-sm-centered">
			<h1>用户登录</h1>
			<br>
			<div class="am-form" >
				<label for="username">用户名:</label> 
				<input type="text" name="username" id="username" onblur="checkusername()"> 
				<font id="username_tip" color="red" size="3"></font> 
				<br> 
				<label for="password">密码:</label> 
				<input type="password" name="password" id="password" onblur="checkpassword()"> 
				<font id="password_tip" color="red" size="3"></font> 
				<br> 
				<label for="remember-me"> <input id="remember-me" type="checkbox">
					记住密码
				</label>
				<input type="hidden" name="sub_type" value="logintype" id="sub_type"/> <br />
				<div class="am-cf">
					<button onclick="checkLogin()" class="am-btn am-btn-primary am-btn-sm am-fl">登录</button>
					 <a	href="${cp}/register"> <input type="button" name="regist"
						value="注 册" class="am-btn am-btn-default am-btn-sm am-fr">
					</a>
				</div>
			</div>
			<hr>
			<p>© 2021 lxc lg</p>
		</div>
	</div>
</body>
<script type="text/javascript">
	
	if (typeof (Storage) !== "undefined") {
		if (localStorage.username_storage && localStorage.password_storage) {
			document.getElementById("username").value = localStorage.username_storage;
			document.getElementById("password").value = localStorage.password_storage;
			document.getElementById("remember-me").setAttribute("checked",
					"checked");
		} 
	}else {
		console.log("抱歉! 不支持 web 存储");
	}

////////////////////////////////////	
	function checkLogin(){
		var user = {}; 
		user.userName = document.getElementById("username").value;
		user.userPassword = document.getElementById("password").value;
		if(user.userName == ''){
			layer.msg('用户名不能为空',{icon:2});
			return;
		}
		else if(user.userName.length >= 12){
			layer.msg('用户名长度不能超过12个字符',{icon:2});
			return;
		}
		else if(user.userPassword == ''){
			layer.msg('密码不能为空',{icon:2});
			return;
		}
		localStorageform();
		var loginResult = null;
		$.ajax({
			async : false, //设置同步
			type : 'POST',
			url : '${cp}/doLogin',
			data : user,
			dataType : 'json',
			success : function(result) {
				loginResult = result.result;
			},
			error : function(result) {
				layer.alert('查询用户错误');
		}
		});
		if(loginResult == 'success'){
			layer.msg('登录成功',{icon:1});
			window.location.href="${cp}/main";
		}
		else if(loginResult == 'unexist'){
			layer.msg('是不是用户名记错了？',{icon:2});
		}
		else if(loginResult == 'wrong'){
			layer.msg('密码不对哦，再想想~',{icon:2});
		}
		else if(loginResult == 'fail'){
			layer.msg('服务器异常',{icon:2});
		}
	}
</script>
</html>
