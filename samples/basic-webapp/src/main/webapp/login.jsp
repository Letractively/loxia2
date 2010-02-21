<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%boolean error = "true".equalsIgnoreCase(request.getParameter("error"));  %>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Login Page</title>
		<style>			
			#login-div {width: 400px; border: 1px solid #efefef; padding: 1px;
				background: url("<s:url value='/images/logo-feather.png' includeParams='none' encode='false'/>") 200px bottom no-repeat;}
			#login-input {padding: 10px 4px; margin: 20px 10px; width: auto;}
			#login-input input, #login-input span{margin: 5px 2px 1px 4px;}
			#login-input span {font-style: italic;}
		</style>
		<s:include value="commons/meta.jsp"/>
		<script type="text/javascript">
			$j(document).ready(function(){
				var w = $j("input[name='j_username']").width();
				$j("#login-input").css({width: w+18});
			    $j("body").bind("formvalidatefailed",function(event,data){
			        loxia.unlockPage();
			    	showErrorMsg(data[0]);
			    });

			    if($j("#info-block").find("li").length >0)
			    	$j("#info-block").show();
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
	<%if(error){ %><li>Wrong user name or password.</li><%} %>
	<s:iterator value="#request.messages"><li><s:property/></li></s:iterator>
	</ul>
	</p></div>
	</div>
	</body>
</html>