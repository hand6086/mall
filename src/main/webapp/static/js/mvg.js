function mvgPickShow(row, pickTitle, pickUrl,func)
{
	var diag = new Dialog();
	diag.Width = $(window).width() * 0.9;
	diag.Height = $(window).height() * 0.8;
	diag.Title = pickTitle;
	diag.URL = pickUrl;
	diag.ShowCloseButton=false;
	
	diag.OKEvent = function(){
		contentPage.window.$('#pickComplete').attr('onclick', func + '()');
		contentPage.window.$('#pickComplete').trigger('click');
  		diag.close();
	};
	diag.show();
	diag.cancelButton.style.display = "none";

}



