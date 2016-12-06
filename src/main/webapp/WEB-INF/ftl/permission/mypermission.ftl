<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<title>我的权限  —个人中心</title>
		<#include "../common/config/reference.ftl"/>
		<@reference/>
	</head>
	<body data-target="#one" data-spy="scroll">
		<@_top.top 1/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<#--row-->
			<div class="row">
				<@_left.user 2/>
				<div class="col-md-10">
					<h2>我的权限</h2>
					<hr>
					<div id="getPermissionTree" >loding... ...</div>
				</div>
			</div>
			<#--/row-->
		</div>
		<script >
			$(function(){
				//加载 permission tree data
				var load = layer.load();
				$.post("getPermissionTree.shtml",{},function(data){
					layer.close(load);
					if(data && !data.length){
						return $("#getPermissionTree").html('<code>您没有任何权限。只有默认的个人中心。</code>'),!1;
					}
					$('#getPermissionTree').treeview({
			          levels: 1,//层级
			          color: "#428bca",
			          nodeIcon: "glyphicon glyphicon-user",
			          showTags: true,//显示数量
			          data: data//数据
			        });
				},'json');
			});
		</script>
	</body>
</html>