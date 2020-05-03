;(function($){
	
	$.fn.BobImage = function (opt) {
		var _this = this;
		_this.defaults = {
	    	id : '',
	    	maxLimit : '1',
	    	upLoadUrl : '/action/portal/myFile/uploadImg',
	    	success : true,
	    	readOnly : false,
	    	result : '',
	    	width : '190px',
	    	height : '180px',
	    	message : '',
	    	fileType : ["jpg","png","bmp","jpeg"], // 上传文件的类型
	    	fileSize : 1024 * 1024 * 10, // 上传文件的大小 10M
	    	initImgUrl : '',
	    	myComplete : {},
	    	myRemove : {}
	    };
		_this.options = $.extend({}, _this.defaults, opt);
		
		_this.each(function() {
			
			if(_this.options.initImgUrl){
				// 初始化代码
			    var $imgContainer = $(this).parents(".z_photo"); //存放图片的父亲元素
			    
				var $input = $(this).parent();//文本框的父亲元素
			    var imgUrl = _this.options.initImgUrl;
				var $section = $("<section class='up-section fl loading'>");
				// 设置图片框的大小 开始
				$section.height(_this.options.height);
				$section.width(_this.options.width);
				// 设置图片框的大小 结束
				$imgContainer.prepend($section);
				var $span = $("<span class='up-span'>");
				$span.appendTo($section);

				var $img0 = $("<img class='close-upimg'>").on("click",
						function(event) {
							event.preventDefault();
							event.stopPropagation();
							$(_this).val('');
							$(this).parent().next().show();
							$(this).parent().remove();
							
							_this.options.myRemove();
				});
				if(!_this.options.readOnly){
					$img0.attr("src", "/static/images/a7.png").appendTo($section);
				}
				
				var $img = $("<img class='up-img up-opcity'>");
				$img.attr("src", imgUrl);
				$img.appendTo($section);
				var $p = $("<p class='img-name-p'>");
				$p.html("file").appendTo($section);
				var $input = $("<input id='taglocation' name='taglocation' value='' type='hidden'>");
				$input.appendTo($section);
				var $input2 = $("<input id='tags' name='tags' value='' type='hidden'/>");
				$input2.appendTo($section);
				
				setTimeout(function(){
		             $(".up-section").removeClass("loading");
				 	 $(".up-img").removeClass("up-opcity");
				},450);
				$(this).parent().parent().hide();
			}else{
			    var $imgContainer = $(this).parents(".z_photo"); //存放图片的父亲元素
				// 设置图片框的大小 开始
				$imgContainer.find('img').height(_this.options.height);
				$imgContainer.find('img').width(_this.options.width);
				// 设置图片框的大小 结束
			}
			
			$(this).on('change', function(){
				var maxsize = 1*1024*1024;
				if(this.files[0].size > maxsize){
					alert('文件大小大于1	M');	
					return ;
				}
				console.log("---------" + this.files[0].size);// 获取单位B
				
				var maxLimit = _this.options.maxLimit;// 展示图片数量
				var upLoadUrl = _this.options.upLoadUrl;
				var id = _this.options.id;
				
				var fileList = this.files; //获取的图片文件
				var imgArr = [];
				var $imgContainer = $(this).parents(".z_photo"); //存放图片的父亲元素
				var $input = $(this).parent();//文本框的父亲元素
				var numUp = $imgContainer.find(".up-section").length;
				var totalNum = numUp + fileList.length;  //总的数量
				
				// fileList = validateUp(fileList);
				for (var i = 0; i < fileList.length; i++) {
					var imgUrl = window.URL.createObjectURL(fileList[i]);
					imgArr.push(imgUrl);
					var $section = $("<section class='up-section fl loading'>");
					$imgContainer.prepend($section);
					
					// 设置图片框的大小 开始
					$section.height(_this.options.height);
					$section.width(_this.options.width);
					// 设置图片框的大小 结束
					
					var $span = $("<span class='up-span'>");
					$span.appendTo($section);

					var $img0 = $("<img class='close-upimg'>").on("click",
							function(event) {
								event.preventDefault();
								event.stopPropagation();
								var numUp = $(this).parent().siblings().length;
								$(_this).val('');
								if(numUp <= maxLimit){
									$(this).parent().next().show();
								}
								$(this).parent().remove();
								
								_this.options.myRemove();
							});
					
					if(!_this.options.readOnly){
						$img0.attr("src", "/static/images/a7.png").appendTo($section);
					}
					var $img = $("<img class='up-img up-opcity'>");
					$img.attr("src", imgArr[i]);
					$img.appendTo($section);
					var $p = $("<p class='img-name-p'>");
					$p.html(fileList[i].name).appendTo($section);
					var $input = $("<input id='taglocation' name='taglocation' value='' type='hidden'>");
					$input.appendTo($section);
					var $input2 = $("<input id='tags' name='tags' value='' type='hidden'/>");
					$input2.appendTo($section);
					
					setTimeout(function(){
			             $(".up-section").removeClass("loading");
					 	 $(".up-img").removeClass("up-opcity");
					 },450);
					numUp = $imgContainer.find(".up-section").length;
					
					if(numUp >= maxLimit){
						$(this).parent().parent().hide();
						var options = {
				   			url: upLoadUrl,
				   			type:'post',
				   			dataType:'json',
				   			contentType:"application/x-www-form-urlencoded;charset=utf-8",
				   			success : function(data) {
				   				_this.options.success = data.success;
				   				_this.options.result = data.result;
				   				_this.options.message = data.message;
				   				_this.options.myComplete(_this.options.success, _this.options.result, _this.options.message);
				   			}
				   		};
				   		$(this).parent().ajaxSubmit(options);
					}
				}
		    })
		    
		});
		
		/*var fileList = _this.files; //获取的图片文件
		console.log(fileList);
		$('#file').val(_this.options.initImgUrl);*/
		// $(_this).val(_this.options.initImgUrl);
		//alert(_this.options.initImgUrl);
	}
	
	
	/*function validateUp(files){
		var arrFiles = [];//替换的文件数组
		for(var i = 0, file; file = files[i]; i++){
			//获取文件上传的后缀名
			var newStr = file.name.split("").reverse().join("");
			if(newStr.split(".")[0] != null){
					var type = newStr.split(".")[0].split("").reverse().join("");
					if(jQuery.inArray(type, defaults.fileType) > -1){
						// 类型符合，可以上传
						if (file.size >= defaults.fileSize) {
							alert(file.size);
							alert('您这个"'+ file.name +'"文件大小过大');	
						} else {
							// 在这里需要判断当前所有文件中
							arrFiles.push(file);	
						}
					}else{
						alert('您这个"'+ file.name +'"上传类型不符合');	
					}
				}else{
					alert('您这个"'+ file.name +'"没有类型, 无法识别');	
				}
		}
		return arrFiles;
	}*/
	
})(jQuery)
