<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<script src="${pageContext.request.contextPath}/js/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
	
	var url;

	function searchNotice(){
		$("#dg").datagrid('load',{
			"s_notice.title":$("#s_noticeTitle").val()
		});
	}
	
	function openNoticeAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加公告信息");
		url="notice_save.action";
	}
	
	
	function saveNotice(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				var content=CKEDITOR.instances.content.getData();
				if(content==null || content==""){
					$.messager.alert("系统提示","公告内容不能为空！");
					return false;
				}
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","保存成功");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert("系统提示","保存失败");
					return;
				}
			}
		});
	}
	
	function openNoticeModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑公告信息");
		$("#title").val(row.title);
		CKEDITOR.instances.content.setData(row.content);
		$("#createTime").val(row.createTime);
		url="notice_save.action?notice.id="+row.id;
	}
	
	function resetValue(){
		$("#title").val("");
		$("#createTime").val("");
		CKEDITOR.instances.content.setData("");
	}
	
	function closeNoticeDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function deleteNotice(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("notice_delete.action",{ids:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","数据已成功删除！");							
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","数据删除失败！");
					}
				},"json");
			}
		});
		
	}
	
	function formatContent(val,row){
		if(val.length<=30){
			return val;
		}else{
			return val.substr(0,30)+"...";
		}
	}
	
</script>
</head>
<body style="margin:1px;">
	<table id="dg" title="公告管理" class="easyui-datagrid"
	 fitColumns="true" pagination="true" rownumbers="true"
	 url="notice_list.action" fit="true" toolbar="#tb">
	 <thead>
	 	<tr>
	 		<th field="cb" checkbox="true" align="center"></th>
	 		<th field="id" width="50" align="center">编号</th>
	 		<th field="title" width="100" align="center">公告名称</th>
	 		<th field="createTime" width="100" align="center">创建时间</th>
	 		<th field="content" width="400" align="center" formatter="formatContent">内容</th>
	 	</tr>
	 </thead>
	</table>
	
	<div id="tb">
		<div>
			<a href="javascript:openNoticeAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			<a href="javascript:openNoticeModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:deleteNotice()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		</div>
		<div>
			&nbsp;公告名称：&nbsp;<input type="text" id="s_noticeTitle" size="20" onkeydown="if(event.keyCode==13) searchNotice()"/>
			<a href="javascript:searchNotice()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width: 750px;height:450px;padding: 10px 20px"
	  closed="true" buttons="#dlg-buttons">
	 	<form id="fm" method="post">
	 		<table cellspacing="8px">
	 			<tr>
	 				<td>公告标题：</td>
	 				<td colspan="4"><input type="text" id="title" name="notice.title" class="easyui-validatebox" required="true" style="width: 300px"/></td>
	 			</tr>
	 			<tr>
	 				<td valign="top">公告内容：</td>
	 				<td colspan="4">
	 					<textarea  id="content" name="notice.content" class="ckeditor"></textarea>
	 					
	 					<input type="hidden" id="createTime" name="notice.createTime"/>
	 				</td>
	 			</tr>
	 		</table>
	 	</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:saveNotice()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeNoticeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>