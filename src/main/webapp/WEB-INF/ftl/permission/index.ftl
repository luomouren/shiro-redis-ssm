<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<title>权限列表 - 权限管理</title>
		<@_quote.quote 1/>
		<script type="text/javascript">
			so.init(function(){
				//初始化全选。
				so.checkBoxInit('#checkAll','[check=box]');
				<@shiro.hasPermission name="/permission/deletePermissionById.shtml">
				//全选
				so.id('deleteAll').on('click',function(){
					var checkeds = $('[check=box]:checked');
					if(!checkeds.length){
						return layer.msg('请选择要删除的选项。',so.default),!0;
					}
					var array = [];
					checkeds.each(function(){
						array.push(this.value);
					});
					return deleteById(array);
				});
				</@shiro.hasPermission>
			});
			<@shiro.hasPermission name="/permission/deletePermissionById.shtml">
			<#--根据ID数组删除角色-->
			function deleteById(ids){
				var index = layer.confirm("确定这"+ ids.length +"个权限？",function(){
					var load = layer.load();
					$.post('${basePath}/permission/deletePermissionById.shtml',{ids:ids.join(',')},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg(result.resultMsg);
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
			}
			</@shiro.hasPermission>
			<@shiro.hasPermission name="/permission/addPermission.shtml">
			<#--添加权限-->
			function addPermission(){
				var name = $('#name').val(),
					url  = $('#url').val();
				if($.trim(name) == ''){
					return layer.msg('权限名称不能为空。',so.default),!1;
				}
				if($.trim(url) == ''){
					return layer.msg('权限Url不能为空。',so.default),!1;
				}
				<#--loding-->
				var load = layer.load();
				$.post('${basePath}/permission/addPermission.shtml',{name:name,url:url},function(result){
					layer.close(load);
					if(result && result.status != 200){
						return layer.msg(result.message,so.default),!1;
					}
					layer.msg('添加成功。');
					setTimeout(function(){
						$('#formId').submit();
					},1000);
				},'json');
			}
			</@shiro.hasPermission>
		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		<@_topNav.top 1/>
		<div class="tpl-page-container tpl-page-header-fixed">
		<@_leftNav.left 3.3/>
		<div class="tpl-content-wrapper">
			<div class="tpl-content-page-title">权限列表</div>
            <ol class="am-breadcrumb">
                <li><a href="#" class="am-icon-home">首页</a></li>
                <li><a href="#">权限管理</a></li>
                <li class="am-active">权限列表</li>
            </ol>
            <div class="tpl-portlet-components">
	            <form method="post" action="" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent?default('')}" 
					        			name="findContent" id="findContent" placeholder="输入权限名称">
					      </div>
					     <span class=""> <#--pull-right -->
				         	<a class="btn btn-primary" title="查询" type="submit"  onclick="$('#formId').submit();">
			                <i class="fa fa-search"></i></a>
				         	<@shiro.hasPermission name="/permission/addPermission.shtml">
				         		<a class="btn btn-success" title="增加权限" onclick="$('#addPermission').modal();">
			                    <i class="fa fa-plus-square"></i></a>
				         	</@shiro.hasPermission>
				         	<@shiro.hasPermission name="/permission/deletePermissionById.shtml">
				         		<a class="btn btn-default label-danger" id="deleteAll" title="删除" href="javascript:void(0);">
			                    <i class="fa fa-trash-o"></i></a>
				         	</@shiro.hasPermission>
				         </span>    
				        </div>
					<hr>
					<table class="table table-bordered">
						<tr>
							<th><input type="checkbox" id="checkAll"/></th>
							<th>权限名称</th>
							<th>角色类型</th>
							<th>操作</th>
						</tr>
						<#if page?exists && page.list?size gt 0 >
							<#list page.list as it>
								<tr>
									<td><input value="${it.id}" check='box' type="checkbox" /></td>
									<td>${it.name?default('-')}</td>
									<td>${it.url?default('-')}</td>
									<td>
										<@shiro.hasPermission name="/permission/deletePermissionById.shtml">
											<a class="btn btn-default label-danger" id="deleteRow" title="删除" href="javascript:deleteById([${it.id}]);">
			                    			<i class="fa fa-trash-o"></i></a>
										</@shiro.hasPermission>
									</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="4">没有找到角色</td>
							</tr>
						</#if>
					</table>
					<#if page?exists>
						<div class="pagination pull-right">
							${page.pageHtml}
						</div>
					</#if>
				</form>
				<@shiro.hasPermission name="/permission/addPermission.shtml">
				<#--弹框-->
				<div class="modal fade" id="addPermission" tabindex="-1" role="dialog" aria-labelledby="addPermissionLabel"  style="margin-top:70px;">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title" id="addPermissionLabel">添加权限</h4>
				      </div>
				      <div class="modal-body">
				        <form id="boxRoleForm">
				          <div class="form-group">
				            <label for="recipient-name" class="control-label">权限名称:</label>
				            <input type="text" class="form-control" name="name" id="name" placeholder="请输入权限名称"/>
				          </div>
				          <div class="form-group">
				            <label for="recipient-name" class="control-label">权限URL地址:</label>
				            <input type="text" class="form-control" id="url" name="url"  placeholder="请输入权限URL地址">
				          </div>
				        </form>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				        <button type="button" onclick="addPermission();" class="btn btn-primary">保存</button>
				      </div>
				    </div>
				  </div>
				</div>
				<#--/弹框-->
				</@shiro.hasPermission>
            </div>
		</div>
		</div>
		<@_quoteAmazeUi.quoteAmazeUi 1/>
			
	</body>
</html>