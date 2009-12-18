<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Dashboard for Basic Webapp</title>		
		<s:include value="commons/meta.jsp"/>
		<link rel="stylesheet" type="text/css"  href="<s:url value='/css/dashboard/default.css' includeParams='none' encode='false'/>"/>
		<style>		
			#main {height: 400px;}				
			#loginfobar {float: right; height: 92px;}
			#loginfobar p{color: #FFF; font-size: 0.75em; font-weight: bold; margin-top: 60px; padding: 6px 10px;}
			#portrait-container {width:90px;float:left;padding-top:8px;text-align:center; border: 1px solid #F2F5F7; margin: 2px;}
			#portrait-container.show {border-color: #C0C0C0;}
			#portrait img {border:1px solid #8f8f8f;width:72px;height:92px;}
			#portrait-uploader {height: 20px; margin-top: 2px; background-color: #F2F5F7;}
			#portrait-container.show #portrait-uploader{background-color: #EBEBEB;}
			#portrait-uploader img{cursor: pointer; font-size:11px;display:none;float:right;width:20px;margin-right:5px;line-height:18px;text-indent:-800px;}
			#portrait-container.show #portrait-uploader img{display:block;}
		</style>
		<script type="text/javascript">		
			$j(document).ready(function(){
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
	   			 				
			   			 	 }}]
				};
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
					<p>Main Content Here.</p>
				</div>
				<div class="sidenav" id="personal-profile">			
					<div class="ui-state-active ui-corner-top" style="margin-bottom: 1px; padding: 2px 6px">Personal Profile
					<a href="#" style="float: right;"><span class="ui-icon ui-icon-triangle-1-n"></span></a></div>
					<div class="ui-widget ui-widget-content ui-corner-bottom" style="overflow: hidden;">
						<div id="portrait-container">
						<div id="portrait"><img src='<s:url value="/images/no-photo.gif"/>'/></div>
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
			<form action='<s:url value="/uploadportrait.do">' method="post" enctype="multipart/form-data" target="hiddenIframe">
				<p style="padding-left: 10px; padding-top: 20px;">Please choose your portrait: <input type="file" name="portrait" class="ui-state-default"/></p>
			</form>
		</div>
		<iframe src="/commons/attach_result.jsp" id="hiddenIframe"  name="hiddenIframe" style="display:none"></iframe>		
	</body>
</html>
