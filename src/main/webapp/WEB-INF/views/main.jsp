<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cn">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>ChatWithMe</title>
<%--     <link href="${cp}/img/logo.ico" rel="icon" type="image/x-ico">  --%>
	<link rel="alternate icon" type="image/png" href="${cp}/i/favicon.png">
    <link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${cp}/css/animate.css" rel="stylesheet">
    <link href="${cp}/css/style.css" rel="stylesheet">
    <link href="${cp}/css/main-style.css" rel="stylesheet">
    <link href="${cp}/ueditor/themes/default/css/ueditor.css" type="text/css" rel="stylesheet">

	<script src="${cp}/js/jquery.js" type="text/javascript"></script>
    <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${cp}/js/layer.js" type="text/javascript"></script>
    <script src="${cp}/js/sockjs.js" type="text/javascript"></script>
    <script src="${cp}/ueditor/ueditor.config.js" charset="utf-8" type="text/javascript"></script>
    <script src="${cp}/ueditor/ueditor.all.js" charset="utf-8" type="text/javascript"></script>
    <script type="text/javascript" src="${cp}/ueditor/lang/zh-cn/zh-cn.js"></script>
	
	<style type="text/css">
		img{
			max-width:250px;
		}
	</style>
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
				<!-- ?????? -->
				<ul class="nav navbar-nav navbar-right">
					<li>
						<img style="margin-top:2px;width:45px;height:45px;" class="img-circle" id="topbar-userimg" src="${cp}/img/photo.jpg">
					</li>
					<li class="dropdown" >
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"
					role="button" aria-haspopup="true" aria-expanded="false">${currentUser.userNickName }
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu" style="z-index:9999;">
							<li><span style="text-align:center">&nbsp;&nbsp;?????????:${currentUser.userName }</span></li>
							<li><span>&nbsp;&nbsp;???&nbsp;&nbsp;???:${currentUser.userNickName }</span></li>
							<li><a href="${cp}/info"><span class="fa fa-user" aria-hidden="true"></span> ????????????</a></li>
						</ul></li>
					<li><a href="${cp }/logout">????????????</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
	<div class="icon">
      <a id="listRelation" onclick="listRelation();">
        <img width="60px" height="60px" src="${cp}/img/icon.png" alt="??????">
      </a>
    </div>
	<script type="text/javascript">
		console.log("??????"+${currentUser.userId}+"??????");
		if(${currentUser.userId}==""){
			window.location.href = "${cp}/login";
		}
		//?????????????????????
		var ws = null;
		ws = "ws://127.0.0.1:20818/${currentUser.userId}";
		var websocket = null;

		//?????????????????????????????????WebSocket
		if ('WebSocket' in window) {
			websocket = new WebSocket(ws);
		} else {
			layer.alert('????????????????????????????????????WebSocket', {
				icon : 2
			});
		};

		//?????????????????????????????????
		websocket.onopen = function() {
			//??????????????????
			//??????????????????????????????????????????
			onLineStatusNotice(3);
		};

		//??????????????????????????????
		websocket.onmessage = function(event) {
			//??????????????????????????????
			handleReceiveMessage(event.data);
		};

		//?????????????????????????????????
		websocket.onerror = function() {
            //?????????????????????????????????????????????
            onLineStatusNotice(4);
            console.log('websocket ??????: ' + e.code + ' ' + e.reason + ' ' + e.wasClean)
            console.log(e)

            reconnect();
		};

		//???????????????????????????
		websocket.onclose = function() {
			//?????????????????????????????????????????????
			console.log("websoctetclose");
			onLineStatusNotice(4);
			console.log('websocket ??????: ' + e.code + ' ' + e.reason + ' ' + e.wasClean)
			  console.log(e)
            reconnect();
		};


		//???????????????????????????????????????????????????????????????websocket???????????????????????????????????????????????????server??????????????????
		window.onbeforeunload = function() {
			closeWebSocket();
		};

		//??????WebSocket??????
		function closeWebSocket() {
			websocket.close();
		}
		//????????????
		function reconnect() {
			var url=ws;
		    if(lockReconnect) return;
		    lockReconnect = true;
		    setTimeout(function () {     //????????????????????????????????????????????????????????????
		    	websocket = new WebSocket(url);
		    console.log("reconnect()");
		        lockReconnect = false;
		    }, 2000);
		}
// 		 "message"{
// 					"from": "xxxx",
// 					"to":["xxx"],
// 					"content":"xxxxx",
// 					"type":0,
// 					"time":"xxxx.xx.xx xx.xx.xx"
// 				}
		function reLoad(){
			location.reload();
		}
		var noticeIndex = null;
		var noticeUser = new Array();
		var noticeMessage = new Array();
		var noticeCount = 0;
		var statusChangeMark = 0;
/////////////////////////////////////////////
	loadUserImg();
	function loadUserImg(){
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
					$("#topbar-userimg").attr('src',result.userImg);
				}	
				else
					layer.alert('????????????');
			},
			error:function(result){
				layer.alert('??????????????????');
			}
		});
	}
	
