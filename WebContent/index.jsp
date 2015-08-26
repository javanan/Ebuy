<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>易买网 - 首页</title>
</head>
<body>
<div id="header" class="wrap">
	<jsp:include page="common/top.jsp"/>
</div>

<div id="main" class="wrap">
	<div class="lefter">
		<jsp:include page="common/left.jsp"/>
	</div>
	<div class="main">
			<div class="price-off ">
				<h2>今日特价</h2>
				<ul class="product clearfix">
					<c:forEach items="${specialPriceProductList }" var="spProduct">
						<li>
							<dl>
								<dt>
									<a href="product_showProduct.action?productId=${spProduct.id }" target="_blank"><img src="${spProduct.proPic }"/></a>
								</dt>
								<dd class="title">
									<a href="product_showProduct.action?productId=${spProduct.id }" target="_blank">${spProduct.name }</a>
								</dd>
								<dd class="price">
									￥${spProduct.price }
								</dd>
							</dl>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="side">

				<div class="news-list">
					<h4>最新公告</h4>
					<ul>
						<c:forEach items="${noticeList }" var="notice">
							<li><a href="notice_showNotice.action?noticeId=${notice.id }">${notice.title }</a></li>
						</c:forEach>
					</ul>
				</div>
				<div class="spacer"></div>
				<div class="news-list">
					<h4>新闻动态</h4>
					<ul>
						<c:forEach items="${newsList }" var="news">
							<li><a href="news_showNews.action?newsId=${news.id }">${news.title }</a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="spacer clear"></div>
			
			<div class="hot">
				<h2>热卖推荐</h2>
				<ul class="product clearfix">
					<c:forEach items="${hotProductList }" var="hProduct">
						<li>
							<dl>
								<dt>
									<a href="product_showProduct.action?productId=${hProduct.id }" target="_blank"><img src="${hProduct.proPic }"/></a>
								</dt>
								<dd class="title">
									<a href="product_showProduct.action?productId=${hProduct.id }" target="_blank">${hProduct.name }</a>
								</dd>
								<dd class="price">
									￥${hProduct.price }
								</dd>
							</dl>
						</li>
					</c:forEach>
				</ul>
			</div>
			
		</div>
		<div class="clear"></div>
</div>

<div id="footer">
	<jsp:include page="common/footer.jsp"/>
</div>
</body>
</html>