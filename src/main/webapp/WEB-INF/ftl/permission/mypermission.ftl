<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<title>我的权限  —个人中心</title>
		<@_quote.quote 1/>
	</head>
	<body data-target="#one" data-spy="scroll">
		<@_topNav.top 1/>
		<div class="tpl-page-container tpl-page-header-fixed">
		<@_leftNav.left 1.4/>
		<div class="tpl-content-wrapper">
			<div class="tpl-content-page-title">我的权限</div>
            <ol class="am-breadcrumb">
                <li><a href="#" class="am-icon-home">首页</a></li>
                <li><a href="#">个人中心</a></li>
                <li class="am-active">我的权限</li>
            </ol>
            <div class="tpl-portlet-components">
	            <div id="getPermissionTree" >loding... ...</div>
            </div>
		</div>
		</div>
		<@_quoteAmazeUi.quoteAmazeUi 1/>
		<script>
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