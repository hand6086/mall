<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div>
	<table border="0" width="100%">
		<tr>
			<td class="td-label" width="10%">需要总部审核：</td>
			<td width="80%"><input type="checkbox" name="attr1" value="Y" /></td>
		</tr>
	</table>
</div>

<script type="text/javascript">
	function getOtherInfo()
	{
		var otherInfo = {};
		$('input[name="attr1"]:checked').each(function(){
			otherInfo["attr1"] = $(this).val();
		}); 
		if(otherInfo["attr1"] == null || otherInfo["attr1"] == ''){
			otherInfo["attr1"] = 'N';
		}
		return otherInfo;
	}
</script>