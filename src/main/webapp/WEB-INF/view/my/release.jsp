<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String htmlData = request.getParameter("content1") != null ? request.getParameter("content1") : "";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>KindEditor JSP</title>
	<link rel="stylesheet" href="/resource/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="/resource/kindeditor/plugins/code/prettify.css" />
	<script charset="utf-8" src="/resource/kindeditor/plugins/code/prettify.js"></script>
	<script charset="utf-8" src="/resource/kindeditor/kindeditor-all.js"></script>
    <script charset="utf-8" src="/resource/kindeditor/lang/zh-CN.js"></script>
	<script
		src="/resource/js/jquery-3.2.1.js"></script>

	<script>
	KindEditor.ready(function(K) {
		window.editor1 = K.create('textarea[name="content1"]', {
			cssPath : '/resource/kindeditor/plugins/code/prettify.css',
			uploadJson : '/resource/kindeditor/jsp/upload_json.jsp',
			fileManagerJson : '/resource/kindeditor/jsp/file_manager_json.jsp',
			allowFileManager : true,
			afterCreate : function() {
				var self = this;
				K.ctrl(document, 13, function() {
					self.sync();
					document.forms['example'].submit();
				});
				K.ctrl(self.edit.doc, 13, function() {
					self.sync();
					document.forms['example'].submit();
				});
			}
		});
		prettyPrint();
	});
	function query(){
	
		//alert( $("[name='content1']").attr("src"))
	} 

		$(function(){
			$.post("/article/channelList",function(list){
				for ( var i in list) {
					$("[name='channel_id']").append("<option value="+list[i].id+">"+list[i].name+"</option>");
				}
			});
			$("[name='channel_id']").change(function(){
				var id=$("[name='channel_id']").val();
				if(id==0){
					$("[name='category_id']").empty();
					$("[name='category_id']").append("<option value='0'>---请选择分类---</option>");
				}else{
					$.post("/article/categoryList",{id:id},function(list){
						$("[name='category_id']").empty();
						$("[name='category_id']").append("<option value='0'>---请选择分类---</option>");
						for ( var i in list) {
							$("[name='category_id']").append("<option value="+list[i].id+">"+list[i].name+"</option>");
						}
					});
				}
				
			});
			
		})
		
		//发布
		function add(){
			//ajax提交    上传   副文本编辑器的内容
			//序列化表单数据 带文件
			var formData=new FormData($("#f1")[0]);
			//封装富文本中的html内容
			formData.append("content",editor1.html());
			//ajax提交
			$.ajax({
				// 告诉jQuery不要去处理发送的数据
				processData : false,
				// 告诉jQuery不要去设置Content-Type请求头
				contentType : false,
				url:"/article/add",
				data:formData,
				type:"post",
				success:function(msg){
					if(msg){
						alert("发布完成");
						$("#content-wrapper").load("/article/toAdd");
					}else{
						alert("发布失败");
					}
				}
				
			})
		}
	</script>
</head>
<body >
	<%=htmlData%>
	
	<form style="margin-left:50px" name="example" id="f1">
	
		文章标题:
		<input style="width: 920px" type="text" name="title" class="form-control"/><br>
		<div class="form-inline">
		栏目:<select name="channel_id" class="form-control">
			<option value="0">---请选择栏目---</option>
			</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		分类:<select name="category_id" class="form-control">
			<option value="0">---请选择分类---</option>
		</select>
		</div>
		<br>
			标题图片:
		<input type="file" name="file"/>
		<br>
		<br>
		<textarea  name="content1" cols="100" rows="8" style="width:920px;height:200px;visibility:hidden;">
		<%=htmlspecialchars(htmlData)%></textarea>
		
		<br />
		<button type="button" class="btn btn-primary" onclick="add()">发布</button>
	</form>
</body>
</html>
<%!
private String htmlspecialchars(String str) {
	str = str.replaceAll("&", "&amp;");
	str = str.replaceAll("<", "&lt;");
	str = str.replaceAll(">", "&gt;");
	str = str.replaceAll("\"", "&quot;");
	return str;
}
%>