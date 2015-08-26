<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>易买网</title>
</head>
<body>
<div id="header" class="wrap">
	<jsp:include page="common/top.jsp"/>
</div>
<div id="position" class="wrap">
		${navCode }
</div>

<div id="main" class="wrap">
	<div id="menu-mng" class="lefter" >
		<div class="box">
			<dl>
				<dt>用户管理</dt>
				<dd><a href="user_getUserInfo.action">个人信息管理</a></dd>
				<dt>订单管理</dt>
				<dd><a href="order_findOrder.action">个人订单管理</a></dd>
			</dl>
		</div>
	</div>
	<div class="main">
		<jsp:include page="${mainPage }"/>
	</div>
	<div class="clear"></div>
</div>

<div id="footer">
	<jsp:include page="common/footer.jsp"/>
</div>
</body>
</html>