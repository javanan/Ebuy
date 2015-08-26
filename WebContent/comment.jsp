<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="css/style.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	function checkForm(){
		var nickName=$("#nickName").val();
		var content=$("#content").val();
		if(nickName==""){
			$("#error").html("昵称不能为空！");
			return false;
		}
		if(content==""){
			$("#error").html("留言内容不能为空！");
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<div id="header" class="wrap">
	<jsp:include page="common/top.jsp"/>
</div>

<div id="main"  class="wrap">
	<div class="lefter">
		<jsp:include page="common/left.jsp"/>
	</div>
	
	<div class="main">
	<div class="guestbook">
		<h2>全部留言</h2>
		<ul>
			<c:forEach items="${commentList }" var="comment">
				<li>
					<dl>
						<dt>${comment.content}</dt>
						<dd class="author">
							网友：${comment.nickName }
							<span class="timer">
								<fmt:formatDate value="${comment.createTime }" type="date" pattern="yyyy-MM-dd"/>
							</span>
							<c:if test="${not empty comment.replyContent }">
								<dd>
									官方回复：${comment.replyContent }&nbsp;&nbsp;
									<span class="timer">
								<fmt:formatDate value="${comment.replyTime }" type="date" pattern="yyyy-MM-dd"/>
							</span>
								</dd>
							</c:if>
						</dd>
					</dl>
				</li><br/>
			</c:forEach>
		</ul>
		<div class="clear"></div>
		<div class="pager">
				<ul class="clearfix">
					${pageCode }
				</ul>
		</div>
		<div id="reply-box">
			<form action="comment_save.action" method="post" onsubmit="return checkForm()">
				<table>
					<tr>
						<td class="field">昵称：</td>
						<td><input class="text" type="text"  id="nickName"  name="comment.nickName" />
						</td>
					</tr>
					<tr>
						<td class="field">留言内容：</td>
						<td><textarea id="content" name="comment.content"></textarea>
						</td>
					</tr>
					<tr>
						<td></td>
						<td><label class="ui-blue"><input type="submit"
								name="submit" value="提交留言" /> </label>&nbsp;&nbsp;<font id="error"  color="red">${error }</font>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	</div>
</div>
<div class="clear"></div>

<div id="footer">
	<jsp:include page="common/footer.jsp"/>
</div>
</body>
</html>