/////////////////////////////////////////////
		//????????????????????????
		function handleReceiveMessage(message) {
			messages = JSON.parse(message);
			//??????????????????????????????
			//3 ?????? 4 ??????
			if(messages.type == 3 || messages.type == 4){
				changeToOnlineStatus(messages.content, messages.from, messages.to,messages.type,messages.time,message);
			}
			//5 ???????????? 6 
			else if(messages.type == 5 || messages.type == 6){
				openRelationApply(messages.content, messages.from, messages.to,messages.type,messages.time,message);
			}
			else if(messages.type == 0 ||messages.type == -1 || messages.type == 1){
				//????????????????????????
				var fromImg=null;
				var toImg=null;
				$.ajax({
					async:false,
					type:'POST',
					url:'${cp}/doFindUserImgById',
					data:{'userId':messages.from},
					dataType:'json',
					success:function(result){
						fromImg=result.userImg;
					}
				});
				$.ajax({
					async:false,
					type:'POST',
					url:'${cp}/doFindUserImgById',
					data:{'userId':messages.to},
					dataType:'json',
					success:function(result){
						toImg=result.userImg;
					}
				});
				//????????????
				showReceiveMessage(fromImg,toImg,messages.content, messages.from, messages.to,messages.type,messages.time,message);
			}	
		}
		//????????????
		function sendMessage(content, usersId, type) {
			console.log("main:230 sendMessage()");
			var message=JSON.stringify({
				from : ${currentUser.userId},
				to : usersId,
				content : content,
				type : type,
				time : getDateFull()
			});
			websocket.addEventListener('close',function(){
				reconnect();
			});
			console.log("main:241 socket.send\n"+message);
			websocket.send(message);
		}

		//???????????????????????????
		function showReceiveMessage(fromImg,toImg,content, from, to, type, time, message) {
			console.log("showReceiveMessage");
			var times = time.split(' ');
			var now = getDateFull();
			var nows = now.split(' ');
			var showTime = times[1];
			if(nows[0]!=times[0]){
				showTime = time;
			}
			if (from == ${currentUser.userId}) {
				var messageReceiver = '#' + to[0] + 'output';
				var target = document.getElementById(to[0]+'output');
				if(type == 1){
					messageReceiver = '#' + to[0] + 'outputGroup';
					target = document.getElementById(to[0]+'outputGroup');
				}
				var rightArrow = '<div class="row singleMessage">'
						+ '<div class="col-md-11 col-sm-11 col-xs-11 col-lg-11 text">'
						+ '<div class="col-md-12 col-sm-12 col-xs-12 col-lg-12 timePositionRight">'
						+ '<div id="time" class="timeRight">'
						+ showTime
						+ '</div>'
						+ '</div>'
						+ '<div class="arrowBoxRight">'
						+ '<div class="message">'
						+ content
						+ '</div>'
						+ '</div>'
						+ '</div>'
						+ '<div id="icons" class="col-md-1 col-sm-1 col-xs-1 col-lg-1  iconsRight">'
						+ '<img class="img-circle iconssRight" src="'
						+ fromImg
						+'">'
						+ '</div>' + '</div>';
				if(target){
					$(messageReceiver).append(rightArrow);
					target.scrollTop = target.scrollHeight;
				}
				else{
					doMessageNotice(content, from, to,type,time,message);
				}
			} else {
				var messageReceiver= '#' + from + 'output';
				var target = document.getElementById(from+'output');
				if(type == 1){
					messageReceiver= '#' + to[0] + 'outputGroup';
					target = document.getElementById(to[0]+'outputGroup');
					var fromUser = null;
					var findUser = {};
					findUser.userId = from;
					$.ajax({
						async : false, //????????????
						type : 'POST',
						url : '${cp}/doFindUserById',
						data : findUser,
						dataType : 'json',
						success : function(resoult) {
							if (resoult.userId != null) {
								fromUser = resoult;
							}
							else{
								layer.alert('????????????');
							}
						},
						error : function(resoult) {
							layer.alert('????????????');
						}
						});
					
					$.ajax({
						async : false, //????????????
						type : 'POST',
						url : '${cp}/doFindUserImgById',
						data : findUser,
						dataType : 'json',
						success : function(resoult) {
							if (resoult.userId != null) {
								toImg = resoult.userImg;
							}
							else{
								layer.alert('????????????');
							}
						},
						error : function(resoult) {
							layer.alert('????????????');
						}
						});
					showTime = fromUser.userNickName +'&nbsp;&nbsp;'+showTime;
				}
				leftArrow = '<div class="row singleMessage">'
						+ '<div id="icons" class="col-md-1 col-sm-1 col-xs-1 col-lg-1  iconsLeft">'
						+ '<img class="img-circle iconssLeft" src="'
						+ toImg
						+'">'
						+ '</div>'
						+ '<div class="col-md-11 col-sm-11 col-xs-11 col-lg-11 text">'
						+ '<div class="col-md-12 col-sm-12 col-xs-12 col-lg-12 timePositionLeft">'
						+ '<div class="timeLeft">' 
						+ showTime
						+ '</div>'
						+ '</div>' + '<div class="arrowBoxLeft">'
						+ '<div id="leftMessage" class="message">' + content
						+ '</div>' + '</div>' + '</div>' + '</div>';
				if(target){
					$(messageReceiver).append(leftArrow);
					target.scrollTop = target.scrollHeight;
					}
				else
					doMessageNotice(content, from, to,type,time,message);
			}
		}
