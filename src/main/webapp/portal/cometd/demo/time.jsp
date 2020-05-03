<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <script src="${AppContext.ctxPath}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${AppContext.ctxPath}/static/cometd/org/cometd.js"></script>
    <script type="text/javascript" src="${AppContext.ctxPath}/static/cometd/jquery/jquery.cometd.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div id="div"></div>
	<br>
	>>>>>>>>>>>>>>>>>>>>>>>>>>><br>
	<div id="body"></div>
</body>
<script type="text/javascript">
	$(function(){
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
                        $('#div').append('<div>' + message.data.msg + '</div>');
                        $('#div').append('<div>thisId:' + message.data.thisId + '</div>');
                        $('#div').append('<div><br><br><br></div>');
                    });
                    // Publish on a service channel since the message is for the server only
                    cometd.publish('/service/hello', {name: 'World'});
                });
            }
        }

        // Disconnect when the page unloads
        $(window).unload(function() {
            cometd.disconnect(true);
        });
        
        cometd.addListener('/meta/handshake', _metaHandshake);
        cometd.addListener('/meta/connect', _metaConnect);

        cometd.handshake();
/* 		// Handshake
		cometd.handshake(function(handshakeReply)
		{
		    if (handshakeReply.successful)
		    {
		        // Publish to a channel
		        cometd.publish('/foo', { foo: 'bar' });
		    }
		}); */
	});
</script>
</html>