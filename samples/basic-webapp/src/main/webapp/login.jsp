<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Login Page</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
		
		<link rel="stylesheet" type="text/css"  href="<s:url value='css/jquery-ui-1.7.2.custom.css' includeParams='none' includeContext='false'/>"/>
		<script type="text/javascript" src="<s:url value='scripts/jquery-1.3.2.min.js' includeParams='none' includeContext='false'/>"></script>
		<script type="text/javascript" src="<s:url value='scripts/jquery-ui-1.7.2.custom.min.js' includeParams='none' includeContext='false'/>"></script>
		<script type="text/javascript" src="<s:url value='scripts/jquery.bgiframe.min.js' includeParams='none' includeContext='false'/>"></script>
		<script type="text/javascript" src="<s:url value='scripts/jquery.livequery.js' includeParams='none' includeContext='false'/>"></script>
		<script type="text/javascript" src="<s:url value='scripts/jquery.loxia-1.1.min.js' includeParams='none' includeContext='false'/>"></script>
		
		<script type="text/javascript">
			var $j = jQuery.noConflict();
			
			$j(document).ready(function(){
				loxia.init({debug: true});		

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
	<div id="login-div">
	<form method="post" action="<s:url value='/j_spring_security_check' includeParams='none' includeContext='false'/>">
	<input loxiaType="input" name="j_username"/>
	<input loxiaType="input" type="password" name="j_password"/>
	<button loxiaType="button" buttonType="submit">Login</button>
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