var pickListParentObjId = undefined;

/**
 * account-picklist
 * picklist弹出
 * @param obj 
 * @param pickTitle
 * @param pickUrl
 * @param operationUrl
 * @param func
 */
function acctPickListShow(id, pickTitle, pickUrl, operationUrl, func)
{
	pickUrl = pickUrl + '/'+id;
	var diag = new Dialog();
	diag.Width = $(window).width() * 0.8;
	diag.Height = $(window).height() * 0.8;
	diag.Title = pickTitle;
	diag.URL = pickUrl;
	pickListParentObjId = id;
	diag.OKEvent = function(){
		var operationObj = diag.innerWin.$picklistdatagrid;
		var selectedRow = operationObj.datagrid('getSelected');
		$.post(operationUrl,
		{
			preObjId:id,
			rearObjId:selectedRow.id
		},
	    function (data)
	    {
	  	  if(data.success){
	  		/*contentPage.window.pickSelectedRow = selectedRow;
	  		contentPage.window.$('#pickComplete').attr('onclick', func + '()');
	  		contentPage.window.$('#pickComplete').trigger('click');*/
	  		window.parent.$('#pickComplete').attr('onclick', func + '()');
	  		window.parent.$('#pickComplete').trigger('click');
	  	  }
	    });
		diag.close();
	};
	diag.show();
}