// 		var noticeIndex = null;
// 		var noticeUser = new Array();
// 		var noticeMessage = new Array();
// 		var noticeCount = 0;
// 		var statusChangeMark = 0;
		//????????????
		function doMessageNotice(content,from, to,type, time,message){
			var fromUser = null;
			var findUser = {};
			findUser.userId = from;
			$.ajax({
				async : false, //????????????
				type : 'POST',
				url : '${cp}/doFindUserById',
				data : findUser,
				dataType : 'json',
				success : function(resoult) {
					if (resoult.userId != null) {
						fromUser = resoult;
					}
					else{
						layer.alert('????????????');
					}
				},
				error : function(resoult) {
					layer.alert('????????????');
				}
				});
			
			if(noticeIndex == null){
				var html = '<div class="notice">'+
					      '<div class="noticePosition" onclick="openNotice();">'+
					        '<marquee id="noticeText">'+
					        '</marquee>'+
					      '</div>'+
					    '</div>';
		        noticeIndex = layer.open({
		          type:1,
		          title:false,
		          closeBtn:0,
		          content:html,
		          shade:0,
		          offset:'t',
		          area:['180px','40px'],
		          anim:6,
		          id:'notice'
		        });
		   }
		   if(type==0 || type == -1 || type == 1){
			        noticeUser[noticeCount] = fromUser;
			        noticeMessage[noticeCount] = message;
			        noticeCount++;
			}
		   var noticeText = document.getElementById('noticeText');
		   
		   var text='';
		   if(type == 0 || type == -1){
		   		text += fromUser.userNickName+':'+content;
		   }
		   else if(type ==3){
		   		text = '???????????????&nbsp;'+fromUser.userNickName+'&nbsp;?????????';
		   		statusChangeMark = 1;
		   }
		   else if(type == 4){
		   		text = '??????????????? &nbsp;'+fromUser.userNickName+'&nbsp;?????????';
		   		statusChangeMark = 1;
		   }
		   else if(type == 1){
		   		var group = ajaxGetGroupById(to[0]);
		   		text = group.groupName+'|'+fromUser.userNickName+':'+content;
		   }
		   text+='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
		   noticeText.innerHTML +=text;
		}
		//???????????????????????????
		function openNotice(content, from, to, time){
			layer.close(noticeIndex);
			if(statusChangeMark == 1){
				listRelation();
				location.reload();
			}
			for(var i=0;i<noticeCount;i++){
				var messages = JSON.parse(noticeMessage[i]);
				if(messages.type == 0 ||messages.type == -1){
					chatWithSomeBody(noticeUser[i].userId,noticeUser[i].userName,noticeUser[i].userNickName);
				}
				else if(messages.type == 1){
					var group = ajaxGetGroupById(messages.to[0]);
					chatWithGroup(group.id, group.groupId, group.groupName,group.groupCreaterId);
				}	
			}
			noticeIndex = null;
			noticeUser.splice(0,noticeUser.length);
			noticeMessage.splice(0,noticeMessage.length);
			noticeCount = 0;
			statusChangeMark = 0;
		}

		function appendZero(s) {
			return ("00" + s).substr((s + "").length);
		} //???0??????

		//????????????????????????
		function getDateFull() {
			var date = new Date();
			var currentdate = date.getFullYear() + "-"
					+ appendZero(date.getMonth() + 1) + "-"
					+ appendZero(date.getDate()) + " "
					+ appendZero(date.getHours()) + ":"
					+ appendZero(date.getMinutes()) + ":"
					+ appendZero(date.getSeconds());
			return currentdate;
		}

		function closeWindow() {
			window.opener = null;
			window.open('', '_self');
			window.close();
		}

		layer.ready(function() {
			listRelation();
		});
		
		//??????ajax?????????????????????????????????
		function getAllRelations(){
			var allRelations = null;
			var currentUser = {};
			currentUser.userId = ${currentUser.userId};
			$.ajax({
				async : false, //????????????
				type : 'POST',
				url : '${cp}/getRelations',
				data : currentUser,
				dataType : 'json',
				success : function(resoult) {
					if (resoult!=null) {
						allRelations = resoult.relations;
					}
					else{
						layer.alert('????????????', function(){
							reLoad();
						});
						
					}
				},
				error : function(resoult) {
					layer.alert('????????????');
				}
				});
			
			//?????????eval???????????????prase????????????????????????
			allRelations = eval("("+allRelations+")");
			
			//??????????????????
			for(var i=0;i<allRelations.length;++i){
				var theUser={};
				var theImg=null;
				theUser.userId=allRelations[i].userId;
				$.ajax({
					async : false, //????????????
					type : 'POST',
					url : '${cp}/doFindUserImgById',
					data : theUser,
					dataType : 'json',
					success:function(result){
						theImg=result.userImg;
					},
					error:function(){
						layer.alert("????????????????????????");
					}
				});
				allRelations[i].userImg=theImg;
			}
			return allRelations;
		}
		//
		function onLineStatusNotice(type){
			var allRelations = getAllRelations();
			var content = null;
			if(type==3)
				content='????????????';
			else if(type==4)
				content='????????????';
			var usersId = new Array();
			for(var i=0;i<allRelations.length;i++){
				usersId[i] = allRelations[i].userId;
			}
			sendMessage(content,usersId,type);
		}
		//??????????????????
		function changeToOnlineStatus(content,from,to,type,time,message){
			var onLineStatus = document.getElementById(from+'onlineStatus');
			var offLineStatus = document.getElementById(from+'offlineStatus');
			//???????????????????????????id?????????????????????????????????????????????
			if(onLineStatus && type==3){
				onLineStatus.style.opacity = 1;
				offLineStatus.style.opacity = 0;
			}
			else if(offLineStatus && type==4){
				onLineStatus.style.opacity = 0;
				offLineStatus.style.opacity = 1;
			}
			else{
				doMessageNotice(content,from, to,type, time,message);
			}
		}

		//??????????????????
		var relationListIndex = null;
		function listRelation() {
			var allRelations = getAllRelations();
			var allGroups = getUserAllGroups();
			var html = '<div id="relationList" class="relation">'+
				      '<div class="lists">'+
					      '<ul class="nav nav-tabs">'+
					        '<li class="active justifile text-center">'+
					          '<a href="#relationPeople" data-toggle="tab">'+
					           	 '????????????'+
					          '</a>'+
					        '</li>'+
					        '<li class="justifile text-center">'+
					          '<a href="#groupPeople" data-toggle="tab">'+
					           	' ?????????'+
					          '</a>'+
					        '</li>'+
					      '</ul>'+
				      '<div class="tab-content">'+
				        '<div class="tab-pane fade in active" id="relationPeople">';
			 for(var i=0;i<allRelations.length;i++){
				 console.log(allRelations[i].userId);
			 	//???????????????????????????onclick???????????????function????????????????????????????????????????????????????????????????????????????????????
			 	//????????????????????????????????????????????????????????????????????????????????????????????????????????????ajax??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
			 	//???????????????????????????js???????????????????????????????????????????????????html??????????????????????????????????????????html??????????????????????????????????????????????????????????????????????????????????????????
			 	//??????????????????????????????????????????html?????????????????????????????????????????????????????????????????????js????????????????????????\+????????????????????????????????????????????????????????????????????????????????????????????????????????????
			 	html+='<div class="relationSingle" onclick="chatWithSomeBody('+allRelations[i].userId+',\''+allRelations[i].userName+'\',\''+allRelations[i].userNickName+'\');">'+
						            '<div class="photoBox">'+
						              '<img class="img-circle photo" src="'+allRelations[i].userImg+'">'+
						            '</div>'+
						            '<div id="currentNickName" class="list">'+
						              	allRelations[i].userNickName+
						            '</div>'+
						            '<div id="'+allRelations[i].userId+'onlineStatus" class="onlineStatus">'+
						            	'??????'+
						            '</div>'+
						            '<div id="'+allRelations[i].userId+'offlineStatus" class="offlineStatus">'+
						            	'??????'+
						            '</div>'+
						            '<div class="recent">'+
						            '</div>'+
						          '</div>';

			 }
				html+='</div>'+
				        '<div class="tab-pane fade" id="groupPeople">';
			for(var i=0;i<allGroups.length;i++){     
				html+='<div class="relationSingle" onclick="chatWithGroup('+allGroups[i].id+',\''+allGroups[i].groupId+'\',\''+allGroups[i].groupName+'\','+allGroups[i].groupCreaterId+');">'+
					            '<div class="photoBox">'+
					              '<img class="img-circle photo" src="${cp}/img/photo.jpg">'+
					            '</div>'+
					            '<div class="list">'+
					              allGroups[i].groupName+
					            '</div>'+
					            '<div class="recent">'+
					            '</div>'+
					          '</div>';
			}
			html+='</div>'+
				      '</div>'+
				    '</div>'+
				    '<div class="functions">'+
				      '<div class="btn-group btn-group-justified">'+
				        '<div class="btn-group">'+
				          '<button type="button" class="btn btn-default" onclick="searchFriend();">????????????</button>'+
				        '</div>'+
				        '<div class="btn-group">'+
				          '<button type="button" class="btn btn-default" onclick="createGroup()">?????????</button>'+
				        '</div>'+
				      '</div>'+
				    '</div>'+
				    '</div>';
			relationListIndex = layer.open({
				type : 1,
				skin : 'layer-ext-lists',
				title : ['${currentUser.userNickName}','font-family:Microsoft YaHei;font-size: 20px;height: 65px;'],
				closeBtn : 1,
				content : html,
				area : [ '300px', '580px' ],
				offset : 'rb',
				anim : 2,
				id :'relationList',
				shade : 0,
				zIndex: 9995,
				success: function(layero){
				   layer.setTop(layero);
				}
			});
			for(var i=0;i<allRelations.length;i++){
				var onLineStatus = document.getElementById(allRelations[i].userId+'onlineStatus');
				var offLineStatus = document.getElementById(allRelations[i].userId+'offlineStatus');
				if(allRelations[i].userIsOnline == 0){
					onLineStatus.style.opacity = 0;
					offLineStatus.style.opacity = 1;
				}
				else{
					onLineStatus.style.opacity = 1;
					offLineStatus.style.opacity = 0;
				}
			}
		}
		//??????/????????????
		function searchFriend() {
			layer.prompt({
				title : '?????????????????????',
				value :'',
				zIndex : 20000000
			}, function(value, index) {
				layer.close(index);
				findUser(value);
			});
		}

		function findUser(userName) {
			var findtheUser = {};
			findtheUser.userName = userName;
			var currentUserName='${currentUser.userName}';
			if(currentUserName==userName){
				layer.msg("???????????????????????????");
				return ;
			}
			$.ajax({
				async : false, //????????????
				type : 'POST',
				url : '${cp}/doFindUserByName',
				data : findtheUser,
				dataType : 'json',
				success : function(resoult) {
					if (resoult.userId != null) {
						addFriend(resoult.userId, resoult.userName,resoult.userNickName,resoult.userImg);
					} else {
						layer.msg('?????????????????????', {
							icon : 6,
							zIndex : 20000001,
							time : 2000
						});
					}
				},
				error : function(resoult) {
					layer.msg('????????????', {
						icon : 6,
						zIndex : 20000001,
						time : 2000
					});
				}
			});
		}
		//????????????
		var addFriendIndex = null;
		function addFriend(userId, userName, userNickName,userImg) {
			var relation=null;
			$.ajax({
				async:false,
				type:'POST',
				data:{'userId':userId},
				url:'${cp}/getRelationById',
				dataType:'json',
				success:function(result){
					relation=result.result;
				},
				error:function(){
					layer.alert("????????????");
				}
			});
			if(relation=="exist"){
				layer.msg("??????????????????");
				return ;
			}else if(relation=="unexist"){
				
			}else if(relation=="Fail"){
				layer.alert("????????????");
				return ;
			}
			var html = '<div id="addFriend" class="addFriend">'
					+ '<div class="container addFriendBox">'
					+ '<div class="row addFriendRow">'
					+ '<div class="col-md-5 col-sm-5 col-xs-5 col-lg-5 addFriendImgBox">'
					+ '<img src="'
					+userImg
					+'" class="img-circle addFriendImg">'
					+ '</div>'
					+ '<div class="col-md-7 col-sm-7 col-xs-7 col-lg-7 addFriendInfo">'
					+ '???&nbsp;&nbsp;???&nbsp;&nbsp;??????'
					+ userName
					+ '</div>'
					+ '<div class="col-md-7 col-sm-7 col-xs-7 col-lg-7 addFriendInfo">'
					+ '???&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;??????'
					+ userNickName
					+ '</div>'
					+ '<div class="col-md-6 col-sm-6 col-xs-6 col-lg-6 addFriendInfo">'
					+ '???????????????'
					+ '<textarea id="addFriendMessage" class="form-control addFriendTextArea" rows="2"></textarea>'
					+ '</div>'
					+ '<div class="col-md-7 col-sm-7 col-xs-7 col-lg-7 addFriendInfo">'
					+ '<button class="btn btn-default" onclick=\'addThisUser('+userId+')\'>????????????</button>'
					+ '</div>' + '</div>' + '</div>' + '</div>';
			addFriendIndex = layer.open({
				type : 1,
				title : '????????????',
				content : html,
				area : [ '500px', '275px' ],
				resize : false,
				id : 'addFriend',
				zIndex : 20000001
			});
		};
		
		function addThisUser(userId){
			var text = document.getElementById('addFriendMessage').value;
			var usersId = new Array();
			usersId[0] = userId;
			console.log("addThisUser"+userId);
			sendMessage(text,usersId,5);
			layer.close(addFriendIndex);
			location.reload();
		}
		
		var relationApply= null;
		var relationApplyNumber = 0;

		function agreeAddThisUser(userId){
			var text = '';
			var addUser = {};
			addUser.userIdA = userId;
			addUser.userIdB = ${currentUser.userId};
			console.log("build relation"+userId);
			$.ajax({
				async : false, //????????????
				type : 'POST',
				url : '${cp}/buildRelation',
				data : addUser,
				dataType : 'json',
				success : function(resoult) {
					if (resoult.resoult == 'success') {
						text = '?????????????????????????????????????????????????????????????????????';
					} else {
						text = '??????????????????????????????????????????';
					}
				},
				error : function(resoult) {
					layer.msg('????????????', {
						icon : 6,
						zIndex : 20000001,
						time : 2000
					});
				}
			});
			var usersId = new Array();
			usersId[0] = userId;
			sendMessage(text,usersId,-1);
			var addFriendRow = document.getElementById(userId+'addFriendRow');
			addFriendRow.style.display = 'none';
			relationApplyNumber--;
			if(relationApplyNumber == 0)
				layer.close(relationApply);
			//??????????????????
			var relationList = document.getElementById('relationList');
			if(relationList){
				layer.close(relationListIndex);
				location.reload();
			}
		}
		
		function refuseAddThisUser(userId){
			var text = '?????????????????????????????????????????????????????????????????????????????????';
			var usersId = new Array();
			usersId[0] = userId;
			sendMessage(text,usersId,-1);
			var addFriendRow = document.getElementById(userId+'addFriendRow');
			addFriendRow.style.display = 'none';
			relationApplyNumber--;
			if(relationApplyNumber == 0)
				layer.close(relationApply);
		}
		
		function openRelationApply(content, from, to,type,time,message){
				var fromUser = null;
				var findUser = {};
				findUser.userId = from;
				$.ajax({
					async : false, //????????????
					type : 'POST',
					url : '${cp}/doFindUserById',
					data : findUser,
					dataType : 'json',
					success : function(resoult) {
						if (resoult.userId != null) {
							fromUser = resoult;
						}
						else{
							layer.alert('????????????');
						}
					},
					error : function(resoult) {
						layer.alert('????????????');
					}
					});
				var addFriendApply = document.getElementById('addFriendApply');
				if(!addFriendApply){
						var html = '<div id="addFriendApply" class="addFriend">'
								+ '<div id="friendApplyBox" class="container addFriendBox">'
								+ '</div>' 
								+ '</div>';
						relationApply = layer.open({
							type : 1,
							title : '????????????',
							content : html,
							area : [ '500px', '275px' ],
							shade: 0,
							resize : false,
							zIndex: layer.zIndex,
							success: function(layero){
							   layer.setTop(layero);
							}
						});
				}
				relationApplyNumber++;
				if(type == 5)
					var friendApplyHtml= '<div id="'+from+'addFriendRow" class="row addFriendRow">'
							+ '<div class="col-md-5 col-sm-5 col-xs-5 col-lg-5 addFriendImgBox">'
							+ '<img src="img/photo.jpg" class="img-circle addFriendImg">'
							+ '</div>'
							+ '<div class="col-md-7 col-sm-7 col-xs-7 col-lg-7 addFriendInfo">'
							+ '???&nbsp;&nbsp;???&nbsp;&nbsp;??????'
							+ fromUser.userName
							+ '</div>'
							+ '<div class="col-md-7 col-sm-7 col-xs-7 col-lg-7 addFriendInfo">'
							+ '???&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;??????'
							+ fromUser.userNickName
							+ '</div>'
							+ '<div class="col-md-7 col-sm-7 col-xs-7 col-lg-7 addFriendInfo">'
							+ '???????????????'
							+ '</div>'
							+ '<div class="col-md-7 col-sm-7 col-xs-7 col-lg-7 addFriendInfo">'
							+ content
							+ '</div>'
							+ '<div class="col-md-3 col-sm-3 col-xs-3 col-lg-3 addFriendInfo">'
							+ '<button class="btn btn-default" onclick=\'agreeAddThisUser('+from+')\'>????????????</button>'
							+ '</div>' 
							+ '<div class="col-md-3 col-sm-3 col-xs-3 col-lg-3 addFriendInfo">'
							+ '<button class="btn btn-default" onclick=\'refuseAddThisUser('+from+')\'>????????????</button>'
							+ '</div>' 
							+ '</div>';
				else if(type ==6){
					var group = ajaxGetGroupById(content);
					friendApplyHtml= '<div id="'+group.id+'addFriendRow" class="row addFriendRow">'
							+ '<div class="col-md-5 col-sm-5 col-xs-5 col-lg-5 addFriendImgBox">'
							+ '<img src="img/photo.jpg" class="img-circle addFriendImg">'
							+ '</div>'
							+ '<div class="col-md-7 col-sm-7 col-xs-7 col-lg-7 addFriendInfo">'
							+ '???&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;??????'
							+ group.groupId
							+ '</div>'
							+ '<div class="col-md-7 col-sm-7 col-xs-7 col-lg-7 addFriendInfo">'
							+ '???&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;??????'
							+ group.groupName
							+ '</div>'
							+ '<div class="col-md-7 col-sm-7 col-xs-7 col-lg-7 addFriendInfo">'
							+ '?????????????????????'
							+ '</div>'
							+ '<div class="col-md-7 col-sm-7 col-xs-7 col-lg-7 addFriendInfo">'
							+ '????????????'
							+fromUser.userNickName
							+ '</div>'
							+ '<div class="col-md-3 col-sm-3 col-xs-3 col-lg-3 addFriendInfo">'
							+ '<button class="btn btn-default" onclick=\'agreeGroupInvite('+content+')\'>????????????</button>'
							+ '</div>' 
							+ '<div class="col-md-3 col-sm-3 col-xs-3 col-lg-3 addFriendInfo">'
							+ '<button class="btn btn-default" onclick=\'refuseGroupInvite('+content+')\'>????????????</button>'
							+ '</div>' 
							+ '</div>';
				}
				var friendApplyBox = document.getElementById('friendApplyBox');
				friendApplyBox.innerHTML += friendApplyHtml;
		}
		
		//ajax????????????????????????????????????
		function getMessageRecordBetweenUsers(userId){
			//var allMessages = null;
			var messageandImg={};
			var twoUser = {};
			twoUser.userIdA = ${currentUser.userId};
			twoUser.userIdB = userId;
			$.ajax({
				async : false, //????????????
				type : 'POST',
				url : '${cp}/getMessageRecordBetweenUsers',
				data : twoUser,
				dataType : 'json',
				success : function(resoult) {
					if (resoult!=null) {
						messageandImg.allMessages = resoult.result;
						messageandImg.userImgA=resoult.userImgA;
						messageandImg.userImgB=resoult.userImgB;
					}
					else{
						layer.alert('????????????');
					}
				},
				error : function(resoult) {
					layer.alert('????????????');
				}
				});
			//??????????????????????????????eval???????????????prase????????????????????????
// 			allMessages = eval("("+allMessages+")");
			return messageandImg;
		}
		//??????????????????
		function chatWithSomeBody(userId, userName, userNickName) {
			console.log("chatWithSomeBody id="+userId);
			var chatWith = '<div class="chatWith">'
					+ '<div id="'+userId+'output" class="container output">'
					+ '</div>'
					+ '<hr/>'
					+ '<div class="options">'
					+ '<button type="button" class="btn btn-default pull-left" onclick="tabControl('
					+userId
					+')">??????</button>'
					+ '<button type="button" class="btn btn-default pull-right" onclick="sendMessagePre('
					+ userId
					+ ')">??????</button>'
					+ '</div>' 
					+ '<script id="'
					+ userId
					+ 'messageText" class="ueditorFlag" type="text/plain" '
					+  '/>'  
					+ '</div>';
			layer.open({
				type : 1,
				title : [userNickName,'font-family:Microsoft YaHei;font-size: 20px;height: 80px;'],
				content : chatWith,
				area : [ '600px', '600px' ],
				maxmin : true,
				offset : [ '100px', '100px' ],
				shade : 0,
				id : userName,
				resize : true,
				zIndex : layer.zIndex,
				success : function(layero) {
					layer.setTop(layero);
				},
				cancel : function(){
					var editor = userId + 'messageText';
					var ue=UE.getEditor(editor);
					ue.destroy();
				}
			});
			// ???????????? ????????????????????????
			$(".ueditorFlag").each(function() {
			    var id = this.id;    
			    var ue = UE.getEditor(id, {
			        pasteplain: true, /* ??????????????? */
			        autoHeightEnabled:false,/* ??????????????????,?????????true??????????????????*/
			        toolbars: [[
			        	'bold', 'italic' ,'underline', 'strikethrough', '|' ,
			        	'forecolor' ,'backcolor', '|' ,'removeformat' ,'|',
			            'selectall' ,'cleardoc','|' ,
			            'link' ,'unlink' ,'|' ,
			            'emotion', 'simpleupload' , 'attachment' ,'insertvideo',  '|'
			      ]]
			    });
// 			    .addOutputRule(function(root){
// 			      // ??????????????????????????????????????????????????????<p><br/></p> ?????????????????????????????????????????????
// 			    // ?????????????????????????????????????????????????????????????????????
// 			    var firstPNode = root.getNodesByTagName("p")[0];
// 			    firstPNode && /^\s*(<br\/>\s*)?$/.test(firstPNode.innerHTML()) && firstPNode.parentNode.removeChild(firstPNode);
// 			    });
			    console.log('ueditor for ' + id + ' init.');
			});
			//??????????????????
			var messageandImg=getMessageRecordBetweenUsers(userId);
			var fromImg=messageandImg.userImgA;
			var toImg=messageandImg.userImgB;
			var allMessages = messageandImg.allMessages;
			allMessages = eval("("+allMessages+")");
			for(var i=0;i<allMessages.length;i++){
				var usersId = new Array();
				usersId[0] = allMessages[i].to;
				var jsonMessage = JSON.stringify({
					from : allMessages[i].from,
					to : usersId,
					content : allMessages[i].content,
					type : allMessages[i].type,
					time : allMessages[i].time
				});
				showReceiveMessage(fromImg,toImg,allMessages[i].content, allMessages[i].from, usersId, allMessages[i].type, allMessages[i].time, jsonMessage);
			}
		}
		//??????????????????????????????
		function sendMessagePre(toUserId) {
			var textAreaId = toUserId + 'messageText';
			var ue=UE.getEditor(textAreaId);
			var message = ue.getContent();
			if(message != ''){
				var toUsersId = new Array();
				toUsersId[0] = toUserId;
				sendMessage(message, toUsersId ,0);
				ue.setContent('');
			}
		}
		//?????????
		function tabControl(userId){
			var userInfo=null;
			var findUser={};
			findUser.userId=userId;
			$.ajax({
				async : false,
				type : 'POST',
				url : '${cp}/doFindUserById',
				data : findUser,
				dataType : 'json',
				success : function(result){
					if(result!=null){
						userInfo=result;
					}
					else{
						layer.alert('????????????');
					}
				},
				error : function(result) {
					layer.alert('????????????');
				}
			});
			html='<div class="panel panel-primary">'
			+'<div class="panel-heading">?????????</div>'
			+'<div class="panel-body">'
			+userInfo.userName
			+'</div>'
			+'</div>'
			+'<div class="panel panel-success">'
			+'<div class="panel-heading">??????</div>'
			+'<div class="panel-body">'
			+userInfo.userNickName
			+'</div>'
			+'</div>';
			if(userInfo.userEmail!=''){
				html+='<div class="panel panel-info">'
				+'<div class="panel-heading">??????</div>'
				+'<div class="panel-body">'
				+userInfo.userEmail
				+'</div>'
				+'</div>';
			}
			if(userInfo.userPhone!=''){
				html+='<div class="panel panel-warning">'
					+'<div class="panel-heading">?????????</div>'
					+'<div class="panel-body">'
					+userInfo.userPhone
					+'</div>'
					+'</div>';
			}
			html+='<button type="button" onclick="deleteUser('
			+userInfo.userId
			+')">????????????</button>';
			layer.open({
				type : 1,
				content : html,
				area : '400px',
				offset : 'auto',
				shade : 0.3,
				shadeClose : true,
				anim : 5,
				id : userInfo.userName+'info',
				resize : true,
				zIndex : layer.zIndex+1,
				success : function(layero) {
					layer.setTop(layero);
				}
			});
		}
		//????????????
		function deleteUser(userId){
			var deletetheUser={};
			deletetheUser.userId=userId;
			var result=null;
			layer.confirm("??????????????????????????????", {icon: 3, title:'??????',zIndex : layer.zIndex+2}, function(index){
				 $.ajax({
					async : false, //????????????
					type : 'POST',
					url : '${cp}/removeRelation',
					data : deletetheUser,
					dataType : 'json',
					success : function(resoult) {
						if (resoult!=null) {
							result = resoult.result;
							console.log("???????????????"+result);
							if(result=='success'){
								layer.msg("???????????????");
								location.reload();
							}else if(result=='error'){
								layer.alert("????????????");
							}else if(result=='Fail'){
								layer.alert("????????????");
							}
						}
						else{
							layer.alert('????????????');
						}
					},
					error : function(resoult) {
						layer.alert('????????????');
					}
				 });
				// layer.close(index);
			});
			
			
			
		}
		//???????????????????????????????????????
		
		//????????????????????????
		function getUserAllGroups(){
			var allGroups = null;
			var currentUser = {};
			currentUser.userId = ${currentUser.userId};
			$.ajax({
				async : false, //????????????
				type : 'POST',
				url : '${cp}/getUserGroups',
				data : currentUser,
				dataType : 'json',
				success : function(resoult) {
					if (resoult!=null) {
						allGroups = resoult.groups;
					}
					else{
						layer.alert('????????????');
					}
				},
				error : function(resoult) {
					layer.alert('????????????');
				}
				});
			//??????????????????????????????eval???????????????prase????????????????????????
			allGroups = eval("("+allGroups+")");
			return allGroups;	
		}
		
		//????????????????????????
		function getGroupAllUsers(id){
			var usersAndUserGroup= {};
			var currentGroup = {};
			currentGroup.id = id;
			$.ajax({
				async : false, //????????????
				type : 'POST',
				url : '${cp}/getGroupUsers',
				data : currentGroup,
				dataType : 'json',
				success : function(resoult) {
					if (resoult!=null) {
						usersAndUserGroup.userGroups = resoult.userGroups;
						usersAndUserGroup.users = resoult.users;
					}
					else{
						layer.alert('????????????');
					}
				},
				error : function(resoult) {
					layer.alert('????????????');
				}
				});
			usersAndUserGroup.userGroups = eval("("+usersAndUserGroup.userGroups+")");
			usersAndUserGroup.users = eval("("+usersAndUserGroup.users+")");
			return usersAndUserGroup;	
		}
		
		//??????????????????
		var createGroupIndex = null;
		function createGroup(){
        var html = '<div class="createGroup">'
          + '<div class="container createGroupBox">'
          + '<div class="row createGroupRow">'
          + '<div class="col-md-5 col-sm-5 col-xs-5 col-lg-5 createGroupImgBox">'
          + '<img src="img/photo.jpg" class="img-circle createGroupImg">'
          + '</div>'
          + '<div class="col-md-2 col-sm-2 col-xs-2 col-lg-2 createGroupInfo">'
          + '???&nbsp;&nbsp;???&nbsp;&nbsp;??????' 
          + '</div>'
          + '<div class="col-md-4 col-sm-4 col-xs-4 col-lg-4 createGroupInfo">'
          + '<input id="createGroupName" type="text" class="form-control" placeholder="???????????????">'
          + '</div>'
          + '<div class="col-md-6 col-sm-6 col-xs-6 col-lg-6 createGroupInfo">'
          + '????????????'
          + '<textarea id="createGroupIntroduction" class="form-control createGroupTextArea" placeholder="??????????????????????????????" rows="2"></textarea>'
          + '</div>'
          + '<div class="col-md-6 col-sm-6 col-xs-6 col-lg-6 createGroupInfo">'
          + '<button class="btn btn-default" onclick="ajaxCreateGroup()">????????????</button>'
          + '</div>' 
          + '</div>' 
          + '</div>' 
          + '</div>';
        createGroupIndex = layer.open({
          type:1,
          title:'????????????',
          content:html,
          area:['500px','275px'],
          resize:false,
          zIndex:layer.zIndex,
          success:function(layero){
            layer.setTop(layero);
          }
        });
      }
      
      //??????????????????
      function ajaxCreateGroup(){
      	if(createGroupIndex!=null){
      		var createGroup = {};
			createGroup.groupName = document.getElementById('createGroupName').value;
			createGroup.groupIntroduction = document.getElementById('createGroupIntroduction').value;
			createGroup.groupCreaterId = ${currentUser.userId};
			layer.close(createGroupIndex);
			$.ajax({
				async : false, //????????????
				type : 'POST',
				url : '${cp}/createGroup',
				data : createGroup,
				dataType : 'json',
				success : function(resoult) {
					if (resoult.resoult !=null) {
						layer.alert('??????????????????,?????????id??????'+resoult.resoult);
					} else {
						layer.msg('??????????????????', {
						icon : 2,
						zIndex : 20000001,
						time : 2000
					});
					}
				},
				error : function(resoult) {
					layer.msg('????????????????????????', {
						icon : 2,
						zIndex : 20000001,
						time : 2000
					});
				}
			});
		}
		else{
			layer.msg('????????????????????????????????????????????????????????????', {
						icon : 2,
						zIndex : 20000001,
						time : 2000
					});
		}
      }
      
      //ajax??????????????????????????????????????????
      function getMessageRecordBetweenUserAndGroup(id){
      	var allMessages = null;
			var userGroup = {};
			userGroup.userId = ${currentUser.userId};
			userGroup.id = id;
			$.ajax({
				async : false, //????????????
				type : 'POST',
				url : '${cp}/getMessageRecordBetweenUserAndGroup',
				data : userGroup,
				dataType : 'json',
				success : function(resoult) {
					if (resoult!=null) {
						allMessages = resoult.resoult;
					}
					else{
						layer.alert('????????????');
					}
				},
				error : function(resoult) {
					layer.alert('????????????');
				}
				});
			//??????????????????????????????eval???????????????prase????????????????????????
			allMessages = eval("("+allMessages+")");
			return allMessages;
      }

		//??????????????????
		function chatWithGroup(id, groupId, groupName,groupCreaterId) {
			var chatWith = '<div class="chatWith">'
					+ '<div id="'+id+'outputGroup" class="container output">'
					+ '</div>'
					+ '<hr/>'
					+ '<div class="options">'
					+ '<button type="button" class="btn btn-default pull-left" onclick="groupTabControl('
					+ id
					+ ')">??????</button>'
					+ '<button type="button" class="btn btn-default pull-right" onclick="sendGroupMessagePre('
					+ id
					+ ')">??????</button>'
					+'<button type="button" class="btn btn-default pull-right smallOffset" onclick="groupUserList('+id+')">???????????????</button>'
					+'<button type="button" class="btn btn-default pull-right smallOffset" onclick="groupInvite('+id+')">???????????????</button>'	
					+'</div>'
					+ '<script id="'
					+ id
					+ 'messageTextGroup" class="ueditorGroupFlag" type="text/plain" '
					+  '/>'  
					+ '</div>';
			layer.open({
				type : 1,
				title : [groupName,'font-family:Microsoft YaHei;font-size: 24px;height: 80px;'],
				content : chatWith,
				area : [ '600px', '600px' ],
				maxmin : true,
				offset : [ '100px', '150px' ],
				shade : 0,
				id : groupId,
				resize : true,
				zIndex : layer.zIndex,
				success : function(layero) {
					layer.setTop(layero);
				},
				cancel : function(){
					var editor = id + 'messageTextGroup';
					var ue=UE.getEditor(editor);
					ue.destroy();
				}
			});
			// ????????????????????????
			$(".ueditorGroupFlag").each(function() {
			    var id = this.id;    
			    var ue = UE.getEditor(id, {
			        pasteplain: true, /* ??????????????? */
			        autoHeightEnabled:false,/* ??????????????????,?????????true??????????????????*/
			        enableContextMenu: false,
			        toolbars: [[
			        	'bold', 'italic' ,'underline', 'strikethrough', '|' ,
			        	'forecolor' ,'backcolor', '|' ,
			        	'removeformat' ,'|',
			            'selectall' ,'cleardoc','|' ,
			            'link' ,'unlink' ,'|' ,
			            'emotion', 'image', 'simpleupload', 'attachment','insertvideo', '|'
			      ]]
			    });
// 			    .addOutputRule(function(root){
// 			      // ??????????????????????????????????????????????????????<p><br/></p> ?????????????????????????????????????????????
// 			    // ?????????????????????????????????????????????????????????????????????
// 			    var firstPNode = root.getNodesByTagName("p")[0];
// 			    firstPNode && /^\s*(<br\/>\s*)?$/.test(firstPNode.innerHTML()) && firstPNode.parentNode.removeChild(firstPNode);
// 			    });
			    console.log('ueditorGroup for ' + id + ' init.');
			});
			//??????????????????
			var allMessages = getMessageRecordBetweenUserAndGroup(id);
			for(var i=0;i<allMessages.length;i++){
				//console.log(allMessages[i]);
				var usersId = new Array();
				usersId[0] = id;
				usersId[1] = allMessages[i].to;
				var jsonMessage = JSON.stringify({
					from : allMessages[i].from,
					to : usersId,
					content : allMessages[i].content,
					type : allMessages[i].type,
					time : allMessages[i].time
				});
				var fromImg=null;
				var toImg=null;
				$.ajax({
					async : false, //????????????
					type : 'POST',
					url : '${cp}/doFindUserImgById',
					data : {'userId':allMessages[i].from},
					dataType : 'json',
					success : function(resoult){
						fromImg=resoult.userImg;
					}
				});
				showReceiveMessage(fromImg,toImg,allMessages[i].content, allMessages[i].from, usersId, allMessages[i].type, allMessages[i].time, jsonMessage);
			}
		}
		
		function ajaxGetGroupById(id){
			var group = null; 
			var groups = {};
			groups.id = id;
			$.ajax({
				async : false, //????????????
				type : 'POST',
				url : '${cp}/findGroupById',
				data : groups,
				dataType : 'json',
				success : function(resoult) {
					if (resoult.resoult !=null) {
						group = resoult.resoult;
					} else {
						layer.msg('??????????????????', {
						icon : 2,
						zIndex : 20000001,
						time : 2000
					});
					}
				},
				error : function(resoult) {
					layer.msg('????????????????????????', {
						icon : 2,
						zIndex : 20000001,
						time : 2000
					});
				}
			});
			group = eval("("+group+")");
			return group;
		}
		//????????????????????????????????????
		function sendGroupMessagePre(id) {
			var group = ajaxGetGroupById(id);
			
			var textAreaId = id + 'messageTextGroup';
			var ue=UE.getEditor(textAreaId);
			var message = ue.getContent();
			if(message != ''){
				var toUsersIdString = new Array();
				toUsersIdString = (group.groupMembers).split(',');
				var toUsersId = new Array();
				for(var i=0;i<toUsersIdString.length;i++){
					toUsersId[i] = parseInt(toUsersIdString[i]);
				}
				sendMessage(message, toUsersId ,1);
				ue.setContent('');
			}
		}
		//???????????????
		function groupTabControl(id){
			deleteGroup(id);
		}
		//????????????
		function deleteGroup(id){
			var deletetheGroup={};
			deletetheGroup.id=id;
			var result=null;
			console.log(id);
			layer.confirm("??????????????????????????????", {icon: 3, title:'??????',zIndex : layer.zIndex+2}, function(index){
				 $.ajax({
					async : false, //????????????
					type : 'POST',
					url : '${cp}/deleteGroupUserById',
					data : deletetheGroup,
					dataType : 'json',
					success : function(resoult) {
						if (resoult!=null) {
							result = resoult.result;
						}
						else{
							layer.alert('????????????');
						}
					},
					error : function(resoult) {
						layer.alert('????????????');
					}
				 });
				 layer.close(index);
			});
			if(result=='success'){
				layer.msg("???????????????");
				location.reload();
			}else if(result=='error'){
				layer.alert("????????????");
			}
		}
		//????????????????????????
		function groupInvite(id){
			var allRelations = getAllRelations();
			var html='<div class="groupInviteList">'+
					'<table class="table table-striped table-hover">'+
			        '<tr>'+
			          '<th>#</th>'+
			          '<th>?????????</th>'+
			          '<th>??????</th>'+
			          '<th>??????</th>'+
			        '</tr>';
			for(var i=0;i<allRelations.length;i++){
				html+=  '<tr>'+
				          '<td>'+
				          (i+1)+
				          '</td>'+
				          '<td>'+allRelations[i].userName+'</td>'+
				          '<td>'+allRelations[i].userNickName+'</td>'+
				          '<td>'+
				          '<button type="button" class="btn btn-default" onclick="groupInviteUser('+id+','+allRelations[i].userId+')">????????????</button>'
				          '</td>'+
				        '</tr>';
			}
			html+= '</table>'+
					'</div>';
			layer.open({
	          type:1,
	          title:'??????????????????',
	          content:html,
	          area:['400px','600px'],
	          resize:false,
	          zIndex:layer.zIndex,
	          success:function(layero){
	            layer.setTop(layero);
	          }
	        });
		}
		//??????????????????
		function groupInviteUser(id,userId){
			var message = id;
			var toUsersId = new Array();
			toUsersId[0] = userId;
			sendMessage(message, toUsersId ,6);
		}
		
		//??????????????????
		function agreeGroupInvite(id){
			var addGroup = {};
			addGroup.id = id;
			addGroup.userId = ${currentUser.userId};
			$.ajax({
				async : false, //????????????
				type : 'POST',
				url : '${cp}/addGroupUsers',
				data : addGroup,
				dataType : 'json',
				success : function(resoult) {
					if (resoult.resoult == 'success') {
						location.reload();
					} else {
						text = '??????????????????????????????????????????';
					}
				},
				error : function(resoult) {
					layer.msg('????????????', {
						icon : 6,
						zIndex : 20000001,
						time : 2000
					});
				}
			});
			var addFriendRow = document.getElementById(id+'addFriendRow');
			addFriendRow.style.display = 'none';
			relationApplyNumber--;
			if(relationApplyNumber == 0)
				layer.close(relationApply);
		}
		
		//??????????????????
		function refuseGroupInvite(id){
			var addFriendRow = document.getElementById(id+'addFriendRow');
			addFriendRow.style.display = 'none';
			relationApplyNumber--;
			if(relationApplyNumber == 0)
				layer.close(relationApply);
		}
		
		//???????????????
		function groupUserList(id){
			var usersAndUserGroup = getGroupAllUsers(id);
			var users = usersAndUserGroup.users;
			var userGroup = usersAndUserGroup.userGroups;
			var html='<div class="groupInviteList">'+
					'<table class="table table-striped table-hover">'+
			        '<tr>'+
			          '<th>#</th>'+
			          '<th>?????????</th>'+
			          '<th>??????</th>'+
			          '<th>?????????</th>'+
			          '<th>??????</th>'+
			          '<th>????????????</th>'+
			        '</tr>';
			for(var i=0;i<users.length;i++){
				html+=  '<tr>'+
				          '<td>'+
				          (i+1)+
				          '</td>'+
				          '<td>'+users[i].userName+'</td>'+
				          '<td>'+users[i].userNickName+'</td>'+
				          '<td>'+userGroup[i].groupUserNickName+'</td>'+
				          '<td>'+userGroup[i].groupLevel+'</td>'+
				          '<td>'+userGroup[i].enterGroupTime+'</td>'+
				        '</tr>';
			}
			html+= '</table>'+
					'</div>';
			layer.open({
	          type:1,
	          title:'?????????',
	          content:html,
	          area:['500px','600px'],
	          resize:false,
	          zIndex:layer.zIndex,
	          success:function(layero){
	            layer.setTop(layero);
	          }
	        });
		}
	</script>
  </body>
</html>