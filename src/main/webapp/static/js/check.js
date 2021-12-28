function checkusername(){
	var username=document.getElementById("username").value;
	var userNamePattern = /^[A-Za-z0-9_\-\u4e00-\u9fa5]{2,16}$/;
	
	if (userNamePattern.test(username)) {
		document.getElementById("username_tip").innerHTML="";
		return true;
	}else{
		document.getElementById("username_tip").innerHTML="    *用户名2-16个字符";
		return false;
	}
}

function checknickname(){
	var nickname=document.getElementById("nickname").value;
	var userNamePattern = /^[A-Za-z0-9_\-\u4e00-\u9fa5]{2,16}$/;
	
	if (userNamePattern.test(nickname)) {
		document.getElementById("nickname_tip").innerHTML="";
		return true;
	}else{
		document.getElementById("nickname_tip").innerHTML="    *用户名2-16个字符";
		return false;
	}
}

function checkpassword(){
	var reg=/[^A-Za-z0-9_]+/;
	var regs=/^[a-zA-Z0-9_\u4e00-\u9fa5]+$/;
	var password=document.getElementById("password").value;
	
	if(password.length<6||password.length>12){
		document.getElementById("password_tip").innerHTML="    *密码长度为6-12位";
		return false;
	}
	if(!regs.test(password)){
		document.getElementById("password_tip").innerHTML="    *密码格式不正确";
		return false;
	}else{
		document.getElementById("password_tip").innerHTML="";
		return true;
	}
}

function checkrepassword(){
	var password=document.getElementById("password").value;
	var repassword=document.getElementById("repassword").value;
	if(checkpassword()&&repassword==password){
		document.getElementById("repassword_tip").innerHTML="";
		return true;
	}else{
		document.getElementById("repassword_tip").innerHTML="    *输入错误";
		return false;
	}
}

function localStorageform(){
	var remember=document.getElementById("remember-me");
	if(typeof(Storage)!=="undefined"){
	// 支持 localStorage  sessionStorage 对象!
		if(remember.checked){
			console.log("保存");
			var username_val=document.getElementById("username").value;
			var password_val=document.getElementById("password").value;
			localStorage.setItem("username_storage",username_val);
			localStorage.setItem(
			"password_storage",password_val);
			localStorage.setItem("remember_storage","remember");
		}else{
			localStorage.clear();//移除所有；
		}
	}else{
		console.log("抱歉! 不支持 web 存储");
	}
}


function checkloginform(){
	if(checkusername()&&checkpassword()){
		localStorageform();
		return true;
	}else{
		return false;
	}
}

function checkregistform(){
	if(checkusername()&&checkpassword()&&checkrepassword()&&checknickname()){
		
		return true;
	}else{
		return false;
	}
}