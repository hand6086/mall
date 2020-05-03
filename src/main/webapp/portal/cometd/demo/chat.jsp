<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/portal/header.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="common.css"/>
<link rel="stylesheet" type="text/css" href="chat.css"/>
<script type="text/javascript" src="${AppContext.ctxPath}/static/cometd/org/cometd.js"></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/cometd/jquery/jquery.cometd.js"></script>
</head>
<body>
        <section id="chatBox">
			<div id="users">
				<h2>在线用户</h2>
				<div id="usersInfo">
					<p>正在获取列表...</p>
				</div>
			</div>
			<div id="show">
				<section class="message">
					<p class="header"><span>用户1</span><time>19:01:22</time></p>
					<p class="content">这是聊天内容</p>
				</section>

			</div>
			<form  id="input" >
				<textarea name="message"></textarea>
				<button type="button" id="btn-send">发送</button>
			</form>
		</section>
		
		<div id="body"></div>
</body>

<script type="text/javascript">
//消息封装函数
var $send = $("#btn-send");
var $textarea = $("#input textarea");
var $show = $("#show");
var $usersInfo = $("#usersInfo");
var currentUserId = '${sessionScope.UserContext.id}';
var currentUserName= '${AppContext.fstName}';
function messagePackage(message) {
    /*
     message{
     userName : xx,
     timeSign : 22:12:44,
     content : abc
     }
     */
    var element_section = $("<section></section>");
    var element_section_p1 = $("<p></p>");
    var element_section_p1_user = $("<span></span>");
    var element_section_p1_time = $("<time></time>");
    var element_section_p2_content = $("<p></p>");
    element_section.addClass("message");
    element_section_p1.addClass("header");
    element_section_p2_content.addClass("content");
    element_section_p1_user.text(message.username);
    element_section_p1_time.text(message.timeSign);
    element_section_p2_content.text(message.content);
    element_section_p1.append(element_section_p1_user);
    element_section_p1.append(element_section_p1_time);
    element_section.append(element_section_p1);
    element_section.append(element_section_p2_content);
    return element_section;
}
//1.初始化文本输入框
$textarea.keyup(function(event){
    if(event.ctrlKey && event.keyCode == 13) {
        $send.trigger(("click"));
    }
});
$textarea.keypress(function(event) {
    if(event.keyCode == 13) {
        if(!$.trim($textarea.val())) return false;
    }
});
$textarea.keydown(function(event) {
    if(event.keyCode == 13) {
        if(!$.trim($textarea.val())) return false;
    }
});
function getTime() {
    var currentTime = {};
    var raw = new Date();
    currentTime.date = raw.getFullYear() + "-" + raw.getMonth() + "-" + raw.getDate();
    currentTime.time = raw.getHours() + ":" + raw.getMinutes() + ":" + String(raw.getMilliseconds()).slice(0,2);
    return currentTime;
}
	$(function(){
		$usersInfo = $("#usersInfo");
		var cometd = $.cometd;
		cometd.configure({
		    url: 'http://localhost:8080/cometd'
		});

		 function _connectionEstablished() {
	            $('#body').append('<div>CometD Connection Established</div>');
	        }

	        function _connectionBroken() {
	            $('#body').append('<div>CometD Connection Broken</div>');
	        }

	        function _connectionClosed() {
	            $('#body').append('<div>CometD Connection Closed</div>');
	        }
		// Function that manages the connection status with the Bayeux server
        var _connected = false;

        function _metaConnect(message) {
            if (cometd.isDisconnected()) {
                _connected = false;
                _connectionClosed();
                return;
            }

            var wasConnected = _connected;
            _connected = message.successful === true;
            if (!wasConnected && _connected) {
                _connectionEstablished();
            }
            else if (wasConnected && !_connected) {
                _connectionBroken();
            }
        }
     	// Function invoked when first contacting the server and
        // when the server has lost the state of this client
        function _metaHandshake(handshake) {
            if (handshake.successful === true) {
                cometd.batch(function() {
                    cometd.subscribe('/sys/time', function(message) {
                        $('#div').append('<div>Server Says: ' + message.data.time + '</div>');
                    });
                    
                    cometd.subscribe('/chat/userLogin', function(message) {//用户进入聊天室时刷新用户列表
                    	$usersInfo.empty();
                    	var userList = message.data;
                    	for(var i=0; i<userList.length; i++){
                    		var $user = $("<p id='"+userList[i].userId+"'></p>");
                            $user.text(userList[i].userName);
                            $usersInfo.append($user);
                    	}
                    });
                    cometd.subscribe('/chat/userLogout', function(message) {//用户退出聊天室时刷新用户列表
                    	var user = message.data;
                    	$usersInfo.find($("#"+user.userId)).remove();
                    	alert(user.userId+" logout");
                    });
                    cometd.subscribe('/chat/userSay', function(message) {
                    	var data = message.data;
                    	console.log(message);
                    	if(data.userName == currentUserName)return;
                    	$message = messagePackage({
                            username : data.userName,
                             timeSign : data.timeSign,
                             content : data.content
                         });
                         $show.append($message);
                         //让滚动条自动滚到底
                         $show.get(0).scrollTop = $show.get(0).scrollHeight;
                    });
                    $send.click(function(event){
                    	//event.preventDefault();
                        //event.stopPropagation();
                        //console.log($textarea.val());
                        if($textarea.val() == "") return;
                        var message = {
                            username:currentUserName,
                            timeSign:getTime().time,
                            content:$textarea.val()
                        };
                       var $message = messagePackage(message);
                       $message.addClass("sendByMyself");
                       $show.append($message); 
                       $show.get(0).scrollTop = $show.get(0).scrollHeight;
                       
                        $textarea.val("");
                        //TODO 将消息发送到服务器
						cometd.publish('/chat/say',message);
                        
                    });
                    // Publish on a service channel since the message is for the server only
                    cometd.publish('/chat/login', {
                    	userId: '${sessionScope.UserContext.id}',
                    	userName: '${AppContext.fstName}'
                    	});
                });
            }
            else if(handshake.successful === false){
            	alert("connection denied!");
            }
        }

        // Disconnect when the page unloads
        $(window).unload(function() {
        	cometd.publish('/chat/logout', {
            	userId: '${sessionScope.UserContext.id}',
            	userName: '${AppContext.fstName}'
            	});
            cometd.disconnect(true);
        });
        //jq 的unload貌似在火狐中不生效
        window.onbeforeunload=function(){
        	cometd.publish('/chat/logout', {
            	userId: '${sessionScope.UserContext.id}',
            	userName: '${AppContext.fstName}'
            	});
            cometd.disconnect(true);
        }
        cometd.addListener('/meta/handshake', _metaHandshake);
        cometd.addListener('/meta/connect', _metaConnect);

        cometd.handshake({
		    ext: {
		        "com.crm.authn": {
		            userId: appCtx.userId,
		            ssid: appCtx.ssid
		        }
		    }
		});//握手
	});
</script>
</html>