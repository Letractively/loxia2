<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Edit User</title>		
		<s:include value="../commons/meta.jsp"/>		
		<style>		
			#main {width: 98%; margin-left: auto; margin-right: auto;}
			#loginfobar {float: right; height: 92px;}
			#loginfobar p{color: #FFF; font-size: 0.75em; font-weight: bold; margin-top: 60px; padding: 6px 10px;}
			#portrait-container {width:90px;float:left;padding-top:8px;text-align:center; border: 1px solid #F2F5F7; margin: 2px;}
			#portrait-container.show {border-color: #C0C0C0;}
			#portrait {width:72px;height:92px; vertical-align: middle; margin-left: 6px;}
			#portrait img {border:1px solid #8f8f8f; margin-left: auto; margin-right: auto;}
			#portrait-uploader {height: 20px; margin-top: 2px; background-color: #F2F5F7;}
			#portrait-container.show #portrait-uploader{background-color: #EBEBEB;}
			#portrait-uploader img{cursor: pointer; font-size:11px;display:none;float:right;width:20px;margin-right:5px;line-height:18px;text-indent:-800px;}
			#portrait-container.show #portrait-uploader img{display:block;}
			.content .loxia{font-size: 80%;}
			.content .ui-loxia-table tr{height: 22px;}
			.content .ui-loxia-table th, .content .ui-loxia-table th{line-height: 22px;}
			
			#userlist-table td.col-3 {vertical-align: middle;}
			#userlist-table img {float: left; border: 1px solid transparent; margin: 2px; cursor: pointer;}
			#userlist-table img.hover {border-color: #8f8f8f;}
			a.rtmenu {font-size: 8pt;}
			a.rtmenu, a.rtmenu:visited {color: #EBEBEB;}
			a.rtmenu:hover{color: #FFFF00;}
			a.rtmenu span{padding-right: 18px;}
		</style>
		<script type="text/javascript">		
		var $portrait;
		var $userlistTable;
		$j(document).ready(function(){
			$portrait = $j("#portrait");
			$userlistTable = $j("#userlist-table").data("loxiatable");
			$j(".sidenav .ui-widget-content").each(function(){
					$j(this).data("height",$j(this).height());
				});
			$j(".sidenav .ui-state-active a").hover(function(){
					$j(this).find(".ui-icon-triangle-1-n").removeClass("ui-icon-triangle-1-n").addClass("ui-icon-circle-triangle-n");
					$j(this).find(".ui-icon-triangle-1-s").removeClass("ui-icon-triangle-1-s").addClass("ui-icon-circle-triangle-s");
				},function(){
					$j(this).find(".ui-icon-circle-triangle-n").removeClass("ui-icon-circle-triangle-n").addClass("ui-icon-triangle-1-n");
					$j(this).find(".ui-icon-circle-triangle-s").removeClass("ui-icon-circle-triangle-s").addClass("ui-icon-triangle-1-s");
				});
			$j(".sidenav .ui-state-active a").click(function(){
					var $content = $j(this).parents(".sidenav").find(".ui-widget-content");
					if($content.data("isHidden")){	
						$content.data("isHidden",false);
						//$j(this).find("span.ui-icon-triangle-1-s").removeClass("ui-icon-carat-1-s").addClass("ui-icon-carat-1-n");	
						$j(this).find("span.ui-icon-circle-triangle-s").removeClass("ui-icon-circle-triangle-s").addClass("ui-icon-circle-triangle-n");							
						$content.show();
						$content.animate({height:$content.data("height")},"slow");							
					}else{							
						$content.data("isHidden",true);		
						//$j(this).find("span.ui-icon-triangle-1-n").removeClass("ui-icon-carat-1-n").addClass("ui-icon-carat-1-s");	
						$j(this).find("span.ui-icon-circle-triangle-n").removeClass("ui-icon-circle-triangle-n").addClass("ui-icon-circle-triangle-s");
						$content.hide();															
						$content.animate({height:0},"slow");	
					}
				});
			$j("#portrait-container").hover(function(){
					$j(this).addClass("show");
				},function(){
					$j(this).removeClass("show");
				});
			$j("#portrait-uploader img").click(function(){
				$j('#up-portrait-dlg').loxiadialog("open");
				});
			$j("#userlist-table img").livequery(function(){
					$j(this).hover(function(){
						$j(this).addClass("hover");
					},function(){
						$j(this).removeClass("hover");
				});
				});
		});	
		var upPortraitDlgSettings = {modal: true,
				autoOpen: false,
				width: 400,
				buttons :[{value:"Cancel", 
			   			 func : function(){
		   					$j('#up-portrait-dlg').loxiadialog("close");
		   				 }},
	   					{value:"Upload", 
			   			 func : function(){
   			 				$j("#uploadForm").submit();
   			 				$j('#up-portrait-dlg').loxiadialog("close");
		   			 	 }}]
			};	
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
				var form = $j("#editUserForm").get(0);
				var errorMsg = loxia.validateForm(form);
				if(errorMsg.length == 0){
					var data = loxia.syncXhrPost('<s:url value="/user/modifyuserrentry.do"/>',{form: form});
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

			function checkLoginName(username)
			{
				var reg=/^[a-z A-Z][a-z A-Z \d \- _]*/; 
				return reg.test(str);   
			}

			function checkLength(value, obj){
				if(value.length > 20)
					return "please keep your length less-than 20";
				if(obj.name="user.password" && value.length <6 )
					return "password length must greater-than 6"
				return loxia.SUCCESS;
			}
		</script>
	</head>
	<body>
		<div id="main">
		
			<div class="ui-state-active ui-corner-top" style="margin-bottom: 1px; padding: 2px 6px">Edit User</div>
			<div class="ui-widget ui-widget-content ui-corner-bottom" style="background-image: none; overflow: hidden; padding-left: 4px;padding-right: 4px;">
			     
				<form id="editUserForm" name="editUserForm" action='<s:url value="#"/>'  enctype="multipart/form-data" method="post">
				<table cellpadding="2" cellspacing="2" border="0" style="width: 100%;">
					<tr class="odd">
						<td class="label" style="text-align: right; padding-right: 4px;" width="100px">Login Name:</td>
						<td width="120px"><s:property value="user.loginName"/><input type="hidden" id="user.id" name="user.id" value='<s:property value="user.id"/>' />
										 
						</td>
						<td class="hint"></td>
						<td rowspan="4">
							<div class="ui-widget ui-widget-content ui-corner-bottom" style="overflow: hidden;">
								<div id="portrait-container">
								<div id="portrait">
									<s:if test="userInformation.portrait == null">
									<img src='<s:url value="/images/no-photo.gif"/>'/>
									</s:if>
									<s:else>
									<img src='<s:url value="/commons/getattachment.do"/>?userInfoIdForPortrait=<s:property value="userInformation.id"/>'></img>
									</s:else>
								</div>
								<div id="portrait-uploader"><img src='<s:url value="/images/newspaper.png"/>'/></div>
								</div>
							</div>
						</td>
					</tr>
					<tr class="even">
						<td class="label" style="text-align: right; padding-right: 4px;">Password:</td>
						<td width="120px"><input loxiaType="input" name="user.password"  trim="true" selectonfocus="true"  style="width:95%" checkmaster="checkLength"/></td>
						<td class="hint">change the password or leave it alone if not.</td>
						
					</tr>
					<tr class="odd">
						<td class="label" style="text-align: right; padding-right: 4px;">User Name:</td>
						<td width="120px"><input loxiaType="input" name="user.userName" required="true" trim="true" selectonfocus="true"  style="width:95%" checkmaster="checkLength" value='<s:property value="user.userName"/>' /></td>
						<td class="hint">Write the real user name.</td>
					</tr>
					<tr class="even">
						<td class="label" style="text-align: right; padding-right: 4px;">Habbit:</td>
						<td width="120px"><s:property value="userInformation.habbit"/></td>
						<td class="hint"></td>
					</tr>
					
				</table>
				<table>
					<tr class="odd">
						<td class="label" style="text-align: right; padding-right: 4px;">Description:</td>
						<td width="420px" ><textarea rows="5" loxiaType="input" name="userInformation.description"  trim="true" selectonfocus="true" style="width:100%"><s:property value="userInformation.description"/></textarea></td>
					</tr>
					<tr class="even">
						<td class="label" style="text-align: right; padding-right: 4px;">System User?:</td>
						<td><s:property value="user.isSystem"/></td>
					</tr>
				</table>
				</form>
				<div class="buttonbar">
					<input type="button" loxiaType="button" value="Edit" onclick="addUser();"/>
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
		<div loxiaType="dialog" settings="upPortraitDlgSettings" id="up-portrait-dlg" title="Upload Protrait">
			<form id="uploadForm" action='<s:url value="/user/uploadportrait.do"/>' method="post" enctype="multipart/form-data" target="hiddenIframe">
				<p style="padding-left: 10px; padding-top: 20px;">Please choose your portrait: <input type="file" name="portrait" class="ui-state-default"/></p>
				<input type="hidden" id="user.id" name="user.id" value='<s:property value="user.id"/>' />
			</form>
		</div>	
		<iframe src="../commons/attach_result.jsp" id="hiddenIframe"  name="hiddenIframe" style="display: none;"></iframe>		
	</body>
</html>
