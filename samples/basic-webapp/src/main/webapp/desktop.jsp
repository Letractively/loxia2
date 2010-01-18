<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Dashboard for Basic Webapp</title>		
		<s:include value="commons/meta.jsp"/>
		<link rel="stylesheet" type="text/css"  href="<s:url value='/css/dashboard/default.css' includeParams='none' encode='false'/>"/>
		<style>					
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
			#user-info-drag {width: 400px; height: 250px; padding: 0.5em;}
			p {font-size: 9px}
			.ihabbit {border: 0px; background:inherit;}
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
						$j(this).find(".ui-icon-close").removeClass("ui-icon-close").addClass("ui-icon-circle-close");
					},function(){
						$j(this).find(".ui-icon-circle-triangle-n").removeClass("ui-icon-circle-triangle-n").addClass("ui-icon-triangle-1-n");
						$j(this).find(".ui-icon-circle-triangle-s").removeClass("ui-icon-circle-triangle-s").addClass("ui-icon-triangle-1-s");
						$j(this).find(".ui-icon-circle-close").removeClass("ui-icon-circle-close").addClass("ui-icon-close");
					});
				$j(".sidenav .ui-state-active a").click(function(){
					var aId = $j(this).attr("id");
					if(aId == "triangle"){
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
					}else if(aId == "close"){
						$j(this).find(".ui-icon-circle-close").removeClass("ui-icon-circle-close").addClass("ui-icon-close");
						$j('#user-info-drag').center().hide('clip',null,500,null);
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
				$j('#user-info-drag').hide().draggable({handle: 'div.ui-state-active',
					containment: 'window'}).center();
				$j('#ihabbit').removeClass("ui-state-default").toggleClass("ihabbit").blur(function(){editHabbit($j(this).val())});
				
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
			var deleteUserDlgSettings = {modal: true,
					autoOpen: false,
					resizable: false,
					width: 400,
					buttons :[{value:"Cancel", 
				   			 func : function(){
			   					$j('#delete-user-dlg').loxiadialog("close");
			   				 }},
		   					{value:"Delete", 
				   			 func : function(){
			   					deleteUser();
	   			 				$j('#delete-user-dlg').loxiadialog("close");
			   			 	 }}]
				};
			var editDesDlgSettings = {modal: true,
					autoOpen: false,
					width: 400,
					buttons :[{value:"Cancel", 
				   			 func : function(){
			   					$j('#edit-des-dlg').loxiadialog("close");
			   				 }},
		   					{value:"Submit", 
				   			 func : function(){
			   					$j("#editDesForm").submit();
			   					$j("#idescription").text();
	   			 				$j('#edit-des-dlg').loxiadialog("close");
			   			 	 }}]
				};
			var t1Settings = $j.extend({
					url: '<s:url value="/commons/getusersindesktop.do" includeParams="none" encode="false"/>'
				}, <s:property value="#session.userTableModel.model" escape="false"/>);
			var t2Settings = $j.extend({
				url: '<s:url value="/commons/gettodayswork.do" includeParams="none" encode="false"/>',
				emptyMessage: "No work today."
			}, <s:property value="#session.umTableModel.model" escape="false"/>);
			function genUserListOpTd(data){
				var result = "";
				result +='<s:if test="checkAcl(new java.lang.String[]{\'ACL_USER_MAINTAIN\'})"> '
				result += '<img title="view user" src="images/magnifier.gif" onclick="viewUserInfo(' + data.id + ')"></img>';
				result += '<img title="add/modify user information" src="<s:url value='/images/pencil.gif' includeParams='none' encode='false'/>" onclick="editUserInfo(' + data.id + ')"></img>';
				result +='</s:if>'
				if(!data.system)
					result += '<img title="delete user" src="<s:url value='/images/trash.gif' includeParams='none' encode='false'/>" onclick="innerDeleteUser(' + data.id + ')"></img>';
				result += '<div class="clearer"><span></span></div>';
				return result;
			}
			function addUser(){
				var oWin = loxia.openPage('<s:url value="/user/adduserentry.do" includeParams="none" encode="false"/>','useraddwindow',null,[640,400]);
				if(!oWin.opener) oWin.opener = self;
				oWin.focus();				
			}				
			function editUserInfo(userId){

				
				var url='<s:url value="/user/edituserentry.do"/>';
				var url1=url+'?user.id='+userId
				
				
				var oWin = loxia.openPage(url1,'useraddwindow',null,[640,400]);
				if(!oWin.opener) oWin.opener = self;
				oWin.focus();
			}
			var delUserId = 0;
			function innerDeleteUser(userId){
				delUserId = userId;
				$j('#delete-user-dlg').loxiadialog("open");
			}
			function deleteUser(){
				var data = loxia.syncXhrGet("<s:url value='/user/deleteuser.do?acl=ACL_USERMEMO_MAINTAIN' encode='false' includeParams='none'/>",{data: {"user.id": delUserId}});
				if(data.result){
					$userlistTable.reload();
				}else{
					showErrorMsg(data.exception.message || "System Error.");
				}
			}
			function viewUserInfo(userId){
				var data = loxia.syncXhrGet("<s:url value='/user/viewuser.do' encode='false' includeParams='none'/>",{data: {"user.id": userId}});
				$j('#name').text("");
				$j('#createTime').text("");
				$j('#latestUpdateTime').text("");
				$j('#habbit').text("");
				$j('#description').text("");
				
				$j('#name').text(data.userName);
				$j('#createTime').text(data.createTime);
				$j('#latestUpdateTime').text(data.latestUpdateTime);
				$j('#habbit').text(data.habbit);
				$j('#description').text(data.description);
				if($j('#user-info-drag').css('display') == 'none')
					$j('#user-info-drag').show('clip',null,500,null);		
			}
			function editHabbit(value){
				if(value != "" && value.length > 0){
					loxia.syncXhrGet("<s:url value='/user/updatehabbit.do' encode='false' includeParams='none'/>",
						{data: {"user.id": <s:property value="currentUser.id"/>, "userInformation.habbit": value}});
				}
			}		
			function editTodoList(){
				var oWin = loxia.openPage('<s:url value="/user/maintaintodolistentry.do?acl=ACL_USERMEMO_MAINTAIN" includeParams="none" encode="false"/>','useraddtodowindow',null,[640,400]);
				if(!oWin.opener) oWin.opener = self;
				oWin.focus();
			}
			$j.fn.center = function () {
				this.css("position","absolute");
				this.css("top", ( $j(window).height() - this.height() ) / 2+$j(window).scrollTop() + "px");
				this.css("left", ( $j(window).width() - this.width() ) / 2+$j(window).scrollLeft() + "px");
				return this;
			}
		</script>
	</head>
	<body>
		<div class="container">
			<div class="header">

				<div class="title">
					<h1>Basic Webapp</h1>
				</div>
		
				<div class="navigation">
					<a href="#">Vestibulum</a>
					<a href="#">Suspendisse</a>
					<a href="#">Elemen</a>
					<div class="clearer"><span></span></div>
				</div>		
				
				<div id="loginfobar">
					<p>Current User:&nbsp;<s:property value="userInfo"/>&nbsp; <a href="<s:url value='/logout.do'/>">logout</a></p>
				</div>		
			</div>
			<div class="main" id="main">
				<div class="content">
				<div class="ui-state-active ui-corner-top" style="height:16px; margin-bottom: 1px; padding: 2px 6px"><span style="float:left;">Todo List</span>
				<a class="rtmenu" title="Add new users here" href="#" onclick="editTodoList();return false;" style="float: right;"><span style="background: url('images/pencil.gif') right bottom no-repeat;">Edit</span></a>
				</div>
				<div class="ui-widget ui-widget-content ui-corner-bottom" style="overflow: hidden;">
				<table id="todolist-table" loxiaType="table" settings="t2Settings" cellpadding="0" cellspacing="0">
				<thead><tr><th property="memo">Today's Work</th></tr></thead>
				<tbody></tbody><tbody></tbody><tbody></tbody>
				</table>
				</div>
				<p></p>
				<div class="ui-state-active ui-corner-top" style="height:16px; margin-bottom: 1px; padding: 2px 6px"><span style="float:left;">Current User List</span>
				<s:if test="checkAcl(new java.lang.String[]{'ACL_USER_MAINTAIN'})">
				<a class="rtmenu" title="Add new users here" href="#" onclick="addUser();return false;" style="float: right;"><span style="background: url('images/plus.png') right bottom no-repeat;">New User</span></a>
				</s:if>
				</div>
				<div class="ui-widget ui-widget-content ui-corner-bottom" style="overflow: hidden; padding-bottom: 4px;">
				<table id="userlist-table" loxiaType="table" settings="t1Settings" cellpadding="0" cellspacing="0">
				<thead>
				<tr>
					<th property="userName" sort="u.USER_NAME" style="width:60%">User</th>
					<th property="withInformation" style="width:10%">Info.</th>
					<th property="withProtrait" style="width:10%">Portrait</th>
					<th generator="genUserListOpTd" style="width:20%">Operation</th>
				</tr>
				</thead>
				<tbody></tbody>
				<tbody><tr>
					<td></td><td></td><td></td>
					<td>Put two operations here</td>
				</tr></tbody>
				<tbody></tbody>
				</table>
				<p style="padding: 2px 2px 2px 6px">Why there are so few users. Please add more~~</p>				
				</div>
				</div>
				<div class="sidenav" id="personal-profile">			
					<div class="ui-state-active ui-corner-top" style="height:16px; margin-bottom: 1px; padding: 2px 6px"><span style="float:left;">Personal Profile</span>
					<a href="#" style="float: right;" id="triangle"><span class="ui-icon ui-icon-triangle-1-n"></span></a>								
					</div>
					<div class="ui-widget ui-widget-content ui-corner-bottom" style="overflow: hidden;">
						<div id="portrait-container">
						<div id="portrait">
						<s:if test="#request.userInformation == null">
						<img src='<s:url value="/images/no-photo.gif"/>'/>
						</s:if>
						<s:else>
						<img src='<s:url value="/commons/getattachment.do"/>?userInfoIdForPortrait=<s:property value="#request.userInformation.id"/>'></img>
						</s:else>
						</div>
						<div id="portrait-uploader"><img src='<s:url value="/images/newspaper.png"/>'/></div>
						</div>
						<p><b>Name:</b><span style="padding-left:10px"><s:property value="#request.user.userName"/></span></p>
						<p><b>Attend Time:</b><span style="padding-left:10px"><s:property value="#request.user.createTime"/></span></p>
						<p><b>Last Update Time:</b><span style="padding-left:10px"><s:property value="#request.user.latestUpdateTime"/></span></p>
						<p><b>Habbit:</b><span style="padding-left:10px"><input loxiaType="input" name="" value='<s:property value="#request.userInformation.habbit"/>' 
							trim="true" max="20" onblur="" id="ihabbit"/></span></p>
						<p><b>Description:</b><span style="padding-left:10px"><s:property value="#request.userInformation.description"/></span></p>
					</div>					
				</div>
				<div class="clearer"><span></span></div>
			</div>			
		</div>
		<div class="footer">&copy; 2006 <a href="#">Aixol.com</a>. 
		</div>
		<div loxiaType="dialog" settings="upPortraitDlgSettings" id="up-portrait-dlg" title="Upload Protrait">
			<form id="uploadForm" action='<s:url value="/uploadportrait.do"/>' method="post" enctype="multipart/form-data" target="hiddenIframe">
				<p style="padding-left: 10px; padding-top: 20px;">Please choose your portrait: <input type="file" name="portrait" class="ui-state-default"/></p>
			</form>
		</div>
		<div loxiaType="dialog" settings="deleteUserDlgSettings" id="delete-user-dlg" title="Confirm to Delete">
			<p>Do you confirm to remove this user? User will not be recoved after deletion.</p>
		</div>
		<div loxiaType="dialog" settings="editDesDlgSettings" id="edit-des-dlg" title="Edit Description">
			<form id="editDesForm" action='<s:url value="/edituserself.do"/>' method="post">
				<p style="padding-left: 10px; padding-top: 20px;">Description: <textarea name="user.description" loxiaType="input"></textarea></p>
			</form>
		</div>		
		<div id="user-info-drag" class="sidenav">
			<div class="ui-state-active ui-corner-top" style="height:16px;  padding: 2px 6px; cursor: move;">
				<span style="float: left;">User Info.</span>
				<a style="float: right;" href="#" id="close"><span class="ui-icon ui-icon-close"/></a>
			</div>
			<div class="ui-widget-content ui-corner-bottom" style="height:220px;overflow: hidden;">
				<div id="portrait-container">
				<div id="portrait">
				<s:if test="#request.userInformation == null">		
				<img src="images/no-photo.gif"/>
				</s:if>
				<s:else>
				<img src='<s:url value="/commons/getattachment.do"/>?userInfoIdForPortrait=<s:property value="#request.userInformation.id"/>'></img>
				</s:else>
				</div>
				</div>
				<div style="float: left; height: auto; width: 280px; margin: 2px;word-break:break-all;">
					<p><b>Name:</b><span id="name" style="padding-left:10px"></span></p>
					<p><b>Attend Time:</b><span id="createTime" style="padding-left:10px"></span></p>
					<p><b>Last Update Time:</b><span id="latestUpdateTime" style="padding-left:10px"></span></p>
					<p><b>Habbit:</b><span id="habbit" style="padding-left:10px"></span></p>
					<p><b>Description:</b><span id="description" style="padding-left:10px;"></span></p>
				</div>
			</div>
		</div>
		<iframe src="/commons/attach_result.jsp" id="hiddenIframe"  name="hiddenIframe" style="display: none;"></iframe>		
	</body>
</html>
