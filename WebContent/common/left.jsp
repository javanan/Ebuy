<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="box">
	<h2>商品分类</h2>
	<dl>
		<c:forEach items="${bigTypeList }" var="bigType">
			<dt>${bigType.name }</dt>
			<c:forEach items="${bigType.smallTypeList }" var="smallType">
				<dd><a href="product.action?s_product.smallType.id=${smallType.id}">${smallType.name }</a></dd>
			</c:forEach>
		</c:forEach>	
	</dl>
</div>

<div class="spacer"></div>
<div class="last-view">
	<h2>最近浏览</h2>
	<dl class="clearfix">
	 <c:forEach var="p" items="${currentBrowse }">
	 	<dt>
	 		<img src="${p.proPic }" class="imgs" style="height: 50px;width: 50px;">
	 	</dt>
	 	<dd>
	 		<a href="product_showProduct.action?productId=${p.id }" target="_blank">${p.name }</a>
	 	</dd>
	 </c:forEach>
	</dl>
</div>
</body>
</html>