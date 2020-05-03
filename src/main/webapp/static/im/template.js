;(function(RCS){
	var getTemplates = function(callback){
		var list = {
	        button: '/static/im/templates/button.html',
	        chat: '/static/im/templates/chat.html',
	        closebefore: '/static/im/templates/closebefore.html',
	        conversation: '/static/im/templates/conversation.html',
	        endconversation: '/static/im/templates/endconversation.html',
	        evaluate: '/static/im/templates/evaluate.html',
	        imageView: '/static/im/templates/imageView.html',
	        leaveword: '/static/im/templates/leaveword.html',
	        main: '/static/im/templates/main.html',
	        imMain: '/static/im/templates/imMain.html',
	        message: '/static/im/templates/message.html',
	        imMessage: '/static/im/templates/imMessage.html',
	        messageTemplate: '/static/im/templates/messageTemplate.html',
	        imMessageTemplate: '/static/im/templates/imMessageTemplate.html',
	        userInfo: '/static/im/templates/userInfo.html',
	    };
	    var templates = {};
	    for (var key in list) {
	    	var url = list[key];
	    	var html = RCS.templateCache[url];
	    	if (html) {
	    		templates[key] = html;
	    	} else {
		    	var xhr = new XMLHttpRequest();
		    	xhr.open('get', url, false);
		    	xhr.onreadystatechange = function(){
		    		if (xhr.readyState == 4 && xhr.status == 200) {
		    			templates[key] = xhr.responseText;
		    		}
		    	}
		    	xhr.send(null);
	    	}

	    }
	    return templates;
	}
	RCS.getTemplates = getTemplates;
})(RCS);