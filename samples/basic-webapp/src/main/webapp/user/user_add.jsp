<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Add User</title>		
		<s:include value="../commons/meta.jsp"/>		
		<style>		
			#main {width: 98%; margin-left: auto; margin-right: auto;}
		</style>
		<script type="text/javascript">		
			$j(document).ready(function(){
			});	
			function checkUserUnique(value){
				var data = loxia.syncXhrGet('<s:url value="/commons/checkuserunique.do"/>',{data: {"user.loginName": value}});
				if(data.unique)
					return loxia.SUCCESS;
				if(data.exception)
					return "System Error";
				return "Input is used, please change another one.";
			}
			function addUser(){
				showErrorMsg("");
				loxia.lockPage();
				var form = $j("#addUserForm").get(0);
				var errorMsg = loxia.validateForm(form);
				if(errorMsg.length == 0){
					var data = loxia.syncXhrPost('<s:url value="/user/adduser.do"/>',{form: form});
					if(data.result){
						opener.$userlistTable.reload();
						window.close();
					}else{
						loxia.unlockPage();
						showErrorMsg(data.exception.message || "System Error.");
					}						
				}else{
					loxia.unlockPage();
			    	showErrorMsg(errorMsg);
				}				
			}
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
		</script>
	</head>
	<body>
		<div id="main">
		<jsp:include page="../commons/header.jsp"/>
			<div class="ui-state-active ui-corner-top" style="margin-bottom: 1px; padding: 2px 6px">Add New User</div>
			<div class="ui-widget ui-widget-content ui-corner-bottom" style="background-image: none; overflow: hidden; padding-left: 4px;padding-right: 4px;">
				<s:form name="addUserForm" id="addUserForm">
				<s:token/>
				<table cellpadding="2" cellspacing="2" border="0" style="width: 100%;">
					<tr class="odd">
						<td class="label" style="text-align: right; padding-right: 4px;" width="100px">Login Name:</td>
						<td width="120px"><input loxiaType="input" name="user.loginName" required="true" trim="true" selectonfocus="true" checkmaster="checkUserUnique" style="width:95%"/></td>
						<td class="hint">Choose one login name which should be unique in system.</td>
					</tr>
					<tr class="even">
						<td class="label" style="text-align: right; padding-right: 4px;">Password:</td>
						<td><input loxiaType="input" name="user.password" required="true" trim="true" selectonfocus="true" style="width:95%"/></td>
						<td class="hint">Set the initial password</td>
					</tr>
					<tr class="odd">
						<td class="label" style="text-align: right; padding-right: 4px;">User Name:</td>
						<td><input loxiaType="input" name="user.userName" required="true" trim="true" selectonfocus="true" style="width:95%"/></td>
						<td class="hint">Write the real user name.</td>
					</tr>
					<tr class="even">
						<td class="label" style="text-align: right; padding-right: 4px;">System User?:</td>
						<td><s:checkbox name="user.isSystem"/></td>
						<td class="hint">Is this user a system one or not</td>
					</tr>
				</table>
				</s:form>
				<div class="buttonbar">
					<input type="button" loxiaType="button" value="Add" onclick="addUser();"/>
				</div>
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
