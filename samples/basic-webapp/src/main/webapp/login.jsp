<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Login Page</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
		<meta http-equiv="Cache-Control" content="no-store"/>
		<meta http-equiv="Pragma" content="no-cache"/>
		<meta http-equiv="Expires" content="0"/>
		
		<link rel="stylesheet" type="text/css"  href="<s:url value='/css/jquery-ui-1.7.2.custom.css' includeParams='none' encode='false'/>"/>
		<style>
			body {margin: 30px;}
			body, .ui-widget { font:10pt Verdana, Arail,"Trebuchet MS", sans-serif;}	
			div.ui-datepicker{ font-size: 11px;}
			#login-div {width: 400px; border: 1px solid #efefef; padding: 1px;
				background: url("<s:url value='/images/logo-feather.png' includeParams='none' encode='false'/>") 200px bottom no-repeat;}
			#login-input {padding: 10px 0; margin: 20px 10px; width: auto;}
			#login-input input, #login-input span{margin: 5px 2px 1px 4px;}
			#login-input span {font-style: italic;}
		</style>

		<script type="text/javascript" src="<s:url value='/scripts/jquery-1.3.2.min.js' includeParams='none' encode='false'/>"></script>
		<script type="text/javascript" src="<s:url value='/scripts/jquery-ui-1.7.2.custom.min.js' includeParams='none' encode='false'/>"></script>
		<script type="text/javascript" src="<s:url value='/scripts/jquery.bgiframe.min.js' includeParams='none' encode='false'/>"></script>
		<script type="text/javascript" src="<s:url value='/scripts/jquery.livequery.js' includeParams='none' encode='false'/>"></script>
		<script type="text/javascript" src="<s:url value='/scripts/jquery.loxia-1.1.min.js' includeParams='none' encode='false'/>"></script>
		
		<script type="text/javascript">
			var $j = jQuery.noConflict();
			
			$j(document).ready(function(){
				loxia.init({debug: true});		

				var w = $j("input[name='j_username']").width();
				$j("#login-input").css({width: w+18});
			    $j("body").bind("formvalidatefailed",function(event,data){
			        loxia.unlockPage();
			    	showErrorMsg(data[0]);
			    });
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
		</script>
	</head>
	<body>
	<div id="login-div" class="ui-widget ui-corner-top">
	<form method="post" action="<s:url value='/j_spring_security_check' includeParams='none' encode='false'/>">
	<div class="ui-state-active ui-corner-top" style="margin-bottom: 10px; padding: 2px 6px">Login</div>
	<span style="padding-left: 8px;">Please input your user name and password here.</span>
	<div id="login-input" class="ui-widget ui-widget-content ui-corner-all">
	<span>User Name:</span>
	<input loxiaType="input" name="j_username" required="true"/>
	<span>Password:</span>
	<input loxiaType="input" type="password" name="j_password" required="true"/>
	<input type="button" loxiaType="button" buttonType="submit" value="Login"/>
	</div>
	</form>
	</div>
	<div class="ui-widget" id="info-block" style="display:none;">
	<div class="ui-state-highlight ui-corner-all"  style="padding: .3em .7em; width: auto;">
	<p><span class="ui-icon ui-icon-info" style="float: left; margin-right: 0.3em; margin-top: 2px;"></span>
	<ul style="min-height:1%; list-style:none; margin: 0; padding-left: 0;">
	</ul>
	</p></div>
	</div>
	</body>
</html>