<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<script type="text/javascript">
	function checkForm(){
		 var userName=$("#userName").val();
		 var password=$("#password").val();
		 if(userName==""){
			 $("#error").html("用户名不能为空！");
			 return false;
		 }
		 if(password==""){
			 $("#error").html("密码不能为空！");
			 return false;
		 }
		 if(imageCode==""){
			 $("#error").html("验证码不能为空！");
			 return false;
		 }
		 return true;
	}
</script>
</head>
<body>
<div id="header" class="wrap">
<div id="logo"><img src="${pageContext.request.contextPath}/images/logo.gif" /></div>
</div>
<div id="childNav">

	<div class="wrap">
		<ul class="clearfix">
		
		</ul>
	</div>
</div>

<div id="register" class="wrap">
	<div class="shadow">
		<em class="corner lb"></em>
		<em class="corner rt"></em>
		<div class="box">
			<h1>管理员登陆</h1>
			<form id="loginForm" method="post" action="${pageContext.request.contextPath}/user_login.action" onsubmit="return checkForm()">
				<table>
					<tr>
						<td class="field">用户名：</td>
						<td><input class="text" type="text" id="userName" name="user.userName"  value="${user.userName }" /><span></span></td>
					</tr>
					<tr>
						<td class="field">登录密码：</td>
						<td><input class="text" type="password" id="password" name="user.password"  value="${user.password }"/><span></span></td>
					</tr>
					<tr>
						<td class="field">验证码：</td>
						<td><input  class="text" style="width: 60px;margin-right: 10px;"
									type=text value="${imageCode }" name="imageCode" id="imageCode"><img
									onclick="javascript:loadimage();" title="换一张试试" name="randImage"
									id="randImage" src="${pageContext.request.contextPath}/image.jsp" width="60" height="20" border="1"
									align="absmiddle">					
						</td>
					</tr>
					<tr>
						<td>
							<input type="hidden" name="user.status" value="2"/>
						</td>
						<td><label class="ui-green"><input type="submit" name="submit" value="立即登录" /></label>&nbsp;&nbsp;<font id="error"  color="red">${error }</font></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<div class="clear"></div>
</div>
<div id="footer">
	Copyright &copy; 2014 Java知识分享网 All Rights Reserved.
		http://www.java1234.com
</div>
</body>
</html>