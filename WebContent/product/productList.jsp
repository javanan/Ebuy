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
<div class="main">
	<div class="product-list">
			<h2>全部商品</h2>
			<ul class="product clearfix">
				<c:forEach items="${productList }" var="p">
					<li>
						<dl>
							<dt>
								<a href="product_showProduct.action?productId=${p.id }" target="_blank"><img src="${p.proPic }"/></a>
							</dt>
							<dd class="title">
								<a href="product_showProduct.action?productId=${p.id }" target="_blank">${p.name }</a>
							</dd>
							<dd class="price">
								￥${p.price }
							</dd>
						</dl>
					</li>
				</c:forEach>
			</ul>
			<div class="clear"></div>
			<div class="pager">
						<ul class="clearfix">
							${pageCode }
						</ul>
			</div>
	</div>
</div>
</body>
</html>