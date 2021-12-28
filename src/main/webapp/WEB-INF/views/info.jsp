<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>个人信息</title>
<link rel="alternate icon" type="image/png" href="${cp}/i/favicon.png">
<!-- css -->
<link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
<link href="${cp}/css/bootstrap-theme.min.css" rel="stylesheet">
<link rel="stylesheet" href="${cp}/css/amazeui.min.css"/>
 <link rel="stylesheet" href="${cp}/css/admin.css">
<!-- js -->
<script src="${cp}/js/jquery.js" type="text/javascript"></script>
<script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
<script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${cp}/js/layer.js" type="text/javascript"></script>
<script src="${cp}/js/layui.js" type="text/javascript"></script>
<script src="${cp}/js/sockjs.js" type="text/javascript"></script>
<script src="${cp}/js/check.js" type="text/javascript"></script>

<!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="${cp}/main">ChatWithMe</a>
			</div>
			<!-- 右侧 -->
			<ul class="nav navbar-nav navbar-right">
				<li>
					<img style="margin-top:2px;width:45px;height:45px;" class="img-circle" id="topbar-userimg" src="${cp}/img/photo.jpg">
				</li>
				<li class="dropdown" >
					<a class="navbar-brand" href="#" data-toggle="dropdown"
					role="button" aria-haspopup="true" aria-expanded="false">
					${currentUser.userNickName }<span class="caret"></span>
				</a>
					<ul class="dropdown-menu" style="z-index: 9999;">
						<li><a href="#">&nbsp;&nbsp;用户名:${currentUser.userName }</a></li>
						<li><a href="#">&nbsp;&nbsp;昵&nbsp;&nbsp;称:${currentUser.userNickName }</a></li>
					</ul>
				</li>
				<li><a href="${cp }/logout">退出账户</a></li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
	 <!-- Nav tabs -->
	<ul id="myTabs" class="nav nav-tabs" >
		<li role="presentation" class="active" style="margin-left:400px;"><a href="#personinfo">个人信息</a></li>
		<li role="presentation"><a href="#changepwd">更改密码</a></li>
	</ul>
	<!-- Tab panes -->
	<div class="tab-content" >
		<div role="tabpanel" class="tab-pane active" id="personinfo" style="width:1000px;margin-left:100px;">
			<br>
			<br>
			<div class="am-g">
				<div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
					<div class="am-panel am-panel-default">
						<div class="am-panel-bd">
							<div class="am-g">
								<div id="box-1" class="am-u-md-4">
									<img id="user-img" class="am-img-circle am-img-thumbnail"
										src="${cp}/img/photo.jpg"
										alt="${currentUser.userNickName}" />
								</div>
								<div class="am-u-md-8">
									<p>用户头像</p>
									<form class="am-form" method="post" id="uploadForm" enctype="multipart/form-data">
										<div class="am-form-group">
											<input type="file" id="choose-file" name="file" accept="image/*">
											<p class="am-form-help">请选择要上传的头像...</p>
											<input type="hidden" name="userId" value="${currentUser.userId}">
											<button type="button" id="saveImg" onClick="SaveImg()" class="am-btn am-btn-primary am-btn-xs">保存</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
					<form class="am-form am-form-horizontal">
						<div class="am-form-group">
							<label for="user-name" class="am-u-sm-3 am-form-label">姓名
								/ Name</label>
							<div class="am-u-sm-9">
								<input type="text" id="user-name" placeholder="姓名 / Name" value="">
								<small>你的姓名。</small>
							</div>
						</div>
						
						<div class="am-form-group">
							<label for="user-nickname" class="am-u-sm-3 am-form-label">昵称
								/ NickName</label>
							<div class="am-u-sm-9">
								<input type="text" id="user-nickname" placeholder="昵称 / NickName" value="">
								<small>输入你的昵称，让我们记住你。</small>
							</div>
						</div>

						<div class="am-form-group">
							<label for="user-email" class="am-u-sm-3 am-form-label">电子邮件
								/ Email</label>
							<div class="am-u-sm-9">
								<input type="email" id="user-email" value=""
									placeholder="输入你的电子邮件 / Email"> <small>邮箱你懂得...</small>
							</div>
						</div>

						<div class="am-form-group">
							<label for="user-phone" class="am-u-sm-3 am-form-label">电话
								/ Telephone</label>
							<div class="am-u-sm-9">
								<input type="tel" id="user-phone" value=""
									placeholder="输入你的电话号码 / Telephone">
							</div>
						</div>
						<br>
						<br>
						<div class="am-form-group">
							<div class="am-u-sm-9 am-u-sm-push-3">
								<button type="button" onClick="UpdateUserInfo()" class="am-btn am-btn-primary">保存修改</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div role="tabpanel" class="tab-pane" id="changepwd" style="width: 850px; margin-left: 800px;">
			<br> <br>
			<div class="am-g">
				<div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
					<form class="am-form am-form-horizontal">
						<div class="am-form-group">
							<label for="user-oldpwd" class="am-u-sm-3 am-form-label">原密码
								/ OldPassword</label>
							<div class="am-u-sm-9">
								<input type="password" id="user-oldpwd"
									placeholder="原密码 / OldPassword" value=""> <small>你的原密码。</small>
							</div>
						</div>

						<div class="am-form-group">
							<label for="user-newpwd" class="am-u-sm-3 am-form-label">新密码
								/ NewPassword</label>
							<div class="am-u-sm-9">
								<input type="password" id="user-newpwd"
									placeholder="新密码 / NewPassword" value=""> <small>你的新密码。</small>
							</div>
						</div>

						<div class="am-form-group">
							<label for="user-repwd" class="am-u-sm-3 am-form-label">验证新密码
								/ NewPassword</label>
							<div class="am-u-sm-9">
								<input type="password" id="user-repwd" value=""
									placeholder="你的新密码 / NewPassword"> <small>请再次输入你的新密码</small>
							</div>
						</div>
						<br> <br>
						<div class="am-form-group">
							<div class="am-u-sm-9 am-u-sm-push-3">
								<button type="button" onClick="UpdateUserPwd()"
									class="am-btn am-btn-primary">保存修改</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$('#myTabs a').click(function(e) {
		e.preventDefault()
		$(this).tab('show')
	});
	var findUser = {};
	findUser.userId = ${currentUser.userId};
	var userDetail=null;
	$.ajax({
		async:false,
		type:'POST',
		url:'${cp}/doFindUserById',
		data:findUser,
		dataType:'json',
		success:function(result){
			if(result.userId != null){
				$("#user-name").val(result.userName);
				$("#user-nickname").val(result.userNickName);
				$("#user-email").val(result.userEmail);
				$("#user-phone").val(result.userPhone);
				$("#topbar-userimg").attr('src',result.userImg);
				$("#user-img").attr('src',result.userImg);
			}	
			else
				layer.alert('查询错误');
		},
		error:function(result){
			layer.alert('查询用户错误');
		}
	});
	//
	//点击保存按钮 正式上传头像
	function SaveImg(){
		if($('#choose-file').val()==''){
			layer.alert("请先上传头像");
			$('#saveImg').disabled=false;
			return ;
		}
 		var formData=new FormData($("#uploadForm")[0]);
 		var result=null;
		$.ajax({
			url:'${cp}/userImgUpload',
			data:formData,
			type:"POST",
			async:false,
			cache:false,
			contentType:false,
			processData:false,
			dataType:'json',
			success:function(data){
				result=data.result;
			},
			error:function(){
				layer.alert("上传出错");
			}
		});
		if(result=="imgbt"){
			layer.msg("上传文件过大");
		}
		else if(result=="error"){
			layer.alert("上传出错");
		}
		else if(result=="success"){
			layer.msg("修改成功",{icon:1});
			location.reload();
		}
	}
	//
	//选择图像后预览
	$(function(){
		//在input file内容改变的时候触发事件
		$('#choose-file').change(function(){
			//获取input file的files文件数组;
			//$('#filed')获取的是jQuery对象，.get(0)转为原生对象;
			//这边默认只能选一个，但是存放形式仍然是数组，所以取第一个元素使用[0];
			var file=$('#choose-file').get(0).files[0];
			//创建用来读取此文件的对象
			var reader = new FileReader();
			//使用该对象读取file文件
			reader.readAsDataURL(file);
			//读取文件成功后执行的方法函数
			reader.onload=function(e){
				//读取成功后返回的一个参数e，整个的一个进度事件
				console.log(e);
				//选择所要显示图片的img，要赋值给img的src就是e中target下result里面
				//的base64编码格式的地址
				$('#user-img').get(0).src = e.target.result;
			}
		});
	})
	//隐藏input file控件
	$("#choose-file").hide();
	$("#box-1").bind('click',function(){
		//当点击头像框时，就会弹出文件选择对话框
		$("#choose-file").click();
		
	});
	//
	//修改用户信息
	function UpdateUserInfo(){
		userDetail.userId=${currentUser.userId};
		userDetail.userName=$("#user-name").val();
		userDetail.userNickName=$("#user-nickname").val();
		userDetail.userEmail=$("#user-email").val();
		userDetail.userPhone=$("#user-phone").val();
		$.ajax({
			async:false,
			type:'POST',
			url:'${cp}/doUpdateUserInfo',
			data:userDetail,
			dataType:'json',
			success:function(result){
				layer.msg("修改成功",{icon:1});
				window.location.reload(); //刷新当前页面
			},
			error:function(result){
				layer.alert("保存修改失败");
			}
		});
	}
	//
	//修改用户密码
	function UpdateUserPwd() {
		userDetail.userId = ${currentUser.userId};
		userDetail.userOldPassword = $("#user-oldpwd").val();
		userDetail.userNewPassword = $("#user-newpwd").val();
		var rePassword = $("#user-repwd").val();
		var results;
		if(checkpassword()==false){
			layer.msg("密码格式不正确,长度为6-12位");
			return ;
		}
		if (rePassword!=userDetail.userNewPassword) {
			layer.msg("两次输入的密码不相同");
			$("#user-repwd").val("");
			$("#user-newpwd").val("");
			return;
		}
		$.ajax({
			async : false,
			type : 'POST',
			url : '${cp}/doUpdateUserPassword',
			data : userDetail,
			dataType : 'json',
			success : function(result) {
				results = result.result;
			},
			error : function(result) {
				layer.alert("修改密码失败", {icon : 1});
			}
		});
		if (results == "success") {
			//询问框
			layer.confirm("修改密码成功,是否重新登录？", {
				btn : [ "立刻", "稍后" ]
			}, function() {
				window.location.href = "${cp}/login";
			}, function() {
				$("#user-oldpwd").val("");
				$("#user-newpwd").val("");
				$("#user-repwd").val("");
			});
		} else if (results == "unexist") {
			layer.alert("密码输入错误");
			$("#user-oldpwd").val("");
			$("#user-newpwd").val("");
			$("#user-repwd").val("");
		} else if (results == "fail") {
			layer.msg('服务器异常', {icon : 2});
		}
	}
	
</script>
</html>