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
			var t1Settings = $j.extend({
					url: '<s:url value="/commons/getusersindesktop.do" includeParams="none" encode="false"/>'
				}, <s:property value="#session.userTableModel.model" escape="false"/>);
			var t2Settings = $j.extend({
				url: '<s:url value="/commons/gettodayswork.do" includeParams="none" encode="false"/>',
				emptyMessage: "No work today."
			}, <s:property value="#session.umTableModel.model" escape="false"/>);
			function genUserListOpTd(data){
				var result = "";
				result += '<img title="add/modify user information" src="<s:url value='/images/pencil.gif' includeParams='none' encode='false'/>" onclick="editUserInfo(' + data.id + ')"></img>';
				if(!data.system)
					result += '<img title="delete user" src="<s:url value='/images/trash.gif' includeParams='none' encode='false'/>" onclick="deleteUser(' + data.id + ')"></img>';
				result += '<div class="clearer"><span></span></div>';
				return result;
			}
			function addUser(){
				var oWin = loxia.openPage('<s:url value="/user/adduserentry.do" includeParams="none" encode="false"/>','useraddwindow',null,[640,400]);
				if(!oWin.opener) oWin.opener = self;
				oWin.focus();				
			}			
			function editUserInfo(userId){
			}
			function deleteUser(userId){
			}
			function editTodoList(){
				var oWin = loxia.openPage('<s:url value="/user/maintaintodolistentry.do?acl=ACL_USERMEMO_MAINTAIN" includeParams="none" encode="false"/>','useraddtodowindow',null,[640,400]);
				if(!oWin.opener) oWin.opener = self;
				oWin.focus();
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
				<a class="rtmenu" title="Add new users here" href="#" onclick="addUser();return false;" style="float: right;"><span style="background: url('images/plus.png') right bottom no-repeat;">New User</span></a>
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
					<a href="#" style="float: right;"><span class="ui-icon ui-icon-triangle-1-n"></span></a>								
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
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
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
		<iframe src="/commons/attach_result.jsp" id="hiddenIframe"  name="hiddenIframe" style="display: none;"></iframe>		
	</body>
</html>
