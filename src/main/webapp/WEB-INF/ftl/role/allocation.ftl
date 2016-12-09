<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<title>用户角色分配 - 权限管理</title>
		<@_quote.quote 1/>
		<script type="text/javascript">
		so.init(function(){
				//初始化全选。
				so.checkBoxInit('#checkAll','[check=box]');
				<@shiro.hasPermission name="/role/clearRoleByUserIds.shtml">
				//全选
				so.id('deleteAll').on('click',function(){
					var checkeds = $('[check=box]:checked');
					if(!checkeds.length){
						return layer.msg('请选择要清除的用户。',so.default),!0;
					}
					var array = [];
					checkeds.each(function(){
						array.push(this.value);
					});
					return deleteById(array);
				});
				</@shiro.hasPermission>
			});
			<@shiro.hasPermission name="/role/clearRoleByUserIds.shtml">
			<#--根据ID数组清空用户的角色-->
			function deleteById(ids){
				var index = layer.confirm("确定清除这"+ ids.length +"个用户的角色？",function(){
					var load = layer.load();
					$.post('${basePath}/role/clearRoleByUserIds.shtml',{userIds:ids.join(',')},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg(result.message);
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
			}
			</@shiro.hasPermission>
			<@shiro.hasPermission name="/role/addRole2User.shtml">
			<#--选择角色后保存-->
			function selectRole(){
				var checked = $("#boxRoleForm  :checked");
				var ids=[],names=[];
				$.each(checked,function(){
					ids.push(this.id);
					names.push($.trim($(this).attr('name')));
				});
				var index = layer.confirm("确定操作？",function(){
					<#--loding-->
					var load = layer.load();
					$.post('${basePath}/role/addRole2User.shtml',{ids:ids.join(','),userId:$('#selectUserId').val()},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!1;
						}
						layer.msg('添加成功。');
						setTimeout(function(){
							$('#formId').submit();
						},1000);
					},'json');
				});
			}
			/*
			*根据角色ID选择权限，分配权限操作。
			*/
			function selectRoleById(id){
				var load = layer.load();
				$.post("${basePath}/role/selectRoleByUserId.shtml",{id:id},function(result){
					layer.close(load);
					if(result && result.length){
						var html =[];
						$.each(result,function(){
							html.push("<div class='checkbox'><label>");
							html.push("<input type='checkbox' id='");
							html.push(this.id);
							html.push("'");
							if(this.check){
								html.push(" checked='checked'");
							}
							html.push("name='");
							html.push(this.name);
							html.push("'/>");
							html.push(this.name);
							html.push('</label></div>');
						});
						return so.id('boxRoleForm').html(html.join('')) & $('#selectRole').modal(),$('#selectUserId').val(id),!1;
					}else{
						return layer.msg('没有获取到用户数据，请先注册数据。',so.default);
					}
				},'json');
			}
			</@shiro.hasPermission>
		</script>
	</head>
	
	
	<body data-target="#one" data-spy="scroll">
		<@_topNav.top 3/>
		<div class="tpl-page-container tpl-page-header-fixed">
		<@_leftNav.left 3.2/>
		<div class="tpl-content-wrapper">
			<div class="tpl-content-page-title">角色分配</div>
            <ol class="am-breadcrumb">
                <li><a href="#" class="am-icon-home">首页</a></li>
                <li><a href="#">权限管理</a></li>
                <li class="am-active">角色分配</li>
            </ol>
            <div class="tpl-portlet-components">
	            <form method="post" action="" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent?default('')}" 
					        			name="findContent" id="findContent" placeholder="输入用户昵称 / 用户帐号">
					      </div>
					     <span class=""> <#--pull-right -->
				         	<a class="btn btn-primary" title="查询" type="submit"  onclick="$('#formId').submit();">
			                <i class="fa fa-search"></i></a>
				         	<@shiro.hasPermission name="/role/clearRoleByUserIds.shtml">
				         		<a class="btn btn-default label-danger" id="deleteAll" title="清空用户角色" href="javascript:void(0);">
			                    <i class="fa fa-trash-o"></i></a>
			         		</@shiro.hasPermission>
				         </span>    
				        </div>
					<hr>
					<table class="table table-bordered">
						<input type="hidden" id="selectUserId">
						<tr>
							<th width="5%"><input type="checkbox" id="checkAll"/></th>
							<th width="10%">用户昵称</th>
							<th width="10%">Email/帐号</th>
							<th width="10%">状态</th>
							<th width="55%">拥有的角色</th>
							<th width="10%">操作</th>
						</tr>
						<#if page?exists && page.list?size gt 0 >
							<#list page.list as it>
								<tr>
									<td><input value="${it.id}" check='box' type="checkbox" /></td>
									<td>${it.nickname}</td>
									<td>${it.email}</td>
									<td>${(it.status==1)?string('有效','禁止')}</td>
									<td roleIds="${it.roleIds?default('')}">${it.roleNames?default('-')}</td>
									<td>
										<@shiro.hasPermission name="/role/addRole2User.shtml">
											<a class="btn btn-success" title="选择角色"  href="javascript:selectRoleById(${it.id});">
			                    			<i class="fa fa-mail-forward"></i></a>
										</@shiro.hasPermission>
									</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="6">没有找到用户</td>
							</tr>
						</#if>
					</table>
					<#if page?exists>
						<div class="pagination pull-right">
							${page.pageHtml}
						</div>
					</#if>
				</form>
				
				<#--弹框-->
				<div class="modal fade bs-example-modal-sm"  id="selectRole" tabindex="-1" role="dialog" aria-labelledby="selectRoleLabel" style="margin-top:70px;">
				  <div class="modal-dialog modal-sm" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title" id="selectRoleLabel">添加角色</h4>
				      </div>
				      <div class="modal-body">
				        <form id="boxRoleForm">
				          loading...
				        </form>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				        <button type="button" onclick="selectRole();" class="btn btn-primary">保存</button>
				      </div>
				    </div>
				  </div>
				</div>
				<#--/弹框-->
				
            </div>
		</div>
		</div>
		<@_quoteAmazeUi.quoteAmazeUi 1/>
			
	</body>
</html>