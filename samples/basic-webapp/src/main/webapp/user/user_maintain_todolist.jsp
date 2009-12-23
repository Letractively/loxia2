<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Maintain User Todo List</title>		
		<s:include value="../commons/meta.jsp"/>		
		<style>		
			#main {width: 98%; margin-left: auto; margin-right: auto;}
		</style>
		<script type="text/javascript">		
			$j(document).ready(function(){
			});				
			function showErrorMsg(msg){
				var $info = $j("#info-block");
				if(msg){
					if(loxia.isString(msg)) msg = [msg];
					var lilist = "";
					for(var i=0; i< msg.length; i++)
						lilist += "<li>" + msg[i] + "</li>";
					$info.find("ul").html(lilist);
					$info.show();
				}else 
					$info.hide();
			}
			var userMemoEditSettings = {append: <s:property value="#request.umList.size() == 0 ? 1: 0"/>};
		</script>
	</head>
	<body>
		<div id="main">
			<div class="ui-state-active ui-corner-top" style="margin-bottom: 1px; padding: 2px 6px">Maintain Todo List</div>
			<div class="ui-widget ui-widget-content ui-corner-bottom" style="background-image: none; overflow: hidden; padding-left: 4px;padding-right: 4px;">
				<s:form name="maintainUserMemoForm" id="maintainUserMemoForm" action="maintaintodolist">
				<s:token/>
				<table loxiaType="edittable" settings="userMemoEditSettings" cellpadding="0" cellspacing="0">
					<thead><tr><th width="40px;"><input type="checkbox"/></th><th>Todo List</th></tr></thead>
					<tbody>
					<s:iterator value="#request.umList" status="umStatus">
						<tr>
							<td><input type="checkbox"/></td>
							<td><input loxiaType="input" required="true" name="userMemos(<s:property value='#umStatus.index'/>).memo" value="<s:property value='memo'/>" style="width: 95%"/></td>
						</tr>
					</s:iterator>						
					</tbody>
					<tbody>
						<tr>
							<td><input type="checkbox"/></td>
							<td><input loxiaType="input" required="true" name="userMemos(#).memo" value="" style="width: 95%"/></td>
						</tr>
					</tbody>
					<tfoot></tfoot>
				</table>				
				<div class="buttonbar">
					<input type="button" loxiaType="button" buttonType="submit" value="Save"/>
				</div>
				</s:form>
				<div class="ui-widget" id="info-block" style="display:none;">
				<div class="ui-state-highlight ui-corner-all"  style="padding: .3em .7em; width: auto;">
				<p><span class="ui-icon ui-icon-info" style="float: left; margin-right: 0.3em; margin-top: 2px;"></span>
				<ul style="min-height:1%; list-style:none; margin: 0; padding-left: 0;">
				</ul>
				</p></div>
				</div>
			</div>
		</div>		
	</body>
</html>
